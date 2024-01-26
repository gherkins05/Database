-- departments TABLE
CREATE TABLE departments(
    dept_id SERIAL PRIMARY KEY,

    dept_name VARCHAR(50) NOT NULL
);
-- courses TABLE
CREATE TABLE courses(
    course_id SERIAL PRIMARY KEY,

    course_name VARCHAR(100) NOT NULL
);
-- students TABLE
CREATE TABLE students(
    stu_id SERIAL PRIMARY KEY,

    stu_first_name VARCHAR(50) NOT NULL,
    stu_mid_name VARCHAR(50),
    stu_last_name VARCHAR(50) NOT NULL,
    stu_addr1 VARCHAR(50) NOT NULL,
    stu_addr2 VARCHAR(50),
    stu_city VARCHAR(30) NOT NULL,
    stu_postcode CHAR(8) NOT NULL,
    stu_email VARCHAR(150) NOT NULL,
    stu_phone VARCHAR(15) NOT NULL,
    stu_year SMALLINT NOT NULL
);
-- lecturers TABLE
Create TABLE lecturers(
    lect_id SERIAL PRIMARY KEY,
    dept_id INT NOT NULL REFERENCES departments(dept_id),

    lect_title VARCHAR(10),
    lect_first_name VARCHAR(50) NOT NULL,
    lect_last_name VARCHAR(50) NOT NULL,
    lect_email VARCHAR(100) NOT NULL
);
-- lecturers_courses TABLE with composite key
Create TABLE lecturers_courses(
    lect_id INT NOT NULL REFERENCES lecturers(lect_id),
    course_id INT NOT NULL REFERENCES courses(course_id)
);
-- students_courses TABLE with composite key
Create TABLE students_courses(
    stu_id INT NOT NULL REFERENCES students(stu_id),
    course_id INT NOT NULL REFERENCES courses(course_id),

    grade SMALLINT NOT NULL
);

-- Insert students
INSERT INTO students (stu_first_name, stu_mid_name, stu_last_name, stu_addr1, stu_addr2, stu_city, stu_postcode, stu_email, stu_phone, stu_year)
VALUES
  ('Mark', 'J', 'Johnson', '123 Main Street', '', 'Portsmouth', 'PO1 3AX', 'mark.johnson@email.com', '1234567890', 3),
  ('Lisa', 'M', 'Smith', '456 High Street', 'Floor 3', 'London', 'SW1A 1AA', 'lisa.smith@email.com', '0987654321', 2),
  ('John', 'D', 'Doe', '789 Park Avenue', 'Floor 2', 'Manchester', 'M1 4BT', 'john.doe@email.com', '1234567890', 4),
  ('Emma', 'L', 'Brown', '1011 South Street', '', 'Birmingham', 'B1 1QU', 'emma.brown@email.com', '0987654321', 1),
  ('Sam', 'T', 'Green', '1213 East Street', 'Floor 4', 'Liverpool', 'L1 1JT', 'sam.green@email.com', '1234567890', 3),
  ('Alan', 'B', 'Turing', '1415 North Street', '', 'Cambridge', 'CB2 1TN', 'alan.turing@email.com', '1112223334', 2),
  ('Grace', 'M', 'Hopper', '1617 West Street', 'Flat 6', 'Oxford', 'OX1 2JD', 'grace.hopper@email.com', '5556667778', 1);

-- Insert departments
INSERT INTO departments (dept_name)
VALUES
  ('School of Computing'),
  ('School of Engineering');

-- Insert lecturers
INSERT INTO lecturers (dept_id, lect_title, lect_first_name, lect_last_name, lect_email)
VALUES
  (1, '', 'Val', 'Adamescu', 'val.adamescu@port.ac.uk'),
  (1, '', 'Mark', 'Venn', 'mark.venn@port.ac.uk'),
  (1, 'Dr.', 'Claudia', 'Iacob', 'claudia.iacob@port.ac.uk'),
  (2, 'Prof.', 'Mark', 'Black', 'mark.black@port.ac.uk'),
  (2, 'Dr.', 'Sarah', 'Blue', 'sarah.blue@port.ac.uk');

-- Insert courses
INSERT INTO courses (course_name)
VALUES
  ('Computing'),
  ('Software Engineering'),
  ('Computer Science'),
  ('Networking'),
  ('Cyber Security'),
  ('Mechanical Engineering'),
  ('Civil Engineering');

-- Insert students_courses
INSERT INTO students_courses (stu_id, course_id, grade)
VALUES
  (1, 1, 75),
  (2, 2, 85),
  (3, 3, 65),
  (4, 4, 95),
  (5, 5, 80),
  (6, 6, 70),
  (7, 7, 88);

-- Insert lecturers_courses
INSERT INTO lecturers_courses (lect_id, course_id)
VALUES
  (1, 1),
  (2, 2),
  (3, 3),
  (4, 6),
  (5, 7);

-- Custom insert statement
INSERT INTO students (stu_first_name, stu_mid_name, stu_last_name, stu_addr1, stu_addr2, stu_city, stu_postcode, stu_email, stu_phone, stu_year)
VALUES
  ('Joe', '', 'Bloggs', '867 Saint Marys Road', '', 'Southampton', 'SO18 8ER', 'joe.bloggs@email.com', '563490165', 1);

INSERT INTO students_courses (stu_id, course_id, grade)
VALUES
  (8, 3, 82);