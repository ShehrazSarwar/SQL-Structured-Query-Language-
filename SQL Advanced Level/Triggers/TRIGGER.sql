-- ==================================
-- TRIGGER IN SQL - With Log Use Case
-- ==================================

-- Create a Table For Trigger
CREATE TABLE Sales.EmployeeLogs (
	LogID INT IDENTITY(1,1) PRIMARY KEY,
	EmployeeID INT,
	LogMessage VARCHAR(255),
	LogDate DATE
)

-- Creating Trigger
CREATE TRIGGER trg_AfterInsertEmployee ON Sales.Employees
AFTER INSERT
AS
BEGIN
	INSERT INTO Sales.EmployeeLogs (EmployeeID, LogMessage, LogDate)
	SELECT
		EmployeeID,
		'New Employee Added = ' + CAST(EmployeeID AS VARCHAR),
		GETDATE()
	FROM INSERTED
END


-- Checking Trigger By Inserting New Employees
INSERT INTO Sales.Employees
VALUES (8, 'Shehraz', 'Sarwar', 'DA', '2005-01-27', 'M', 80000, 3)

-- Check If Trigger Works
SELECT * FROM Sales.EmployeeLogs
SELECT * FROM Sales.Employees