--8.1
(SELECT surname FROM Teacher)
UNION
(SELECT surname FROM Student)
ORDER BY surname

--8.2
(SELECT city FROM Campus)
INTERSECT 
(SELECT city FROM Student)

--8.3
(SELECT city FROM Campus)
EXCEPT
(SELECT city FROM Student)

--8.4
(SELECT YEAR(birth_date) AS Year FROM Teacher)
UNION
(SELECT YEAR(birth_date) AS Year FROM Student)
 ORDER BY Year DESC

 --8.5
 (SELECT YEAR(birth_date) AS Year FROM Teacher)
 INTERSECT
 (SELECT YEAR(birth_date) AS Year FROM Student)

 --8.6
 (SELECT YEAR(birth_date) AS Year FROM Teacher)
 EXCEPT
 (SELECT YEAR(birth_date) AS Year FROM Student)

 --8.7
 (SELECT YEAR(birth_date) AS Year FROM Student)
 EXCEPT
 (SELECT YEAR(birth_date) AS Year FROM Teacher)
 ORDER BY Year DESC
 
 --To be continue 
