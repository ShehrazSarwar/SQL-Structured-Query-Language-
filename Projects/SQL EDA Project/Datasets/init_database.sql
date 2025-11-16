/* ======================================================================================================
   Script: Data Warehouse Initialization Script
   Author: Shehraz Sarwar
   Date: 11/8/2025

   Purpose:
       - This script sets up a clean Data Warehouse environment from scratch.
       - It drops the existing 'DataWarehouse' database (if it exists) and recreates it.
       - It then creates three schemas — bronze, silver, and gold — representing
         the data ingestion, transformation, and analytics layers respectively.

   WARNING:
       - Running this script will PERMANENTLY DELETE the existing 'DataWarehouse' database 
         along with ALL its data, tables, and objects.
       - The command "ALTER DATABASE ... SET SINGLE_USER WITH ROLLBACK IMMEDIATE" 
         will forcibly disconnect all active connections and rollback uncommitted transactions.
       - Use this script ONLY in development or test environments, or ensure you have a full backup 
         before execution.

   ====================================================================================================== */

USE master;
GO

-- Drop and recreate the 'DataWarehouse' database
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN
	ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE DataWarehouse
END;
GO

-- Create Database 'DataWarehouse'
CREATE DATABASE DataWarehouse;
GO

USE DataWarehouse;
GO

-- Create Schemas
CREATE SCHEMA bronze;
GO
CREATE SCHEMA silver;
GO
CREATE SCHEMA gold;
GO