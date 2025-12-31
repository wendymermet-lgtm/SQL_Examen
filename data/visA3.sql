USE AdventureWorks2025

SELECT * FROM Sales.SalesOrderHeader 
SELECT * FROM Sales.SalesTerritory
SELECT * FROM Sales.Customer

-- Store Revenue Over Time

SELECT 
    CONCAT(sst.Name, ' ', sst.CountryRegionCode) AS TerritoryName,
    SUM(CASE 
        WHEN c.StoreID IS NOT NULL THEN SubTotal
        ELSE 0 END) AS RevenueStores,
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

-- TOP 4 Territories Store Revenue Over Time

WITH Top4Territories AS (
    SELECT TOP 4
        c.TerritoryID
    FROM Sales.SalesOrderHeader soh
    INNER JOIN Sales.Customer c 
        ON soh.CustomerID = c.CustomerID
    GROUP BY c.TerritoryID
    ORDER BY SUM(soh.SubTotal) DESC
)

SELECT 
    CONCAT(sst.Name, ' ', sst.CountryRegionCode) AS TerritoryName,
    SUM(CASE 
        WHEN c.StoreID IS NOT NULL THEN soh.SubTotal
        ELSE 0 
    END) AS RevenueStores,
    YEAR(soh.OrderDate) AS [Year],
    RIGHT('00' + CAST(MONTH(soh.OrderDate) AS varchar(2)), 2) AS [Month],
    FORMAT(soh.OrderDate, 'yyyyMM') AS Period,
    FORMAT(soh.OrderDate, 'yyyy MMMM') AS PeriodName
FROM Sales.SalesOrderHeader soh
INNER JOIN Sales.Customer c 
    ON soh.CustomerID = c.CustomerID
INNER JOIN Sales.SalesTerritory sst 
    ON c.TerritoryID = sst.TerritoryID
INNER JOIN Top4Territories t4
    ON c.TerritoryID = t4.TerritoryID
WHERE soh.OrderDate >= DATEADD(
        MONTH,
        -13,
        DATEADD(
            MONTH,
            DATEDIFF(MONTH, 0, (SELECT MAX(OrderDate) FROM Sales.SalesOrderHeader)),
            0
        )
      )
  AND soh.OrderDate < DATEADD(
        MONTH,
        DATEDIFF(MONTH, 0, (SELECT MAX(OrderDate) FROM Sales.SalesOrderHeader)),
        0
      )
GROUP BY 
    sst.Name, 
    sst.CountryRegionCode,
    YEAR(soh.OrderDate),
    MONTH(soh.OrderDate),
    FORMAT(soh.OrderDate, 'yyyyMM'),
    FORMAT(soh.OrderDate, 'yyyy MMMM')
ORDER BY Period DESC;

-- TOP 4 Territories Individual Revenue Over Time

WITH Top4Territories AS (
    SELECT TOP 4
        c.TerritoryID
    FROM Sales.SalesOrderHeader soh
    INNER JOIN Sales.Customer c 
        ON soh.CustomerID = c.CustomerID
    GROUP BY c.TerritoryID
    ORDER BY SUM(soh.SubTotal) DESC
)

SELECT 
    CONCAT(sst.Name, ' ', sst.CountryRegionCode) AS TerritoryName,
    SUM(CASE 
        WHEN c.StoreID IS NULL THEN soh.SubTotal
        ELSE 0 
    END) AS RevenueIndividus,
    YEAR(soh.OrderDate) AS [Year],
    RIGHT('00' + CAST(MONTH(soh.OrderDate) AS varchar(2)), 2) AS [Month],
    FORMAT(soh.OrderDate, 'yyyyMM') AS Period,
    FORMAT(soh.OrderDate, 'yyyy MMMM') AS PeriodName
FROM Sales.SalesOrderHeader soh
INNER JOIN Sales.Customer c 
    ON soh.CustomerID = c.CustomerID
INNER JOIN Sales.SalesTerritory sst 
    ON c.TerritoryID = sst.TerritoryID
INNER JOIN Top4Territories t4
    ON c.TerritoryID = t4.TerritoryID
WHERE soh.OrderDate >= DATEADD(
        MONTH,
        -13,
        DATEADD(
            MONTH,
            DATEDIFF(MONTH, 0, (SELECT MAX(OrderDate) FROM Sales.SalesOrderHeader)),
            0
        )
      )
  AND soh.OrderDate < DATEADD(
        MONTH,
        DATEDIFF(MONTH, 0, (SELECT MAX(OrderDate) FROM Sales.SalesOrderHeader)),
        0
      )
GROUP BY 
    sst.Name, 
    sst.CountryRegionCode,
    YEAR(soh.OrderDate),
    MONTH(soh.OrderDate),
    FORMAT(soh.OrderDate, 'yyyyMM'),
    FORMAT(soh.OrderDate, 'yyyy MMMM')
ORDER BY Period ASC;
