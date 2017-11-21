/* -.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.

* File Name : STUDENTS-queries.sql

* Purpose :

* Creation Date : 20-11-2017

* Last Modified : Mon 20 Nov 2017 09:26:45 PM STD

* Created By :  Jordan Castillo

* Email : jtcastil@calpoly.edu
_._._._._._._._._._._._._._._._._._._._._.*/
USE students
-- Q1
SELECT First, Last, MAX(myTbl.count)
FROM 
	(SELECT tc.First, tc.Last, COUNT(tc.Last) AS count
	FROM list ls, teachers tc
	WHERE ls.classroom = tc.classroom
	GROUP BY tc.Last) AS myTbl;



