-- CREATE Customers table
CREATE TABLE Customers (
    CustomerID VARCHAR(255) NOT NULL PRIMARY KEY,
    FirstName VARCHAR(255) NOT NULL,
    LastName VARCHAR(255) NOT NULL,
    Contact VARCHAR(255) NOT NULL,
    CompanyName VARCHAR(255) NOT NULL
);

-- CREATE Employees table
CREATE TABLE Employees (
    EmployeeID VARCHAR(255) NOT NULL PRIMARY KEY,
    FirstName VARCHAR(255) NOT NULL,
    LastName VARCHAR(255) NOT NULL,
    Contact VARCHAR(255) NOT NULL,
    Gender CHAR(1) NOT NULL
);

-- Create Datasets table
CREATE TABLE Datasets (
    DatasetID VARCHAR(255) NOT NULL PRIMARY KEY,
    DatasetName VARCHAR(255) NOT NULL
);

-- CREATE ModelTypes table
CREATE TABLE ModelTypes (
    ModelType VARCHAR(255) NOT NULL PRIMARY KEY,
    ModelCode VARCHAR(255) NOT NULL
);

-- CREATE Models table
CREATE TABLE Models (
    ModelID VARCHAR(255) NOT NULL PRIMARY KEY,
    ModelType VARCHAR(255) NOT NULL,
    TrainingDate DATE NOT NULL,
    Accuracy DECIMAL(5, 1) NOT NULL,
    ParentModelID VARCHAR(255),
    DatasetID VARCHAR(255) NOT NULL,
    FOREIGN KEY (ModelType) REFERENCES ModelTypes(ModelType),
    FOREIGN KEY (ParentModelID) REFERENCES Models(ModelID),
    FOREIGN KEY (DatasetID) REFERENCES Datasets(DatasetID)
);

-- CREATE Orders table
CREATE TABLE Orders (
    OrderID VARCHAR(255) NOT NULL PRIMARY KEY,
    CustomerID VARCHAR(255) NOT NULL,
    OrderDate DATE NOT NULL,
    CompletionDate DATE NOT NULL,
    RequiredAccuracy DECIMAL(5, 1) NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- CREATE OrderModelTypes table
CREATE TABLE OrderModelTypes (
    OrderModelTypeID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    OrderID VARCHAR(255) NOT NULL,
    ModelType VARCHAR(255),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ModelType) REFERENCES ModelTypes(ModelType)
);


-- CREATE ModelOrderAssignments table
CREATE TABLE ModelOrderAssignments (
    AssignmentID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    OrderID VARCHAR(255) NOT NULL,
    ModelID VARCHAR(255) NULL,
    EmployeeID VARCHAR(255) NULL,
    DateAssigned DATE NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ModelID) REFERENCES Models(ModelID),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);

--####################################################################--

-- INSERT data into Customers table
INSERT INTO Customers (CustomerID, FirstName, LastName, Contact, CompanyName) VALUES
('c1231', 'Macie', 'Chew', '21313445', 'Power AI Ltd.'),
('c2231', 'June', 'Gu', '23591312', 'Fish and Dogs'),
('c3231', 'Miller', 'Wu', '34513265', 'Smart Commute'),
('c4231', 'Paul', 'Halim', '11390442', 'B&C Furniture'),
('c5231', 'Bella', 'Tan', '75813435', 'City Drainage'),
('c6231', 'Kiara', 'Sakura', '24634521', 'City Power'),
('c7231', 'Bowen', 'Han', '75643524', 'Country Development');

-- INSERT data into Employees table
INSERT INTO Employees (EmployeeID, FirstName, LastName, Contact, Gender) VALUES
('s1111', 'Peter', 'Phua', '142524124', 'M'),
('s2222', 'George', 'Mason', '344324251', 'M'),
('s3333', 'Francis', 'Lee', '234235246', 'M'),
('s4444', 'Alice', 'Wong', '324567342', 'F'),
('s5555', 'William', 'Chong', '893456114', 'M'),
('s6666', 'Brilliant', 'Dior', '907456251', 'F');

-- INSERT data into Datasets table
INSERT INTO Datasets (DatasetID, DatasetName) VALUES
('d1', 'Adult'),
('d2', 'River'),
('d3', 'Arizona'),
('d4', 'Vermont'),
('d5', 'Covertype'),
('d6', 'Iris');

-- Insert data into ModelTypes Table
INSERT INTO ModelTypes (ModelType, ModelCode) VALUES
('Decision Tree', 'DT' ),
('Linear Regression', 'LR'),
('Random Forest', 'RF'),
('k-Nearest Neighbour', 'kNN'),
('Support Vector Machine', 'NB'),
('Naive Bayes', 'NB'),
('Neural Network', 'NN'),
('Logistic Regression', 'LogR');

