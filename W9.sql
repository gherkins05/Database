--Question 1
SELECT
    book_title AS "Book Title",
    book_pub_year AS "Book publication year"
FROM
    books
WHERE
    books.book_pages > 500;

--Question 2
SELECT
    CONCAT_WS(' ', auth_name, auth_mid_name, auth_last_name) AS "Full Name"
FROM
    authors
WHERE
    authors.auth_name = 'Michael';

--Question 3
SELECT
    CONCAT_WS(' ', stu_name, stu_mid_name, stu_last_name) AS "Full Name",
    CONCAT_WS(
        ' , ',
        stu_addr1,
        stu_addr2,
        stu_city,
        stu_postcode
    ) AS "Address",
    stu_email AS "Email",
    stu_phone AS "Pnone Number",
    stu_enroll AS "Enrollment Date"
FROM
    students
WHERE
    students.stu_enroll > '2021-9-1'
    AND students.stu_city = 'Portsmouth';

--Question 4
SELECT
    book_title AS "Book Title",
    book_pub_year AS "Publication Year"
FROM
    books
WHERE
    book_pub_year <= 2005
    AND book_pub_year >= 2000
ORDER BY
    book_pub_year ASC;

--Question 5
SELECT
    CONCAT_WS(' ', auth_name, auth_mid_name, auth_last_name) AS "Full Name"
FROM
    authors
WHERE
    authors.auth_name LIKE 'M%'
    OR authors.auth_mid_name LIKE 'M%'
    OR authors.auth_last_name LIKE 'M%';

--Question 6
SELECT
    book_title AS "Book Title"
FROM
    books
    JOIN genres ON books.genre_id = genres.genre_id
WHERE
    genres.genre_name IN ('Science Fiction', 'Action');

--Question 7
SELECT
    CONCAT_WS(' ', stu_name, stu_mid_name, stu_last_name) AS "Full Name",
    course_name AS "Course Name",
    course_code AS "Course Code"
FROM
    students
    JOIN courses ON students.stu_course = courses.course_id
WHERE
    courses.course_code != 'C006'
ORDER BY
    stu_name ASC;

--Question 8
SELECT
    book_title AS "Book Title",
    book_pub_year AS "Publication Year"
FROM
    books
ORDER BY
    book_pub_year DESC,
    book_title ASC
LIMIT
    10;

--Question 9
SELECT
    DISTINCT genre_name AS "Genre"
FROM
    genres
    JOIN books ON books.genre_id = genres.genre_id
    JOIN books_inventory ON books.book_id = books_inventory.book_id
    JOIN loans ON loans.inv_id = books_inventory.inv_id
    JOIN students ON students.stu_id = loans.stu_id
    JOIN courses ON students.stu_course = courses.course_id
WHERE
    courses.course_name = 'Web Development';

--Question 10
SELECT
    book_title AS "Book Title"
FROM
    books
    JOIN publishers ON books.pub_id = publishers.pub_id
WHERE
    books.book_pub_year = 2015
    AND publishers.pub_name = 'Elsevier';

--Question 11
SELECT
    CONCAT_WS(' ', auth_name, auth_mid_name, auth_last_name) AS "Full Name",
    book_title AS "Book Title",
    book_pages AS "Num of Pages"
FROM
    authors
    JOIN books_authors ON authors.auth_id = books_authors.auth_id
    JOIN books ON books.book_id = books_authors.book_id
WHERE
    books.book_pages >= 800
ORDER BY
    book_pages ASC;

--Question 12
SELECT
    CONCAT_WS(' ', stu_name, stu_mid_name, stu_last_name) AS "Full Name"
FROM
    students
    JOIN courses ON students.stu_course = courses.course_id
WHERE
    courses.course_name = 'Software Engineering'
    AND students.stu_city = 'Portsmouth';

--Question 13
SELECT
    book_title AS "Book Title",
    genre_name AS "Genre",
    auth_name AS "Author Name"
FROM
    authors
    JOIN books_authors ON authors.auth_id = books_authors.auth_id
    JOIN books ON books.book_id = books_authors.book_id
    JOIN genres ON genres.genre_id = books.genre_id
WHERE
    authors.auth_name = 'Ayato'
    and genres.genre_name = 'Science';

--Question 14
SELECT
    book_title AS "Book Title",
    genre_name AS "Genre",
    auth_name AS "Author Name",
    book_pages AS "Num of Pages",
    lang_name AS "Language",
    book_pub_year AS "Publication Year"
FROM
    authors
    JOIN books_authors ON authors.auth_id = books_authors.auth_id
    JOIN books ON books.book_id = books_authors.book_id
    JOIN genres ON genres.genre_id = books.genre_id
    JOIN books_languages ON books.book_id = books_languages.book_id
    JOIN languages on books_languages.lang_id = languages.lang_id
    JOIN publishers ON publishers.pub_id = books.pub_id
WHERE
    languages.lang_name = 'German'
    AND publishers.pub_name = 'Wiley'
ORDER By
    books.book_pub_year ASC;

--Question 15
SELECT
    CONCAT_WS(' ', stu_name, stu_mid_name, stu_last_name) AS "Full Name",
    loan_date AS "Date loaned",
    due_date AS "Date Due",
    stu_email AS "Student Email",
    stu_phone AS "Student Phone"
FROM
    students
    JOIN loans ON loans.stu_id = students.stu_id
    JOIN books_inventory ON books_inventory.inv_id = loans.inv_id
    JOIN books ON books.book_id = books_inventory.book_id
WHERE
    books.book_title = 'Database Systems'
ORDER BY
    "Full Name" ASC;