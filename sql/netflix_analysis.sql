-- Netflix Catalog SQL Analysis
-- PostgreSQL
-- Author: Muhammad Daniyal

-- =========================================================
-- 1. TABLE CREATION
-- =========================================================

DROP TABLE IF EXISTS netflix_titles;

CREATE TABLE netflix_titles (
    show_id VARCHAR(20) PRIMARY KEY,
    type VARCHAR(20),
    title TEXT,
    director TEXT,
    cast_members TEXT,
    country TEXT,
    date_added DATE,
    release_year INTEGER,
    rating VARCHAR(20),
    duration VARCHAR(50),
    listed_in TEXT,
    description TEXT
);

-- =========================================================
-- 2. DATASET OVERVIEW
-- =========================================================

SELECT COUNT(*) AS total_titles
FROM netflix_titles;

SELECT
    type,
    COUNT(*) AS title_count,
    ROUND(
        COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (),
        2
    ) AS catalog_percentage
FROM netflix_titles
GROUP BY type
ORDER BY title_count DESC;

-- =========================================================
-- 3. DATA QUALITY ASSESSMENT
-- =========================================================

SELECT
    COUNT(*) FILTER (
        WHERE director IS NULL OR TRIM(director) = ''
    ) AS missing_director,
    COUNT(*) FILTER (
        WHERE cast_members IS NULL OR TRIM(cast_members) = ''
    ) AS missing_cast,
    COUNT(*) FILTER (
        WHERE country IS NULL OR TRIM(country) = ''
    ) AS missing_country,
    COUNT(*) FILTER (
        WHERE date_added IS NULL
    ) AS missing_date_added,
    COUNT(*) FILTER (
        WHERE rating IS NULL OR TRIM(rating) = ''
    ) AS missing_rating,
    COUNT(*) FILTER (
        WHERE duration IS NULL OR TRIM(duration) = ''
    ) AS missing_duration
FROM netflix_titles;

SELECT
    show_id,
    COUNT(*) AS duplicate_count
FROM netflix_titles
GROUP BY show_id
HAVING COUNT(*) > 1;

-- =========================================================
-- 4. CONTENT ADDITIONS BY YEAR
-- =========================================================

SELECT
    EXTRACT(YEAR FROM date_added)::INTEGER AS year_added,
    COUNT(*) AS content_count
FROM netflix_titles
WHERE date_added IS NOT NULL
GROUP BY year_added
ORDER BY year_added;

-- =========================================================
-- 5. YEAR-OVER-YEAR GROWTH
-- =========================================================

WITH yearly_additions AS (
    SELECT
        EXTRACT(YEAR FROM date_added)::INTEGER AS year_added,
        COUNT(*) AS content_count
    FROM netflix_titles
    WHERE date_added IS NOT NULL
    GROUP BY year_added
),
growth_analysis AS (
    SELECT
        year_added,
        content_count,
        LAG(content_count) OVER (
            ORDER BY year_added
        ) AS previous_year_count
    FROM yearly_additions
)

SELECT
    year_added,
    content_count,
    previous_year_count,
    ROUND(
        (
            content_count - previous_year_count
        ) * 100.0 / NULLIF(previous_year_count, 0),
        2
    ) AS growth_rate_percentage
FROM growth_analysis
ORDER BY year_added;

-- =========================================================
-- 6. CONTENT TYPE TREND
-- =========================================================

SELECT
    EXTRACT(YEAR FROM date_added)::INTEGER AS year_added,
    type,
    COUNT(*) AS content_count
FROM netflix_titles
WHERE date_added IS NOT NULL
GROUP BY year_added, type
ORDER BY year_added, type;

-- =========================================================
-- 7. TOP COUNTRIES
-- =========================================================

WITH country_split AS (
    SELECT
        TRIM(
            UNNEST(STRING_TO_ARRAY(country, ','))
        ) AS country_name
    FROM netflix_titles
    WHERE country IS NOT NULL
      AND TRIM(country) <> ''
)

SELECT
    country_name,
    COUNT(*) AS title_count
FROM country_split
GROUP BY country_name
ORDER BY title_count DESC
LIMIT 10;

-- =========================================================
-- 8. COUNTRY AND CONTENT TYPE
-- =========================================================

WITH country_type_split AS (
    SELECT
        type,
        TRIM(
            UNNEST(STRING_TO_ARRAY(country, ','))
        ) AS country_name
    FROM netflix_titles
    WHERE country IS NOT NULL
      AND TRIM(country) <> ''
)

SELECT
    country_name,
    type,
    COUNT(*) AS title_count
FROM country_type_split
GROUP BY country_name, type
ORDER BY country_name, title_count DESC;

-- =========================================================
-- 9. TOP DIRECTORS
-- =========================================================

WITH director_split AS (
    SELECT
        TRIM(
            UNNEST(STRING_TO_ARRAY(director, ','))
        ) AS director_name
    FROM netflix_titles
    WHERE director IS NOT NULL
      AND TRIM(director) <> ''
)

