SELECT ChurnStatus, COUNT(*) AS CustomerCount
FROM customer_churn
GROUP BY ChurnStatus;

SELECT AVG(Tenure) AS AvgTenure, SUM(CashbackAmount) AS TotalCashback
FROM customer_churn
WHERE ChurnStatus = 'Churned';

SELECT 
ROUND(SUM(CASE WHEN ComplaintReceived = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS ComplaintPercentage
FROM customer_churn
WHERE ChurnStatus = 'Churned';

SELECT CityTier, COUNT(*) AS Count
FROM customer_churn
WHERE ChurnStatus = 'Churned' AND PreferredOrderCat = 'Laptop & Accessory'
GROUP BY CityTier
ORDER BY Count DESC
LIMIT 1;

SELECT PreferredPaymentMode, COUNT(*) AS Count
FROM customer_churn
WHERE ChurnStatus = 'Active'
GROUP BY PreferredPaymentMode
ORDER BY Count DESC
LIMIT 1;

SELECT SUM(OrderAmountHikeFromLastYear) AS TotalHike
FROM customer_churn
WHERE MaritalStatus = 'Single' AND PreferredOrderCat = 'Mobile Phone';

SELECT AVG(NumberOfDeviceRegistered) AS AvgDevices
FROM customer_churn
WHERE PreferredPaymentMode = 'UPI';

SELECT Gender, SUM(CouponUsed) AS TotalCoupons
FROM customer_churn
GROUP BY Gender
ORDER BY TotalCoupons DESC
LIMIT 1;

SELECT PreferredOrderCat, COUNT(*) AS CustomerCount, MAX(HoursSpentOnApp) AS MaxHours
FROM customer_churn
GROUP BY PreferredOrderCat;

SELECT SUM(OrderCount) AS TotalOrders
FROM customer_churn
WHERE PreferredPaymentMode = 'Credit Card'
AND SatisfactionScore = (SELECT MAX(SatisfactionScore) FROM customer_churn);

SELECT AVG(SatisfactionScore) AS AvgSatisfaction
FROM customer_churn
WHERE ComplaintReceived = 'Yes';

SELECT DISTINCT PreferredOrderCat
FROM customer_churn
WHERE CouponUsed > 5;

SELECT PreferredOrderCat, AVG(CashbackAmount) AS AvgCashback
FROM customer_churn
GROUP BY PreferredOrderCat
ORDER BY AvgCashback DESC
LIMIT 3;

SELECT DISTINCT PreferredPaymentMode
FROM customer_churn
WHERE Tenure = 10 AND OrderCount > 500;

SELECT CASE WHEN WarehouseToHome <= 5 THEN 'Very Close Distance'
WHEN WarehouseToHome <= 10 THEN 'Close Distance'
WHEN WarehouseToHome <= 15 THEN 'Moderate Distance'
ELSE 'Far Distance'
END AS DistanceCategory,ChurnStatus,
COUNT(*) AS CustomerCount
FROM customer_churn
GROUP BY DistanceCategory, ChurnStatus;

SELECT *
FROM customer_churn
WHERE MaritalStatus = 'Married' 
AND CityTier = 1 
AND OrderCount > (SELECT AVG(OrderCount) FROM customer_churn);

CREATE TABLE customer_returns (
  ReturnID INT PRIMARY KEY,
  CustomerID INT,
  ReturnDate DATE,
  RefundAmount DECIMAL(10, 2)
);

INSERT INTO customer_returns (ReturnID, CustomerID, ReturnDate, RefundAmount) VALUES
(1001, 50022, '2023-01-01', 2130),
(1002, 50316, '2023-01-23', 2000),
(1003, 51099, '2023-02-14', 2290),
(1004, 52321, '2023-03-08', 2510),
(1005, 52928, '2023-03-20', 3000),
(1006, 53749, '2023-04-17', 1740),
(1007, 54206, '2023-04-21', 3250),
(1008, 54838, '2023-04-30', 1990);

SELECT cr.*, cc.*
FROM customer_returns cr
JOIN customer_churn cc ON cr.CustomerID = cc.CustomerID
WHERE cc.ChurnStatus = 'Churned' AND cc.ComplaintReceived = 'Yes';