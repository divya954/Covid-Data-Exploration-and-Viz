# Covid Data Exploration And Viz

## Project Overview

This project focuses on exploring COVID-19 data from the PortfolioProject database and then visualize in Tableau. The aim is to analyze various aspects of the pandemic, including total cases, deaths, vaccinations, and population percentages across different locations and continents.

## Data Exploration Methods

### 1. Overview of Covid Data
- Initially retrieved data from the `CovidDeaths` table to explore general trends and distributions.
- Utilized SQL queries to filter out NULL values and organize data by location and date.

### 2. Total Cases vs Total Deaths
- Calculated the percentage of deaths relative to total cases to assess the severity of the pandemic.
- Examined the likelihood of dying if contracting COVID-19 in specific countries.

### 3. Total Cases vs Population
- Investigated the percentage of total cases compared to the population to understand the scale of infection rates across different regions.

### 4. Vaccination Analysis
- Explored vaccination data from the `CovidVaccinations` table and compared it with population data.
- Calculated the total vaccinations and rolling people vaccinated percentages across various locations and continents.

### 5. Data Visualization Preparation
- Utilized Common Table Expressions (CTEs) and temporary tables to organize and preprocess data for later visualization.
- Created a view to store processed data for subsequent visualization tasks.

## Files Included

- **Covid_data_exploration_project_file.sql**: Contains SQL Queries used to explore COVID-19 data.
- **SQL Queries for Tableau Covid Data exploration Project.sql**:  Contains SQL Queries used for Tableau Covid Data Exploration Project
- **README.md**: This file, providing an overview of the project and methods used for data exploration and visualization.


## Usage

1. Ensure access to the PortfolioProject database containing COVID-19 data.
2. Run the SQL queries provided in `Covid_data_exploration_project_file.sql` to perform data exploration tasks.
3. Analyze the results obtained from each query to gain insights into the trends and patterns of the pandemic.
4. Use the prepared data for visualization purposes or further analysis as needed.

## Contributors

- Divya B K

## Contact

For any questions or suggestions regarding this project, please contact divyabk54@gmail.com

