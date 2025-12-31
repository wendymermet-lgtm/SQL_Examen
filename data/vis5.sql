USE AdventureWorks2025

SELECT * FROM Sales.SalesOrderDetail
SELECT * FROM Production.Product
SELECT * FROM Production.ProductCategory

--- Top 10 Products by Revenue and Quantity Sold
SELECT TOP 10
    SUM(sod.OrderQty) AS QuantitySold,
    ROUND(SUM(sod.LineTotal), 2) AS TotalRevenue,
    p.Name AS ProductName,
    pc.Name AS Categorie
    
FROM Sales.SalesOrderDetail sod 
INNER JOIN Production.Product p ON sod.ProductID = p.ProductID
INNER JOIN Production.ProductSubcategory psc ON p.ProductSubcategoryID = psc.ProductSubcategoryID
INNER JOIN Production.ProductCategory pc ON psc.ProductCategoryID = pc.ProductCategoryID
GROUP BY p.Name, pc.Name
ORDER BY TotalRevenue DESC 
