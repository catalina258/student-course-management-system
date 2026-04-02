-- Create
INSERT INTO Student (name, email, phone)
VALUES ('George Smith', 'george.smith+2@gmail.com', '07412345607');

-- Add a new instructor
INSERT INTO Instructor (name, department)
VALUES ('Andrei Popescu', 'Computer Science');

-- Create a new course
INSERT INTO Course (title, credits)
VALUES ('Introduction to Databases', 5);

-- Read
SELECT s.name, c.title, e.grade
FROM Student s
JOIN Enrollment e USING (student_id)
JOIN Course c USING (course_id)
WHERE s.email = 'maria.elena@yahoo.com';

-- Shows all students and courses in semester Fall
SELECT s.name, c.title
FROM Student s
JOIN Enrollment e ON s.student_id = e.student_id
JOIN Course c ON e.course_id = c.course_id
WHERE e.semester = 'Fall';

-- Shows all students and courses in semester Spring
SELECT s.name, c.title
FROM Student s
JOIN Enrollment e ON s.student_id = e.student_id
JOIN Course c ON e.course_id = c.course_id
WHERE e.semester = 'Spring';

-- Shows all grades of all student for a type of course
SELECT s.name, e.grade
FROM Enrollment e
JOIN Student s ON s.student_id = e.student_id
WHERE e.course_id = 2;

-- Update
UPDATE Enrollment
SET grade = 95
WHERE student_id = 1 AND course_id = 1;

UPDATE Student
SET phone = '0799999999'
WHERE student_id = 1;

-- Updates department for instructor
UPDATE Instructor
SET department = 'Mathematics'
WHERE instructor_id = 3;

-- Rises the number of credits for a course
UPDATE Course
SET credits = credits + 1
WHERE course_id = 1;


-- Delete
DELETE FROM Enrollment
WHERE enrollment_id = 5;

DELETE FROM Enrollment
WHERE course_id = 3 AND semester = 'Fall';

-- Delete a student using email
DELETE FROM Student
WHERE email = 'test@example.com';

-- Detele all student with no enrollment
DELETE FROM Student
WHERE student_id NOT IN (SELECT DISTINCT student_id FROM Enrollment);