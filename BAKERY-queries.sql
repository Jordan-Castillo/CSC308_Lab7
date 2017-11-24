/* -.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.

* File Name : BAKERY-queries.sql

* Purpose :

* Creation Date : 20-11-2017

* Last Modified : Mon 20 Nov 2017 09:27:00 PM STD

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
		AND gd.Food = "Twist")

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
HAVING MAX(revenueContribution)

-- Q4




