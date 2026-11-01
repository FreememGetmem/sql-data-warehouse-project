/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===============================================================================
Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files.
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the `BULK INSERT` command to load data from csv Files to bronze tables.

Parameters:
    None.
      This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC bronze.load_bronze;

Note:
    The BULK INSERT paths point to 'C:\sql\dwh_project\01_datasets\'.
    Change them to the folder where you saved the datasets.
===============================================================================
*/

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
    DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;
    BEGIN TRY
        SET @batch_start_time = GETDATE();
        PRINT '================================================================= ';
        PRINT 'Loading data into bronze layer...';
        PRINT '================================================================= ';

        PRINT '-------------------------------------';
        PRINT 'Loading CRM TAbles...';
        PRINT '-------------------------------------';

        SET @start_time = GETDATE();
        PRINT '>>> TRUNCATING TABLES: bronze.crm_cust_info';
        TRUNCATE TABLE DataWarehouse.bronze.crm_cust_info;

        PRINT '>>> Inserting Data Into: bronze.crm_cust_info';
        BULK INSERT DataWarehouse.bronze.crm_cust_info
        FROM 'D:\Data Academy Engineer\DE projects\SQL DW analytics\datas\source_crm\cust_info.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '************************************************';
        PRINT '>> Load duration for bronze.crm_cust_info: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS VARCHAR) + ' seconds';
        PRINT '************************************************';

        SET @start_time = GETDATE();
        PRINT '>>> TRUNCATING TABLES: DataWarehouse.bronze.crm_prd_info';
        TRUNCATE TABLE DataWarehouse.bronze.crm_prd_info;

        PRINT '>>> Inserting Data Into: bronze.crm_prd_info';
        BULK INSERT DataWarehouse.bronze.crm_prd_info
        FROM 'D:\Data Academy Engineer\DE projects\SQL DW analytics\datas\source_crm\prd_info.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '**************************************************';
        PRINT '>> Load duration for bronze.crm_prd_info: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS VARCHAR) + ' seconds';
        PRINT '**************************************************';

        SET @start_time = GETDATE();
        PRINT '>>> TRUNCATING TABLES: bronze.crm_sales_details';
        TRUNCATE TABLE DataWarehouse.bronze.crm_sales_details;

        PRINT '>>> Inserting Data Into: bronze.crm_sales_details';
        BULK INSERT DataWarehouse.bronze.crm_sales_details
        FROM 'D:\Data Academy Engineer\DE projects\SQL DW analytics\datas\source_crm\sales_details.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '******************************************************';
        PRINT '>> Load duration for bronze.crm_sales_details: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS VARCHAR) + ' seconds';
        PRINT '******************************************************';

        PRINT '-----------------------------------------';
        PRINT 'Loading ERP TAbles...';
        PRINT '-----------------------------------------';

        SET @start_time = GETDATE();
        PRINT '>>> TRUNCATING TABLES: bronze.erp_cust_az12';
        TRUNCATE TABLE DataWarehouse.bronze.erp_cust_az12;

        PRINT '>>> Inserting Data Into: bronze.erp_cust_az12';
        BULK INSERT DataWarehouse.bronze.erp_cust_az12
        FROM 'D:\Data Academy Engineer\DE projects\SQL DW analytics\datas\source_erp\cust_az12.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '*******************************************************';
        PRINT '>> Load duration for bronze.erp_cust_az12: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS VARCHAR) + ' seconds';
        PRINT '*******************************************************';

        SET @start_time = GETDATE();
        PRINT '>>> TRUNCATING TABLES: bronze.erp_loc_a101';
        TRUNCATE TABLE DataWarehouse.bronze.erp_loc_a101;

        PRINT '>>> Inserting Data Into: bronze.erp_loc_a101';
        BULK INSERT DataWarehouse.bronze.erp_loc_a101
        FROM 'D:\Data Academy Engineer\DE projects\SQL DW analytics\datas\source_erp\loc_a101.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '******************************************************';
        PRINT '>> Load duration for bronze.erp_loc_a101: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS VARCHAR) + ' seconds';
        PRINT '******************************************************';

        SET @start_time = GETDATE();
        PRINT '>>> TRUNCATING TABLES: bronze.erp_px_cat_g1v2';
        TRUNCATE TABLE DataWarehouse.bronze.erp_px_cat_g1v2;

        PRINT '>>> Inserting Data Into: bronze.erp_px_cat_g1v2';
        BULK INSERT DataWarehouse.bronze.erp_px_cat_g1v2
        FROM 'D:\Data Academy Engineer\DE projects\SQL DW analytics\datas\source_erp\px_cat_g1v2.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );
        SET @end_time = GETDATE();
        PRINT '**********************************************************';
        PRINT '>> Load duration for bronze.erp_px_cat_g1v2: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS VARCHAR) + ' seconds';
        PRINT '**********************************************************';
        SET @batch_end_time = GETDATE();
        PRINT '================================================================= ';
        PRINT 'Loading Bronze Layer is Completed Successfully.';
        PRINT '    - Total Load duration for bronze layer: ' + CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time) AS VARCHAR) + ' seconds';
        PRINT '================================================================= ';
    END TRY
    BEGIN CATCH
        PRINT '------------------------------------------------------';
        PRINT 'Error occurred while loading data into bronze layer.';
        PRINT 'Error Message: ' + ERROR_MESSAGE();
        PRINT 'Error Message: ' + CAST(ERROR_NUMBER() AS VARCHAR);
        PRINT 'Error Message: ' + CAST(ERROR_STATE() AS VARCHAR);
        PRINT '-------------------------------------------------------';
    END CATCH
END

