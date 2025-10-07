-- ISSUE: Sql not join the rows where there is NULL
-- So we need to use ISNULL() or COALESCE
/*
SELECT
	a.year,
	a.type,
	a.orders,
	b.sales
FROM table1 AS a
JOIN table2 AS b
ON a.year = b.year
AND ISNULL(a.type,'') = ISNULL(b.type,'')
*/
-- ISNULL or COALESCE will not effect the output because it's not selected
