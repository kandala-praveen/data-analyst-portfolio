# Layoffs Data Exploratory Analysis Using SQL

## Project Overview

This project focuses on exploring and analyzing a layoffs dataset using SQL Server.

The goal of this project is to understand layoffs patterns across different years, months, companies, industries, stages, and countries, and to identify meaningful insights from the data.

## Dataset

The dataset contains information about layoffs across different companies and includes the following attributes:

- Company
- Location
- Industry
- Total Laid Off
- Percentage Laid Off
- Date
- Country
- Stage
- Funds Raised in Millions

## Tools Used

- SQL Server
- SQL

## Data Preparation

Before performing the exploratory analysis, the dataset was prepared by:

- Converting columns into appropriate data types.
- Handling `NULL` values.
- Converting the date column into the appropriate date data type.

## Exploratory Data Analysis

The following analyses were performed:

- Identified the maximum number of employees laid off and the maximum percentage of layoffs.
- Analyzed layoffs at the company level.
- Calculated the overall total layoffs.
- Analyzed layoffs year-wise.
- Analyzed layoffs month-wise.
- Analyzed layoffs by industry.
- Analyzed layoffs by company stage.
- Analyzed layoffs by country.
- Analyzed company-wise layoffs for each year.
- Identified the top 5 companies with the highest layoffs for each year using `DENSE_RANK()` and `PARTITION BY`.

## SQL Concepts Used

- Aggregate Functions
- `SUM()`
- `MAX()`
- `GROUP BY`
- `ORDER BY`
- `WHERE`
- Date Functions
- CTEs
- Window Functions
- `DENSE_RANK()`
- `PARTITION BY`

## Key Insights

The analysis was used to identify:

- Changes in layoffs across different years.
- Monthly patterns in layoffs.
- Industries with higher numbers of layoffs.
- Countries with higher numbers of layoffs.
- Companies with the highest total layoffs.
- The top companies with the highest layoffs in each year.
- Differences in layoffs across company stages.

## Conclusion

This project demonstrates how SQL can be used to explore a real-world dataset, identify patterns and trends, and extract meaningful insights from the data.

The analysis provides a structured view of layoffs across time, companies, industries, stages, and countries.
