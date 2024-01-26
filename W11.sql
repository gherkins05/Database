-- Quesiton 1
SELECT
    p.pub_name AS "Publisher",
    MIN(b.book_pages) AS "Min Pages",
    MAX(b.book_pages) AS "Max Pages"
FROM
    publishers p
    JOIN books b ON p.pub_id = b.pub_id
GROUP BY
    p.pub_name
ORDER BY
    p.pub_name ASC;

-- Question 2
SELECT
    CONCAT_WS(' ', s.stu_name, s.stu_mid_name, s.stu_last_name) AS "Full Name",
    COUNT(l.loan_id) AS "Num of books borrowed"
FROM
    students s
    JOIN loans l ON s.stu_id = l.stu_id
GROUP BY
    CONCAT_WS(' ', s.stu_name, s.stu_mid_name, s.stu_last_name)
ORDER BY
    CONCAT_WS(' ', s.stu_name, s.stu_mid_name, s.stu_last_name) ASC;

-- Question 3
SELECT
    a.auth_name AS "Author",
    (MAX(b.book_pub_year) - MIN(b.book_pub_year)) AS "Years difference"
FROM
    authors a
    JOIN books_authors ba ON a.auth_id = ba.auth_id
    JOIN books b ON ba.book_id = b.book_id
GROUP BY
    a.auth_name
ORDER BY
    a.auth_name ASC;

-- Question 4
SELECT
    a.auth_name AS "Author",
    MIN(be.ed_year) AS "First book",
    MAX(be.ed_year) AS "Latest book"
FROM
    authors a
    JOIN books_authors ba ON a.auth_id = ba.auth_id
    JOIN books b ON ba.book_id = b.book_id
    JOIN books_editions be ON b.book_id = be.book_id
GROUP BY
    a.auth_name;

-- Question 5
SELECT
    CONCAT_WS(' ', s.stu_name, s.stu_mid_name, s.stu_last_name) AS "Full Name",
    MIN(l.loan_date) AS "First loan",
    MAX(l.loan_date) AS "Latest loan"
FROM
    students s
    JOIN loans l ON s.stu_id = l.stu_id
GROUP BY
    CONCAT_WS(' ', s.stu_name, s.stu_mid_name, s.stu_last_name)
ORDER BY
    CONCAT_WS(' ', s.stu_name, s.stu_mid_name, s.stu_last_name) ASC;

-- Question 6
SELECT
    CONCAT_WS(' ', a.auth_name, a.auth_mid_name, a.auth_last_name) AS "Author",
    COUNT(b.book_id) AS "Num of books",
    (COUNT(b.book_id) - MAX(COUNT(b.book_id)) OVER()) AS "Diff from MAX written"
FROM
    authors a
    JOIN books_authors ba ON a.auth_id = ba.auth_id
    JOIN books b ON ba.book_id = b.book_id
GROUP BY
    CONCAT_WS(' ', a.auth_name, a.auth_mid_name, a.auth_last_name)
ORDER BY
    COUNT(b.book_id) DESC;

-- Question 7
SELECT
    CONCAT_WS(' ', s.stu_name, s.stu_mid_name, s.stu_last_name) AS "Full Name",
    ROUND((COUNT(l.loan_id) * 100 /SUM(COUNT(l.loan_id)) OVER()), 2) AS "Percent of loans"
FROM
    students s
    JOIN loans l ON s.stu_id = l.stu_id
GROUP BY
    CONCAT_WS(' ', s.stu_name, s.stu_mid_name, s.stu_last_name)
ORDER BY
    ROUND((COUNT(l.loan_id) * 100 /SUM(COUNT(l.loan_id)) OVER()), 2) ASC;

-- Question 8
SELECT
    g.genre_name AS "Genre",
    ROUND(AVG(b.book_pages), 0) AS "Genre AVG",
    581 AS "Pages AVG",
    (ROUND(AVG(b.book_pages), 0) - 581) AS "Diff from overall"
FROM
    genres g
    JOIN books b ON g.genre_id = b.genre_id
GROUP BY
    g.genre_name
ORDER BY
    g.genre_name ASC;

-- Question 9
SELECT
    c.course_name AS "Course Name",
    SUM(s.stu_id) AS "Students registered",
    ROUND(SUM(s.stu_id) * 100 / SUM(SUM(s.stu_id)) OVER(), 2) AS "Percentage of students"

FROM 
    courses c
    JOIN students s ON c.course_id = s.stu_course
GROUP BY
    c.course_name
ORDER BY
    c.course_name;

-- Question 10
SELECT
    g.genre_name AS "Genre",
    COUNT(b.book_id) AS "Genre Book Count",
    ROUND(COUNT(b.book_id) * 100 / SUM(COUNT(b.book_id)) OVER(), 2) || ' %' AS "Genre Percentage"
FROM
    genres g
    JOIN books b ON g.genre_id = b.genre_id
GROUP BY
    g.genre_name;