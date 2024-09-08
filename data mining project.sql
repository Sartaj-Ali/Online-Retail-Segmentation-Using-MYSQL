
CREATE schema retailshop;

use retailshop;

select * from online_retail;

DESCRIBE online_retail;

-- Distribution of order values
SELECT 
  CustomerID, 
  SUM(Quantity * UnitPrice) AS TotalSpend
FROM 
  online_retail
GROUP BY 
  CustomerID
ORDER BY 
  TotalSpend DESC;
  
-- Unique products purchased
  SELECT 
  CustomerID, 
  COUNT(DISTINCT StockCode) AS UniqueProducts
FROM 
  online_retail
GROUP BY 
  CustomerID
ORDER BY 
  UniqueProducts DESC;
  
--  Customers with single purchase
SELECT 
  CustomerID
FROM 
  online_retail
GROUP BY 
  CustomerID
HAVING 
  COUNT(InvoiceNo) = 1;
  
-- Products commonly purchased together
SELECT 
  Product1, 
  Product2, 
  COUNT(*) AS CoPurchaseCount
FROM (
  SELECT 
    InvoiceNo, 
    StockCode AS Product1, 
    LEAD(StockCode) OVER (PARTITION BY InvoiceNo ORDER BY StockCode) AS Product2
  FROM 
    online_retail
) AS subquery
WHERE 
  Product2 IS NOT NULL
GROUP BY 
  Product1, 
  Product2
ORDER BY 
  CoPurchaseCount DESC;
  
--  Advanced Queries
-- 1 Customer Segmentation
WITH customer_frequency AS (
  SELECT 
    CustomerID, 
    COUNT(InvoiceNo) AS PurchaseFrequency
  FROM 
    online_retail
  GROUP BY 
    CustomerID
)
SELECT 
  CASE 
    WHEN PurchaseFrequency > 10 THEN 'High'
    WHEN PurchaseFrequency BETWEEN 5 AND 10 THEN 'Medium'
    ELSE 'Low'
  END AS PurchaseFrequencySegment,
  COUNT(*) AS NumCustomers
FROM 
  customer_frequency
GROUP BY 
  PurchaseFrequencySegment;
  
-- 2 Average Order Value by Country
SELECT 
  Country, 
  AVG(Quantity * UnitPrice) AS AverageOrderValue
FROM 
  online_retail
GROUP BY 
  Country
ORDER BY 
  AverageOrderValue DESC;
  
-- 3 Customer Churn Analysis
WITH inactive_customers AS (
  SELECT 
    CustomerID
  FROM 
    online_retail
  WHERE 
    InvoiceDate < DATE_SUB(CURRENT_DATE, INTERVAL 6 MONTH)
  GROUP BY 
    CustomerID
  HAVING 
    COUNT(InvoiceNo) = 0
)
SELECT 
  * 
FROM 
  inactive_customers;
  
-- 4 Product Affinity Analysis
WITH product_pairs AS (
  SELECT 
    Product1, 
    Product2, 
    COUNT(*) AS CoPurchaseCount
  FROM (
    SELECT 
      InvoiceNo, 
      StockCode AS Product1, 
      LEAD(StockCode) OVER (PARTITION BY InvoiceNo ORDER BY StockCode) AS Product2
    FROM 
      online_retail
  ) AS subquery
  WHERE 
    Product2 IS NOT NULL
  GROUP BY 
    Product1, 
    Product2
)
SELECT 
  Product1, 
  Product2, 
  CoPurchaseCount
FROM 
  product_pairs
ORDER BY 
  CoPurchaseCount DESC;
  
-- 5 Time-based Analysis
SELECT 
  DATE_FORMAT(InvoiceDate, '%Y-%m') AS Month,
  SUM(Quantity * UnitPrice) AS Sales
FROM 
  online_retail
GROUP BY 
  Month
ORDER BY 
  Month
LIMIT 0, 1000;