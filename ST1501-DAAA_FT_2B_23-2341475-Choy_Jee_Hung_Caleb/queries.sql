--Q1
SELECT 
    (SELECT COUNT(*) FROM Models WHERE ParentModelID IS NULL) AS FreshModel,			-- Count the number of fresh models
    (SELECT COUNT(*) FROM Models WHERE ParentModelID IS NOT NULL) AS FinetunedModel;	-- Count the number of finetuned models



--Q2
SELECT 
    MT.ModelType,
    COUNT(M.ModelID) AS NumberUnassigned,									-- Count the number of unassigned models.
    CAST(ROUND(AVG(M.Accuracy), 1) AS DECIMAL(10,1)) AS MeanAccuracy,		-- Calculate the mean accuracy then rounded to one decimal place.
    ROUND(MAX(M.Accuracy), 1) AS MaxAccuracy								-- Find the maximum accuracy then rounded to one decimal place.
FROM 
    ModelTypes MT
JOIN 
    Models M ON MT.ModelType = M.ModelType				-- Join ModelTypes and Models tables on ModelType.
WHERE 
    M.ModelID NOT IN (									-- Filter out models that are already assigned.
        SELECT ModelID FROM ModelOrderAssignments
    )
GROUP BY 
    MT.ModelType										-- Group the results by ModelType.
HAVING 
    COUNT(M.ModelID) > 0								-- Filter out ModelTypes with no unassigned models.
ORDER BY 
    MT.ModelType ASC;									-- Order the results by ModelType in ascending order.



--Q3
SELECT 
    CONCAT(E.FirstName, ' ', E.LastName) AS FullName,	-- Concatenates first name and last name to form the full name.
    E.Contact,											-- Select the contact information of the employee.
    E.Gender											-- Select the gender of the employee.
FROM 
    Employees E											-- Select data from the Employees table.
WHERE 
    E.EmployeeID IN (									-- Filter employees based on their EmployeeID.
        SELECT 
            MOA.EmployeeID								-- Select the EmployeeID from ModelOrderAssignments table.
        FROM 
            ModelOrderAssignments MOA					-- Select data from ModelOrderAssignments table.
        GROUP BY 
            MOA.OrderID, MOA.EmployeeID					-- Group the results by OrderID and EmployeeID.
        HAVING 
            COUNT(MOA.ModelID) > 1						-- Filter out employees who are assigned to more than one model order.
    )
ORDER BY 
    FullName;											-- Order the results by the full name of the employees.



--Q4
SELECT 
    COUNT(*) AS NumberAccepted										-- Count the total number of accepted model order assignments.
FROM 
    ModelOrderAssignments MOA										-- Select data from the ModelOrderAssignments table.
INNER JOIN 
    Orders O ON MOA.OrderID = O.OrderID								-- Join ModelOrderAssignments with Orders based on OrderID.
INNER JOIN 
    Models M ON MOA.ModelID = M.ModelID								-- Join ModelOrderAssignments with Models based on ModelID.
LEFT JOIN 
    OrderModelTypes OMT ON O.OrderID = OMT.OrderID					-- Left join Orders with OrderModelTypes based on OrderID.
WHERE 
    MOA.DateAssigned <= O.CompletionDate							-- Filter assignments where the date assigned is before or on the completion date of the order.
    AND (M.ModelType = OMT.ModelType OR OMT.ModelType IS NULL)		-- Filter based on matching ModelType between Models and OrderModelTypes or if there's no specific ModelType required for the order.
    AND M.Accuracy >= O.RequiredAccuracy;							-- Filter assignments where the accuracy of the model meets or exceeds the required accuracy for the order.