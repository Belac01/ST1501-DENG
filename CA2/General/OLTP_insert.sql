USE SPAI2B2305

-- DELETE BEFORE SUBMITTING
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Model;
DROP TABLE IF EXISTS ModelType;
DROP TABLE IF EXISTS Dataset;
DROP TABLE IF EXISTS Employee;
DROP TABLE IF EXISTS Customer;

-- Create Customer table
CREATE TABLE Customer (
    CustomerID VARCHAR(10) PRIMARY KEY,
    FirstName VARCHAR(20) NOT NULL,
    LastName VARCHAR(20) NOT NULL,
    CompanyName VARCHAR(50) NOT NULL,
    Contact VARCHAR(10)
);

CREATE TABLE Employee (
    EmployeeID VARCHAR(10) PRIMARY KEY,
    FirstName VARCHAR(20) NOT NULL,
    LastName VARCHAR(20) NOT NULL,
    Contact VARCHAR(10),
    Gender VARCHAR(6) NOT NULL  -- Adjusted to VARCHAR(6) instead of CHAR(1)
);

-- Create Dataset table
CREATE TABLE Dataset (
    DatasetID VARCHAR(10) PRIMARY KEY,
    DatasetName VARCHAR(50) NOT NULL
);

-- Create ModelType table
CREATE TABLE ModelType (
    ModelCode VARCHAR(10) PRIMARY KEY,
    ModelType VARCHAR(50) NOT NULL
);

-- Create Model table
CREATE TABLE Model (
    ModelID VARCHAR(10) PRIMARY KEY,
    ModelCode VARCHAR(10) NOT NULL,
    TrainingDate DATE NOT NULL,
    Accuracy DECIMAL(6,2) NOT NULL,
    DatasetID VARCHAR(10),
    FOREIGN KEY (ModelCode) REFERENCES ModelType(ModelCode),
    FOREIGN KEY (DatasetID) REFERENCES Dataset(DatasetID)
);

-- Create Orders table
CREATE TABLE Orders (
    OrderID VARCHAR(10) PRIMARY KEY,
	CustomerID VARCHAR(10) NOT NULL,
	EmployeeID VARCHAR(10) NOT NULL,
	ModelCode VARCHAR(10) NOT NULL,
	RequiredAcc DECIMAL(6,2) NOT NULL,
    OrderDate DATE NOT NULL,
    CompletionDate DATE,
    ModelID VARCHAR(10),
    Price INT NOT NULL,
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (ModelCode) REFERENCES ModelType(ModelCode),
    FOREIGN KEY (ModelID) REFERENCES Model(ModelID)
);

--##############################################################--

-- BULK INSERT into Customer table
BULK INSERT Customer
FROM 'C:\Studies\DENG\CA2\customer.csv'  
WITH (
    FIELDTERMINATOR = ',',  
    ROWTERMINATOR = '\n',   
    FIRSTROW = 2            
);

-- BULK INSERT into Employee table
BULK INSERT Employee
FROM 'C:\Studies\DENG\CA2\employee.csv'  
WITH (
    FIELDTERMINATOR = ',',  
    ROWTERMINATOR = '\n',   
    FIRSTROW = 2           
);

-- BULK INSERT into Dataset table
BULK INSERT Dataset
FROM 'C:\Studies\DENG\CA2\dataset.csv'  
WITH (
    FIELDTERMINATOR = ',',  
    ROWTERMINATOR = '\n',   
    FIRSTROW = 2            
);

-- BULK INSERT into ModelType table
BULK INSERT ModelType
FROM 'C:\Studies\DENG\CA2\modeltype.csv'  
WITH (
    FIELDTERMINATOR = ',',  
    ROWTERMINATOR = '\n',   
    FIRSTROW = 2            
);

-- BULK INSERT into Model table
BULK INSERT Model
FROM 'C:\Studies\DENG\CA2\model.csv'  
WITH (
    FIELDTERMINATOR = ',',  
    ROWTERMINATOR = '\n',   
    FIRSTROW = 2            
);

-- BULK INSERT into Order table
BULK INSERT Orders
FROM 'C:\Studies\DENG\CA2\order.csv'  
WITH (
    FIELDTERMINATOR = ',',  
    ROWTERMINATOR = '\n',   
    FIRSTROW = 2 
);

-- ##############################################################################

-- Select * to check data inserted are correct
SELECT * FROM Customer;
SELECT * FROM Employee;
SELECT * FROM Dataset;
SELECT * FROM ModelType;
SELECT * FROM Model;
SELECT * FROM Orders;

-- Verify by checking the tables 
SELECT COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Customer';

SELECT COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Employee';

SELECT COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Dataset';

SELECT COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'ModelType';

SELECT COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Model';

SELECT COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Orders';