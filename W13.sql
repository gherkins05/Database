-- dsd_lab13
-- forgot to meet all specific requirements e.g 1 book by all 3 authors
INSERT INTO authors
    (auth_id, auth_name, auth_last_name, auth_phone, auth_country)
VALUES
    (1, 'Lilia', 'Wintour', '769-428-7287', null),
    (2, 'Ema', 'Sellars', '345-205-9863', 'Brazil'),
    (3, 'Mahmud', 'Slowcock', '181-464-8814', 'New Zealand');

INSERT INTO publishers
    (pub_id, pub_name, pub_city)
VALUES
    (1, 'Julina', null),
    (2, 'Dacie', 'Yanqi');

INSERT INTO genres
    (genre_id, genre_name)
VALUES
    (1, 'Bunny'),
    (2, 'Lenna'),
    (3, 'Spike');

INSERT INTO books
    (book_id, pub_id, book_title, book_pub_year)
VALUES
    (1, 2, 'Lady Be Good', 1803),
    (2, 1, 'Sexual Chronicles of a French Family (Chroniques sexuelles d''une famille d''aujourd''hui)', 1839),
    (3, 1, 'Yossi (Ha-Sippur Shel Yossi)', 1976),
    (4, 1, 'Bridge of Dragons', 1818),
    (5, 1, 'War of the Shaolin Temple (Shao Lin shi san gun seng)', 1838),
    (6, 1, 'Suspended Vocation, The (La vocation suspendue)', 1825),
    (7, 1, 'Suspended Animation', 2002),
    (8, 2, 'Yellow Sky', 1949),
    (9, 2, 'Green Lantern: First Flight', 1864),
    (10, 1, 'Thomas and the Magic Railroad', 1868);

INSERT INTO books_genres
    (book_id, genre_id) 
VALUES
    (4, 1),
    (6, 1),
    (4, 2),
    (7, 3),
    (10, 2),
    (2, 2),
    (4, 3),
    (3, 2),
    (9, 2),
    (1, 2);

INSERT INTO books_authors
    (book_id, auth_id) 
VALUES 
    (7, 3),
    (2, 3),
    (6, 1),
    (10, 2),
    (6, 2),
    (3, 1),
    (7, 2),
    (10, 3),
    (4, 1),
    (2, 1);


-- Question 2
CREATE VIEW books_details AS 
SELECT
    b.book_id AS "ID",
    b.book_title AS "Title",
    g.genre_name AS "Genre",
    p.pub_name AS "Publisher",
    b.book_pub_year AS "Publication Year"
FROM
    books b
    JOIN publishers p ON b.pub_id = p.pub_id
    JOIN genres g ON b.genre_id = g.genre_id
ORDER BY
    g.genre_name ASC;

-- Question 3
SELECT
    CONCAT_WS(' ',a.auth_name,a.auth_mid_name,a.auth_last_name) AS "Author",
    bd."Title",
    bd."Genre"
FROM
    authors a
    JOIN books_authors ba ON a.auth_id = ba.auth_id
    JOIN books b ON ba.book_id = b.book_id
    JOIN books_details bd ON bd."ID" = b.book_id
WHERE
    bd."Publication Year" >= '2020'
ORDER BY 
    bd."Publication Year" DESC;

-- Question 4
CREATE VIEW student_loan_details AS
SELECT
    s.stu_id AS "Student ID",
    CONCAT_WS(' ', s.stu_name, s.stu_mid_name, s.stu_last_name) AS "Name",
    l.loan_id AS "Loan ID",
    l.loan_date AS "Loan Date",
    l.due_date AS "Due Date",
    l.status AS "Loan Status",
    l.inv_id AS "Inv ID",
    bd."Title"
FROM
    students s
    JOIN loans l ON s.stu_id = l.stu_id
    JOIN books_inventory bi ON l.inv_id = bi.inv_id
    JOIN books b on bi.book_id = b.book_id
    JOIN books_details bd on bd."ID" = b.book_id;

-- Question 5
SELECT
    sd."Student ID",
    sd."Name",
    sd."Loan Status",
    sd."Loan ID",
    sd."Loan Date",
    sd."Due Date",
    bd."Title",
    c.course_name AS "Course"
FROM
    student_loan_details sd
    JOIN books_inventory bi ON sd."Inv ID" = bi.inv_id
    JOIN books b ON bi.book_id = b.book_id
    JOIN books_details bd ON b.book_id = bd."ID"
    JOIN students s ON sd."Student ID" = s.stu_id
    JOIN courses c ON s.stu_course = c.course_id

WHERE
    sd."Loan Status" = 'Borrowed'
    AND sd."Due Date" < '2023-09-14';

-- Question 6
SELECT *
FROM
    books_details bd
WHERE
    bd."Title" LIKE '%Science%';

-- Question 7
SELECT *
FROM
    books_details bd
WHERE
    bd."Publisher" LIKE 'Penguin%';

-- Question 8
SELECT *
FROM
    books_details bd
WHERE
    bd."Title" LIKE 'The%%of%';

-- Question 9

-- Index the books ID along with the
-- books_authors table a these are 2
-- common join statements
SELECT
    b.book_id AS "Book ID",
    b.book_title AS "Title",
    CONCAT(a.auth_name,' ', COALESCE(a.auth_mid_name,''),' ', a.auth_last_name) AS "Author Full Name",
    b.book_pub_year AS "Publication Year",
    g.genre_name AS "Genre"
FROM
    books b
    JOIN genres g ON b.genre_id = g.genre_id
    JOIN books_authors ba ON b.book_id = ba.book_id
    JOIN authors a ON ba.auth_id = a.auth_id
WHERE
    b.book_pub_year > 2000
    AND g.genre_name = 'Science';

-- Question 10
SELECT
    bd."ID",
    bd."Title",
    bd."Genre",
    bd."Publisher",
    bd."Publication Year"
FROM
    books_details bd
    JOIN books_languages bl ON bd."ID" = bl.book_id
    JOIN languages l ON bl.lang_id = l.lang_id
WHERE
    l.lang_name IN ('Chinese', 'German')
ORDER BY
    bd."Title" ASC;

-- Question 11
-- DOESNT WORK
SELECT
    c.course_name AS "Course Name",
    SUM(s.stu_id) AS "Students registered"

FROM 
    courses c
    RIGHT JOIN students s ON c.course_id = s.stu_course
GROUP BY
    c.course_name
ORDER BY
    c.course_name;