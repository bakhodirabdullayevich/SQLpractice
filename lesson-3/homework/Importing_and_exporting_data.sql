﻿/*
Importing and Exporting Data
✅ Importing Data (BULK INSERT, Excel, Text) 
✅ Exporting Data (Excel, Text) 
✅ Comments, Identity column, NULL/NOT NULL values 
✅ Unique Key, Primary Key, Foreign Key, Check Constraint 
✅ Differences between UNIQUE KEY and PRIMARY KEY
*/

-- Easy-Level Tasks
-- 1. Define and explain the purpose of BULK INSERT in SQL Server.
/* 
BULK INSERT is a Transact-SQL command used to import large amounts of data 
from a file into a SQL Server table efficiently.

Purpose:
To quickly load data from external files (like .txt, .csv, etc.) into a database table.
Commonly used for data migration, ETL processes, and initial data loading.

Benefits:
Faster than inserting rows individually.
Useful for importing data generated by other systems.
Supports formatting options (like field separator, row terminator).

Example:
BULK INSERT Products
FROM 'C:\data\products.csv'
WITH (
    FIELDTERMINATOR = ',',    -- Columns are separated by commas
    ROWTERMINATOR = '\n',     -- Each row ends with a new line
    FIRSTROW = 2              -- Skips the header row
);
*/

-- 2. List four file formats that can be imported into SQL Server.
/*
File formats that can be imported into SQL Server:
 - CSV (Comma-Separated Values) -> data.csv / Common for spreadsheets and flat data.
 - TXT (Plain Text File) -> data.txt / Often used with custom delimiters (e.g., tab, pipe |).
 - XLS/XLSX (Excel Files) -> data.xlsx / Imported using SQL Server Integration Services (SSIS) or the Import Wizard.
 - XML (eXtensible Markup Language) -> data.xml / Used for structured hierarchical data.
 */

-- 3. Create a table Products with columns: ProductID (INT, PRIMARY KEY), ProductName (VARCHAR(50)), Price (DECIMAL(10,2)).
CREATE TABLE Products (
	ProductID INT PRIMARY KEY, 
	ProductName VARCHAR(50), 
	Price DECIMAL(10,2)
);

-- 4. Insert three records into the Products table using INSERT INTO.
INSERT INTO Products VALUES (1, 'Lenevo', 1500.00);

SELECT * FROM Products;

-- 5. Explain the difference between NULL and NOT NULL.
/*
NULL means "no value" or "unknown".
It does not mean 0, '' (empty string), or False.
It represents missing or inapplicable data.

Example: 
SELECT * FROM Employees WHERE Region IS NULL; -- This query returns all employees where the Region column has no value.

NOT NULL means the column must have a value.
When you define a column with NOT NULL, 
SQL will not allow you to insert a row without a value for that column.

Example:
CREATE TABLE Products (
    ProductID INT NOT NULL,
    ProductName VARCHAR(100) NOT NULL,
    Description TEXT NULL
);

ProductID and ProductName must always be filled in.
Description can be left empty (i.e., NULL is allowed).
*/

-- 6. Add a UNIQUE constraint to the ProductName column in the Products table.

ALTER TABLE Products
ADD CONSTRAINT unique_product_name UNIQUE (ProductName);

-- 7. Write a comment in a SQL query explaining its purpose.
/*
Comments in SQL:
	-- for single-line comments.
	/* ... */ for multi-line comments.

Examle:
/*
This query retrieves the names and prices of all products
that cost more than 100 units from the Products table.
*/

SELECT ProductName, Price
FROM Products
WHERE Price > 100;
*/

-- 8. Create a table Categories with a CategoryID as PRIMARY KEY and a CategoryName as UNIQUE.
CREATE TABLE Categories (
	CategoryID INT PRIMARY KEY,
	CategoryName VARCHAR(50) UNIQUE
);

-- 9. Explain the purpose of the IDENTITY column in SQL Server.
/*
The IDENTITY column in SQL Server is used to automatically generate unique numbers 
for a column, usually for a primary key.

Purpose:
To auto-increment the value of a column every time a new row is inserted, 
without manually specifying the value.

Syntax:
ColumnName INT IDENTITY(seed, increment)

-- seed = starting value
-- increment = how much to increase for each new row

Example:
CREATE TABLE Products (
    ProductID INT IDENTITY(1,1) PRIMARY KEY,
    ProductName VARCHAR(100)
);

In this example:
The first row inserted gets ProductID = 1
The second row gets ProductID = 2, and so on...

-- Medium-Level Tasks
-- 10. Use BULK INSERT to import data from a text file into the Products table.
*/

