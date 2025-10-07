/* ==============================================================================
   NULLs vs EMPTY STRING vs BLANK SPACES
===============================================================================*/

/* TASK 8: 
   Demonstrate differences between NULL, empty strings, and blank spaces 
*/
WITH Orders AS (
    SELECT 1 AS Id, 'A' AS Category UNION
    SELECT 2, NULL UNION
    SELECT 3, '' UNION
    SELECT 4, '  '
)
SELECT 
    *,
    DATALENGTH(Category) AS LenCategory,
    TRIM(Category) AS Policy1
FROM Orders;

-- Remember LEN() Does Not Count Empty Spaces That's Why We Are Using DATALENGTH()