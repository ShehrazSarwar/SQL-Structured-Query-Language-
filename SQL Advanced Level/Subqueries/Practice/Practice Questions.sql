/* QUESTION: Find the employees who's salary is more than the average salary earned by all employees. */
-- 1) find the avg salary
-- 2) filter employees based on the above avg salary

SELECT *
FROM EMPLOYEE
WHERE SALARY > (SELECT AVG(SALARY) FROM EMPLOYEE)
ORDER BY SALARY;

/* QUESTION: Find the employees who earn more than the average salary earned by all employees. */
-- it return exactly 1 row and 1 column

SELECT 
	E.*,
	A.Avg_Salary
FROM EMPLOYEE AS E
JOIN (SELECT AVG(SALARY) AS Avg_Salary FROM EMPLOYEE) AS A
ON E.SALARY > A.Avg_Salary
ORDER BY E.SALARY;

-- Multiple column, multiple row subquery
/* QUESTION: Find the employees who earn the highest salary in each department. */

-- Using JOIN
SELECT E.*
FROM EMPLOYEE AS E
JOIN 
(SELECT
	DEPT_NAME,
	MAX(SALARY) AS SALARY
FROM EMPLOYEE
GROUP BY DEPT_NAME) AS EE
ON E.DEPT_NAME = EE.DEPT_NAME
AND E.SALARY = EE.SALARY;

-- Using RANK() WINDOW 
SELECT *
FROM
(SELECT
	*,
	RANK() OVER(PARTITION BY DEPT_NAME ORDER BY SALARY DESC) AS RN
FROM EMPLOYEE) AS X
WHERE RN = 1;

-- Using Correlated Subquery
SELECT *
FROM EMPLOYEE AS E
WHERE SALARY = (
			SELECT
				MAX(SALARY)
			FROM EMPLOYEE
			WHERE E.DEPT_NAME = DEPT_NAME
);

-- Single column, multiple row subquery
/* QUESTION: Find department who do not have any employees */

SELECT *
FROM department
WHERE dept_name NOT IN (SELECT DISTINCT dept_name FROM EMPLOYEE);

--------------------------------------------------------------------------------
/* < CORRELATED SUBQUERY >
-- A subquery which is related to the Outer query
QUESTION: Find the employees in each department who earn more than the average salary in that department.
1) find the avg salary per department
2) filter data from employee tables based on avg salary from above result. */

SELECT *
FROM EMPLOYEE E
WHERE SALARY > (
SELECT
	AVG(SALARY)
FROM EMPLOYEE EE
WHERE EE.DEPT_NAME = E.DEPT_NAME)
ORDER BY E.DEPT_NAME, E.SALARY;


/* QUESTION: Find department who do not have any employees */
-- Using correlated subquery

SELECT *
FROM department D
WHERE NOT EXISTS (SELECT 1 FROM EMPLOYEE E WHERE D.DEPT_NAME = E.dept_name);


--------------------------------------------------------------------------------
/* < SUBQUERY inside SUBQUERY (NESTED Query/Subquery)> */
/* QUESTION: Find stores who's sales where better than the average sales accross all stores */

-- Using Having
SELECT
	store_id,
	store_name,
	SUM(price) AS TotalSale
FROM sales
GROUP BY store_id, store_name
HAVING SUM(price) > (
SELECT
	AVG(TotalSale)
FROM
(SELECT
	store_id,
	store_name,
	SUM(price) AS TotalSale
FROM sales
GROUP BY store_id, store_name) X )

-- Using JOIN
SELECT Sales.* 
FROM (
SELECT
	store_id,
	store_name,
	SUM(price) AS TotalSales
FROM sales
GROUP BY store_id, store_name
) AS Sales JOIN
(SELECT
	AVG(TotalSale) AS AVG_Sale
FROM
(SELECT
	store_id,
	store_name,
	SUM(price) AS TotalSale
FROM sales
GROUP BY store_id, store_name) X ) AvgSale
ON Sales.TotalSales > AvgSale.AVG_Sale

-- Using CTE
WITH CTE_Sales AS (
		SELECT
			store_id,
			store_name,
			SUM(price) AS TotalSale
		FROM sales
		GROUP BY store_id, store_name)
SELECT * FROM CTE_Sales
WHERE TotalSale > (SELECT AVG(TotalSale) FROM CTE_Sales);


--------------------------------------------------------------------------------
/* < USING SUBQUERY IN SELECT CLAUSE > */
/* QUESTION: Fetch all employee details and add remarks to those employees who earn more than the average pay. */

SELECT
	*,
	CASE WHEN SALARY > (SELECT AVG(SALARY) FROM EMPLOYEE) THEN 'Above Average Pay'
		 ELSE 'N/A'
	END AS Remarks
FROM EMPLOYEE

-- Alternative Way Using CROSS JOIN
SELECT
	E.*,
	CASE WHEN SALARY > AvgP.AvgPay THEN 'Above Average Pay'
		 ELSE 'N/A'
	END AS Remarks
FROM EMPLOYEE AS E
CROSS JOIN (SELECT AVG(SALARY) AS AvgPay FROM EMPLOYEE) AS AvgP


--------------------------------------------------------------------------------
/* < Using Subquery in HAVING clause > */
/* QUESTION: Find the stores who have sold more units than the average units sold by all stores. */

SELECT
	store_name,
	SUM(quantity) AS Total_Units
FROM sales
GROUP BY store_name
HAVING SUM(quantity) > (SELECT AVG(quantity) FROM sales)


-- SQL COMMANDS WHICH ALLOW A SUBQUERY
--------------------------------------------------------------------------------
/* < Using Subquery with INSERT statement > */
/* QUESTION: Insert data to employee history table. Make sure not insert duplicate records. */

-- TRUNCATE TABLE employee_history
INSERT INTO employee_history
SELECT 
	E.*, 
	D.location
FROM EMPLOYEE AS E
JOIN department AS D
ON D.dept_name = E.DEPT_NAME
WHERE NOT EXISTS (SELECT 1 FROM employee_history AS EH WHERE EH.emp_id = E.EMP_ID)

SELECT * FROM employee_history

--------------------------------------------------------------------------------
/* < Using Subquery with UPDATE statement > */
/* QUESTION: Give 10% increment to all employees in Bangalore location based on the maximum
salary earned by an emp in each dept. Only consider employees in employee_history table. */

UPDATE EMPLOYEE
SET SALARY = (SELECT MAX(SALARY) + (MAX(SALARY) * 0.1)
			  FROM employee_history EH
			  WHERE EH.dept_name = EMPLOYEE.DEPT_NAME)
WHERE DEPT_NAME IN (SELECT dept_name FROM department WHERE location = 'Bangalore')
AND EMP_ID IN (SELECT emp_id FROM employee_history);

--------------------------------------------------------------------------------
/* < Using Subquery with DELETE statement > */
/* QUESTION: Delete all departments who do not have any employees. */

-- First Check If Your Logic Works Before Deleting as It's A Risking Task
SELECT dept_name
    FROM department d2
    WHERE NOT EXISTS (
        SELECT 1
        FROM employee e
        WHERE e.dept_name = d2.dept_name
)

DELETE FROM department
WHERE NOT EXISTS (SELECT 1
				  FROM EMPLOYEE
				  WHERE department.dept_name = EMPLOYEE.DEPT_NAME);

SELECT * FROM department;