USE SPAIDW2B2305

-- Profit Insights

-- This query shows the total profit for each year, allowing us to see the trend in profits over time.
SELECT t.Year, SUM(order_facts.Price) AS TotalProfit
FROM OrderFacts AS order_facts
JOIN TimeDIM AS t ON order_facts.TimeKey = t.TimeKey
GROUP BY t.Year
ORDER BY t.Year ASC;

-- This query shows the total profit for each model type, allowing us to see which models are most profitable.
SELECT mtl.ModelType, SUM(order_facts.Price) AS TotalProfit
FROM OrderFacts AS order_facts
JOIN ModelDIM AS modelDIM ON order_facts.ModelKey = modelDIM.ModelKey
JOIN ModelTypeLookup AS mtl ON modelDIM.ModelCode = mtl.ModelCode
GROUP BY mtl.ModelType
ORDER BY TotalProfit DESC;


-- Customer and Orders Insights

-- This query shows the top 10 customers by total order value, allowing us to see who our most valuable customers are.
SELECT TOP 10 customerDIM.FirstName, customerDIM.LastName, SUM(order_facts.Price) AS TotalOrderValue
FROM OrderFacts AS order_facts
JOIN CustomerDIM AS customerDIM ON order_facts.CustomerKey = customerDIM.CustomerKey
GROUP BY customerDIM.FirstName, customerDIM.LastName
ORDER BY TotalOrderValue DESC;


-- This query shows the number of orders for each month, allowing us to see the distribution of orders throughout the year.
SELECT timeDIM.Month, COUNT(*) AS OrderCount
FROM OrderFacts AS order_facts
JOIN TimeDIM AS timeDIM ON order_facts.TimeKey = timeDIM.TimeKey
GROUP BY timeDIM.Month
ORDER BY OrderCount DESC;


-- Employee Insights

-- This query shows the top 5 employees by total sales, allowing us to see who are SPAI's top performers are.
SELECT TOP 5 employeeDIM.FirstName, employeeDIM.LastName, SUM(order_facts.Price) AS TotalSales
FROM OrderFacts AS order_facts
JOIN EmployeeDIM AS employeeDIM ON order_facts.EmployeeKey = employeeDIM.EmployeeKey
GROUP BY employeeDIM.FirstName, employeeDIM.LastName
ORDER BY TotalSales DESC;

-- This query shows the total sales for each gender, and total sales per each employee within that gender, allowing us to see if there are any differences in sales performance by gender per employee.

WITH GenderSales AS (
    SELECT employeeDIM.Gender, SUM(order_facts.Price) AS TotalSales
    FROM OrderFacts AS order_facts
    JOIN EmployeeDIM AS employeeDIM ON order_facts.EmployeeKey = employeeDIM.EmployeeKey
    GROUP BY employeeDIM.Gender
),
GenderCount AS (
    SELECT Gender, COUNT(*) AS EmployeeCount
    FROM EmployeeDIM
    GROUP BY Gender
)
SELECT gs.Gender, gs.TotalSales, gc.EmployeeCount, 
       (gs.TotalSales / gc.EmployeeCount) AS SalesPerPerson
FROM GenderSales AS gs
JOIN GenderCount AS gc ON gs.Gender = gc.Gender
ORDER BY SalesPerPerson DESC;