BULK INSERT CUSTOMERS
FROM 'C:\Users\Desktop\SQL_LESSON\Customers.txt'
WITH (
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '\n'
);

-- 11. Create a FOREIGN KEY in the Products table that references the Categories table.
-- While creating the Products table:
/*
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    Price DECIMAL(10, 2),
    CategoryID INT,
    CONSTRAINT FK_Products_Categories FOREIGN KEY (CategoryID)
        REFERENCES Categories(CategoryID)
);
*/
-- Add it to an existing table using ALTER TABLE:

ALTER TABLE Products
ADD CONSTRAINT FK_Products_Categories
FOREIGN KEY (CategoryID)
REFERENCES Categories(CategoryID);

-- 12. Explain the differences between PRIMARY KEY and UNIQUE KEY.
/*
A PRIMARY KEY is used to uniquely identify each row in a table. 
It does not allow NULL values and you can have only one primary key in a table. 
It's typically used for the main identifier of the table, like an ID column.

A UNIQUE KEY, on the other hand, also ensures that the values in a column 
(or group of columns) are unique, but it does allow NULL values 
(usually one per column, depending on the database). 
Unlike the primary key, you can have multiple unique keys in a table.

In short:
PRIMARY KEY = 1 per table, no NULLs, main identifier.
UNIQUE KEY = many allowed, allows NULLs, ensures uniqueness but not the main identifier.
*/
-- 13. Add a CHECK constraint to the Products table ensuring Price > 0.

ALTER TABLE Products
ADD CONSTRAINT chk_price_positive CHECK (Price > 0);

-- 14. Modify the Products table to add a column Stock (INT, NOT NULL).

ALTER TABLE Products
ADD Stock INT NOT NULL DEFAULT 0;
/* 
Note: If your table already contains data, 
and we add a NOT NULL column without a default value, 
SQL Server will raise an error because it cannot insert NULLs into existing rows.
To avoid errors with existing data, we can provide a default value.
*/

-- 15. Use the ISNULL function to replace NULL values in Price column with a 0.
/*
SELECT * FROM Products;
INSERT INTO Products VALUES (0, 'Nokia', null);
SELECT ProductID, ProductName, ISNULL(Price, 0) AS Price
FROM Products;
*/

UPDATE Products
SET Price = 0
WHERE Price IS NULL;

-- 16. Describe the purpose and usage of FOREIGN KEY constraints in SQL Server.
/*
FOREIGN KEY constraint in SQL Server is used to maintain referential
integrity between two tables. It ensures that the value in one table (child table) 
must match a value in another table (parent table), or be NULL if allowed.
*/

-- Hard-Level Tasks
-- 17. Write a script to create a Customers table with a CHECK constraint ensuring Age >= 18.

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    Age INT,
    CHECK (Age >= 18)
);

-- 18. Create a table with an IDENTITY column starting at 100 and incrementing by 10.
CREATE TABLE Department (
    ID INT IDENTITY(100, 10) PRIMARY KEY,
    DepartmentName VARCHAR(100)
);

-- 19. Write a query to create a composite PRIMARY KEY in a new table OrderDetails.

CREATE TABLE OrderDetails (
    OrderID INT,
    ProductID INT,
    Quantity INT,
    Price DECIMAL(10, 2),
    PRIMARY KEY (OrderID, ProductID)
);

-- 20. Explain the use of COALESCE and ISNULL functions for handling NULL values.
/*
ISNULL:
The ISNULL function in SQL Server is used to replace NULL values with a specified 
replacement value. It takes two arguments: the expression to check and the value to
use if the expression is NULL. For example, ISNULL(Price, 0) will return the value 
of Price if it is not NULL, otherwise it returns 0. ISNULL only works with two arguments
and is specific to SQL Server.

COALESCE:
The COALESCE function returns the first non-NULL value from a list of expressions.
It can take two or more arguments. For example, COALESCE(Price, DiscountPrice, 0)
will return the first value among Price, DiscountPrice, or 0 that is not NULL. 
COALESCE is part of the SQL standard and works in many database systems,
making it more versatile than ISNULL.*/

-- 21. Create a table Employees with both PRIMARY KEY on EmpID and UNIQUE KEY on Email.
CREATE TABLE Employees (
    EmpID INT PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100) UNIQUE
);
-- 22. Write a query to create a FOREIGN KEY with ON DELETE CASCADE and ON UPDATE CASCADE options.

CREATE TABLE ProductsOnSell (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    CategoryID INT,
    Price DECIMAL(10, 2),
    CONSTRAINT FK_Products_Categories FOREIGN KEY (CategoryID)
        REFERENCES Categories(CategoryID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);
