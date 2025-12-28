USE AdventureWorks2025

SELECT * FROM Sales.SalesOrderHeader
 

SELECT
    YEAR(OrderDate) AS Year,
    COUNT(*) AS TotalOrders,
    ROUND(SUM(SubTotal),2) AS TotalRevenue,
    (SUM(SubTotal)) / COUNT(*) AS AverageRevenuePerOrder
    
FROM Sales.SalesOrderHeader
GROUP BY YEAR(OrderDate)
ORDER BY Year DESC