

CREATE TABLE Student (
  student_id SERIAL PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  email VARCHAR(100) UNIQUE NOT NULL,
  phone VARCHAR(15)
);

CREATE TABLE Course (
  course_id SERIAL PRIMARY KEY,
  title VARCHAR(100) NOT NULL,
  credits INTEGER CHECK (credits > 0 AND credits <= 10)
);

CREATE TABLE Instructor (
  instructor_id SERIAL PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  department VARCHAR(100)
);

CREATE TABLE Enrollment (
  enrollment_id SERIAL PRIMARY KEY,
  student_id INTEGER NOT NULL REFERENCES Student(student_id) ON DELETE CASCADE,
  course_id INTEGER NOT NULL REFERENCES Course(course_id) ON DELETE CASCADE,
  grade INTEGER CHECK (grade >= 0 AND grade <= 100),
  semester VARCHAR(10) NOT NULL CHECK (semester IN ('Spring','Fall')),
  UNIQUE(student_id, course_id, semester)
);

-- Add indexes to optimize foreign key lookups
CREATE INDEX idx_enrollment_student ON Enrollment(student_id);
CREATE INDEX idx_enrollment_course ON Enrollment(course_id);

CREATE TABLE Teaching_Assignment (
  assignment_id SERIAL PRIMARY KEY,
  instructor_id INTEGER NOT NULL REFERENCES Instructor(instructor_id) ON DELETE CASCADE,
  course_id INTEGER NOT NULL REFERENCES Course(course_id) ON DELETE CASCADE,
  semester VARCHAR(10) NOT NULL CHECK (semester IN ('Spring','Fall')),
  UNIQUE(instructor_id, course_id, semester)
);

-- Add indexes to optimize foreign key lookups
CREATE INDEX idx_assignment_instructor ON Teaching_Assignment(instructor_id);
CREATE INDEX idx_assignment_course ON Teaching_Assignment(course_id);

