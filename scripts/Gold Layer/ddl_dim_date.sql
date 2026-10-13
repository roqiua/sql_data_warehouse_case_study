
USE DataWarehouse;


GO
IF OBJECT_ID('gold.dim_date', 'U') IS NOT NULL
    DROP TABLE gold.dim_date;


GO
CREATE TABLE gold.dim_date
(
    date_key INT PRIMARY KEY, -- Format: YYYYMMDD
    full_date DATE NOT NULL,
    day TINYINT NULL,
    day_name NVARCHAR (20) NULL,
    day_of_week TINYINT NULL,
    month TINYINT NULL,
    month_name NVARCHAR (20) NULL,
    quarter TINYINT NULL,
    year SMALLINT NULL,
    year_month CHAR (7) NULL,
    is_weekend BIT NULL
);
