/* SET OPERATORS RULES (UNION, UNION ALL, EXCEPT, INTERSECT)
   1. ORDER BY allowed only at the end (final result).
   2. Number of columns must match.
   3. Column order must match.
   4. Column data types must be compatible.
   5. First query decides column names (aliases in later queries ignored).
*/

SELECT
	FirstName,
	LastName
FROM sales.Customers

UNION

SELECT
	FirstName,
	LastName
FROM sales.Employees