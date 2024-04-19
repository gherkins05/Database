-- Student Info View
CREATE
OR REPLACE VIEW stu_info AS
SELECT
    s.stu_id AS "ID",
    CONCAT_WS(' ', s.stu_name, s.stu_mid_name, s.stu_last_name) AS "Student",
    s.stu_phone AS "Phone",
    s.stu_email AS "Email",
    s.stu_email2 AS "Email2",
    s.acc_level AS "Year",
    c.course_id AS "Course ID",
    s.tutor_id AS "Tutor ID"
FROM
    students s
    JOIN courses c ON c.course_id = s.course_id
    JOIN staff st ON s.tutor_id = st.staff_id
ORDER BY
    "Student";


SELECT
    s.staff_id AS "Staff ID",
    CONCAT_WS(' ', s.staff_name, s.staff_mid_name, s.staff_last_name) AS "Staff",
    s.staff_role AS "Role",
    COUNT(v."ID") AS "Num of tutees"
FROM
    stu_info v
    JOIN staff s ON v."Tutor ID" = s.staff_id
GROUP BY
    s.staff_id
ORDER BY
    "Num of tutees";

-- Student Grades View
CREATE
OR REPLACE VIEW stu_prog AS
SELECT
    v."ID",
    v."Student",
    v."Course ID",
    m.mod_id AS "Module ID",
    m.submission_date AS "Date",
    m.submission_mark AS "Mark",
    m.submission_weight AS "Weight",
    m.submission_ontime AS "Ontime"
FROM
    stu_info v
    JOIN modules_results m ON v."ID" = m.stu_id
ORDER BY
    "Student";

/*
Performace per module = weight * mark
*/
CREATE 
OR REPLACE VIEW stu_grad AS
SELECT
    s.stu_id AS "ID",
    CONCAT_WS(' ', s.stu_name, s.stu_mid_name, s.stu_last_name) AS "Student",
    c.course_id AS "Course ID",
    m.mod_id AS "Module ID",
    SUM(
        ROUND(m.submission_mark * m.submission_weight / 100, 2)
    ) AS "Module Grade"
FROM
    students s
    JOIN courses c ON c.course_id = s.course_id
    JOIN modules_results m ON s.stu_id = m.stu_id
GROUP by
    s.stu_id,
    c.course_id,
    m.mod_id
ORDER BY
    "ID";

-- Rank each course by average mark
SELECT
    v."Course ID" AS "ID",
    c.course_name AS "Course",
    ROUND(AVG(v."Module Grade"), 2) AS "Avg Score"
FROM
    stu_grad v
    JOIN courses c ON v."Course ID" = c.course_id
GROUP BY
    v."Course ID", c.course_name
ORDER BY
    "Avg Score" DESC;