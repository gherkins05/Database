-- Question 1
SELECT
    a.auth_name AS "Name",
    a.auth_last_name AS "Surname"
FROM 
    authors a
    JOIN books_authors ba ON a.auth_id = ba.auth_id
WHERE ba.book_id IN (
    SELECT 
        b.book_id
    FROM
        books b
    WHERE b.book_pub_year > 2020
);

-- Question 2
SELECT DISTINCT
    a.auth_name AS "Name",
    a.auth_last_name AS "Surname"
FROM 
    authors a
    JOIN books_authors ba ON a.auth_id = ba.auth_id
WHERE EXISTS (
    SELECT 1
    FROM
        books b
        JOIN books_editions be ON b.book_id = be.book_id
    WHERE be.ed_year > 2020 
);

-- Question 3
SELECT DISTINCT
    a.auth_name AS "Name",
    a.auth_last_name AS "Surname",
    b.book_title AS "Book",
    b.book_pub_year AS "Origin Yr",
    be.ed_year AS "Recent Yr"
FROM 
    authors a
    JOIN books_authors ba ON a.auth_id = ba.auth_id
    JOIN books b ON ba.book_id = b.book_id
    JOIN books_editions be ON b.book_id = be.book_id
WHERE be.ed_id IN (
    SELECT
        be.ed_id
    FROM
        books b
        JOIN books_editions be ON b.book_id = be.book_id
    WHERE be.ed_year > 2020
);

-- Question 4
SELECT DISTINCT
    a.auth_name AS "Name",
    a.auth_last_name AS "Surname"
FROM 
    authors a
WHERE a.auth_id NOT IN (
    SELECT
        ba.auth_id
    FROM
        books_authors ba
    JOIN books b ON ba.book_id = b.book_id
        JOIN genres g ON b.genre_id = g.genre_id
    WHERE g.genre_name = 'Sci-Fi'
);

-- Question 5
SELECT
    g.genre_name AS "Genre",
    COUNT(b.genre_id) AS "Num of books"
FROM
    genres g
    JOIN books b ON g.genre_id = b.genre_id

WHERE g.genre_id = (
    SELECT
        g.genre_id
    FROM 
        genres g
        JOIN books b ON g.genre_id = b.genre_id
    GROUP BY
        g.genre_id
    ORDER BY
        COUNT(b.genre_id) DESC
    LIMIT 1
)
GROUP BY
    g.genre_name;

-- Question 6
SELECT DISTINCT
    CONCAT_WS(' ', s.stu_name, s.stu_mid_name, s.stu_last_name) AS "Name",
    l.loan_id AS "Loan",
    l.loan_date AS "Loan Date",
    bi.inv_id AS "Inv ID"
FROM
    students s
    JOIN loans l ON s.stu_id = l.stu_id
    JOIN books_inventory bi ON l.inv_id = bi.inv_id
WHERE l.loan_id IN (
    SELECT
        sd."Loan ID"
    FROM
        student_loan_details sd
    WHERE 
        sd."Due Date" < '2024-02-09' AND sd."Loan Status" = 'Borrowed' AND sd."Title" = 'PostgreSQL up and running'
);

-- Question 7
SELECT 
    bd."Title"
FROM
    books_details bd
    JOIN books_inventory bi ON bd."ID" = bi.book_id
WHERE
    bi.inv_id NOT IN (
        SELECT 
            sd."Inv ID"
        FROM
            student_loan_details sd
    );

-- Question 8
SELECT
    sd."Title",
    ROUND(AVG(l.return_date - sd."Loan Date"), 2) AS "Loan Duration"
FROM
    student_loan_details sd
    JOIN loans l ON sd."Loan ID" = l.loan_id
WHERE
    sd."Loan Status" = 'Returned'
GROUP BY
    sd."Title";
ORDER BY
    ROUND(AVG(l.return_date - sd."Loan Date"), 2) ASC;
