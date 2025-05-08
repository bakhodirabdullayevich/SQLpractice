-- Lesson 2: DDL and DML Commands
-- Basic-Level Tasks (10)
-- 1. Create a table Employees with columns: EmpID INT, Name (VARCHAR(50)), and Salary (DECIMAL(10,2)).

CREATE TABLE Employees (
	EmpID INT, 
	Name VARCHAR(50), 
	Salary DECIMAL(10,2)
);

-- 2. Insert three records into the Employees table using different INSERT INTO approaches (single-row insert and multiple-row insert).
INSERT INTO Employees (EmpID, Name, Salary)
	VALUES (1, 'Akbar', 1500.00);

INSERT INTO Employees (EmpID, Name, Salary)
	VALUES	(2, 'Umar', 2000.00),
			(3, 'Hanna', 1500.00),
			(4, 'Nussa', 3000.00);
INSERT INTO Employees VALUES (5, 'Ali', 2500.00);
INSERT INTO Employees VALUES (6, 'Vali', 3500.00), (7, 'Halil', 1200.00);
SELECT * FROM Employees;

-- 3. Update Salary where EmpID = 1
UPDATE Employees
SET Salary = 7000.00
WHERE EmpID = 1;

-- 4. Delete a record from the Employees table where EmpID = 2.
DELETE FROM Employees 
WHERE EmpID = 2;

-- 5. Give a brief definition for difference between DELETE, TRUNCATE, and DROP.
/* 
DELETE
Used to remove specific rows from a table.
- Supports WHERE clause to filter which rows to delete.
- Can be rolled back if inside a transaction.
- Fully logged in the transaction log (each deleted row is recorded).
- Table structure and schema stay intact.
- Identity column values are not reset.

Example:
DELETE FROM Employees WHERE Salary < 5000;

TRUNCATE
Used to quickly remove all rows from a table.
- Does not support WHERE clause.
- Can be rolled back only if used inside a transaction.
- Minimally logged (much faster than DELETE).
- Table structure remains, but:
- Identity values are reset to the seed.

Example:
TRUNCATE TABLE Employees;

DROP
Used to completely delete a table (or other database object).
- Removes the table, all its data, structure, constraints, and indexes.
- Cannot be recovered unless you restore from backup or undo the transaction (if used).
- Rollback is possible only if inside an explicit transaction.
- Destroys everything related to the object.

Example:
DROP TABLE Employees;

Summary:
Feature					        DELETE				    TRUNCATE					        DROP
Removes data			      ✅ Specific rows	✅ All rows					      ✅ Entire table
Supports WHERE		      ✅ Yes				    ❌ No						        ❌ No
Rollback possible	      ✅ Yes				    ⚠️ Only in transactions		⚠️ In transactions only
Logs each row			      ✅ Fully logged	❌ Minimally logged			  ❌ No logging
Keeps table structure	  ✅ Yes				    ✅ Yes						        ❌ No
Resets identity column	❌ No				      ✅ Yes						        ❌ Not applicable
Speed					          ❌ Slower			    ✅ Faster					      ✅ Fastest (removes all)
*/

-- 6. Modify the Name column in the Employees table to VARCHAR(100).
ALTER TABLE Employees
ALTER COLUMN Name VARCHAR(100);

-- 7. Add a new column Department (VARCHAR(50)) to the Employees table.
ALTER TABLE Employees
ADD Department VARCHAR(50);

-- 8. Change the data type of the Salary column to FLOAT.
ALTER TABLE Employees
ALTER COLUMN Salary FLOAT;

-- 9. Create another table Departments with columns DepartmentID (INT, PRIMARY KEY) and DepartmentName (VARCHAR(50)).
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50)
);

-- 10. Remove all records from the Employees table without deleting its structure.
TRUNCATE TABLE Employees;

-- Intermediate-Level Tasks (6)
-- '1. Insert five records into the Departments table using INSERT INTO SELECT method(you can write anything you want as data).
INSERT INTO Departments (DepartmentID, DepartmentName)
SELECT 1, 'HR' UNION ALL
SELECT 2, 'IT' UNION ALL
SELECT 3, 'Finance' UNION ALL
SELECT 4, 'Marketing' UNION ALL
SELECT 5, 'Operations';

SELECT * FROM Employees;
-- 2. Update the Department of all employees where Salary > 5000 to 'Management'.
UPDATE Employees
SET Department = 'Management'
WHERE Salary > 5000;

-- 3. Write a query that removes all employees but keeps the table structure intact.
DELETE FROM Employees;

-- 4. Drop the Department column from the Employees table.
ALTER TABLE Employees
DROP COLUMN Department;

-- 5. Rename the Employees table to StaffMembers using SQL commands.
EXEC sp_rename 'Employees', 'StaffMembers';

-- 6. Write a query to completely remove the Departments table from the database.
DROP TABLE Departments;

-- Advanced-Level Tasks (9)
-- 1. Create a table named Products with at least 5 columns, including: ProductID (Primary Key), ProductName (VARCHAR), Category (VARCHAR), Price (DECIMAL)
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2),
    Description VARCHAR(255)
);
SELECT * FROM Products;

-- 2. Add a CHECK constraint to ensure Price is always greater than 0.
ALTER TABLE Products
ADD CONSTRAINT chk_price_positive CHECK (Price > 0);

-- Checking -- 
INSERT INTO Products (ProductID, ProductName, Category, Price, Description)
	VALUES	(9, 'Sumsung A52', 'Telefon', 900.00, 'GSM'),
			(10, 'Nokia 701', 'Telefon', 0.00, 'CDMA');

-- 3. Modify the table to add a StockQuantity column with a DEFAULT value of 50.
ALTER TABLE Products
ADD StockQuantity INT DEFAULT 50;

-- 4. Rename Category to ProductCategory
EXEC sp_rename 'Products.Category', 'ProductCategory', 'COLUMN';

-- 5. Insert 5 records into the Products table using standard INSERT INTO queries.
INSERT INTO Products (ProductID, ProductName, ProductCategory, Price, Description)
VALUES 
(1, 'LG Sovutgich', 'Mayishiy texnika', 100.00, 'Yangi'),
(2, 'Mulivarka', 'Mayishiy texnika', 50.00, 'Foydalanilgan'),
(3, 'HP Noutbuk', 'Elektronika', 1200.00, 'Yangi'),
(4, 'Samsung S21', 'Elektronika', 1000.00, 'Yangi'),
(5, 'Artel', 'Elektronika', 400.00, 'Foydalanilgan');

-- 6. Use SELECT INTO to create a backup table called Products_Backup containing all Products data.
SELECT * INTO Products_Backup
FROM Products;
-- Checking-- 
SELECT * FROM Products_Backup;

-- 7. Rename the Products table to Inventory.
EXEC sp_rename 'Products', 'Inventory';

-- 8. Alter the Inventory table to change the data type of Price from DECIMAL(10,2) to FLOAT.
ALTER TABLE Inventory
ALTER COLUMN Price FLOAT;

-- 9. Add an IDENTITY column named ProductCode that starts from 1000 and increments by 5 to Inventory table.
ALTER TABLE Inventory
ADD ProductCode INT IDENTITY(1000, 5);
