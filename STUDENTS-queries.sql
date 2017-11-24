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
SELECT First, Last, MAX(myTbl.count) AS numStudents
FROM 
	(SELECT tc.First, tc.Last, COUNT(tc.Last) AS count
	FROM list ls, teachers tc
	WHERE ls.classroom = tc.classroom
	GROUP BY tc.Last) AS myTbl;

-- Q2 )  Originally used LIKE function, which I included below
-- 		But switched to using regular expressions because the same
--			logic could be done in less statements. 
--
--
-- SELECT ls.FirstName, ls.grade, COUNT(ls.grade)
-- FROM list ls, teachers tc
-- WHERE ls.classroom = tc.classroom
-- 	AND (ls.FirstName LIKE "A%"
-- 	OR ls.FirstName LIKE "B%"
--    OR ls.FirstName LIKE "C%")
-- GROUP BY ls.grade;

SELECT MAX(num) AS totalStudents, Grade
FROM(
	SELECT ls.FirstName AS FirstName, ls.grade AS Grade, COUNT(ls.grade) AS num
	FROM list ls, teachers tc
	WHERE ls.classroom = tc.classroom
		AND ls.FirstName REGEXP '^A|^B|^C'
	GROUP BY ls.grade
	ORDER BY num DESC) AS myTbl;

-- Q3 
SELECT classroom, COUNT(*)
FROM list
GROUP BY classroom
HAVING COUNT(*) < (SELECT (COUNT(*) / COUNT(DISTINCT classroom)) FROM list)
ORDER BY classroom ASC;

-- Q4 
SELECT ls1.classroom AS classroom1, ls2.classroom AS classroom2,
		ls1.num AS numStudents
FROM (SELECT classroom, COUNT(*) AS num
		FROM list
		GROUP BY classroom) AS ls1
	JOIN (SELECT classroom, COUNT(*) AS num
      FROM list
      GROUP BY classroom) AS ls2
	ON ls1.num = ls2.num
	AND ls1.classroom > ls2.classroom
ORDER BY ls1.num ASC;

-- Q5  CURRENTLY INCORRECT, SELECTING CORRECT GRADES, INCORRECT TEACHERS:
SELECT *
FROM list ls
	JOIN teachers tc
		ON ls.classroom = tc.classroom
WHERE ls.grade IN (SELECT grade
						FROM list
						GROUP BY grade
						HAVING COUNT(DISTINCT classroom) > 1
						ORDER BY grade ASC)
	AND ls.classroom IN (SELECT MAX(classroom)
								FROM list
								GROUP BY grade)
GROUP BY ls.grade;


SELECT classroom, COUNT(classroom)
FROM list
GROUP BY classroom;


SELECT grade
FROM list 
GROUP BY grade
HAVING COUNT(DISTINCT classroom) > 1
ORDER BY grade ASC;

