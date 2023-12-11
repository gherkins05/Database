-- Question 1
SELECT 
    stu_name AS "Forename",
    stu_last_name AS "Surname",
    stu_email AS "Email",
    course_name AS "Course Name",
    course_code AS "Course Code"
FROM 
    students
    JOIN courses ON students.stu_id = courses.courses_id

-- Question 2 ___________________________________________
SELECT
    book_title AS "Title",
    book_pub_year AS "Publication Year",
    book_pages AS "Number Of Pages",
    genre_name AS "Genre Name"
FROM
    books,
    JOIN genres ON books.genre_id = genres.genre_id;

--Question 3 ___________________________________________
SELECT
    CONCAT_WS(' ',auth_name, auth_mid_name, auth_last_name) AS "Author Full Name",
    book_title AS "Book Title",
    book_pub_year AS "Publication Year"
FROM
    authors
    JOIN books_authors ON authors.auth_id = books_authors.auth_id
    JOIN books ON books_authors.book_id = books.book_id;

--Question 4 ___________________________________________
SELECT 
    book_title AS "Book Title",
    ed_year AS "Edition Publication Year",
    ed_no AS "Edition Number",
    pub_name AS "Publisher Name"
FROM
    books
    JOIN books_editions ON books_editions.book_id = books.book_id
    JOIN publishers ON publishers.pub_id = books.pub_id;

--Question 5 ___________________________________________
SELECT 
    book_title AS "Book Title",
    book_pub_year AS "Publication Year",
    lang_name AS "Language",
    ed_no AS "Edition Number"
FROM
    books
    JOIN books_languages ON books.book_id = books_languages.book_id
    JOIN languages ON languages.lang_id = books_languages.lang_id
    JOIN books_editions ON books_editions.book_id = books.book_id;

--Question 6 ___________________________________________
SELECT 
    book_title AS "Book Title",
    stu_name AS "Student Name",
    CONCAT_WS(' ', lib_name, lib_last_name) AS "Librarian Name"
FROM 
    books
    JOIN books_inventory ON books.book_id = books_inventory.book_id
    JOIN loans ON books_inventory.inv_id = loans.inv_id
    JOIN students ON students.stu_id = loans.stu_id
    JOIN librarians ON librarians.lib_id = loans.lib_id;

--Question 7 ___________________________________________
SELECT 
    book_title AS "Book Title",
    CONCAT_WS(' ', stu_name, stu_last_name) AS "Student Name",
    loan_date AS "Loan Date",
    due_date AS "Due Date",
    return_date AS "Return Date"
FROM
    books
    JOIN books_inventory ON books.book_id = books_inventory.book_id
    JOIN loans ON books_inventory.inv_id = loans.inv_id
    JOIN students ON students.stu_id = loans.stu_id;
