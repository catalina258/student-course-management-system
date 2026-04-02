CREATE VIEW student_average AS
SELECT s.name, AVG(e.grade) AS average_grade
FROM Student s
JOIN Enrollment e USING (student_id)
GROUP BY s.name;

CREATE VIEW instructor_courses AS
SELECT i.name AS instructor_name, c.title, ta.semester
FROM Instructor i
JOIN Teaching_Assignment ta USING (instructor_id)
JOIN Course c USING (course_id);

CREATE VIEW students_per_semester AS
SELECT s.student_id, s.name, e.semester, COUNT(e.course_id) AS courses_taken
FROM Enrollment e
JOIN Student s USING (student_id)
GROUP BY s.student_id, s.name, e.semester
HAVING COUNT(e.course_id) > 3;

CREATE VIEW courses_without_spring_students AS
SELECT c.course_id, c.title
FROM Course c
LEFT JOIN Enrollment e
  ON c.course_id = e.course_id AND e.semester = 'Spring'
WHERE e.course_id IS NULL;

CREATE VIEW highest_grade_per_course AS
SELECT c.title, MAX(e.grade) AS highest_grade
FROM Enrollment e
JOIN Course c USING (course_id)
GROUP BY c.title;

CREATE VIEW avg_grade_per_course AS
SELECT c.title, AVG(e.grade) AS average_grade
FROM Enrollment e
JOIN Course c ON e.course_id = c.course_id
GROUP BY c.title;

CREATE VIEW students_without_enrollments AS
SELECT s.student_id, s.name
FROM Student s
LEFT JOIN Enrollment e ON s.student_id = e.student_id
WHERE e.enrollment_id IS NULL;

CREATE VIEW instructor_load AS
SELECT i.name, ta.semester, COUNT(*) AS courses_taught
FROM Instructor i
JOIN Teaching_Assignment ta ON i.instructor_id = ta.instructor_id
GROUP BY i.name, ta.semester;

CREATE VIEW courses_without_instructor AS
SELECT c.course_id, c.title
FROM Course c
LEFT JOIN Teaching_Assignment ta ON c.course_id = ta.course_id
WHERE ta.course_id IS NULL;