USE AdventureWorks2025

SELECT *, DATEADD(Month,-12,GETDATE()) AS MinDate FROM Sales.SalesOrderHeader ORDER BY OrderDate DESC
SELECT * FROM Sales.CurrencyRate
 
WHERE YEAR(OrderDate) = 2025
WHERE OrderDate >= (DATEADD(Month,-12,2025-06-29))

SELECT     
    SUM(SubTotal) AS TotalRevenue,
    MONTH(OrderDate) AS Period,
    DATENAME(MONTH,OrderDate) AS Month

FROM Sales.SalesOrderHeader
WHERE YEAR(OrderDate) = 2024
GROUP BY MONTH(OrderDate),DATENAME(MONTH,OrderDate) 
ORDER BY Period DESC

SELECT 
      SUM(SubTotal) AS TotalRevenue,
    YEAR(OrderDate) AS Year,
    RIGHT('00'+ CAST(DATEPART(MONTH,OrderDate)AS varchar(10)),2) AS Month,
    CONCAT(YEAR(OrderDate),MONTH(OrderDate)) AS Period,
    CONCAT(DATENAME(YEAR,OrderDate),DATENAME(MONTH,OrderDate)) AS PeriodName

FROM Sales.SalesOrderHeader
GROUP BY YEAR(OrderDate), MONTH(OrderDate),DATENAME(YEAR,OrderDate), DATENAME(MONTH,OrderDate) 
ORDER BY Year DESC, Period DESC