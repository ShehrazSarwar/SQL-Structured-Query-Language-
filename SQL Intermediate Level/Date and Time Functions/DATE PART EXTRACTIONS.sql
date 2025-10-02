/* 
   DATE PART EXTRACTIONS
   (DATETRUNC, DATENAME, DATEPART, YEAR, MONTH, DAY)

TASK 2:
   Extract various parts of CreationTime using DATETRUNC, DATENAME, DATEPART,
   YEAR, MONTH, and DAY.
*/

SELECT
    CreationTime,
	-- YEAR, MONTH, DAY
	YEAR(CreationTime) AS Year, 
	MONTH(CreationTime) AS Month,
	DAY(CreationTime) AS Day,
	-- DATEPART (Return INT)
	DATEPART(year, CreationTime) AS Year_dp,
	DATEPART(month, CreationTime) AS Month_dp,
	DATEPART(day, CreationTime) AS Day_dp,
	DATEPART(week, CreationTime) AS Week_dp,
	DATEPART(weekday, CreationTime) AS Weekday_dp,
	DATEPART(quarter, CreationTime) AS Quarter_dp,
	DATEPART(hour, CreationTime) AS Hour_dp, -- minute or second
	-- DATENAME (Return VARCHAR)
	DATENAME(year, CreationTime) AS Year_dn,
	DATENAME(month, CreationTime) AS Month_dn,
	DATENAME(week, CreationTime) AS Week_dn,
	DATENAME(weekday, CreationTime) AS Weekday_dn,
	-- DATETRUNC (Reset)
	DATETRUNC(minute, CreationTime) AS Min_dt,
	DATETRUNC(hour, CreationTime) AS Hour_dt,
	DATETRUNC(day, CreationTime) AS Day_dt,
	DATETRUNC(month, CreationTime) AS Month_dt,
	DATETRUNC(year, CreationTime) AS Year_dt
FROM Sales.Orders 