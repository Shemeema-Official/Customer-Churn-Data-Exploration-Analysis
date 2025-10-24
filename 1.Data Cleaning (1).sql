SET SQL_SAFE_UPDATES = 0;

UPDATE customer_churn
JOIN (
    SELECT AVG(WarehouseToHome) AS avg_value
    FROM customer_churn
    WHERE WarehouseToHome IS NOT NULL
) AS avg_table
SET customer_churn.WarehouseToHome = ROUND(avg_table.avg_value)
WHERE customer_churn.WarehouseToHome IS NULL;

UPDATE customer_churn
JOIN (
    SELECT AVG(HourSpendOnApp) AS avg_value
    FROM customer_churn
    WHERE HourSpendOnApp IS NOT NULL
) AS avg_table
SET customer_churn.HourSpendOnApp = ROUND(avg_table.avg_value)
WHERE customer_churn.HourSpendOnApp IS NULL;

UPDATE customer_churn
JOIN (
    SELECT AVG(OrderAmountHikeFromlastYear) AS avg_value
    FROM customer_churn
    WHERE OrderAmountHikeFromlastYear IS NOT NULL
) AS avg_table
SET customer_churn.OrderAmountHikeFromlastYear = ROUND(avg_table.avg_value)
WHERE customer_churn.OrderAmountHikeFromlastYear IS NULL;

UPDATE customer_churn
JOIN (
    SELECT AVG(DaySinceLastOrder) AS avg_value
    FROM customer_churn
    WHERE DaySinceLastOrder IS NOT NULL
) AS avg_table
SET customer_churn.DaySinceLastOrder = ROUND(avg_table.avg_value)
WHERE customer_churn.DaySinceLastOrder IS NULL;

UPDATE customer_churn
JOIN (
    SELECT Tenure AS mode_val
    FROM customer_churn
    WHERE Tenure IS NOT NULL
    GROUP BY Tenure
    ORDER BY COUNT(*) DESC
    LIMIT 1
) AS mode_table
SET customer_churn.Tenure = mode_table.mode_val
WHERE customer_churn.Tenure IS NULL;

UPDATE customer_churn
JOIN (
    SELECT CouponUsed AS mode_val
    FROM customer_churn
    WHERE CouponUsed IS NOT NULL
    GROUP BY CouponUsed
    ORDER BY COUNT(*) DESC
    LIMIT 1
) AS mode_table
SET customer_churn.CouponUsed = mode_table.mode_val
WHERE customer_churn.CouponUsed IS NULL;

UPDATE customer_churn
JOIN (
    SELECT OrderCount AS mode_val
    FROM customer_churn
    WHERE OrderCount IS NOT NULL
    GROUP BY OrderCount
    ORDER BY COUNT(*) DESC
    LIMIT 1
) AS mode_table
SET customer_churn.OrderCount = mode_table.mode_val
WHERE customer_churn.OrderCount IS NULL;

DELETE FROM customer_churn
WHERE WarehouseToHome > 100;
SET SQL_SAFE_UPDATES = 0;

UPDATE customer_churn
SET PreferredLoginDevice = 'Mobile Phone'
WHERE PreferredLoginDevice = 'Phone';

UPDATE customer_churn
SET PreferedOrderCat = 'Mobile Phone'
WHERE PreferedOrderCat = 'Mobile';

UPDATE customer_churn
SET PreferredPaymentMode = 'Cash on Delivery'
WHERE PreferredPaymentMode = 'COD';

UPDATE customer_churn
SET PreferredPaymentMode = 'Credit Card'
WHERE PreferredPaymentMode = 'CC';

SET SQL_SAFE_UPDATES = 0;

