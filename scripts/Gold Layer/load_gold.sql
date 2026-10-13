
EXECUTE [gold].[load_date_dim] ;


GO
CREATE OR ALTER VIEW [gold].[dim_customers]
AS
    (SELECT ROW_NUMBER() OVER (ORDER BY silver.crm_cust_info.cst_id) AS customer_key,
            silver.crm_cust_info.cst_id AS customer_id,
            silver.crm_cust_info.cst_key AS customer_number,
            silver.crm_cust_info.cst_firstname AS first_name,
            silver.crm_cust_info.cst_lastname AS last_name,
            silver.erp_cust_az12.bdate AS birthdate,
            silver.erp_loc_a101.cntry AS country,
            silver.crm_cust_info.cst_marital_status AS marital_status,
            CASE WHEN silver.crm_cust_info.[cst_gndr] != N'n/a' THEN silver.crm_cust_info.[cst_gndr] ELSE COALESCE (silver.erp_cust_az12.gen, N'n/a') END AS gender,
            c_date.[date_key] AS create_date_key
     FROM   silver.crm_cust_info
            LEFT OUTER JOIN
            silver.erp_cust_az12
            ON silver.crm_cust_info.cst_key = silver.erp_cust_az12.cid
            LEFT OUTER JOIN
            silver.erp_loc_a101
            ON silver.crm_cust_info.cst_key = silver.erp_loc_a101.cid
            INNER JOIN
            [gold].[dim_date] AS c_date
            ON c_date.[full_date] = silver.crm_cust_info.cst_create_date);


GO
CREATE OR ALTER VIEW [gold].[dim_products]
AS
    (SELECT ROW_NUMBER() OVER (ORDER BY [crm_prd_info].prd_key) AS product_key,
            prd_id AS product_id,
            [prd_key] AS product_number,
            [prd_nm] AS product_name,
            [cat_key] AS category_id,
            [cat] AS category,
            [subcat] AS sub_category,
            [prd_cost] AS product_cost,
            [prd_line] AS product_line,
            p_start_date.date_key AS product_start_date_key,
            p_end_date.date_key AS product_end_date_key,
            [maintenance]
     FROM   [silver].[crm_prd_info]
            LEFT OUTER JOIN
            [silver].[erp_px_cat_g1v2]
            ON [erp_px_cat_g1v2].id = [crm_prd_info].[cat_key]
            INNER JOIN
            [gold].[dim_date] AS p_start_date
            ON p_start_date.[full_date] = [crm_prd_info].[prd_start_dt]
            INNER JOIN
            [gold].[dim_date] AS p_end_date
            ON p_end_date.[full_date] = ISNULL([crm_prd_info].[prd_end_dt], '1900-01-01'));


GO
CREATE OR ALTER VIEW [gold].[fact_sales]
AS
    (SELECT silver.crm_sales_details.sls_ord_num AS order_number,
            gold.dim_customers.customer_key,
            gold.dim_products.product_key,
            crm_sales_details.prd_id,
            order_date.[date_key] AS order_date_key,
            ship_date.[date_key] AS ship_date_key,
            due_date.[date_key] AS due_date_key,
            silver.crm_sales_details.sls_sales AS sales_amount,
            silver.crm_sales_details.sls_quantity AS quantity,
            silver.crm_sales_details.sls_price AS price,
            silver.crm_sales_details.is_return,
            silver.crm_sales_details.tax_amount,
            silver.crm_sales_details.tax_percentage,
            silver.crm_sales_details.profit,
            silver.crm_sales_details.prd_source_type AS product_source_type,
            silver.crm_sales_details.prd_source_id AS product_source_id
     FROM   silver.crm_sales_details
            LEFT OUTER JOIN
            gold.dim_customers
            ON gold.dim_customers.customer_id = silver.crm_sales_details.sls_cust_id
            LEFT OUTER JOIN
            gold.dim_products
            ON gold.dim_products.product_id = crm_sales_details.prd_id
            INNER JOIN
            [gold].[dim_date] AS ship_date
            ON ship_date.[full_date] = silver.crm_sales_details.sls_ship_dt
            INNER JOIN
            [gold].[dim_date] AS order_date
            ON order_date.[full_date] = silver.crm_sales_details.sls_order_dt
            INNER JOIN
            [gold].[dim_date] AS due_date
            ON due_date.[full_date] = silver.crm_sales_details.sls_due_dt);