USE SPAIDW2B2305;

-- DELETE BEFORE SUBMITTING
DROP TABLE IF EXISTS OrderFacts;
DROP TABLE IF EXISTS OrderDIM;
DROP TABLE IF EXISTS CustomerDIM;
DROP TABLE IF EXISTS ModelDIM;
DROP TABLE IF EXISTS ModelTypeLookup;
DROP TABLE IF EXISTS DatasetDIM;
DROP TABLE IF EXISTS EmployeeDIM;
DROP TABLE IF EXISTS TimeDIM;

-- Create Order Dimension
CREATE TABLE OrderDIM (
	OrderKey INT IDENTITY(1,1) NOT NULL, -- INT IDENTITY(1,1) generates surrogate key starting with 1 and incrementing by 1. e.g. 1,2,3... reference: https://www.w3schools.com/sql/sql_autoincrement.asp
	OrderID VARCHAR(10) NOT NULL,
	RequiredAcc DECIMAL(6,2) NOT NULL,
	CompletionDate DATE NOT NULL,
	PRIMARY KEY (OrderKey)
);

-- Create Customer Dimension
CREATE TABLE CustomerDIM (
    CustomerKey INT IDENTITY(1,1) NOT NULL,
	CustomerID VARCHAR(10) NOT NULL,
    FirstName VARCHAR(20) NOT NULL,
    LastName VARCHAR(20) NOT NULL,
    CompanyName VARCHAR(50) NOT NULL,
    Contact VARCHAR(10),
	PRIMARY KEY (CustomerKey)
);

-- Create ModelType Lookup table
CREATE TABLE ModelTypeLookup (
    ModelCode VARCHAR(10) NOT NULL,
    ModelType VARCHAR(50) NOT NULL,
	PRIMARY KEY (ModelCode)
);

-- Create Model Dimension
CREATE TABLE ModelDIM (
    ModelKey INT IDENTITY(1,1) NOT NULL,
	ModelID VARCHAR(10) NOT NULL,
    ModelCode VARCHAR(10) NOT NULL,
    TrainingDate DATE NOT NULL,
    Accuracy DECIMAL(6,2) NOT NULL,
	PRIMARY KEY (ModelKey),
    FOREIGN KEY (ModelCode) REFERENCES ModelTypeLookup(ModelCode),
);

-- Create Dataset Dimension
CREATE TABLE DatasetDIM (
    DatasetKey INT IDENTITY(1,1) NOT NULL,
	DatasetID VARCHAR(10) NOT NULL,
    DatasetName VARCHAR(50) NOT NULL,
	PRIMARY KEY (DatasetKey)
);

-- Create Employee Dimension
CREATE TABLE EmployeeDIM (
    EmployeeKey INT IDENTITY(1,1) NOT NULL,
	EmployeeID VARCHAR(10) NOT NULL,
    FirstName VARCHAR(20) NOT NULL,
    LastName VARCHAR(20) NOT NULL,
    Contact VARCHAR(10),
    Gender VARCHAR(6) NOT NULL,
	PRIMARY KEY (EmployeeKey)
);

-- Create Time Dimension
CREATE TABLE TimeDIM (
	[TimeKey] INT IDENTITY(1,1) PRIMARY KEY, 
	[Date] DATE,
	[Year] CHAR(4),-- Year value of Date stored in the row, e.g. 2015, 2016
	[Quarter] CHAR(1),
	[Month] VARCHAR(2), -- Number of the Month 1 to 12, January to December
	[DayOfMonth] VARCHAR(2) -- Day number of Month e.g. 1,2,...25...
);

-- Create Order Fact table
CREATE TABLE OrderFacts (
	TimeKey INT NOT NULL,
	OrderKey INT NOT NULL,
	CustomerKey INT NOT NULL,
	EmployeeKey INT NOT NULL,
	ModelKey INT NOT NULL,
	DatasetKey INT NOT NULL,
    Price INT NOT NULL,
	PRIMARY KEY (TimeKey,OrderKey,CustomerKey,EmployeeKey,ModelKey,DatasetKey)
);


ALTER TABLE OrderFacts  ADD FOREIGN KEY (CustomerKey) REFERENCES CustomerDIM(CustomerKey);
ALTER TABLE OrderFacts  ADD FOREIGN KEY (EmployeeKey) REFERENCES EmployeeDIM(EmployeeKey);
ALTER TABLE OrderFacts  ADD FOREIGN KEY (OrderKey) REFERENCES OrderDIM(OrderKey);
ALTER TABLE OrderFacts  ADD FOREIGN KEY (ModelKey) REFERENCES ModelDIM(ModelKey);
ALTER TABLE OrderFacts  ADD FOREIGN KEY (TimeKey) REFERENCES TimeDIM(TimeKey);
ALTER TABLE OrderFacts  ADD FOREIGN KEY (DatasetKey) REFERENCES DatasetDIM(DatasetKey);
