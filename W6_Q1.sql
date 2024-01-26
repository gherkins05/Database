/*Databse Name: w6_q1*/

-- Customers TABLE
CREATE TABLE customers (
    cust_id SERIAL PRIMARY KEY,

    cust_name VARCHAR(50) NOT NULL,
    cust_mid_name VARCHAR(50),
    cust_last_name VARCHAR(50) NOT NULL,
    cust_addr1 VARCHAR(50) NOT NULL,
    cust_addr2 VARCHAR(50),
    cust_city VARCHAR(30) NOT NULL,
    cust_postcode CHAR(8) NOT NULL,
    cust_email VARCHAR(150) NOT NULL,
    cust_phone VARCHAR(15) NOT NULL

);
-- Songs TABLE
CREATE TABLE songs (
    song_id SERIAL PRIMARY KEY,

    song_name VARCHAR(200) NOT NULL,
    song_artist VARCHAR(250) NOT NULL,
    song_length INTERVAL NOT NULL,
    song_year DATE

);
-- Playlists TABLE
CREATE TABLE playlists(
    playlist_id SERIAL PRIMARY KEY,
    cust_id INT NOT NULL REFERENCES customers(cust_id),

    pl_creation_date DATE NOT NULL,
    pl_last_accessed DATE
);
-- song_playlist TABLE with composite key
Create TABLE song_playlist(
    playlist_id INT NOT NULL REFERENCES playlists(playlist_id),
    song_id INT NOT NULL REFERENCES songs(song_id)
);


-- Insert customer
INSERT INTO customers (cust_name, cust_mid_name, cust_last_name, cust_addr1, cust_addr2, cust_city, cust_postcode, cust_email, cust_phone)
VALUES
  ('John', 'M', 'Doe', '123 Main Street', '', 'Portsmouth', 'PO1 3AX', 'john.doe@email.com', '1234567890'),
  ('Jane', 'S', 'Smith', '456 High Street', 'Floor 3', 'London', 'SW1A 1AA', 'jane.smith@email.com', '0987654321');

-- Insert songs
INSERT INTO songs (song_name, song_artist, song_length, song_year)
VALUES
  ('Bohemian Rhapsody', 'Queen', '00:05:55', '1975-10-31'),
  ('Hotel California', 'Eagles', '00:06:30', '1977-02-26'),
  ('Imagine', 'John Lennon', '00:03:03', '1971-10-11'),
  ('Smells Like Teen Spirit', 'Nirvana', '00:05:01', '1991-09-10'),
  ('Like a Rolling Stone', 'Bob Dylan', '00:06:13', '1965-07-20');

-- Insert playlists
INSERT INTO playlists (cust_id, pl_creation_date, pl_last_accessed)
VALUES
  (1, '2023-06-01','2023-06-10'),
  (1, '2023-06-15', NULL),
  (2, '2023-07-01','2023-07-05'),
  (2, '2023-07-10', NULL);

-- Insert songs into playlists
INSERT INTO song_playlist (playlist_id, song_id)
VALUES
  (1, 1),
  (1, 3),
  (2, 2),
  (2, 4),
  (3, 5),
  (3, 3),
  (4, 1),
  (4, 2),
  (4, 4);