-- ## Create Table and Insert Data

-- Create Database

CREATE DATABASE university_db;

-- Create Table

CREATE TABLE
    students (
        student_id SERIAL PRIMARY KEY,
        student_name VARCHAR(255),
        age INT,
        email VARCHAR(255),
        frontend_mark INT,
        backend_mark INT,
        status VARCHAR(255)
    );

CREATE TABLE
    courses(
        course_id SERIAL PRIMARY KEY,
        course_name VARCHAR(255),
        credits INT
    );

CREATE TABLE
    enrollment (
        enrollment_id SERIAL PRIMARY KEY,
        student_id INT,
        course_id INT,
        FOREIGN KEY (student_id) REFERENCES students(student_id),
        FOREIGN KEY (course_id) REFERENCES courses(course_id)
    );

-- Insert Data


 INSERT INTO students (student_name, age, email, frontend_mark, backend_mark, status)
 VALUES('Alice', 22, 'alice@example.com', 55, 57, NULL),
 ('Bob', 21, 'bob@example.com', 34, 45, NULL),
 ('Charlie', 23, 'charlie@example.com', 60, 59, NULL),
 ('David', 20, 'david@example.com', 40, 49, NULL),
 ('Eve', 24, 'newemail@example.com', 45, 34, NULL),
 ('Rahim', 23, 'rahim@gmail.com', 46, 42, NULL);
 
 INSERT INTO courses(course_name, credits ) 
 VALUES('Next.js', 3), ('React.js', 4), ('Databases', 3), ('Prisma', 3);
 
 INSERT INTO enrollment(student_id, course_id) VALUES
 (1,1),(1, 2), (2, 1), (3, 2);
 

-- Select tables Details

SELECT * FROM students;

SELECT * FROM courses;

SELECT * FROM enrollment;

-- ## Execute SQL queries

-- Query 1: Insert a new student record

INSERT INTO
    students (
        student_name,
        age,
        email,
        frontend_mark,
        backend_mark,
        status
    )
VALUES (
        'Mahabubur Rahman',
        20,
        'mahabub@email.com',
        60,
        60,
        NULL
    );

SELECT * FROM students;

-- Query 2: Retrieve the names of all students who are enrolled in the course titled 'Next.js'

SELECT students.student_name
FROM students
    INNER JOIN enrollment ON enrollment.student_id = students.student_id
    INNER JOIN courses ON enrollment.course_id = courses.course_id
WHERE
    courses.course_name = 'Next.js';

-- Query 3: Update the status of the student with the highest total

UPDATE students
SET status = 'Awarded'
WHERE (frontend_mark + backend_mark) = (
        SELECT
            MAX(frontend_mark + backend_mark)
        FROM students
    );

SELECT * FROM students;

-- Query 4: Delete all courses that have no students enrolled.

DELETE FROM courses
WHERE course_id NOT IN (
        SELECT course_id
        from enrollment
    );

SELECT * FROM courses;

-- Query 5:Retrieve the names of students using a limit of 2, starting from the 3rd student.

SELECT student_name
FROM students
ORDER BY student_id ASC
LIMIT 2
OFFSET 2;

-- Query 6: Retrieve the course names and the number of students enrolled in each course.

SELECT
    courses.course_name,
    count(enrollment.student_id) as students_enrolled
FROM courses
    LEFT JOIN enrollment ON courses.course_id = enrollment.course_id
GROUP BY courses.course_name
HAVING
    count(enrollment.student_id) > 0;

-- Query 7: Calculate and display the average age of all students.

SELECT avg(age) as average_age FROM students;

-- Query 8: Retrieve the names of students whose email addresses contain 'example.com'.

SELECT student_name FROM students WHERE email LIKE '%example.com%';