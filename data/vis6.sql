USE AdventureWorks2025

SELECT * FROM Sales.SalesOrderHeader
SELECT * FROM Sales.SalesTerritory
SELECT * FROM Sales.Customer


SELECT
    CONCAT(sst.Name,' ',sst.CountryRegionCode) AS TerritoryName,
    ROUND(SUM(soh.SubTotal),2) AS TotalRevenue,
    COUNT(DISTINCT c.CustomerID) AS AmountOfUniqueCustomer
      
    
FROM Sales.SalesOrderHeader soh 
INNER JOIN Sales.Customer c ON soh.CustomerID = c.CustomerID
INNER JOIN Sales.SalesTerritory sst ON c.TerritoryID = sst.TerritoryID
GROUP BY sst.Name, sst.CountryRegionCode
ORDER BY TotalRevenue DESC

