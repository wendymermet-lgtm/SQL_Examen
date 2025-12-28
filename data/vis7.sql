USE AdventureWorks2025

SELECT * FROM Sales.SalesOrderHeader
SELECT * FROM Sales.SalesTerritory
SELECT * FROM Sales.Customer
SELECT * FROM Sales.Store


INSERT INTO Sales.Customer
SELECT CustomerID, TerritoryID, PersonID, StoreID, CASE WHEN PersonID IS NULL THEN 'Store' ELSE 'Privat' END AS CustomerType

FROM Sales.Customer
ORDER BY CustomerType DESC

SELECT
    CONCAT(sst.Name,' ',sst.CountryRegionCode) AS TerritoryName,
    CASE WHEN c.PersonID IS NULL THEN 'Store' ELSE 'Privat' END AS CustomerType,
    ROUND(SUM(soh.SubTotal),2) AS TotalRevenue,
    COUNT(*) AS TotalnumberOfOrders,
    (ROUND(SUM(soh.SubTotal),2)) / COUNT(*) as AverageRevenuePerOrder
      
    
FROM Sales.SalesOrderHeader soh 
INNER JOIN Sales.Customer c ON soh.CustomerID = c.CustomerID
INNER JOIN Sales.SalesTerritory sst ON c.TerritoryID = sst.TerritoryID
GROUP BY sst.Name, sst.CountryRegionCode, CASE WHEN c.PersonID IS NULL THEN 'Store' ELSE 'Privat' END
ORDER BY AverageRevenuePerOrder DESC


SELECT
    CONCAT(sst.Name,' ',sst.CountryRegionCode,' ',CASE WHEN c.PersonID IS NULL THEN 'Store' ELSE 'Privat' END) AS TerritoryName,

    ROUND(SUM(soh.SubTotal),2) AS TotalRevenue,
    COUNT(*) AS TotalnumberOfOrders,
    (ROUND(SUM(soh.SubTotal),2)) / COUNT(*) as AverageRevenuePerOrder
      
    
FROM Sales.SalesOrderHeader soh 
INNER JOIN Sales.Customer c ON soh.CustomerID = c.CustomerID
INNER JOIN Sales.SalesTerritory sst ON c.TerritoryID = sst.TerritoryID
GROUP BY sst.Name, sst.CountryRegionCode, c.PersonID
ORDER BY TerritoryName DESC