--5.1
SELECT surname, first_name, Teacher.teacher_number, course_code, instance_number  FROM Teacher
JOIN CourseInstance ON (Teacher.teacher_number = CourseInstance.teacher_number)
ORDER BY surname, first_name, course_code, instance_number

--5.2
SELECT course_code, course_name, surname + ' ' + first_name AS "Person in charge" FROM Teacher 
JOIN Course ON (Teacher.teacher_number = Course.person_in_charge)
ORDER BY course_code

--5.3
SELECT surname, first_name, Student.student_number, 
CAST(AVG(grade * 1.0) AS DECIMAL (4,2)) AS "Grade point average" FROM Student
JOIN CourseGrade ON (Student.student_number = CourseGrade.student_number)
GROUP BY surname, first_name, Student.student_number
ORDER BY surname, first_name, student_number

--5.4a
SELECT surname, first_name, start_date, end_date FROM Teacher 
JOIN AcademicAdvisor ON (Teacher.teacher_number = AcademicAdvisor.teacher_number) 
WHERE end_date IS NULL
ORDER BY surname, first_name, Teacher.teacher_number

--5.4b
SELECT surname, first_name, start_date, end_date FROM Teacher 
JOIN AcademicAdvisor ON (Teacher.teacher_number = AcademicAdvisor.teacher_number) 
ORDER BY surname, first_name, Teacher.teacher_number

--5.5
SELECT  description AS "Misconduct discription so far" FROM MisconductIncident
JOIN MisconductType ON (MisconductIncident.misconduct_code = MisconductType.misconduct_code)
ORDER BY description

--5.6
SELECT surname, first_name, Student.student_number, course_code, grade FROM Student 
JOIN CourseGrade ON (Student.student_number = CourseGrade.student_number)
WHERE city = 'Helsinki' AND grade > 2 
GROUP BY surname, first_name, Student.student_number, course_code, grade
ORDER BY surname, first_name, student_number, course_code

--5.6
SELECT surname, first_name, Student.student_number, course_code, grade FROM Student 
JOIN CourseGrade ON (Student.student_number = CourseGrade.student_number)
WHERE EXISTS (SELECT student_number FROM Student WHERE grade > 2) AND city = 'Helsinki' 
GROUP BY surname, first_name, Student.student_number, course_code, grade
ORDER BY surname, first_name, student_number, course_code

--5.7
SELECT Course.course_code, Course.course_name, Teacher.teacher_number, surname, first_name 
FROM Teacher
JOIN CourseInstance ON (Teacher.teacher_number = CourseInstance.teacher_number)
JOIN Course ON (CourseInstance.course_code = Course.course_code)
WHERE Course.course_code = 'a730'
GROUP BY Course.course_code, Course.course_name, Teacher.teacher_number, surname, first_name
ORDER BY teacher_number

--5.8
SELECT course_name, grade, surname, first_name, Student.student_number FROM Student 
JOIN CourseGrade ON (Student.student_number = CourseGrade.student_number)
JOIN Course ON (CourseGrade.course_code = Course.course_code) 
WHERE gender = 'F' AND (grade > 0 OR grade IS NOT NULL) 
ORDER BY course_name ASC, grade DESC, surname ASC, first_name ASC, Student.student_number ASC


--5.9
SELECT CourseGrade.course_code, course_name, COUNT(grade) AS "Grade five" FROM Student
JOIN CourseGrade ON (Student.student_number = CourseGrade.student_number)
JOIN Course ON (CourseGrade.course_code = Course.course_code) 
WHERE gender = 'F' AND grade = 5
GROUP BY CourseGrade.course_code, course_name
ORDER BY CourseGrade.course_code

--5.10
SELECT surname, first_name, Student.student_number FROM Student
JOIN CourseGrade ON (Student.student_number = CourseGrade.student_number)
WHERE EXISTS (SELECT DISTINCT Student.student_number FROM Student WHERE grade = 3)
GROUP BY surname, first_name, Student.student_number
ORDER BY surname, first_name, student_number

 --5.11
 SELECT Teacher.teacher_number, surname, first_name, DATENAME(MONTH, grade_date) AS "Grade month" 
 FROM Teacher
 JOIN CourseInstance ON (Teacher.teacher_number = CourseInstance.teacher_number)
 JOIN CourseGrade ON (CourseInstance.teacher_number = CourseGrade.examiner) 
 WHERE DATENAME(MONTH, grade_date) = 'May' OR DATENAME(MONTH, grade_date) = 'Toukokuu'
 ORDER BY Teacher.teacher_number

 --5.12
 SELECT gender, CAST(AVG(grade * 1.0) AS DECIMAL (4,2)) AS "Average grade",
 COUNT(grade) AS "Number of grades" FROM Student 
 JOIN CourseGrade ON (Student.student_number = CourseGrade.student_number)
 GROUP BY gender
 ORDER BY "Number of grades"

 --5.13
 SELECT DISTINCT campus_name, teacher_number FROM Campus CROSS JOIN AcademicAdvisor 
 ORDER BY campus_name, teacher_number

 --5.14
 SELECT CourseGrade.course_code, CourseGrade.instance_number, course_name,
 Student.student_number, surname, first_name, description
 FROM CourseInstance
 JOIN Course ON (CourseInstance.course_code = Course.course_code)
 JOIN CourseGrade ON (Course.course_code = CourseGrade.course_code)
 JOIN Student ON (CourseGrade.student_number = Student.student_number)
 JOIN MisconductIncident ON (CourseInstance.course_code = MisconductIncident.course_code)
 JOIN MisconductType ON (MisconductIncident.misconduct_code = MisconductType.misconduct_code)
 WHERE grade = 0 OR grade IS NULL
 GROUP BY CourseGrade.course_code, CourseGrade.instance_number, course_name,
 Student.student_number, surname, first_name, description
 
 --5.15
 SELECT Student.student_number, surname, first_name,
 SanctionType.description AS "disciplinary sanction", 
 MisconductType.description AS "misconduct discription"  FROM Student
 JOIN MisconductIncident ON (Student.student_number = MisconductIncident.student_number)
 JOIN SanctionType ON (MisconductIncident.sanction_code = SanctionType.sanction_code)
 JOIN MisconductType ON (MisconductIncident.misconduct_code = MisconductType.misconduct_code)
 WHERE SanctionType.description = 'Written warning'

 --5.16 
SELECT CAST((100.0 * (SELECT COUNT(MisconductIncident.student_number) FROM MisconductIncident)/
COUNT(Student.student_number)) AS DECIMAL (4,1)) AS "Misconduct %" FROM Student


 --5.17
 SELECT course_name, Teacher.teacher_number, surname + ' ' + first_name AS "Person in charge teaching" FROM Course AS C1 
 JOIN CourseInstance ON (C1.course_code = CourseInstance.course_code)
 JOIN Teacher ON (CourseInstance.teacher_number = Teacher.teacher_number)
 WHERE person_in_charge = CourseInstance.teacher_number
 ORDER BY surname, first_name, teacher_number