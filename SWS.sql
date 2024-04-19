-- Some SQL queries for the SWS database
--
-- A query that shows each staff's top 3 most interacted students and displays the performance compared to their classes average
-- This can be useful to hepl determine if any staff have any bias towards students that they spend more time with
--
--
-- A query that identifies rooms with the highest booking demand during peak hours
-- This can be useful to help the school maximise the resources available
--
--
-- A query that ranks all the staff based on their student's performance
-- Can be useful to help identify the most effective staff
--
--
-- A query that tries and finds the students that have has a significant increase in performance across multiple courses
-- Can be developed further for a multitude of reasons: cheating, staff effectiveness, compare to students in their classes
--
--
-- A query that links performance based on students location may be difficult cause everyone lives so close to each other



-- A view giving all information on the students
-- CAUTION: USES UNKNOWN INFORMATION
CREATE
OR REPLACE VIEW stu_info AS
SELECT
    s.stu_id AS "ID",
    c.course_id AS "Course ID",
    t.tutor_id AS "Tutor ID"
FROM
    students s
    JOIN courses c ON c.cource_id = s.course_id
    JOIN tutors t ON t.tutor_id = s.tutor_id

ORDER BY
    s.sudent_name;

-- A view getting the performance of each student per module across the years
-- Order by student then by performance

-- A view that compiles all of the teacher, student interactions and which course/module/room etc
-- Call it interactions/ ..?