SELECT
    director_name,
    COUNT(*) AS title_count
FROM director_split
GROUP BY director_name
ORDER BY title_count DESC
LIMIT 10;

-- =========================================================
-- 10. TOP CAST MEMBERS
-- =========================================================

WITH cast_split AS (
    SELECT
        TRIM(
            UNNEST(STRING_TO_ARRAY(cast_members, ','))
        ) AS actor_name
    FROM netflix_titles
    WHERE cast_members IS NOT NULL
      AND TRIM(cast_members) <> ''
)

SELECT
    actor_name,
    COUNT(*) AS title_count
FROM cast_split
GROUP BY actor_name
ORDER BY title_count DESC
LIMIT 10;

-- =========================================================
-- 11. TOP GENRES
-- =========================================================

WITH genre_split AS (
    SELECT
        TRIM(
            UNNEST(STRING_TO_ARRAY(listed_in, ','))
        ) AS genre
    FROM netflix_titles
    WHERE listed_in IS NOT NULL
      AND TRIM(listed_in) <> ''
)

SELECT
    genre,
    COUNT(*) AS title_count
FROM genre_split
GROUP BY genre
ORDER BY title_count DESC
LIMIT 10;

-- =========================================================
-- 12. GENRE RANKING BY CONTENT TYPE
-- =========================================================

WITH genre_type_split AS (
    SELECT
        type,
        TRIM(
            UNNEST(STRING_TO_ARRAY(listed_in, ','))
        ) AS genre
    FROM netflix_titles
    WHERE listed_in IS NOT NULL
      AND TRIM(listed_in) <> ''
),
genre_counts AS (
    SELECT
        type,
        genre,
        COUNT(*) AS title_count
    FROM genre_type_split
    GROUP BY type, genre
)

SELECT
    type,
    genre,
    title_count,
    DENSE_RANK() OVER (
        PARTITION BY type
        ORDER BY title_count DESC
    ) AS genre_rank
FROM genre_counts
ORDER BY type, genre_rank;

-- =========================================================
-- 13. RATING DISTRIBUTION
-- =========================================================

SELECT
    rating,
    COUNT(*) AS title_count,
    ROUND(
        COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (),
        2
    ) AS catalog_percentage
FROM netflix_titles
WHERE rating IS NOT NULL
GROUP BY rating
ORDER BY title_count DESC;

-- =========================================================
-- 14. RATING BY CONTENT TYPE
-- =========================================================

SELECT
    type,
    rating,
    COUNT(*) AS title_count,
    ROUND(
        COUNT(*) * 100.0
        / SUM(COUNT(*)) OVER (PARTITION BY type),
        2
    ) AS percentage_within_type
FROM netflix_titles
WHERE rating IS NOT NULL
GROUP BY type, rating
ORDER BY type, percentage_within_type DESC;

-- =========================================================
-- 15. MONTHLY ADDITIONS
-- =========================================================

SELECT
    EXTRACT(MONTH FROM date_added)::INTEGER AS month_number,
    TRIM(TO_CHAR(date_added, 'Month')) AS month_name,
    COUNT(*) AS title_count
FROM netflix_titles
WHERE date_added IS NOT NULL
GROUP BY month_number, month_name
ORDER BY month_number;

-- =========================================================
-- 16. WEEKDAY ADDITIONS
-- =========================================================

SELECT
    EXTRACT(ISODOW FROM date_added)::INTEGER AS weekday_number,
    TRIM(TO_CHAR(date_added, 'Day')) AS weekday_name,
    COUNT(*) AS title_count
FROM netflix_titles
WHERE date_added IS NOT NULL
GROUP BY weekday_number, weekday_name
ORDER BY weekday_number;

-- =========================================================
-- 17. MONTH-WEEKDAY PATTERN
-- =========================================================

SELECT
    TRIM(TO_CHAR(date_added, 'Month')) AS month_name,
    TRIM(TO_CHAR(date_added, 'Day')) AS weekday_name,
    COUNT(*) AS title_count
FROM netflix_titles
WHERE date_added IS NOT NULL
GROUP BY
    EXTRACT(MONTH FROM date_added),
    EXTRACT(ISODOW FROM date_added),
    month_name,
    weekday_name
ORDER BY title_count DESC;

-- =========================================================
-- 18. MOVIE DURATION STATISTICS
-- =========================================================

WITH movie_duration AS (
    SELECT
        CAST(
            REGEXP_REPLACE(duration, '[^0-9]', '', 'g')
            AS INTEGER
        ) AS duration_minutes
    FROM netflix_titles
    WHERE type = 'Movie'
      AND duration IS NOT NULL
)

SELECT
    COUNT(*) AS movie_count,
    ROUND(AVG(duration_minutes), 2) AS average_duration,
    PERCENTILE_CONT(0.5)
        WITHIN GROUP (ORDER BY duration_minutes)
        AS median_duration,
    MIN(duration_minutes) AS minimum_duration,
    MAX(duration_minutes) AS maximum_duration,
    ROUND(STDDEV_SAMP(duration_minutes), 2)
        AS duration_standard_deviation
