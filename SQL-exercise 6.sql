--6.1 
SELECT DISTINCT surname, first_name, Teacher.teacher_number, course_name FROM Course 
JOIN CourseInstance ON (Course.course_code = CourseInstance.course_code)
JOIN Teacher ON (CourseInstance.teacher_number = Teacher.teacher_number)
WHERE Teacher.teacher_number = 'h303'
ORDER BY course_name 

--6.2
SELECT surname, first_name, Teacher.teacher_number, course_name FROM Course 
RIGHT JOIN Teacher ON (Course.person_in_charge = Teacher.teacher_number)
ORDER BY surname, first_name, Teacher.teacher_number, course_name

--6.3
SELECT course_code, instance_number, start_date,
surname + ' ' + first_name AS "Teacher", Teacher.teacher_number FROM CourseInstance 
LEFT JOIN Teacher ON (CourseInstance.teacher_number = Teacher.teacher_number)
WHERE YEAR(start_date) = 2008
ORDER BY course_code, instance_number

--6.4
SELECT campus_name, surname, first_name, teacher_number, course_name FROM Course 
RIGHT JOIN Teacher ON (Course.person_in_charge = Teacher.teacher_number)
LEFT JOIN Campus ON (Teacher.campus_code = Campus.campus_code)
ORDER BY campus_name, surname, first_name, teacher_number, course_name

--6.5
SELECT campus_name, COUNT(teacher_number) AS "Number of teachers" FROM Teacher 
RIGHT JOIN Campus ON (Teacher.campus_code = Campus.campus_code)
GROUP BY campus_name
ORDER BY campus_name

--6.6
SELECT surname, first_name, Teacher.teacher_number, start_date, end_date FROM Teacher 
JOIN AcademicAdvisor ON (Teacher.teacher_number = AcademicAdvisor.teacher_number)
WHERE YEAR(start_date) = 2010 OR YEAR(end_date) = 2010
ORDER BY surname, first_name, teacher_number

--6.7
SELECT surname, first_name, teacher_number, 
	(CASE course_name
	WHEN course_name THEN course_name
	ELSE ' '
	END) AS "Course name"
FROM Course
RIGHT JOIN Teacher ON (Teacher.teacher_number = Course.person_in_charge)
ORDER BY surname, first_name, teacher_number

--6.8
SELECT DISTINCT surname, first_name, Teacher.teacher_number, 
	(CASE Teacher.campus_code
	WHEN AcademicAdvisor.campus_code  THEN 'Academic advisor'
	ELSE ' '
	END) AS "Comment"
FROM Teacher 
LEFT JOIN AcademicAdvisor ON (Teacher.campus_code = AcademicAdvisor.campus_code)
ORDER BY surname, first_name, teacher_number

--6.9
SELECT campus_name, COUNT(teacher_number) AS "Number of teachers incharge of a course" FROM Course 
JOIN Teacher ON (Course.person_in_charge = Teacher.teacher_number)
JOIN Campus ON (Teacher.campus_code = Campus.campus_code)
GROUP BY campus_name, teacher_number


