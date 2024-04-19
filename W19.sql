-- STRING_AGG ( g.genre_name, ', ' ORDER BY g.genre_name) AS "Genres"
-- Question 1
SELECT
    b.book_title AS "Book",
    g.genre_name AS "Genre",
    p.pub_name AS "Publisher"
FROM
    books b
    JOIN genres g ON b.genre_id = g.genre_id
    JOIN publishers p ON b.pub_id = p.pub_id
ORDER BY
    b.book_title;

-- Question 2
SELECT
    CONCAT_WS(' ', a.auth_name, a.auth_mid_name, a.auth_last_name) AS "Author",
    COUNT(a.auth_id) AS "Num of books"
FROM
    authors a
    JOIN books_authors ba ON a.auth_id = ba.auth_id
    JOIN books b ON ba.book_id = b.book_id
GROUP BY
    a.auth_id
HAVING 
    COUNT(a.auth_id) > 1
ORDER BY
    "Author";

-- Question 3
SELECT
    b.book_title AS "Book"
FROM
    books b
WHERE
    b.book_pub_year >= 2000
    AND b.book_pub_year <= 2010
ORDER BY
    b.book_title;

-- Question 4
SELECT
    g.genre_name AS "Genre",
    COUNT(g.genre_id) AS "Num Of Books"
FROM
    genres g
    JOIN books b ON g.genre_id = b.genre_id
GROUP BY
    g.genre_id
ORDER BY 
    "Genre";

-- Question 5
SELECT
    CONCAT_WS(' ', s.stu_name, s.stu_mid_name, s.stu_last_name) AS "Student",
    COUNT(s.stu_id) AS "Num Of Books"
FROM
    students s
    JOIN loans l ON s.stu_id = l.stu_id
GROUP BY
    s.stu_id
ORDER BY
    "Student";

-- Question 6
SELECT
    b.book_title AS "Book",
FROM
    books b
    FULL JOIN books_inventory bi ON b.book_id = bi.book_id
    FULL JOIN loans l ON bi.inv_id = l.inv_id
GROUP BY 
    b.book_id
HAVING
    COUNT(b.book_id) = 1
ORDER BY
    "Book";

-- Question 7 Assuming the date is 2023-06-10
SELECT DISTINCT
    CONCAT_WS(' ', s.stu_name, s.stu_mid_name, s.stu_last_name) AS "Student"
FROM
    students s
    JOIN loans l ON s.stu_id = l.stu_id
WHERE
    l.status = 'Borrowed'
    AND l.due_date < '2023-06-10'
ORDER BY
    "Student";

-- Question 8
-- STRING_AGG groups items together to put in a single cell
SELECT
    b.book_title AS "Book",
    STRING_AGG (
        DISTINCT CONCAT_WS(' ', a.auth_name, a.auth_mid_name, a.auth_last_name),
        ', '
        ORDER BY
            CONCAT_WS(' ', a.auth_name, a.auth_mid_name, a.auth_last_name)
    ) AS "Authors",
    STRING_AGG (
        DISTINCT l.lang_name,
        ', '
        ORDER BY
            l.lang_name
    ) AS "Languages"
FROM
    books b
    JOIN books_authors ba ON b.book_id = ba.book_id
    JOIN authors a ON ba.auth_id = a.auth_id
    JOIN books_languages bl ON b.book_id = bl.book_id
    JOIN languages l ON bl.lang_id = l.lang_id
GROUP BY
    b.book_title
ORDER BY
    "Book";

-- Question 9
SELECT
    g.genre_name AS "Genre",
    ROUND(AVG(b.book_pages), 0) AS "AVG Pg Num"
FROM
    genres g
    JOIN books b ON g.genre_id = b.genre_id
GROUP BY
    g.genre_id
ORDER BY
    "Genre";

-- Question 10
SELECT
    CONCAT_WS(' ', a.auth_name, a.auth_mid_name, a.auth_last_name) AS "Author",
    COUNT(DISTINCT g.genre_id) AS "Genres"
FROM
    authors a
    JOIN books_authors ba ON a.auth_id = ba.auth_id
    JOIN books b ON ba.book_id = b.book_id
    JOIN genres g ON b.genre_id = g.genre_id
GROUP BY
    a.auth_id
ORDER BY
    "Author";


-- Question 11
SELECT
    b.book_title AS "Book",
    COUNT(b.book_id) AS "Editions"
FROM
    books b
    JOIN books_editions be ON b.book_id = be.book_id
GROUP BY
    b.book_id
ORDER BY
    "Book";

-- Question 12
SELECT
    p.pub_name AS "Publisher",
    STRING_AGG (CAST(b.book_pub_year AS VARCHAR(4)), ', ' ORDER BY CAST(b.book_pub_year AS VARCHAR(4))) AS "Years"
FROM
    publishers p
    JOIN books b ON p.pub_id = b.pub_id
GROUP BY
    p.pub_id
ORDER BY
    "Publisher";