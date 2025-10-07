-- USE CASE: HANDLING NULLS

/* TASK 4: 
   Calculate the average score of customers, treating NULL as 0,
   and provide CustomerID and LastName details.
*/

SELECT
    CustomerID,
    LastName,
    Score,
	AVG(Score) OVER () AS AvgCustomer,
    CASE
        WHEN Score IS NULL THEN 0
        ELSE Score
    END AS ScoreClean,
    AVG(
        CASE
            WHEN Score IS NULL THEN 0
            ELSE Score
        END
    ) OVER () AS AvgCustomerClean
FROM Sales.Customers