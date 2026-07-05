-- ================================================
-- PROJECT 2: STUDENT GRADING SYSTEM
-- Author: Deivanai K
-- Description: A database to manage students,
--              subjects and their grades
-- ================================================

-- DROP existing tables
DROP TABLE IF EXISTS grades;
DROP TABLE IF EXISTS students;
DROP TABLE IF EXISTS subjects;

-- ================================================
-- CREATE TABLES
-- ================================================

CREATE TABLE students (
    id      INTEGER PRIMARY KEY AUTOINCREMENT,
    name    TEXT NOT NULL,
    email   TEXT,
    class   TEXT
);

CREATE TABLE subjects (
    id          INTEGER PRIMARY KEY AUTOINCREMENT,
    name        TEXT NOT NULL,
    max_marks   INTEGER
);

CREATE TABLE grades (
    id          INTEGER PRIMARY KEY AUTOINCREMENT,
    student_id  INTEGER,
    subject_id  INTEGER,
    marks       INTEGER,
    grade       TEXT
);

-- ================================================
-- INSERT SAMPLE DATA
-- ================================================

INSERT INTO students (name, email, class) VALUES
    ('Ravi Kumar', 'ravi@gmail.com', '10A'),
    ('Priya Sharma', 'priya@gmail.com', '10A'),
    ('Kiran Raj', 'kiran@gmail.com', '10B'),
    ('Ananya Singh', 'ananya@gmail.com', '10B'),
    ('Arjun Mehta', 'arjun@gmail.com', '10A');

INSERT INTO subjects (name, max_marks) VALUES
    ('Maths', 100),
    ('Science', 100),
    ('English', 100),
    ('History', 100);

INSERT INTO grades (student_id, subject_id, marks, grade) VALUES
    (1, 1, 92, 'A'),
    (1, 2, 78, 'B'),
    (1, 3, 85, 'A'),
    (1, 4, 70, 'B'),
    (2, 1, 95, 'A'),
    (2, 2, 88, 'A'),
    (2, 3, 76, 'B'),
    (2, 4, 91, 'A'),
    (3, 1, 45, 'C'),
    (3, 2, 38, 'F'),
    (3, 3, 55, 'C'),
    (3, 4, 42, 'C'),
    (4, 1, 88, 'A'),
    (4, 2, 92, 'A'),
    (4, 3, 35, 'F'),
    (4, 4, 78, 'B'),
    (5, 1, 60, 'C'),
    (5, 2, 55, 'C'),
    (5, 3, 72, 'B'),
    (5, 4, 48, 'C');

-- ================================================
-- FEATURE 1: View all students with their grades
-- ================================================

SELECT 
    students.name AS student_name,
    students.class,
    subjects.name AS subject,
    grades.marks,
    grades.grade
FROM grades
JOIN students ON grades.student_id = students.id
JOIN subjects ON grades.subject_id = subjects.id
ORDER BY students.name, subjects.name;

-- ================================================
-- FEATURE 2: Average marks per student
-- ================================================

SELECT 
    students.name AS student_name,
    students.class,
    ROUND(AVG(grades.marks), 2) AS average_marks,
    SUM(grades.marks) AS total_marks
FROM grades
JOIN students ON grades.student_id = students.id
GROUP BY students.id, students.name, students.class
ORDER BY average_marks DESC;

-- ================================================
-- FEATURE 3: Top performers (average above 80)
-- ================================================

SELECT 
    students.name AS student_name,
    students.class,
    ROUND(AVG(grades.marks), 2) AS average_marks
FROM grades
JOIN students ON grades.student_id = students.id
GROUP BY students.id, students.name, students.class
HAVING AVG(grades.marks) > 80
ORDER BY average_marks DESC;

-- ================================================
-- FEATURE 4: Subject wise average marks
-- ================================================
