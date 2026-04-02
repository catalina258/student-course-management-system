-- stored_procedures.sql
CREATE OR REPLACE FUNCTION enroll_student(p_student_id INT, p_course_id INT, p_semester VARCHAR)
RETURNS VOID AS $$
BEGIN
  INSERT INTO Enrollment (student_id, course_id, semester)
  VALUES (p_student_id, p_course_id, p_semester);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION get_courses_by_student(p_email VARCHAR)
RETURNS TABLE(course_title VARCHAR, grade INT) AS $$
BEGIN
  RETURN QUERY
  SELECT c.title, e.grade
  FROM Student s
  JOIN Enrollment e ON s.student_id = e.student_id
  JOIN Course c ON e.course_id = c.course_id
  WHERE s.email = p_email;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION delete_student(p_student_id INT)
RETURNS VOID AS $$
BEGIN
  DELETE FROM Student WHERE student_id = p_student_id;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION assign_instructor(
  p_instructor_id INT, 
  p_course_id INT, 
  p_semester VARCHAR)
RETURNS VOID AS $$
BEGIN
  INSERT INTO Teaching_Assignment (instructor_id, course_id, semester)
  VALUES (p_instructor_id, p_course_id, p_semester);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION get_students_by_course(p_course_id INT)
RETURNS TABLE(student_name VARCHAR, grade INT, semester VARCHAR) AS $$
BEGIN
  RETURN QUERY
  SELECT s.name, e.grade, e.semester
  FROM Enrollment e
  JOIN Student s ON s.student_id = e.student_id
  WHERE e.course_id = p_course_id;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION update_grade(
  p_student_id INT, 
  p_course_id INT, 
  p_semester VARCHAR, 
  p_new_grade INT)
RETURNS VOID AS $$
BEGIN
  UPDATE Enrollment
  SET grade = p_new_grade
  WHERE student_id = p_student_id AND course_id = p_course_id AND semester = p_semester;
END;
$$ LANGUAGE plpgsql;

