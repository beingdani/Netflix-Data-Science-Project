# Netflix Content Analysis | Python, PostgreSQL, SQL & Power BI
![Netflix Dashboard](images/dashboard_preview.png)
## Project Overview

This project presents an end-to-end data analysis of the Netflix catalog dataset using Python, PostgreSQL, SQL, and Power BI.

The project covers data cleaning, feature engineering, exploratory data analysis (EDA), statistical analysis, SQL-based business analysis, and interactive dashboard development.

The objective is to transform raw Netflix catalog metadata into structured analytical insights and business-oriented recommendations.

---

## Business Problem

Streaming platforms manage large content catalogs across multiple countries, genres, ratings, and content formats.

Understanding catalog composition and historical trends can support content portfolio evaluation, regional content strategy, acquisition planning, and licensing analysis.

This project analyzes Netflix catalog metadata to identify important content patterns and statistically relevant characteristics.

---

## Project Objectives

- Analyze Movies and TV Shows distribution.
- Identify major content-producing countries.
- Evaluate genre and rating composition.
- Analyze historical content release trends.
- Measure catalog freshness and content age.
- Examine Movie duration and TV Show season structure.
- Perform descriptive and statistical analysis.
- Detect and evaluate statistical outliers.
- Perform SQL-based business analysis.
- Develop an interactive Power BI dashboard.
- Generate business-oriented recommendations.

---

## Dataset

The dataset contains Netflix catalog metadata including:

- Title
- Content type
- Director
- Cast
- Country
- Date added
- Release year
- Rating
- Duration
- Genre classification
- Description

After data preparation, the analytical dataset contains **8,794 titles**, including:

- **6,128 Movies**
- **2,666 TV Shows**

---

## Project Structure

Netflix-Data-Science-Project/

- `data/raw/netflix_titles.csv` — Raw Netflix dataset
- `notebooks/netflix_analysis.ipynb` — Python data analysis notebook
- `sql/netflix_analysis.sql` — PostgreSQL and SQL analysis
- `images/` — Analysis and visualization images
- `Netflix_Content_Analysis_Dashboard.pbix` — Power BI dashboard
- `README.md` — Project documentation
- `requirements.txt` — Python dependencies

---

## Analysis Workflow

1. Business Problem Definition
2. Dataset Inspection
3. Data Quality Assessment
4. Data Cleaning
5. Feature Engineering
6. Exploratory Data Analysis
7. Statistical Analysis
8. Multivariate Analysis
9. PostgreSQL Database Analysis
10. SQL Business Queries
11. Power BI Dashboard Development
12. Business Recommendations
13. Executive KPI Summary

---

## Python Data Analysis

Python was used for data preparation and analytical exploration.

The analysis includes:

- Missing value assessment
- Data type validation
- Duplicate analysis
- Feature engineering
- Descriptive statistics
- Distribution analysis
- Outlier evaluation
- Correlation analysis
- Movie and TV Show comparison

---

## PostgreSQL & SQL Analysis

The cleaned Netflix dataset was analyzed using PostgreSQL.

SQL analysis includes:

- Content type distribution
- Rating analysis
- Country-level content analysis
- Genre analysis
- Historical release trends
- Country and content type comparison
- Aggregation and grouping
- Common Table Expressions (CTEs)
- String splitting and normalization
- Business-oriented analytical queries

---

## Power BI Dashboard

An interactive Power BI dashboard was developed to provide an executive overview of the Netflix catalog.

### Dashboard KPIs

- **Total Titles:** 9K
- **Total Movies:** 6K
- **Total TV Shows:** 3K
- **Average Release Year:** 2014

### Dashboard Visualizations

- Movies vs TV Shows distribution
- Total titles by release year
- Content rating distribution
- Content type filter
- Release year range filter

The dashboard allows users to interactively explore Netflix catalog patterns.

---

## Key Findings

- The catalog contains **8,794 titles**.
- Movies represent **69.68%** of the catalog.
- TV Shows represent **30.32%** of the catalog.
- The United States has the highest content representation.
- International Movies is the largest genre category.
- TV-MA is the dominant content rating.
- Average Movie duration is **99.58 minutes**.
- Median Movie duration is **98 minutes**.
- Average TV Show length is **1.75 seasons**.
- Median TV Show length is **1 season**.
- Median release year is **2017**.
- Median content age is **1 year**.
- Catalog additions peaked in **2019**.
- July recorded the highest monthly additions.
- Friday is the dominant addition weekday.
- March-Friday is the strongest month-weekday combination with **266 titles**.

---

## Statistical Insights

Movie duration is approximately symmetric and shows moderate relative variability.

TV Show season counts are highly positively skewed because most series contain few seasons while a smaller number of long-running shows extend the distribution.

Statistical outliers were retained where they represented potentially valid catalog segments rather than confirmed data quality errors.

The engineered `content_age` variable was excluded from independent correlation analysis because it is mathematically derived from release year and year added.

---

## Business Recommendations

- Evaluate Movies and TV Shows using separate analytical frameworks.
- Combine catalog metadata with viewer engagement and retention metrics.
- Compare Friday content additions with weekend viewing behavior.
- Evaluate country and genre composition using regional demand data.
- Assess older catalog titles using engagement and licensing cost data.
- Avoid automatically removing statistical outliers without business validation.
- Use interactive BI dashboards for continuous catalog monitoring.

---

## Tools and Technologies

- Python
- Pandas
- NumPy
- Matplotlib
- Seaborn
- Jupyter Notebook
- PostgreSQL
- SQL
- pgAdmin 4
- Power BI
- Visual Studio Code
- Git
- GitHub

---

## Project Limitations

This project analyzes catalog metadata only.

The dataset does not contain viewer watch time, completion rate, subscriber behavior, content cost, licensing information, or revenue.

Therefore, the findings describe catalog structure and patterns but do not directly measure content performance or profitability.

---

## Author

**Muhammad Daniyal**

Data Science Project