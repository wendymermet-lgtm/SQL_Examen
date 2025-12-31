USE AdventureWorks2025

SELECT * FROM Sales.SalesOrderHeader 
SELECT * FROM Sales.SalesTerritory
SELECT * FROM Sales.Customer
 
--- Total Revenue by Month for the Last 13 Full Months
SELECT 
    CONCAT(sst.Name, ' ', sst.CountryRegionCode) AS TerritoryName,
    ROUND(SUM(SubTotal), 2) AS TotalRevenue,
    YEAR(OrderDate) AS [Year],
    RIGHT('00' + CAST(MONTH(OrderDate) AS varchar(2)), 2) AS [Month],
    FORMAT(OrderDate, 'yyyyMM') AS Period,
    FORMAT(OrderDate, 'yyyy MMMM') AS PeriodName
FROM Sales.SalesOrderHeader soh
INNER JOIN Sales.Customer c ON soh.CustomerID = c.CustomerID
INNER JOIN Sales.SalesTerritory sst ON c.TerritoryID = sst.TerritoryID

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
GROUP BY 
    sst.Name, sst.CountryRegionCode,
    YEAR(OrderDate),
    MONTH(OrderDate),
    FORMAT(OrderDate, 'yyyyMM'),
    FORMAT(OrderDate, 'yyyy MMMM')
ORDER BY Period DESC



