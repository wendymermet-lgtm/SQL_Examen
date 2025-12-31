USE AdventureWorks2025

SELECT * FROM Sales.SalesOrderHeader
 
--- Total Orders and Average Revenue per Order by Year
SELECT
    YEAR(OrderDate) AS Year,
    COUNT(*) AS TotalOrders,
    ROUND(SUM(SubTotal),2) AS TotalRevenue,
    (SUM(SubTotal)) / COUNT(*) AS AverageRevenuePerOrder
    
FROM Sales.SalesOrderHeader
GROUP BY YEAR(OrderDate)
ORDER BY Year DESC