CREATE OR REPLACE FUNCTION check_task_dates()
RETURNS TRIGGER AS $$
BEGIN
    SELECT 
        p.proj_start_date, p.proj_end_date, t.task_deadline
    FROM 
        projects p
    JOIN 
        tasks t ON p.proj_id = t.proj_id;

    IF task_date < proj_start_date OR (proj_end_date IS NOT NULL AND task_date > proj_end_date) THEN
        RAISE EXCEPTION 'Task due date is outside of project deadline';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER check_task_date_before_insert
BEFORE INSERT OR UPDATE ON tasks
FOR EACH ROW EXECUTE FUNCTION check_task_dates();

CREATE TABLE staff (
    staff_id SERIAL PRIMARY KEY,
    staff_name VARCHAR(30) NOT NULL,
    staff_role VARCHAR(50) NOT NULL,
    staff_email VARCHAR(50) UNIQUE NOT NULL,
    staff_phone VARCHAR(12) UNIQUE NOT NULL
);

INSERT INTO staff
    (staff_name, staff_role, staff_email, staff_phone)
VALUES
    ('Cthrine', 'General Manager', 'ccholmondeley0@diigo.com', '137-196-5165'),
    ('Mack', 'Database Administrator II', 'mchalcot1@go.com', '579-154-6110'),
    ('Delly', 'Social Worker', 'dedmondson2@cdbaby.com', '265-784-0096');

CREATE TABLE clients (
    client_id SERIAL PRIMARY KEY,
    client_name VARCHAR(30) NOT NULL,
    client_email VARCHAR(50) UNIQUE NOT NULL,
    client_phone VARCHAR(12) UNIQUE NOT NULL
);

INSERT INTO clients
    (client_name, client_email, client_phone)
VALUES
    ('Annemarie', 'asivills0@hexun.com', '351-506-2909'),
    ('Mattias', 'mmealand1@virginia.edu', '161-488-6833'),
    ('Nye', 'nsiggers2@mediafire.com', '504-542-0598'),
    ('Romeo', 'rgoodlife3@cloudflare.com', '452-550-7590'),
    ('Milicent', 'mcorgenvin4@thetimes.co.uk', '284-659-5743');

CREATE TABLE projects (
    proj_id SERIAL PRIMARY KEY,
    client_id SMALLINT NOT NULL REFERENCES clients(client_id),
    proj_name VARCHAR(30) UNIQUE NOT NULL,
    proj_start_date DATE NOT NULL,
    proj_end_date DATE CHECK (proj_start_date <= proj_end_date),
    proj_budget DOUBLE PRECISION
);

INSERT INTO projects
    (client_id, proj_name, proj_start_date, proj_end_date, proj_budget)
VALUES
    (1, 'Spaceship', '2022/1/5', '20223/20', '£6296.72'),
    (3, 'Banana Spoon', '2022/4/13', null, '£6833.72'),
    (2, 'Cream Cheese', '2022/10/23', '2022/12/3', '£2367.26'),
    (1, 'Boat', '4/21/2022', null, '£5041.18');

CREATE TABLE tasks (
    task_id SERIAL PRIMARY KEY,
    proj_id SMALLINT NOT NULL REFERENCES projects(proj_id),
    staff_id SMALLINT NOT NULL REFERENCES staff(staff_id),
    task_cost DOUBLE PRECISION,
    task_status VARCHAR(11) NOT NULL CHECK (tast_status IN ('in-progress', 'pending', 'completed')),
    task_deadline DATE NOT NULL,
    task_description VARCHAR(2000)
);

INSERT INTO tasks
    (proj_id, staff_id, task_cost, task_status, tast_deadline, task_description)
VALUES
    (3, 4, '£734.11', 'completed', '2023/11/14', 'Quisque erat eros, viverra eget, congue eget, semper rutrum, nulla. Nunc purus.'),
    (1, 4, '£261.79', 'completed', '2022/11/16', 'Aenean lectus.'),
    (3, 1, '£647.16', 'in-progress', '2022/12/03', 'Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui.'),
    (3, 2, '£198.16', 'in-progress', '2022/06/28', 'Praesent blandit lacinia erat.'),
    (3, 4, '£718.70', 'in-progress', '2023/09/22', 'Nunc rhoncus dui vel sem.'),
    (3, 3, '£292.24', 'pending', '2022/02/08', 'Quisque ut erat.'),
    (3, 1, '£343.38', 'completed', '2023/09/13', 'Etiam justo.'),
    (1, 3, '£404.53', 'pending', '2023/05/23', 'Duis ac nibh.'),
    (3, 1, '£15.27', 'in-progress', '2022/03/03', 'In quis justo.'),
    (3, 3, '£93.09', 'completed', '2023/08/29', 'Ut tellus. Nulla ut erat id mauris vulputate elementum.'),
    (2, 3, '£337.38', 'completed', '2022/09/09', 'Integer tincidunt ante vel ipsum. Praesent blandit lacinia erat.'),
    (1, 3, '£838.59', 'pending', '2023/12/07', 'Quisque ut erat.'),
    (3, 1, '£107.48', 'pending', '2023/04/28', 'Etiam vel augue.'),
    (4, 5, '£799.99', 'pending', '2022/08/27', 'Cras mi pede, malesuada in, imperdiet et, commodo vulputate, justo.'),
    (1, 4, '£789.18', 'in-progress', '2023/06/29', 'Vestibulum sed magna at nunc commodo placerat.'),
    (1, 1, '£550.14', 'pending', '2022/09/08', 'Proin eu mi. Nulla ac enim.'),
    (4, 3, '£815.49', 'pending', '2022/08/18', 'Morbi vestibulum, velit id pretium iaculis, diam erat fermentum justo, nec condimentum neque sapien placerat ante. Nulla justo.'),
    (2, 1, '£933.21', 'pending', '2023/05/14', 'Curabitur at ipsum ac tellus semper interdum.'),
    (1, 4, '£674.69', 'in-progress', '2022/09/24', 'Morbi odio odio, elementum eu, interdum eu, tincidunt in, leo. Maecenas pulvinar lobortis est.'),
    (4, 1, '£671.54', 'completed', '2023/12/28', 'Proin leo odio, porttitor id, consequat in, consequat ut, nulla.');
