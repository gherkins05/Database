-- Tester Comment
-- Question 1
SELECT
    genre_name AS "Genre",
    COUNT(genre_name) AS "Num of Books"
FROM
    genres
    JOIN books ON books.genre_id = genres.genre_id
GROUP BY
    genre_name
ORDER BY
    genre_name ASC;

-- Question 2
SELECT
    auth_name AS "Name",
    COUNT(auth_name) AS "Num of Books"
FROM
    authors
    JOIN books_authors ON authors.auth_id = books_authors.auth_id
    JOIN books ON books.book_id = books_authors.book_id
GROUP BY
    auth_name
ORDER BY
    COUNT(auth_name) DESC;

-- Question 3
SELECT
    pub_name AS "Publisher Name"
FROM
    publishers
    JOIN books ON books.pub_id = publishers.pub_id
GROUP BY
    pub_name
HAVING
    COUNT(pub_name) >= 5;

-- Question 4
SELECT
    lang_name AS "Language",
    COUNT(lang_name) AS "Num of Books"
FROM
    languages
    JOIN books_languages ON books_languages.lang_id = languages.lang_id
    JOIN books ON books.book_id = books_languages.book_id
GROUP BY
    lang_name
ORDER BY
    COUNT(lang_name) DESC
LIMIT
    2;

-- Question 5
SELECT
    book_title AS "Title"
FROM
    books
    JOIN books_languages ON books.book_id = books_languages.book_id
    JOIN languages ON books_languages.lang_id = languages.lang_id
WHERE
    languages.lang_naqme = 'English'
INTERSECT
SELECT
    book_title AS "Title"
FROM
    books
    JOIN books_languages ON books.book_id = books_languages.book_id
    JOIN languages ON books_languages.lang_id = languages.lang_id
WHERE
    languages.lang_name = 'Spanish';

-- Question 6
SELECT
    auth_name AS "Author Name"
FROM
    authors
    JOIN books_authors ON books_authors.auth_id = authors.auth_id
    JOIN books ON books.book_id = books_authors.book_id
GROUP BY
    auth_name
HAVING
    COUNT(auth_name) > 10;

-- Question 7
SELECT
    genre_name AS "Genre",
    COUNT(genre_name) AS "Num of Books"
FROM
    genres
    JOIN books ON books.genre_id = genres.genre_id
    JOIN books_authors ON books_authors.book_id = books.book_id
    JOIN authors ON authors.auth_id = books_authors.auth_id
WHERE
    authors.auth_id = 4
GROUP BY
    genre_name;

-- Question 8
SELECT
    auth_name AS "Name",
    COUNT(auth_name) AS "Num of Books"
FROM
    authors
    JOIN books_authors ON books_authors.auth_id = authors.auth_id
    JOIN books ON books.book_id = books_authors.book_id
    JOIN genres ON genres.genre_id = books.genre_id
WHERE
    genres.genre_name = 'Programming'
GROUP BY
    auth_name;

-- Question 9
SELECT
    book_title AS "Book Title"
FROM
    books
    JOIN books_authors ON books_authors.book_id = books.book_id
    JOIN authors ON authors.auth_id = books_authors.auth_id
WHERE
    authors.auth_id = 4
UNION
SELECT
    book_title AS "Book Title"
FROM
    books
    JOIN books_authors ON books_authors.book_id = books.book_id
    JOIN authors ON authors.auth_id = books_authors.auth_id
WHERE
    authors.auth_id = 3;

-- Question 10
SELECT
    book_title AS "Book Title"
FROM
    books
    JOIN books_authors ON books_authors.book_id = books.book_id
    JOIN authors ON authors.auth_id = books_authors.auth_id
WHERE
    authors.auth_id = 4
INTERSECT
SELECT
    book_title AS "Book Title"
FROM
    books
    JOIN books_authors ON books_authors.book_id = books.book_id
    JOIN authors ON authors.auth_id = books_authors.auth_id
WHERE
    authors.auth_id = 3;

-- Question 11
SELECT
    stu_last_name AS "Surname",
    COUNT(stu_last_name)
FROM
    students
    JOIN loans ON students.stu_id = loans.stu_id
GROUP BY
    stu_last_name
ORDER BY
    stu_last_name DESC;

-- Question 12
SELECT
    course_name AS "Course Title",
    MAX(stu_enroll) AS "Enrollment Date"
FROM
    courses
    JOIN students ON students.stu_course = courses.course_id
GROUP BY
    course_name
ORDER BY
    course_name ASC;

-- Question 13
SELECT
    CONCAT_WS(' ', lib_name, lib_last_name) AS "Librarian Name",
    MIN(loan_date) AS "Earliest Loan"
FROM
    librarians
    JOIN loans ON librarians.lib_id = loans.lib_id
GROUP BY
    CONCAT_WS(' ', lib_name, lib_last_name);

-- Question 14
SELECT
    genre_name AS "Genre",
    ROUND(AVG(book_pages), 0) AS "AVG Pages per Book"
FROM
    genres
    JOIN books ON books.genre_id = genres.genre_id
GROUP BY
    genre_name
ORDER BY
    genre_name ASC;

-- Question 15
SELECT
    genre_name AS "Genre",
    ROUND(AVG(return_date - loan_date), 2) AS "AVG Loan Days"
FROM
    genres
    JOIN books ON books.genre_id = genres.genre_id
    JOIN books_inventory ON books_inventory.book_id = books.book_id
    JOIN loans ON loans.inv_id = books_inventory.inv_id
GROUP BY
    genre_name
HAVING
    ROUND(AVG(return_date - loan_date), 2) IS NOT NULL
ORDER BY
    genre_name ASC;