USE AdventureWorks2025

SELECT * FROM Sales.SalesOrderHeader ORDER BY OrderDate DESC
SELECT * FROM Sales.CurrencyRate
 
SELECT 
    ROUND(SUM(SubTotal), 2) AS TotalRevenue,
    YEAR(OrderDate) AS [Year],
    RIGHT('00' + CAST(MONTH(OrderDate) AS varchar(2)), 2) AS [Month],
    FORMAT(OrderDate, 'yyyyMM') AS Period,
    FORMAT(OrderDate, 'yyyy MMMM') AS PeriodName
FROM Sales.SalesOrderHeader
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