-- INSERT data into Models table
INSERT INTO Models (ModelID, ModelType, TrainingDate, Accuracy, ParentModelID, DatasetID) VALUES
('m1000', 'Decision Tree', '2024-01-01', 95.6, NULL, 'd1'),
('m1001', 'Linear Regression', '2024-01-05', 60.4, NULL, 'd2'),
('m1002', 'Random Forest', '2024-01-07', 95.3, NULL, 'd3'),
('m1003', 'Decision Tree', '2024-01-08', 53.2, NULL, 'd4'),
('m1004', 'Linear Regression', '2024-01-11', 52.9, NULL, 'd2'),
('m1005', 'Linear Regression', '2024-01-15', 91.7, 'm1001', 'd5'),
('m1006', 'Random Forest', '2024-01-17', 85.7, NULL, 'd3'),
('m1007', 'k-Nearest Neighbour', '2024-01-22', 85.7, NULL, 'd5'),
('m1008', 'Support Vector Machine', '2024-01-23', 50.6, NULL, 'd3'),
('m1009', 'k-Nearest Neighbour', '2024-01-24', 51.9, 'm1007', 'd2'),
('m1010', 'Decision Tree', '2024-01-27', 93.7, 'm1003', 'd2'),
('m1011', 'Support Vector Machine', '2024-01-30', 83.1, NULL, 'd4'),
('m1012', 'Support Vector Machine', '2024-02-06', 97.6, 'm1011', 'd2'),
('m1013', 'k-Nearest Neighbour', '2024-02-07', 90.3, 'm1009', 'd2'),
('m1014', 'k-Nearest Neighbour', '2024-02-08', 59.3, NULL, 'd2'),
('m1015', 'Random Forest', '2024-02-12', 59.4, 'm1006', 'd6'),
('m1016', 'Naive Bayes', '2024-03-04', 70.6, NULL, 'd3'),
('m1017', 'Neural Network', '2024-03-06', 95.5, NULL, 'd6'),
('m1018', 'Logistic Regression', '2024-03-12', 54.1, NULL, 'd2'),
('m1019', 'Neural Network', '2024-03-15', 96.8, NULL, 'd6'),
('m1020', 'Neural Network', '2024-03-17', 85.5, 'm1019', 'd4'),
('m1021', 'Logistic Regression', '2024-03-21', 60.2, NULL, 'd5'),
('m1022', 'Random Forest', '2024-03-22', 67.1, NULL, 'd4'),
('m1023', 'Neural Network', '2024-03-27', 90.5, 'm1020', 'd6'),
('m1024', 'Random Forest', '2024-03-28', 85.9, 'm1015', 'd3');

-- INSERT data into Orders table
INSERT INTO Orders (OrderID, CustomerID, OrderDate, CompletionDate, RequiredAccuracy) VALUES
('o080214', 'c5231', '2024-04-21', '2024-04-22', 70.0),
('o241134', 'c7231', '2024-05-01', '2024-07-01', 99.9),
('o214132', 'c7231', '2024-04-08', '2024-05-01', 50.0),
('o174143', 'c7231', '2024-04-14', '2024-04-18', 70.0),
('o22031', 'c2231', '2024-04-05', '2024-04-27', 50.0),
('o31421', 'c6231', '2024-04-11', '2025-01-01', 1.0),
('o00001', 'c1231', '2024-05-02', '2024-05-31', 60.0),
('o11213', 'c1231', '2024-04-03', '2024-04-11', 80.0),
('o12345', 'c3231', '2024-04-05', '2024-06-30', 77.0),
('o12346', 'c3231', '2024-04-05', '2024-04-30', 56.0);

-- INSERT data into OrderModelTypes table
INSERT INTO OrderModelTypes (OrderID, ModelType) VALUES
('o080214', 'Decision Tree'),
('o241134', NULL),
('o214132', NULL),
('o174143', NULL),
('o22031', NULL),
('o31421', NULL),
('o00001', 'Support Vector Machine'),
('o00001', 'Random Forest'),
('o11213', 'Support Vector Machine'),
('o12345', NULL),
('o12346', NULL);

-- INSERT data into ModelOrderAssignments table
INSERT INTO ModelOrderAssignments (OrderID, ModelID, EmployeeID, DateAssigned) VALUES
('o080214', 'm1018', 's2222', '2024-04-22'),
('o080214', 'm1003', 's3333', '2024-04-22'),
('o080214', 'm1010', 's4444', '2024-04-22'),
('o214132', 'm1021', 's5555', '2024-04-09'),
('o174143', 'm1008', 's4444', '2024-04-14'),
('o22031', 'm1013', 's1111', '2024-04-11'),
('o22031', 'm1013', 's3333', '2024-04-12'),
('o22031', 'm1013', 's2222', '2024-04-15'),
('o22031', 'm1013', 's4444', '2024-04-07'),
('o22031', 'm1013', 's6666', '2024-04-27'),
('o22031', 'm1013', 's5555', '2024-04-28'),
('o22031', 'm1022', 's1111', '2024-04-19'),
('o31421', 'm1001', 's2222', '2024-04-15'),
('o31421', 'm1002', 's2222', '2024-04-15'),
('o00001', 'm1012', 's1111', '2024-05-02'),
('o00001', 'm1022', 's6666', '2024-05-02'),
('o00001', 'm1013', 's5555', '2024-05-02'),
('o11213', 'm1003', 's3333', '2024-04-10'),
('o11213', 'm1011', 's3333', '2024-04-08'),
('o11213', 'm1012', 's3333', '2024-04-09'),
('o11213', 'm1012', 's4444', '2024-04-04'),
('o12345', 'm1018', 's1111', '2024-05-31'),
('o12345', 'm1019', 's3333', '2024-05-31'),
('o12346', 'm1015', 's2222', '2024-05-31'),
('o12346', 'm1023', 's4444', '2024-05-31'),
('o12346', 'm1021', 's6666', '2024-05-31')


-- SELECT * to check if tables and data are correct
SELECT * FROM Customers
SELECT * FROM Employees
SELECT * FROM Datasets
SELECT * FROM Models
SELECT * FROM Orders
SELECT * FROM ModelTypes
SELECT * FROM OrderModelTypes
SELECT * FROM ModelOrderAssignments