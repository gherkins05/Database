-- Get number of genres
SELECT
    g.genre_id as "ID",
    g.genre_name AS "Genre"
FROM
    genres g;

-- returns 8 genres (IDs: 1 - 8)
-- Question 1
INSERT INTO
    genres (genre_id, genre_name)
VALUES
    (9, 'Short Story')
SELECT
    g.genre_name AS "Genre",
    COUNT(b.genre_id) AS "Num of books"
FROM
    genres g
    LEFT JOIN books b on g.genre_id = b.genre_id
GROUP BY
    g.genre_name
ORDER BY
    g.genre_name ASC;

-- Question 2
INSERT INTO
    authors (
        auth_id,
        auth_name,
        auth_mid_name,
        auth_last_name
    )
VALUES
    (6, 'Johnny', 'R', 'Rivierra'),
    (7, 'Maria', NULL, 'West');

SELECT
    DISTINCT ON (
        CONCAT_WS(
            ' ',
            a.auth_name,
            a.auth_mid_name,
            a.auth_last_name
        )
    ) CONCAT_WS(
        ' ',
        a.auth_name,
        a.auth_mid_name,
        a.auth_last_name
    ) AS "Author",
    COALESCE(b.book_title, 'N/A') AS "Book Title"
FROM
    authors a
    LEFT JOIN books_authors ba ON a.auth_id = ba.auth_id
    LEFT JOIN books b ON ba.book_id = b.book_id
ORDER BY
    CONCAT_WS(
        ' ',
        a.auth_name,
        a.auth_mid_name,
        a.auth_last_name
    ) ASC;

-- Queston 3
-- Cannot convert load ID to str as it is stored at int
-- Need to convert to str first using CAST
SELECT
    bi.inv_id AS "Inventory ID",
    b.book_title AS "Book Name",
    COALESCE(CAST(l.loan_id AS varchar), 'N/A') AS "Loan ID"
FROM
    books_inventory bi
    LEFT JOIN books b ON bi.book_id = b.book_id
    LEFT JOIN loans l ON bi.inv_id = l.inv_id
WHERE
    l.loan_id is NULL
ORDER BY
    b.book_title ASC;

-- Question 4
SELECT
    l.loan_id AS "Loan ID",
    CONCAT_WS(' ', s.stu_name, s.stu_mid_name, s.stu_last_name) AS "Student Name",
    bi.inv_id AS "Inv ID",
    b.book_title AS "Book Title",
    l.loan_date AS "Loan Date",
    l.due_date AS "Due Date",
    l.return_date AS "Return Date"
FROM
    students s
    LEFT JOIN loans l ON s.stu_id = l.stu_id
    LEFT JOIN books_inventory bi ON bi.inv_id = l.inv_id
    LEFT JOIN books b ON bi.book_id = b.book_id
WHERE
    l.return_date is not NULL
    AND l.return_date > l.due_date;

-- Question 9
SELECT 
    CONCAT_WS(' ',a.auth_name,a.auth_mid_name,a.auth_last_name) AS "Author Name",
    COUNT(CONCAT_WS(' ',a.auth_name,a.auth_mid_name,a.auth_last_name)) AS "Num of Books Published"
FROM
    authors a
    LEFT JOIN books_authors ba ON a.auth_id = ba.auth_id
    LEFT JOIN books b ON ba.book_id = b.book_id
GROUP BY
    CONCAT_WS(' ',a.auth_name,a.auth_mid_name,a.auth_last_name)
ORDER BY 
    COUNT(CONCAT_WS(' ',a.auth_name,a.auth_mid_name,a.auth_last_name)) DESC;
-- Question 10
SELECT
    b.book_pub_year AS "Publication Year",
    COUNT(b.book_pub_year) AS "Total Books",
    ROUND((COUNT(b.book_pub_year) * 100 /SUM(COUNT(b.book_pub_year)) OVER()), 2) || ' %' AS "Percentage of Total"
FROM
    books b
GROUP BY
    b.book_pub_year
ORDER BY
    b.book_pub_year ASC;