-- Question 1
SELECT
    CASE
        WHEN s.stu_id IS NOT NULL THEN s.stu_id
        WHEN l.lib_id IS NOT NULL THEN l.lib_id
    END AS "ID",
    CASE
        WHEN s.stu_id IS NOT NULL THEN CONCAT_WS(' ',s.stu_name,s.stu_mid_name,s.stu_last_name)
        WHEN l.lib_id IS NOT NULL THEN CONCAT_WS(' ',l.lib_name,l.lib_last_name)
    END AS "Name",
    CASE
        WHEN s.stu_id IS NOT NULL THEN 'Student'
        WHEN l.lib_id IS NOT NULL THEN 'Librarian'
    END AS "Role"
FROM
    students s FULL JOIN librarians l ON FALSE
ORDER BY
    "Role", "Name";

-- Question 2
SELECT
    a.auth_id AS "ID",
    CASE 
        WHEN a.auth_mid_name IS NOT NULL THEN a.auth_last_name||' '||a.auth_name||' '||a.auth_mid_name
        ELSE a.auth_last_name||' '||a.auth_name
    END AS "Name"
FROM
    authors a;



    
-- Question 3
SELECT
    g.genre_name AS "Genre",
    CASE
        WHEN COUNT(g.genre_id) > 6 THEN 'High'
        WHEN Count(g.genre_id) > 3 THEN 'Medium'
        ELSE 'Low'
    END AS "Popularity"
FROM
    genres g
JOIN
    books b ON g.genre_id = b.genre_id
GROUP BY
    g.genre_id;

-- Question 4
SELECT
    "ID",
    "Title",
    "Publication Year",
    CASE
        WHEN "Publication Year" < 2010 THEN 'Old'
        WHEN "Publication Year" < 2016 THEN 'Current'
        ELSE 'New'
    END AS "Classification"

FROM
    books_details bd;

-- Question 5
SELECT
    "Title",
    COUNT("Title") AS "Num Of Editions",
    CASE
        WHEN COUNT(be.book_id) > 1 THEN 'Multiple Editions'
        ELSE 'Single Edition'
    END AS "Edition Class"
FROM
    books_details bd
JOIN
    books_editions be ON "ID" = be.book_id
GROUP BY
    "Title"
ORDER BY
    "Title" ASC;

-- Question 12
SELECT
    p.pub_name AS "Name",
    COUNT(p.pub_name) AS "Num Of Books"
FROM 
    publishers p
JOIN
    books b ON p.pub_id = b.pub_id
GROUP BY
    p.pub_name
ORDER BY
    "Num Of Books" DESC;