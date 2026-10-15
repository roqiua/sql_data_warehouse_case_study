# Sales Data Warehouse

## 📌 Project Overview

This project builds a **Sales Data Warehouse** using Microsoft SQL Server to transform raw sales data into clean, structured, and analysis-ready data for reporting and business intelligence.

## 🏗️ Data Architecture

The project follows the **Medallion Architecture**, organized into three layers:

- **Bronze Layer:** Stores raw data from source systems.
- **Silver Layer:** Cleans, validates, and transforms data while handling invalid and missing values.
- **Gold Layer:** Provides business-ready data using dimensional modeling for analytical queries and reporting.

## ⭐ Data Modeling

The Gold Layer follows a **Star Schema** consisting of a central fact and dimension tables.

### Fact Table

- **`gold.fact_sales`** — Stores sales transactions at the grain of one row per product within an order.

### Dimension Tables

- **`gold.dim_customers`** — Contains customer information and demographic attributes.
- **`gold.dim_products`** — Contains product details, categories, and historical validity periods.
- **`gold.dim_date`** — Provides calendar attributes for time-based analysis.

The Date Dimension supports order date, shipping date, and due date analysis.

## ⚙️ Key Transformations

- Data cleaning and validation across Bronze and Silver layers.
- Handling invalid dates and missing values.
- Correcting sales amounts based on quantity and unit price.
- Identifying returned transactions.
- Calculating tax amounts and percentages using a 14% tax rate.
- Matching products to historical cost records based on order dates.
- Using the latest available product cost when no historical period matches.
- Tracking product cost source types for data traceability.

## 📂 Project Structure

- **Bronze:** Raw source data.
- **Silver:** Cleaned and transformed data.
- **Gold:** Analytical fact and dimension views.
- **Documentation:** Data catalog, schema design, and project references.

## 🔗 Project References

- **Project Implementation Tutorials:** [Tutorials Link](https://youtube.com/playlist?list=PLNcg_FV9n7qaUWeyUkPfiVtMbKlrfMqA8&si=WsNH9MWVoW8r2e2b)
- **LinkedIn:** [LinkedIn Profile](https://www.linkedin.com/in/roqiua-mohammad/)
- **GitHub:** [GitHub Profile](https://github.com/roqiua)

