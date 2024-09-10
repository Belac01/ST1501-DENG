USE SPAIDW2B2305;

-- Insert data into CustomerDIM
INSERT INTO SPAIDW2B2305..CustomerDIM (CustomerID, FirstName, LastName, CompanyName, Contact)
SELECT CustomerID, FirstName, LastName, CompanyName, Contact
FROM SPAI2B2305..Customer;

-- Insert data into OrderDIM
INSERT INTO SPAIDW2B2305..OrderDIM (OrderID, RequiredAcc, CompletionDate)
SELECT OrderID, RequiredAcc, CompletionDate
FROM SPAI2B2305..Orders;

-- Insert data into ModelTypeLookup
INSERT INTO SPAIDW2B2305..ModelTypeLookup (ModelCode, ModelType)
SELECT ModelCode, ModelType
FROM SPAI2B2305..ModelType;

-- Insert data into ModelDIM
INSERT INTO SPAIDW2B2305..ModelDIM (ModelID, ModelCode, TrainingDate, Accuracy)
SELECT ModelID, ModelCode, TrainingDate, Accuracy
FROM SPAI2B2305..Model;

-- Insert data into DatasetDIM
INSERT INTO SPAIDW2B2305..DatasetDIM (DatasetID, DatasetName)
SELECT DatasetID, DatasetName
FROM SPAI2B2305..Dataset;

-- Insert data into EmployeeDIM
INSERT INTO SPAIDW2B2305..EmployeeDIM (EmployeeID, FirstName, LastName, Contact, Gender)
SELECT EmployeeID, FirstName, LastName, Contact, Gender
FROM SPAI2B2305..Employee;

-- Insert data into TimeDIM

-- Get the minimum and maximum dates from the Orders table
DECLARE @MinDate DATE, @MaxDate DATE;

SELECT 
    @MinDate = MIN(OrderDate),
    @MaxDate = MAX(OrderDate)
FROM SPAI2B2305..Orders;

-- Generate a list of all dates within the date range
WITH DateRange AS (
    SELECT @MinDate AS [Date]
    UNION ALL
    SELECT DATEADD(DAY, 1, [Date])
    FROM DateRange
    WHERE DATEADD(DAY, 1, [Date]) <= @MaxDate
)

-- Insert into TimeDIM
INSERT INTO SPAIDW2B2305..TimeDIM ([Date], [Year], [Quarter], [Month], [DayOfMonth])
SELECT 
    [Date], 
    CAST(YEAR([Date]) AS CHAR(4)) AS [Year],
    CAST(DATEPART(QUARTER, [Date]) AS CHAR(1)) AS [Quarter],
    RIGHT('0' + CAST(MONTH([Date]) AS VARCHAR(2)), 2) AS [Month],
    RIGHT('0' + CAST(DAY([Date]) AS VARCHAR(2)), 2) AS [DayOfMonth]
FROM DateRange
ORDER BY [Date]
OPTION (MAXRECURSION 0);  -- Allow recursion to continue beyond the default 100 levels

-- Insert data into OrderFacts
INSERT INTO SPAIDW2B2305..OrderFacts (TimeKey, OrderKey, CustomerKey, EmployeeKey, ModelKey, DatasetKey, Price)
SELECT 
    t.TimeKey, 
    o.OrderKey, 
    c.CustomerKey, 
    e.EmployeeKey, 
    m.ModelKey, 
    d.DatasetKey, 
    o1.Price
FROM SPAI2B2305..Orders o1
JOIN SPAIDW2B2305..OrderDIM o ON o1.OrderID = o.OrderID
JOIN SPAIDW2B2305..CustomerDIM c ON o1.CustomerID = c.CustomerID
JOIN SPAIDW2B2305..EmployeeDIM e ON o1.EmployeeID = e.EmployeeID
JOIN SPAIDW2B2305..ModelDIM m ON o1.ModelID = m.ModelID
JOIN SPAIDW2B2305..TimeDIM t ON t.Date = o1.OrderDate
JOIN SPAI2B2305..Model m1 ON o1.ModelID = m1.ModelID
JOIN SPAIDW2B2305..DatasetDIM d ON d.DatasetID = m1.DatasetID;

-- #############################################################################################################

-- SELECT * to view the data inserted
SELECT * FROM CustomerDIM;
SELECT * FROM EmployeeDIM;
SELECT * FROM DatasetDIM;
SELECT * FROM ModelTypeLookup;
SELECT * FROM ModelDIM;
SELECT * FROM TimeDIM;
SELECT * FROM OrderDIM;
SELECT * FROM OrderFacts;
