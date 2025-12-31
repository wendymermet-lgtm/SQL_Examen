USE AdventureWorks2025

SELECT * FROM Sales.SalesOrderHeader 
SELECT * FROM Sales.Customer
 
SELECT 
  
    YEAR(OrderDate) AS [Year],
    RIGHT('00' + CAST(MONTH(OrderDate) AS varchar(2)), 2) AS [Month],
    FORMAT(OrderDate, 'yyyyMM') AS Period,
    FORMAT(OrderDate, 'yyyy MMMM') AS PeriodName,
    SUM(CASE 
        WHEN c.StoreID IS NULL THEN SubTotal
        ELSE 0 END) AS RevenueIndividus,
    SUM(CASE 
        WHEN c.StoreID IS NOT NULL THEN SubTotal
        ELSE 0 END) AS RevenueStores
FROM Sales.SalesOrderHeader soh
INNER JOIN Sales.Customer c ON soh.CustomerID = c.CustomerID

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
    YEAR(OrderDate),
    MONTH(OrderDate),
    FORMAT(OrderDate, 'yyyyMM'),
    FORMAT(OrderDate, 'yyyy MMMM')
ORDER BY Period DESC



