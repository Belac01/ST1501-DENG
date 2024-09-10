use SPAI2B2305

-- Setting up the MongoDB Database --

-- Preparing the data for the Model Collection
SELECT
    M.ModelID AS 'ModelID',
    MT.ModelType AS 'ModelType',
    M.TrainingDate AS 'TrainingDate',
    M.Accuracy AS 'Accuracy',
    COUNT(O.OrderID) AS 'TotalOrdersAssigned'
FROM
    Model M
INNER JOIN
    ModelType MT ON M.ModelCode = MT.ModelCode
LEFT JOIN
    Orders O ON M.ModelID = O.ModelID
GROUP BY
    M.ModelID,
    MT.ModelType,
    M.TrainingDate,
    M.Accuracy
ORDER BY
    M.ModelID
FOR JSON PATH, ROOT('Models'); -- Converts to JSON form to copy the data for insertMany in MongoDB

-- Preparing the data for the Customer Collection
SELECT
    C.CustomerID AS 'CustomerID',
    CONCAT(C.FirstName, ' ', C.LastName) AS 'FullName',
    C.CompanyName AS 'CompanyName',
    C.Contact AS 'Contact',
    COUNT(O.OrderID) AS 'TotalOrders',
    SUM(O.Price) AS 'TotalPaymentMade'
FROM
    Customer C
LEFT JOIN
    Orders O ON C.CustomerID = O.CustomerID
GROUP BY
    C.CustomerID,
    C.FirstName,
    C.LastName,
    C.CompanyName,
    C.Contact
ORDER BY
    C.CustomerID
FOR JSON PATH, ROOT('Customers'); -- Converts to JSON form to copy the data for insertMany in MongoDB
