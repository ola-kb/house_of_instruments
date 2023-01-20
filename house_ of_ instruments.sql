-- create db to practise, normalizations (eliminates redundancy), using Primary Key and Foreign Key, DDL

CREATE DATABASE House_of_Instruments;
USE House_of_Instruments;


CREATE TABLE Students (
stud_id INT (10) NOT NULL,
firstname VARCHAR (30) NOT NULL,
surname VARCHAR (30) NOT NULL,
parent_firstname VARCHAR (30) NOT NULL,
parent_surname VARCHAR (30) NOT NULL,
parent_email VARCHAR (30), 
parent_phone VARCHAR (30) NOT NULL,
school_student BOOL DEFAULT TRUE,
PRIMARY KEY (stud_id)
);

CREATE TABLE Rental (
instr_id INT  NOT NULL,
date_rent_start DATE, 
date_rent_stop DATE,
stud_id INT NOT NULL,
PRIMARY KEY (instr_id)
);

CREATE TABLE Instruments (
instr_id INT  NOT NULL,
instr_type VARCHAR (30),
date_production DATE,
producer VARCHAR (30),
remark TEXT
);
 

 -- insert data, DML
  INSERT INTO Students 
 (stud_id, firstname, surname, parent_firstname, parent_surname, parent_email, parent_phone, school_student)
 VALUES 
 (001, 'Maria', 'Nowak', 'Joanna', 'Nowak', 'jnowak@wp.pl', 48664999818, TRUE),
 (002, 'Jan', 'Rudy', 'Anna', 'Rudy', 'arudy@op.pl', 48532449800, TRUE),
 (003, 'Aleksandra', 'Mocna', 'Ewa', 'Mocna-Jasna', 'emocjas@wp.pl', 48505987123, FALSE ),
 (004, 'Patryk', 'Kowal', 'Mateusz', 'Kowal', 'mkowal@gmail.com', 48765765111, TRUE);
 
  INSERT INTO Rental
 (instr_id, date_rent_start, date_rent_stop, stud_id)
 VALUES
 (102, '2020-08-30', '2027-06-26', 003),
 (101, '2016-09-20', '2023-05-30', 001),
 (104, '2019-09-10', '2024-06-23', 002),
 (103, '2022-10-01', '2027-06-26', 004);
 
 INSERT INTO Instruments
 (instr_id, instr_type, date_production, producer, remark)
 VALUES
 (101, 'clarinet', '1995-07-30', 'Buffet', 'without mouthpiece'),
 (102, 'violin', '2015-08-08', 'Amati', 'size 1/2'),
 (103, 'bassoon', '2002-03-10', 'Yamaha', 'none'),
 (104, 'cello', '2006-12-11', 'Toto', 'new endpin');
 
-- modify table

CREATE TABLE Parents_data (
stud_id INT NOT NULL,
parent_firstname VARCHAR (30) NOT NULL,
parent_surname VARCHAR (30) NOT NULL,
parent_email VARCHAR (30), 
parent_phone  VARCHAR (30) NOT NULL
 );
 
 INSERT INTO Parents_data 
(stud_id, parent_firstname, parent_surname, parent_email, parent_phone)
SELECT stud_id, parent_firstname, parent_surname, parent_email, parent_phone 
FROM Students; 

SELECT * FROM Students;
SELECT* FROM Parents_data;

ALTER TABLE Students
DROP COLUMN parent_firstname,
DROP COLUMN parent_surname,
DROP COLUMN parent_email,
DROP COLUMN parent_phone;
 
 SELECT * FROM Students;
 SELECT * FROM Parents_data;
 
 -- data manipulation functions/ questions ; select data from multiple tables (INNER JOIN)
 -- Show me a list of students who rented instruments
 
 Select * FROM Students 
 WHERE school_student = true;
 
 -- Show me  who and when rented clarinet
 
 SELECT s.firstname, s.surname, r.date_rent_start, i.instr_type
 FROM Students s
 INNER JOIN Rental r
 ON s.stud_id = r.stud_id
 INNER JOIN Instruments i
 ON r.instr_id = i.instr_id 
 WHERE instr_type = 'clarinet';
 
 -- Tell me, when violin will be able
 
 SELECT i.instr_id, i.instr_type, r.date_rent_stop
 FROM Instruments i
 INNER JOIN Rental r
 ON i.instr_id = r.instr_id
 WHERE instr_type = 'violin';
 
 -- changing existing tables 
 
 ALTER TABLE Instruments
 ADD COLUMN instr_value INT NOT NULL;
  
 SELECT * FROM Instruments;
 
 UPDATE Instruments
SET instr_value = 9300
WHERE instr_id = 101;

 UPDATE Instruments
SET instr_value = 6400
WHERE instr_id = 102;

 UPDATE Instruments
SET instr_value = 12500
WHERE instr_id = 103;

 UPDATE Instruments
SET instr_value = 15300
WHERE instr_id = 104;

-- aggregating and sorting data, numeric functions

-- MAX()
-- Which instrument has the highest value?

SELECT instr_type, instr_value 
FROM Instruments
WHERE instr_value = (SELECT MAX(instr_value) FROM Instruments);

-- COUNT()
-- How many instruments are rented now ?

SELECT COUNT(stud_id)
FROM Rental
WHERE date_rent_stop > '2023-01-17';

-- sorting using ORDER BY
-- Rank in descending order the date of rent

SELECT * FROM Rental
ORDER BY date_rent_start DESC;


-- adding Foreing Keys to existing tables

ALTER TABLE Parents_data
ADD FOREIGN KEY (stud_id) REFERENCES Students(stud_id);

ALTER TABLE Instruments
ADD FOREIGN KEY (instr_id) REFERENCES Rental(instr_id);

ALTER TABLE Rental
ADD FOREIGN KEY (stud_id) REFERENCES Students(stud_id);


