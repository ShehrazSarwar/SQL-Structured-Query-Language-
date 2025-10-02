-- HardCoded & GETDATE()
/* TASK 1:
   Display OrderID, CreationTime, a hard-coded date, and the current system date.
*/

SELECT
	OrderID,
	CreationTime,
	'2025-08-20' AS HardCoded,
	GETDATE() AS Today
FROM Sales.Orders