/* -.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.

* File Name : BAKERY-queries.sql

* Purpose :

* Creation Date : 20-11-2017

* Last Modified : Thu 23 Nov 2017 09:59:37 PM STD

* Created By :  Jordan Castillo

* Email : jtcastil@calpoly.edu
_._._._._._._._._._._._._._._._._._._._._.*/
USE bakery
-- Q1
SELECT FirstName, LastName
FROM 
	(SELECT cm.FirstName, cm.LastName,
			 SUM(it.Ordinal * gd.PRICE) AS totalSpent
	FROM customers cm
		JOIN receipts rc
			ON cm.CId = rc.Customer
		JOIN items it
			ON rc.RNumber = it.Receipt
		JOIN goods gd
			ON it.Item = gd.GId
	WHERE MONTHNAME(rc.SaleDate) = "October"
		AND YEAR(rc.SaleDate) = 2007
	GROUP BY cm.CId
	ORDER BY totalSpent DESC) AS myTbl
HAVING MAX(totalSpent);

-- Q2  --FIRST FIND CUSTOMER IDS WHO ORDERED SAID ITEM, THEN FIND ALL CUSTOMERS NOT IN LIST
SELECT LastName, FirstName
FROM customers
WHERE CId NOT IN 
		(SELECT DISTINCT cm.CId
		FROM customers cm
      JOIN receipts rc
         ON cm.CId = rc.Customer
      JOIN items it
         ON rc.RNumber = it.Receipt
      JOIN goods gd
         ON it.Item = gd.GId
		WHERE MONTHNAME(rc.SaleDate) = "October"
      AND YEAR(rc.SaleDate) = 2007
		AND gd.Food = "Twist");

-- Q3 IN SUBQUERY, GROUPBY FOODTYPE,FLAVOR, FIND TOTAL REVENUE, FIND MAX IN OUTER QUERY
SELECT Flavor, Food, revenueContribution
FROM (SELECT gd.Flavor, gd.Food,
				 ROUND(SUM(it.Ordinal * gd.PRICE), 2) AS revenueContribution
		FROM customers cm
      JOIN receipts rc
         ON cm.CId = rc.Customer
      JOIN items it
         ON rc.RNumber = it.Receipt
      JOIN goods gd
         ON it.Item = gd.GId
		GROUP BY gd.Flavor, gd.Food
		ORDER BY revenueContribution DESC) AS myTbl
HAVING MAX(revenueContribution);

-- Q4 IN SUBQUERY, GROUP BY FOODTYPE, FLAVOR, FIND TOTAL PURCHASES, FIND MAX IN OUTER QUERY
SELECT Flavor, Food, totalPurchases
FROM (SELECT gd.Flavor, gd.Food,
             SUM(it.Ordinal) AS totalPurchases
      FROM customers cm
      JOIN receipts rc
         ON cm.CId = rc.Customer
      JOIN items it
         ON rc.RNumber = it.Receipt
      JOIN goods gd
         ON it.Item = gd.GId
      GROUP BY gd.Flavor, gd.Food
      ORDER BY totalPurchases DESC) AS myTbl
HAVING MAX(totalPurchases);

-- Q5 IN SUBQUERY, GROUP BY DAY(), LIMIT MONTH&YEAR,
SELECT SaleDate, revenueContribution
FROM (SELECT rc.SaleDate, 
		ROUND(SUM(it.Ordinal * gd.PRICE), 2) AS revenueContribution
      FROM customers cm
      JOIN receipts rc
         ON cm.CId = rc.Customer
      JOIN items it
         ON rc.RNumber = it.Receipt
      JOIN goods gd
         ON it.Item = gd.GId
      WHERE MONTHNAME(rc.SaleDate) = "October"
      AND YEAR(rc.SaleDate) = 2007
		GROUP BY DAY(rc.SaleDate)
		ORDER BY revenueContribution DESC) AS myTbl
HAVING MAX(revenueContribution);

-- Q6 
SELECT 
FROM customers cm
	JOIN receipts rc
		ON cm.CId = rc.Customer
	JOIN items it
		ON rc.RNumber = it.Receipt
	JOIN goods gd
		ON it.Item = gd.GId
WHERE rc.SaleDate IN (
	SELECT SaleDate
	FROM (SELECT rc.SaleDate,
	      ROUND(SUM(it.Ordinal * gd.PRICE), 2) AS revenueContribution
	      FROM customers cm
	      JOIN receipts rc
	         ON cm.CId = rc.Customer
	      JOIN items it
	         ON rc.RNumber = it.Receipt
	      JOIN goods gd
	         ON it.Item = gd.GId
	      WHERE MONTHNAME(rc.SaleDate) = "October"
	      AND YEAR(rc.SaleDate) = 2007
	      GROUP BY DAY(rc.SaleDate)
	      ORDER BY revenueContribution DESC) AS myTbl
	HAVING MAX(revenueContribution))
GROUP BY gd.Flavor, gd.Food
-- Q7



-- Q8



-- Q9



-- Q10



