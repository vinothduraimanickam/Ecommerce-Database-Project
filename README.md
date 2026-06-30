# E-Commerce Database Design & Sales Analytics using MySQL

## 📖 Project Overview

This project demonstrates the complete lifecycle of designing, building, and analyzing a relational E-Commerce database using MySQL. It covers database creation, table design, data import, data cleaning, data validation, relationship management, exploratory data analysis, business analysis, advanced SQL concepts, and query optimization.

The primary objective of this project is to strengthen practical SQL skills required for Database Engineer, SQL Developer, ETL Tester, and Data Engineer roles by solving real-world business problems using SQL.

---

# 🎯 Project Objectives

- Design a relational E-Commerce database from scratch.
- Import raw CSV datasets into MySQL.
- Clean and validate imported data.
- Establish relationships using Foreign Keys.
- Perform Exploratory Data Analysis (EDA).
- Solve real-world business problems using SQL.
- Apply advanced SQL concepts.
- Improve query performance using indexes and execution plans.

---

# 🛠 Technologies Used

- MySQL 8.0
- MySQL Workbench
- SQL
- Microsoft Excel (Documentation)
- Git
- GitHub

---

# 📂 Dataset

The project uses an E-Commerce dataset consisting of six CSV files:

- Users
- Orders
- Order Items
- Products
- Inventory Items
- Distribution Centers

The CSV files were imported into MySQL and cleaned before analysis.

> **Note**
>
> The **inventory_items.csv** file is approximately **90 MB**, which exceeds GitHub's web upload size limit. Therefore, it is not included in this repository.
>
---

# 📁 Project Structure

```text
Ecommerce-Database-Project
│
├── 01_Dataset
│
├── 02_Documentation
│   ├── Database Table Analysis
│   ├── Data Profiling Report
│   ├── Data Cleaning Strategy
│   └── Database Schema Design
│
├── 03_SQL_Scripts
│   ├── 01_Create_Database.sql
│   ├── 02_Create_Tables.sql
│   ├── 03_Import_Data.sql
│   ├── 04_Data_Transformation_Cleaning.sql
│   ├── 05_Add_Foreign_Keys.sql
│   ├── 06_Data_Validation.sql
│   ├── 07_Exploratory_Data_Analysis.sql
│   └── 08_Business_Analysis.sql
│
├── 04_ER_Diagram
│   └── ER_Diagram.png
│
├── 05_Screenshots
│
└── README.md
```

---

# 🗄 Database Design

The database contains six relational tables.

- Users
- Orders
- Order Items
- Products
- Inventory Items
- Distribution Centers

The tables are connected using Primary Keys and Foreign Keys to maintain referential integrity.

---

# 📊 Entity Relationship Diagram (ERD)

 <img src="https://raw.githubusercontent.com/vinothduraimanickam/Ecommerce-Database-Project/refs/heads/main/04_ER_Diagram/01_ER_Diagram.png" style="width:100%; max-width:100%;"/>

---

# 🔄 Project Workflow

### Step 1: Database Creation

- Created the E-Commerce database using SQL.

### Step 2: Table Creation

- Designed and created all relational tables.
- Defined appropriate data types and Primary Keys.

### Step 3: Import CSV Data

- Imported the CSV files into their respective tables using SQL queries (`LOAD DATA INFILE`).

### Step 4: Data Cleaning & Transformation

- Removed invalid values.
- Replaced blank values with `NULL`.
- Converted `VARCHAR` date columns to `DATETIME`.
- Removed timezone values from datetime columns.
- Standardized the imported data.

### Step 5: Relationship Management

- Added Foreign Keys.
- Maintained referential integrity between tables.

### Step 6: Data Validation

- Verified imported records.
- Checked NULL values.
- Validated relationships.
- Confirmed data consistency.

### Step 7: Exploratory Data Analysis (EDA)

Performed SQL queries to understand:

- Customer distribution
- Product information
- Orders
- Inventory
- Revenue

### Step 8: Business Analysis

Solved more than **80+ real-world SQL business questions**, including:

- Sales Analysis
- Customer Analysis
- Product Analysis
- Inventory Analysis
- Distribution Center Analysis

### Step 9: Advanced SQL

Applied advanced SQL concepts including:

- Common Table Expressions (CTEs)
- Window Functions
- Views
- Stored Procedures
- Constraints

### Step 10: Query Optimization

Improved query performance using:

- Indexes
- EXPLAIN Execution Plan

---

# 💡 SQL Concepts Covered

## Basic SQL

