-- Lesson 1: Introduction to SQL Server and SSMS
-- 1. Define the following terms: data, database, relational database, and table.

/* 
Data - Data is raw, unprocessed facts or values that represent information. 
It can be in the form of text, numbers, dates, or other formats, and is stored in a database for further use or analysis.

Database - a database is a structured collection of data that is stored electronically and managed using a database management system (DBMS), 
such as SQL Server. It allows users to store, retrieve, and manipulate data efficiently.

Relational Database - a relational database is a type of database that stores data in tables with rows and columns. 
Tables can be related to each other through keys, allowing complex queries across multiple data sets.

Table - a table is a database object used to store data in a structured format of rows and columns. 
Each row represents a record, and each column represents a specific attribute or field. 
*/

-- 2. List five key features of SQL Server.

/*
Relational Database Management System (RDBMS)
SQL Server is a robust RDBMS that stores data in tables with rows and columns. 
It uses structured relationships and keys to organize and link data efficiently.

Transact-SQL (T-SQL) Support
SQL Server supports Transact-SQL (T-SQL), an extension of SQL that includes procedural programming features 
like variables, conditions, loops, and error handling.

Security and Authentication
SQL Server provides advanced security features such as:
 - Windows and SQL Server Authentication,
 - Role-based access control,
 - Data encryption (TDE),
 - Row-level security and auditing.

Backup and Recovery
SQL Server offers reliable backup and restore features, including:
 - Full, differential, and transaction log backups,
 - Point-in-time recovery,
 - Automatic backup scheduling.

High Availability and Scalability
SQL Server supports Always On Availability Groups, failover clustering, replication, and log shipping to ensure high availability 
and data redundancy in enterprise environments. 
*/

-- 3. What are the different authentication modes available when connecting to SQL Server? (Give at least 2)

/*
1. Windows Authentication
Definition: Uses the Windows operating system credentials to log in. It is integrated with Active Directory and provides single sign-on.
Key Point: No need to enter a username or password manually—SQL Server uses the Windows login session.

2. SQL Server Authentication
Definition: Uses a username and password that are stored and managed by SQL Server.
Key Point: Login credentials are independent of the Windows system. Commonly used for cross-platform access or external apps.
*/

-- 4. Create a new database in SSMS named SchoolDB.

CREATE DATABASE SchoolDB;

-- 5. Write and execute a query to create a table called Students with columns: StudentID (INT, PRIMARY KEY), Name (VARCHAR(50)), Age (INT).

CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    Name VARCHAR(50),
    Age INT
);

-- Just checkning --
/* SELECT * FROM Students; */

-- 6. Describe the differences between SQL Server, SSMS, and SQL.

/*
SQL Server – The Database Engine
SQL Server is a relational database management system (RDBMS) developed by Microsoft.
It stores, processes, and secures data. It handles data storage, querying, transactions, backups, and security.

SSMS (SQL Server Management Studio) – The User Interface Tool
SSMS is a graphical user interface (GUI) tool used to manage SQL Server databases.
It allows users (like DBAs and developers) to interact with SQL Server — write and run SQL queries, 
create databases/tables, back up data, view logs, etc.

SQL (Structured Query Language) – The Progranning language
SQL is the standard programming language used to manage and manipulate relational databases.
We use SQL to query data, insert, update, delete, and define database structures.
*/

-- 7. Research and explain the different SQL commands: DQL, DML, DDL, DCL, TCL with examples.

/*
In SQL, commands are grouped into categories based on their purpose. Here's a structured explanation of the five main types of SQL commands
— DQL, DML, DDL, DCL, and TCL — with definitions and examples. 

1. DQL – Data Query Language
Purpose: Retrieve data from a database.
Key Command: SELECT
Example: SELECT Name, Age FROM Students;

2. DML – Data Manipulation Language
Purpose: Modify data stored in tables (without changing table structure).
Key Commands: 
- INSERT: Add new rows
- UPDATE: Modify existing rows
- DELETE: Remove rows
Examples: 
-- Create a table
INSERT INTO Students (StudentID, Name, Age) VALUES (1, 'Alice', 20);

-- Update a student's age
UPDATE Students SET Age = 21 WHERE StudentID = 1;

-- Delete a student
DELETE FROM Students WHERE StudentID = 1;

3. DDL – Data Definition Language
Purpose: Define and manage database schema (tables, columns, indexes, etc.).
Key Commands:
- CREATE: Create database objects (e.g., tables)
- ALTER: Modify structure of objects
- DROP: Delete objects

-- Create a table
CREATE TABLE Courses (
    CourseID INT PRIMARY KEY,
    Title VARCHAR(100)
);

-- Add a column to the table
ALTER TABLE Courses
ADD Credits INT;

-- Delete the table
DROP TABLE Courses;

4. DCL – Data Control Language
Purpose: Control permissions and access to data.
Key Commands:
- GRANT: Give privileges
- REVOKE: Remove privileges
Examples:
-- Allow user to SELECT from Students
GRANT SELECT ON Students TO user1;
-- Revoke permission
REVOKE SELECT ON Students FROM user1;

5. TCL – Transaction Control Language
Purpose: Manage transactions (groups of operations treated as a single unit).
Key Commands:
- BEGIN TRANSACTION: Start a new transaction
- COMMIT: Save changes
- ROLLBACK: Undo changes
Examples:

BEGIN TRANSACTION;
UPDATE Students
SET Age = 25
WHERE StudentID = 2;
-- Save the update
COMMIT;
-- Or undo the update
-- ROLLBACK;
*/

-- 8. Write a query to insert three records into the Students table.
INSERT INTO Students (StudentID, Name, Age)
VALUES 
    (1, 'Azizbek', 20),
    (2, 'Bobur', 22),
    (3, 'Charos', 19);

-- 9. Restore AdventureWorksDW2022.bak file to your server. (write its steps to submit) You can find the database from this link:
/* https://github.com/Microsoft/sql-server-samples/releases/download/adventureworks/AdventureWorksDW2022.bak

Steps to Restore AdventureWorksDW2022.bak in SSMS

Step 1: Download the file from this link: https://github.com/Microsoft/sql-server-samples/releases/download/adventureworks/AdventureWorksDW2022.bak 
Save it to a local directory, such as:
C:\Backup\AdventureWorksDW2022.bak

Step 2: Copy the .bak File to SQL Server's Backup Directory (Optional but Recommended)
For local SQL Server, the default backup path is usually:
C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Backup
You can also use any custom path but make sure the SQL Server service account has read access.

Step 3: Open SSMS and Connect to the Server
Launch SQL Server Management Studio (SSMS).
Connect to your SQL Server instance.

Step 4: Start the Restore Process
In Object Explorer, right-click on Databases and choose Restore Database...
In the Source section:
Select Device, then click the ... button.
In the "Select backup devices" window:
Choose File and click Add.
Browse to the location of AdventureWorksDW2022.bak and select it.
Click OK.

In the Destination section:
The database name should auto-fill as AdventureWorksDW2022. You can keep or rename it.
Go to the Files page (left pane):
Optionally change the restore path (if needed).
Click OK to begin the restore.

Step 5: Verify the Restoration
Run this query to confirm the database was restored:

SELECT name 
FROM sys.databases
WHERE name = 'AdventureWorksDW2022';
*/