FROM movie_duration;

-- =========================================================
-- 19. MOVIE DURATION CATEGORIES
-- =========================================================

WITH movie_duration AS (
    SELECT
        CAST(
            REGEXP_REPLACE(duration, '[^0-9]', '', 'g')
            AS INTEGER
        ) AS duration_minutes
    FROM netflix_titles
    WHERE type = 'Movie'
      AND duration IS NOT NULL
),
duration_categories AS (
    SELECT
        CASE
            WHEN duration_minutes <= 60
                THEN 'Short (60 min or less)'
            WHEN duration_minutes <= 120
                THEN 'Standard (61-120 min)'
            WHEN duration_minutes <= 180
                THEN 'Long (121-180 min)'
            ELSE 'Extended (over 180 min)'
        END AS duration_category
    FROM movie_duration
)

SELECT
    duration_category,
    COUNT(*) AS movie_count,
    ROUND(
        COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (),
        2
    ) AS movie_percentage
FROM duration_categories
GROUP BY duration_category
ORDER BY movie_count DESC;

-- =========================================================
-- 20. TV SHOW SEASON STATISTICS
-- =========================================================

WITH tv_seasons AS (
    SELECT
        CAST(
            REGEXP_REPLACE(duration, '[^0-9]', '', 'g')
            AS INTEGER
        ) AS season_count
    FROM netflix_titles
    WHERE type = 'TV Show'
      AND duration IS NOT NULL
)

SELECT
    COUNT(*) AS tv_show_count,
    ROUND(AVG(season_count), 2) AS average_seasons,
    PERCENTILE_CONT(0.5)
        WITHIN GROUP (ORDER BY season_count)
        AS median_seasons,
    MIN(season_count) AS minimum_seasons,
    MAX(season_count) AS maximum_seasons,
    ROUND(STDDEV_SAMP(season_count), 2)
        AS season_standard_deviation
FROM tv_seasons;

-- =========================================================
-- 21. CONTENT AGE BY CONTENT TYPE
-- =========================================================

WITH content_age_data AS (
    SELECT
        type,
        EXTRACT(YEAR FROM date_added)::INTEGER
            - release_year AS content_age
    FROM netflix_titles
    WHERE date_added IS NOT NULL
      AND release_year IS NOT NULL
),
valid_content_age AS (
    SELECT *
    FROM content_age_data
    WHERE content_age >= 0
)

SELECT
    type,
    ROUND(AVG(content_age), 2) AS average_content_age,
    PERCENTILE_CONT(0.5)
        WITHIN GROUP (ORDER BY content_age)
        AS median_content_age,
    MIN(content_age) AS minimum_content_age,
    MAX(content_age) AS maximum_content_age
FROM valid_content_age
GROUP BY type
ORDER BY type;

-- =========================================================
-- 22. CONTENT AGE CATEGORIES
-- =========================================================

WITH content_age_data AS (
    SELECT
        EXTRACT(YEAR FROM date_added)::INTEGER
            - release_year AS content_age
    FROM netflix_titles
    WHERE date_added IS NOT NULL
      AND release_year IS NOT NULL
),
valid_content_age AS (
    SELECT content_age
    FROM content_age_data
    WHERE content_age >= 0
),
age_categories AS (
    SELECT
        CASE
            WHEN content_age = 0 THEN 'Same Year'
            WHEN content_age BETWEEN 1 AND 2 THEN '1-2 Years'
            WHEN content_age BETWEEN 3 AND 5 THEN '3-5 Years'
            WHEN content_age BETWEEN 6 AND 10 THEN '6-10 Years'
            WHEN content_age BETWEEN 11 AND 20 THEN '11-20 Years'
            ELSE '20+ Years'
        END AS age_category
    FROM valid_content_age
)

SELECT
    age_category,
    COUNT(*) AS title_count,
    ROUND(
        COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (),
        2
    ) AS title_percentage
FROM age_categories
GROUP BY age_category
ORDER BY title_count DESC;

-- =========================================================
-- 23. EXECUTIVE KPI SUMMARY
-- =========================================================

SELECT
    COUNT(*) AS total_titles,
    COUNT(*) FILTER (
        WHERE type = 'Movie'
    ) AS total_movies,
    COUNT(*) FILTER (
        WHERE type = 'TV Show'
    ) AS total_tv_shows,
    ROUND(
        COUNT(*) FILTER (WHERE type = 'Movie')
        * 100.0 / COUNT(*),
        2
    ) AS movie_catalog_percentage,
    ROUND(
        COUNT(*) FILTER (WHERE type = 'TV Show')
        * 100.0 / COUNT(*),
        2
    ) AS tv_show_catalog_percentage,
    PERCENTILE_CONT(0.5)
        WITHIN GROUP (ORDER BY release_year)
        AS median_release_year
FROM netflix_titles;