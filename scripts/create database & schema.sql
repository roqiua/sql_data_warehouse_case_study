
-- Create the main database for the Data Warehouse project
CREATE DATABASE DataWarehouse;


GO
-- Switch the current database context to DataWarehouse
USE DataWarehouse;


GO
-- Create the Bronze layer:
-- Stores raw data extracted from source systems with minimal transformations
CREATE SCHEMA bronze;


GO
-- Create the Silver layer:
-- Stores cleaned, validated, and standardized data
CREATE SCHEMA silver;


GO
-- Create the Gold layer:
-- Stores business-ready data prepared for reporting and analytics
CREATE SCHEMA gold;
