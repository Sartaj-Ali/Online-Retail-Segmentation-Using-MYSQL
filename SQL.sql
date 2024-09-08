DROP DATABASE IF EXISTS students_recorde;

CREATE DATABASE students_recorde;

USE students_recorde;

CREATE TABLE student (
  id INT PRIMARY KEY,
  name VARCHAR(100),
  age INT,
  fees INT
);

INSERT INTO student (id, name, age, fees)
VALUES
  (1, 'Sartaj', 20, 5000),
  (2, 'Zain', 18, 3500),
  (3, 'Shahid', 18, 4000);

SELECT * FROM student;

DELETE FROM student
WHERE id = 3;

SELECT * FROM student;

UPDATE student set age = 23 where id = 2;
SELECT * FROM student;