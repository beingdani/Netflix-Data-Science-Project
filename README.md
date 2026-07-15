# Netflix Catalog Data Science Analysis

## Project Overview

This project presents an end-to-end exploratory and statistical analysis of the Netflix catalog dataset. The analysis examines catalog composition, content type, geographic representation, genres, ratings, release patterns, content age, Movie duration, TV Show season structure, and content addition timing.

The objective is to transform raw catalog metadata into structured analytical insights and business-oriented recommendations.

## Business Problem

Streaming platforms manage large and diverse content catalogs across multiple countries, genres, ratings, and content formats. Understanding the structure and evolution of a catalog can support content portfolio evaluation, acquisition planning, licensing analysis, and regional content strategy.

This project analyzes Netflix catalog metadata to identify major catalog patterns and statistically relevant characteristics.

## Project Objectives

- Analyze the distribution of Movies and TV Shows.
- Identify major content-producing countries.
- Evaluate genre and rating composition.
- Analyze historical content addition trends.
- Measure catalog freshness using content age.
- Examine Movie duration and TV Show season structure.
- Perform descriptive and statistical analysis.
- Detect and evaluate statistical outliers.
- Analyze relationships between independent numerical variables.
- Compare Movies and TV Shows statistically.
- Develop business-oriented recommendations.

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

## Project Structure

```text
Netflix-Data-Science-Project/
│
├── data/
│   └── raw/
│       └── netflix_titles.csv
│
├── notebooks/
│   └── netflix_analysis.ipynb
│
├── README.md
└── requirements.txt
```

## Analysis Workflow

1. Business Problem Definition
2. Dataset Inspection
3. Data Quality Assessment
4. Data Cleaning
5. Feature Engineering
6. Exploratory Data Analysis
7. Statistical Analysis
8. Multivariate Analysis
9. Business Recommendations
10. Executive KPI Summary
11. Executive Summary

## Key Findings

- The catalog contains **8,794 titles**.
- Movies represent **69.68%** of the catalog.
- TV Shows represent **30.32%** of the catalog.
- The **United States** has the highest content representation.
- **International Movies** is the largest genre category.
- **TV-MA** is the dominant content rating.
- Average Movie duration is **99.58 minutes**.
- Median Movie duration is **98 minutes**.
- Average TV Show length is **1.75 seasons**.
- Median TV Show length is **1 season**.
- Median release year is **2017**.
- Median content age is **1 year**.
- Catalog additions peaked in **2019**.
- **July** recorded the highest monthly additions.
- **Friday** is the dominant addition weekday.
- **March-Friday** is the strongest month-weekday combination with **266 titles**.

## Statistical Insights

Movie duration is approximately symmetric and shows moderate relative variability.

TV Show season counts are highly positively skewed because most series contain few seasons while a smaller number of long-running shows extend the distribution.

Statistical outliers were retained where they represented potentially valid catalog segments rather than confirmed data quality errors.

The engineered `content_age` variable was excluded from independent correlation analysis because it is mathematically derived from release year and year added.

## Business Recommendations

- Evaluate Movies and TV Shows using separate analytical frameworks.
- Combine catalog metadata with viewer engagement and retention metrics.
- Compare Friday content additions with weekend viewing behavior.
- Evaluate country and genre composition using regional demand data.
- Assess older catalog titles using engagement, licensing cost, and retention contribution.
- Avoid automatically removing statistical outliers without business validation.

## Tools and Technologies

- Python
- Pandas
- NumPy
- Matplotlib
- Seaborn
- Jupyter Notebook
- Visual Studio Code

## Project Limitations

This project analyzes catalog metadata only. The dataset does not contain viewer watch time, completion rate, subscriber behavior, content cost, licensing information, or revenue.

Therefore, the findings describe catalog structure and patterns but do not directly measure content performance or profitability.

## Author

**Muhammad Daniyal**

Data Science Project