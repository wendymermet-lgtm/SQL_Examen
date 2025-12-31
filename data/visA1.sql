USE AdventureWorks2025

SELECT * FROM Sales.SalesOrderHeader

SELECT * FROM Sales.SalesOrderDetail
SELECT * FROM Sales.SalesTerritory
SELECT * FROM Sales.Customer
SELECT * FROM Production.ProductCategory
SELECT * FROM Production.ProductSubcategory

--- Total Revenue by Territory and Product Category for the Last 13 Full Months
SELECT
    CONCAT(sst.Name, ' ', sst.CountryRegionCode) AS TerritoryName,
    pc.Name AS CategoryName,
    ROUND(SUM(sod.LineTotal), 2) AS TotalRevenue


FROM Sales.SalesOrderHeader soh
INNER JOIN Sales.Customer c ON soh.CustomerID = c.CustomerID
INNER JOIN Sales.SalesTerritory sst ON c.TerritoryID = sst.TerritoryID
INNER JOIN Sales.SalesOrderDetail sod ON soh.SalesOrderID = sod.SalesOrderID
INNER JOIN Production.Product p ON sod.ProductID = p.ProductID
INNER JOIN Production.ProductSubcategory psc ON p.ProductSubcategoryID = psc.ProductSubcategoryID
INNER JOIN Production.ProductCategory pc ON psc.ProductCategoryID = pc.ProductCategoryID
WHERE OrderDate >= DATEADD(
        MONTH,
        -13,
        DATEADD(
            MONTH,
            DATEDIFF(MONTH, 0, (SELECT MAX(OrderDate) FROM Sales.SalesOrderHeader)),
            0
        )
      )
  AND OrderDate < DATEADD(
        MONTH,
        DATEDIFF(MONTH, 0, (SELECT MAX(OrderDate) FROM Sales.SalesOrderHeader)),
        0
      )
GROUP BY sst.Name, sst.CountryRegionCode, pc.Name
ORDER BY  TotalRevenue DESC;