- SELECT
- WHERE
- ORDER BY
- GROUP BY
- HAVING
- LIMIT

## Joins

- INNER JOIN
- LEFT JOIN
- SELF JOIN

## Aggregate Functions

- COUNT()
- SUM()
- AVG()
- MIN()
- MAX()

## Date Functions

- YEAR()
- MONTH()
- MONTHNAME()
- DATEDIFF()

## Subqueries

- Single-row
- Multi-row
- Correlated

## Common Table Expressions (CTEs)

- Single CTE
- Multiple CTEs

## Window Functions

- ROW_NUMBER()
- RANK()
- DENSE_RANK()
- LAG()
- LEAD()
- NTILE()

## Views

- CREATE VIEW
- Reusable reporting queries

## Stored Procedures

- IN Parameters
- OUT Parameters
- Variables
- IF...ELSEIF...ELSE
- SELECT...INTO

## Constraints

- PRIMARY KEY
- FOREIGN KEY
- NOT NULL
- UNIQUE
- CHECK
- DEFAULT

## Performance Optimization

- CREATE INDEX
- EXPLAIN

---

# 📸 Project Screenshots

## Database Overview

 <img src="https://raw.githubusercontent.com/vinothduraimanickam/Ecommerce-Database-Project/refs/heads/main/05_Screenshots/01_Database%20Overview.png"/>

---

## Tables

 <img src="https://raw.githubusercontent.com/vinothduraimanickam/Ecommerce-Database-Project/refs/heads/main/05_Screenshots/02_Tables.png" />

---

## ER Diagram

 <img src="https://raw.githubusercontent.com/vinothduraimanickam/Ecommerce-Database-Project/refs/heads/main/05_Screenshots/03_ER_Diagram.png" />

---

## Data Transformation Cleaning

 <img src="https://raw.githubusercontent.com/vinothduraimanickam/Ecommerce-Database-Project/refs/heads/main/05_Screenshots/04_Data%20Cleaning.png" />

---

## Foreign Keys

 <img src="https://raw.githubusercontent.com/vinothduraimanickam/Ecommerce-Database-Project/refs/heads/main/05_Screenshots/05_Foreign%20Keys.png"/>

---

## Business Analysis

 <img src="https://raw.githubusercontent.com/vinothduraimanickam/Ecommerce-Database-Project/refs/heads/main/05_Screenshots/06_Business%20Analysis.png"/>

---

## Window Functions

 <img src="https://raw.githubusercontent.com/vinothduraimanickam/Ecommerce-Database-Project/refs/heads/main/05_Screenshots/07_Window%20Functions.png"/>

---

## Views

 <img src="https://raw.githubusercontent.com/vinothduraimanickam/Ecommerce-Database-Project/refs/heads/main/05_Screenshots/08_Views.png"/>

---

## Stored Procedures

 <img src="https://raw.githubusercontent.com/vinothduraimanickam/Ecommerce-Database-Project/refs/heads/main/05_Screenshots/09_Stored%20Procedures.png"/>

---

## Query Optimization

 <img src="https://raw.githubusercontent.com/vinothduraimanickam/Ecommerce-Database-Project/refs/heads/main/05_Screenshots/10_Query%20Optimization.png"/>

---

# 📈 Project Highlights

- Designed a relational E-Commerce database from scratch.
- Imported and transformed multiple CSV datasets into MySQL.
- Cleaned and validated raw data before analysis.
- Implemented Primary Keys and Foreign Keys.
- Solved **80+ real-world SQL business questions**.
- Applied advanced SQL concepts including CTEs, Window Functions, Views, Stored Procedures, and Constraints.
- Optimized SQL query performance using Indexes and EXPLAIN.
- Created complete project documentation, ER Diagram, and business reports.

---

# 🎯 Skills Demonstrated

- Database Design
- Relational Database Modeling
- SQL Query Writing
- Data Import
- Data Cleaning
- Data Validation
- Exploratory Data Analysis
- Business Analysis
- Window Functions
- Common Table Expressions (CTEs)
- Views
- Stored Procedures
- Constraints
- Query Optimization
- Performance Tuning
- Documentation

---

# 🚀 Future Enhancements

- Build an interactive Power BI dashboard.
- Develop an automated ETL pipeline using Python.
- Deploy the database to a cloud platform.
- Implement Triggers and Events.
- Expand the project with additional business reports and dashboards.

---

# 👨‍💻 Author

**Vinoth Duraimanickam**

- LinkedIn: https://www.linkedin.com/in/vinothduraimanickam/
- GitHub: https://github.com/vinothduraimanickam/

---
