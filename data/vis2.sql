
USE AdventureWorks2025

SELECT * FROM Production.ProductCategory
SELECT * FROM Production.ProductSubcategory
SELECT * FROM Production.Product
SELECT * FROM Sales.SalesOrderDetail
WHERE LineTotal = 0

--- Total Revenue and Quantity Sold by Product Category
SELECT 
    pc.Name AS CategoryName,
    round(SUM(LineTotal),2) AS TotalRevenue,
    SUM(OrderQty) AS TotalQuantitySold

FROM Production.ProductCategory pc 
INNER JOIN Production.ProductSubcategory psc 
    ON pc.ProductCategoryID = psc.ProductCategoryID
INNER JOIN Production.Product p 
    ON psc.ProductSubcategoryID = p.ProductSubcategoryID
INNER JOIN sales.SalesOrderDetail sod 
    ON p.ProductID = sod.ProductID
GROUP BY pc.Name
ORDER BY TotalRevenue DESC;

-- checking if Linetotal is correct
SELECT 
    pc.Name AS CategoryName,
    LineTotal,
    UnitPrice,
    UnitPriceDiscount,
    OrderQty,
    ((UnitPrice*OrderQty)*(1-UnitPriceDiscount)) - LineTotal as Control

FROM Production.ProductCategory pc 
INNER JOIN Production.ProductSubcategory psc 
    ON pc.ProductCategoryID = psc.ProductCategoryID
INNER JOIN Production.Product p 
    ON psc.ProductSubcategoryID = p.ProductSubcategoryID
INNER JOIN sales.SalesOrderDetail sod 
    ON p.ProductID = sod.ProductID
ORDER BY Control DESC




