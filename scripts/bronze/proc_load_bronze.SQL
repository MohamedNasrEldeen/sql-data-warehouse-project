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
===============================================================================
*/

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME,@batch_end_time DATETIME;
	BEGIN TRY
		SET @batch_start_time = GETDATE();
		PRINT '==================================';
		PRINT 'Loading Bronze Layer';
		PRINT '= =================================';
		
		SET @start_time = GETDATE();
		PRINT '>> Truncating: bronze.LocalAuthority';
		TRUNCATE TABLE bronze.LocalAuthority;

		PRINT '>> Inserting Data Into: bronze.LocalAuthority';
		BULK INSERT bronze.LocalAuthority
		FROM 'E:\Courses\sql-Traffic_data-DWH\DataSets\LocalAuthority.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
		PRINT '---------------------';

		SET @start_time = GETDATE();
		PRINT '>> Truncating: bronze.Traffic';
		TRUNCATE TABLE bronze.Traffic;

		PRINT '>> Inserting Data Into: bronze.Traffic';
		BULK INSERT bronze.Traffic
		FROM 'E:\Courses\sql-Traffic_data-DWH\DataSets\Traffic.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
		PRINT '---------------------';

		SET @start_time = GETDATE();
		PRINT '>> Truncating: bronze.Location';
		TRUNCATE TABLE bronze.Location;

		PRINT '>> Inserting Data Into: bronze.Location';
		BULK INSERT bronze.Location
		FROM 'E:\Courses\sql-Traffic_data-DWH\DataSets\Location.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
		PRINT '---------------------';

		SET @start_time = GETDATE();
		PRINT '>> Truncating: bronze.Region';
		TRUNCATE TABLE bronze.Region;

		PRINT '>> Inserting Data Into: bronze.Region';
		BULK INSERT bronze.Region
		FROM 'E:\Courses\sql-Traffic_data-DWH\DataSets\Region.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
		PRINT '---------------------';

		SET @start_time = GETDATE();
		PRINT '>> Truncating: bronze.Road';
		TRUNCATE TABLE bronze.Road;

		PRINT '>> Inserting Data Into: bronze.Road';
		BULK INSERT bronze.Road
		FROM 'E:\Courses\sql-Traffic_data-DWH\DataSets\Road.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			ROWTERMINATOR = '0x0d0a',
			CODEPAGE = '65001',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
		PRINT '---------------------';

		SET @start_time = GETDATE();
		PRINT '>> Truncating: bronze.Date';
		TRUNCATE TABLE bronze.Date;

		PRINT '>> Inserting Data Into: bronze.Date';
		BULK INSERT bronze.Date
		FROM 'E:\Courses\sql-Traffic_data-DWH\DataSets\Date.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
	
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
		PRINT '---------------------';

		SET @batch_end_time = GETDATE();
		PRINT '=====================================';
		PRINT 'Loading Bronze Layer is completed';
		PRINT '	 - Toatal Load Duration: ' + CAST(DATEDIFF(SECOND,@batch_start_time, @batch_end_time) AS NVARCHAR)+ 'seconds';
		PRINT '=====================================';
	END TRY
	BEGIN CATCH
		PRINT '====================================='
		PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER'
		PRINT 'ERROR MESSAGE' + ERROR_MESSAGE();
		PRINT 'ERROR MESSAGE' + CAST(ERROR_NUMBER() AS NVARCHAR);
		PRINT 'ERROR MESSAGE' + CAST(ERROR_STATE() AS NVARCHAR);
		PRINT '====================================='
	END CATCH
END
