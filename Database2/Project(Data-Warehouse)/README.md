# Data Warehouse Implementation for Northwind 2007

This project involves implementing a comprehensive **Data Warehouse** solution for the Northwind 2007 database. The aim was to create a robust system for analyzing and reporting data effectively while learning and applying key data warehousing concepts and techniques.

## Technologies and Concepts Used
- **SQL Server**: Used for database management and querying.
- **ETL Process**: Implemented for data extraction, transformation, and loading into the data warehouse.
  - **Storage Area (SA)**: Initial area for raw data loading.
  - **Data Warehouse (DW)**: Final destination for transformed and structured data.
- **Dimensional Modeling**: Designed to support efficient querying and reporting.

## Main Components
### Dimensional Models
- **Customer Dimension**: Captures details about customers.
- **Employee Dimension**: Maintains employee-related data.
- **Product Dimension**: Includes product details.
- **Location Dimension**: Stores geographical information.
- **Supplier Dimension**: Tracks supplier-related data.
- **Time Dimension**: Represents temporal aspects for analysis.

### Fact Tables Implementation
#### **Sales Mart**
- `SalesOrdersTransactionalFact`: Records detailed sales order transactions.
- `SalesProductTransactionalFact`: Tracks individual product sales data.
- `SalesOrderAccFact`: Accumulated sales orders over time.
- `SalesProductsDailyFact`: Daily sales product summaries.

#### **Purchase Mart**
- `PurchaseOrdersTransactionalFact`: Stores detailed purchase order transactions.
- `PurchaseProductTransactionalFact`: Tracks individual product purchases.
- `PurchaseOrderAccFact`: Accumulated purchase orders.

#### **Salary Mart**
- `EmployeeSalaryTransactionalFact`: Records detailed salary transactions.
- `EmployeeSalaryAccFact`: Accumulated salary data over time.

## Advanced Concepts Learned
- **Slowly Changing Dimensions (SCD)**:
  - **SCD Type 1**: Overwrites old data.
  - **SCD Type 2**: Maintains historical data with versioning.
  - **SCD Type 3**: Tracks previous values alongside current ones.
- **Fact Table Types**:
  - **Transactional Facts**: Records individual transactions.
  - **Periodic Facts (Daily)**: Summarizes data for specific periods.
  - **Accumulating Facts**: Tracks cumulative data over time.

## ETL Procedures
- **Main Loading Procedures**:
  - Initial load for raw data into the storage area.
  - Regular/daily incremental loads for updated data.
- **Dimension Loading Procedures**:
  - Populate dimensional models with relevant data.
  - Implement SCDs for maintaining data history.
- **Fact Table Loading Procedures**:
  - Transform and load data into fact tables.
  - Ensure consistency and integrity of relationships.
- **Data Transformation and Cleaning**:
  - Standardize data formats.
  - Clean and preprocess data to ensure quality.

## Learning Outcomes
This project provided valuable hands-on experience with:
- **Dimensional Modeling**: Understanding how to structure data for analysis.
- **ETL Processes**: Building efficient pipelines for data movement and transformation.
- **Slowly Changing Dimensions**: Managing data versioning and history.
- **Business Intelligence**: Developing solutions for complex data relationships and reporting.

This implementation highlights practical application of **data warehouse concepts** and advanced database techniques, equipping me with essential skills for designing and managing business intelligence systems.
