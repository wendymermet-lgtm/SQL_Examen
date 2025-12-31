USE AdventureWorks2025

SELECT * FROM Sales.SalesOrderHeader
SELECT * FROM Sales.SalesTerritory
SELECT * FROM Sales.Customer

--- Average Revenue per Order by Customer Type and Sales Territory
SELECT
    CONCAT(sst.Name, ' ', sst.CountryRegionCode) AS TerritoryName,
    ROUND(SUM(SubTotal), 2) AS TotalRevenue,
    COUNT(*) AS TotalNumberOfOrders,
    ROUND(SUM(SubTotal) / COUNT(*), 2) AS AverageRevenuePerOrder,
    SUM(CASE 
        WHEN c.StoreID IS NULL THEN SubTotal
        ELSE 0 END) AS RevenueIndividus,
    SUM(CASE 
        WHEN c.StoreID IS NOT NULL THEN SubTotal
        ELSE 0 END) AS RevenueStores,
    SUM(CASE 
        WHEN c.StoreID IS NULL THEN 1
        ELSE 0 
    END) AS NbrOfOrdersIndividus,
    SUM(CASE 
        WHEN c.StoreID IS NOT NULL THEN 1
        ELSE 0 
    END) AS NbrOfOrdersStores,
    SUM(CASE 
        WHEN c.StoreID IS NULL THEN SubTotal
        ELSE 0 END)/SUM(CASE 
        WHEN c.StoreID IS NULL THEN 1
        ELSE 0 
    END) AS AvgRevPerOrderIndividus,

    SUM(CASE 
        WHEN c.StoreID IS NOT NULL THEN SubTotal
        ELSE 0 END)/SUM(CASE 
        WHEN c.StoreID IS NOT NULL THEN 1
        ELSE 0 
    END) AS AvgRevPerOrderStores

FROM Sales.SalesOrderHeader soh
INNER JOIN Sales.Customer c ON soh.CustomerID = c.CustomerID
INNER JOIN Sales.SalesTerritory sst ON c.TerritoryID = sst.TerritoryID
GROUP BY sst.Name, sst.CountryRegionCode
ORDER BY  AverageRevenuePerOrder DESC;

