-- ISNULL() OR COALESCE()
/* TASK 2: 
   Display the full name of customers in a single field by merging their
   first and last names, and add 10 bonus points to each customer's score.
*/

SELECT
	CustomerID,
	FirstName,
	LastName,
	--CONCAT(FirstName,' ',LastName) AS FullName,
	FirstName + ' ' + COALESCE(LastName,'') AS FullName,
	Score,
	COALESCE(Score, 0) + 10 AS ScoreWithBonus
FROM Sales.Customers

