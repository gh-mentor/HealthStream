/*
This file contains a script of Transact SQL (T-SQL) command to interact with a database named 'Inventory'.
Requirements:
- SQL Server 2022 is installed and running
- database 'Inventory' already exists.
- if the database 'Inventory' does not exist, the script will print an error message and exit.
Steps:
- Sets the default database to 'Inventory'.
- Creates a 'categories' table and related 'products' table if they do not already exist.
- Remove all rows from the tables (in case they already existed).
- Populates the 'Categories' table with sample data.
- Populates the 'Products' table with sample data.
- Creates stored procedures to get all categories.
- Creates a stored procedure to get all products in a specific category.
- Creates a stored procudure to get all products in a specific price range sorted by price in ascending order.
*/

-- check if the database 'Inventory' exists, if not, print an error message and exit

IF NOT EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = N'Inventory')
BEGIN
    PRINT 'Error: The database Inventory does not exist. Please create the database and run this script again.'
    RETURN
END

-- set the default database to 'Inventory'
USE Inventory

-- create the 'Categories' table if it does not already exist
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Categories')
BEGIN
    CREATE TABLE Categories (
        CategoryID INT PRIMARY KEY,
        CategoryName NVARCHAR(50) NOT NULL,
        -- add a Description column to store a description of the category
        Description NVARCHAR(255)
    )
    PRINT 'Table Categories created.'
END

-- create the 'Products' table if it does not already exist, with a foreign key constraint to the 'Categories' table
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Products')
BEGIN
    CREATE TABLE Products (
        ProductID INT PRIMARY KEY,
        ProductName NVARCHAR(50) NOT NULL,
        CategoryID INT,
        Price DECIMAL(10, 2),
        FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID),
        -- Add a created date column to store the date the product was added to the inventory
        CreatedDate DATETIME,
        -- Add a updated date column to store the date the product was last updated
        UpdatedDate DATETIME
    )
    PRINT 'Table Products created.'
END

-- remove all rows from the 'Products' and  'Categories' tables
TRUNCATE TABLE Products
TRUNCATE TABLE Categories

-- populate the 'Categories' table with sample data
INSERT INTO Categories (CategoryID, CategoryName, Description) VALUES
(1, 'Electronics', 'Electronic devices and accessories'),
(2, 'Clothing', 'Clothing and apparel'),
(3, 'Home Goods', 'Household items and decor'),
(4, 'Books', 'Books and reading materials')

-- populate the 'Products' table with sample data
INSERT INTO Products (ProductID, ProductName, CategoryID, Price, CreatedDate, UpdatedDate) VALUES
(1, 'Laptop', 1, 1200.00, GETDATE(), GETDATE()),
(2, 'Smartphone', 1, 800.00, GETDATE(), GETDATE()),
(3, 'T-Shirt', 2, 20.00, GETDATE(), GETDATE()),
(4, 'Jeans', 2, 40.00, GETDATE(), GETDATE()),
(5, 'Couch', 3, 500.00, GETDATE(), GETDATE()),
(6, 'Dining Table', 3, 300.00, GETDATE(), GETDATE()),
(7, 'The Great Gatsby', 4, 15.00, GETDATE(), GETDATE()),
(8, 'To Kill a Mockingbird', 4, 12.00, GETDATE(), GETDATE())

-- create a stored procedure to get all categories
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'GetAllCategories')
BEGIN
    DROP PROCEDURE GetAllCategories
END
GO

-- create a stored procedure to get all categories
CREATE PROCEDURE GetAllCategories
AS
BEGIN
    SELECT * FROM Categories
END
GO

-- create a stored procedure to get all products in a specific category
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'GetProductsByCategory')
BEGIN
    DROP PROCEDURE GetProductsByCategory
END
GO


-- create a stored procedure to get all products in a specific category
CREATE PROCEDURE GetProductsByCategory
    @CategoryID INT
AS
BEGIN
    SELECT * FROM Products WHERE CategoryID = @Category
END
GO

-- create a stored procedure to get all products in a specific price range sorted by price in ascending order
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'GetProductsByPriceRange')
BEGIN
    DROP PROCEDURE GetProductsByPriceRange
END
GO




