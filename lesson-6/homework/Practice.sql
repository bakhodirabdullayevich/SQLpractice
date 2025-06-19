-- Puzzle 1: Finding Distinct Values
-- Question: Explain at least two ways to find distinct values based on two columns.
/*
SELECT DISTINCT

Example:
SELECT DISTINCT Category, ProductName
FROM Products;

GROUP BY

Example:
SELECT Category, ProductName
FROM Products
GROUP BY Category, ProductName;
*/

/*
INPUT TABLE (InputTbl):

| col1 | col2 |
|------|------|
| a    | b    |
| a    | b    |
| b    | a    |
| c    | d    |
| c    | d    |
| m    | n    |
| n    | m    |

Result should be like this:

| col1 | col2 |
|------|------|
| a    | b    |
| c    | d    |
| m    | n    |
*/

CREATE DATABASE Lesson_6;
USE Lesson_6;

CREATE TABLE InputTbl (
    col1 VARCHAR(10),
    col2 VARCHAR(10)
);

INSERT INTO InputTbl (col1, col2) VALUES 
	('a', 'b'),
	('a', 'b'),
	('b', 'a'),
	('c', 'd'),
	('c', 'd'),
	('m', 'n'),
	('n', 'm');

SELECT MIN(col1) AS col1, MAX(col2) AS col2
FROM InputTbl
GROUP BY 
    CASE 
        WHEN col1 < col2 THEN col1 + '|' + col2
        ELSE col2 + '|' + col1
    END;

-- Puzzle 2: Removing Rows with All Zeroes
/*
Question: 
If all the columns have zero values, then don’t show that row. 
In this case, we have to remove the 5th row while selecting data.
*/

-- Table Schema:
CREATE TABLE TestMultipleZero (
    A INT NULL,
    B INT NULL,
    C INT NULL,
    D INT NULL
);

INSERT INTO TestMultipleZero(A,B,C,D)
VALUES 
    (0,0,0,1),
    (0,0,1,0),
    (0,1,0,0),
    (1,0,0,0),
    (0,0,0,0),
    (1,1,1,0);

SELECT * FROM TestMultipleZero WHERE NOT (A=0 AND B=0 AND C=0 AND D=0);

-- Puzzle 3: Find those with odd ids

CREATE TABLE section1(id int, name varchar(20))
INSERT INTO section1 VALUES 
	(1, 'Been'),
    (2, 'Roma'),
    (3, 'Steven'),
    (4, 'Paulo'),
    (5, 'Genryh'),
    (6, 'Bruno'),
    (7, 'Fred'),
    (8, 'Andro');

SELECT * FROM section1 WHERE id % 2 = 1;

-- Puzzle 4: Person with the smallest id (use the table in puzzle 3)
-- Option 1: Using ORDER BY with TOP 1
SELECT TOP 1 *
FROM section1
ORDER BY id ASC;

-- Option 2: Using MIN() with a subquery
SELECT *
FROM section1
WHERE id = (SELECT MIN(id) FROM section1);

-- Puzzle 5: Person with the highest id (use the table in puzzle 3)
-- Option 1: Using ORDER BY with TOP 1
SELECT TOP 1 *
FROM section1
ORDER BY id DESC;

-- Option 2: Using MAX() with a subquery
SELECT *
FROM section1
WHERE id = (SELECT MAX(id) FROM section1);

-- Puzzle 6: People whose name starts with b (use the table in puzzle 3)

SELECT * FROM section1 WHERE name LIKE 'b%';

-- Puzle 7: Write a query to return only the rows where the code contains the literal underscore _ (not as a wildcard).

CREATE TABLE ProductCodes (
    Code VARCHAR(20)
);

INSERT INTO ProductCodes (Code) VALUES
('X-123'),
('X_456'),
('X#789'),
('X-001'),
('X%202'),
('X_ABC'),
('X#DEF'),
('X-999');

SELECT *
FROM ProductCodes
WHERE Code LIKE '%\_%' ESCAPE '\';
