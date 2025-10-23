-- hr_demo sample dataset
DROP DATABASE IF EXISTS hr_demo;
CREATE DATABASE hr_demo;
USE hr_demo;

SET FOREIGN_KEY_CHECKS=0;

CREATE TABLE Employee (
  eid INT AUTO_INCREMENT PRIMARY KEY,
  ename VARCHAR(120) NOT NULL,
  age INT CHECK (age BETWEEN 18 AND 70),
  salaryid INT,
  deptid INT,
  ssn CHAR(9) UNIQUE,
  projid INT NULL,
  CONSTRAINT fk_emp_salary FOREIGN KEY (salaryid) REFERENCES Salary(said),
  CONSTRAINT fk_emp_dept FOREIGN KEY (deptid) REFERENCES Department(did),
  CONSTRAINT fk_emp_project FOREIGN KEY (projid) REFERENCES Project(pid)
) ENGINE=InnoDB;

CREATE TABLE Department (
  did INT AUTO_INCREMENT PRIMARY KEY,
  dname VARCHAR(100) NOT NULL UNIQUE,
  hod VARCHAR(100) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE Salary (
  said INT AUTO_INCREMENT PRIMARY KEY,
  salaryamount DECIMAL(12,2) NOT NULL,
  cashbonus DECIMAL(12,2) NOT NULL DEFAULT 0,
  salaryband VARCHAR(20) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE Project (
  pid INT AUTO_INCREMENT PRIMARY KEY,
  pname VARCHAR(120) NOT NULL,
  budget DECIMAL(14,2) NOT NULL,
  deptid INT,
  projhead INT NULL,
  CONSTRAINT fk_project_dept FOREIGN KEY (deptid) REFERENCES Department(did)
) ENGINE=InnoDB;


CREATE TABLE Salarytoemployee (
  eid INT,
  said INT,
  duedate DATE,
  depositdate DATE,
  tax DECIMAL(5,2),
  taxamount DECIMAL(12,2),
  PRIMARY KEY (eid, said, duedate),
  CONSTRAINT fk_ste_emp FOREIGN KEY (eid) REFERENCES Employee(eid),
  CONSTRAINT fk_ste_sal FOREIGN KEY (said) REFERENCES Salary(said)
) ENGINE=InnoDB;

CREATE TABLE Vacation (
  vid INT AUTO_INCREMENT PRIMARY KEY,
  eid INT NOT NULL,
  startdate DATE NOT NULL,
  enddate DATE NOT NULL,
  status ENUM('APPROVED','PENDING','REJECTED') NOT NULL DEFAULT 'PENDING',
  reason VARCHAR(255),
  CONSTRAINT fk_vac_emp FOREIGN KEY (eid) REFERENCES Employee(eid)
) ENGINE=InnoDB;

SET FOREIGN_KEY_CHECKS=1;

INSERT INTO Department (dname, hod) VALUES
('Dept 01','Logan Rodriguez'),
('Dept 02','Liam Turner'),
('Dept 03','Camila Taylor'),
('Dept 04','Emily Martinez'),
('Dept 05','Daniel Davis'),
('Dept 06','Elijah Turner'),
('Dept 07','Hannah Miller'),
('Dept 08','Lucas Lewis'),
('Dept 09','Olivia Williams'),
('Dept 10','Ava Anderson'),
('Dept 11','Emily King'),
('Dept 12','Mason Williams'),
('Dept 13','Lily Wilson'),
('Dept 14','Michael Baker'),
('Dept 15','William Scott'),
('Dept 16','Chloe Thomas'),
('Dept 17','Madison Hill'),
('Dept 18','Camila Johnson'),
('Dept 19','Jacob Lopez'),
('Dept 20','William Lewis'),
('Dept 21','Mila Jackson'),
('Dept 22','Charlotte Anderson'),
('Dept 23','Jacob Thompson'),
('Dept 24','Sophia Miller'),
('Dept 25','Penelope Davis'),
('Dept 26','Aria White'),
('Dept 27','Mason Moore'),
('Dept 28','Olivia Roberts'),
('Dept 29','Eleanor Scott'),
('Dept 30','Isabella Sanchez');

INSERT INTO Salary (salaryamount, cashbonus, salaryband) VALUES
(44161.00, 4645.00, 'S01'),
(48198.00, 5439.00, 'S02'),
(50813.00, 6919.00, 'S03'),
(52682.00, 3647.00, 'S04'),
(54142.00, 2955.00, 'S05'),
(56966.00, 7252.00, 'S06'),
(59163.00, 8018.00, 'S07'),
(63274.00, 3802.00, 'S08'),
(64569.00, 6156.00, 'S09'),
(68208.00, 5898.00, 'S10'),
(69758.00, 5966.00, 'S11'),
(72872.00, 5589.00, 'S12'),
(75918.00, 8985.00, 'S13'),
(76646.00, 8501.00, 'S14'),
(79350.00, 8205.00, 'S15'),
(82001.00, 5439.00, 'S16'),
(84777.00, 6527.00, 'S17'),
(88395.00, 10077.00, 'S18'),
(90140.00, 6486.00, 'S19'),
(92164.00, 12376.00, 'S20'),
(95589.00, 5314.00, 'S21'),
(98183.00, 5224.00, 'S22'),
(99646.00, 8979.00, 'S23'),
(101635.00, 7226.00, 'S24'),
(105931.00, 11304.00, 'S25'),
(107970.00, 8796.00, 'S26'),
(110342.00, 11025.00, 'S27'),
(113311.00, 16028.00, 'S28'),
(114939.00, 7389.00, 'S29'),
(116785.00, 8719.00, 'S30');

INSERT INTO Project (pname, budget, deptid, projhead) VALUES
('Project 01 - Aster', 230322.00, 9, NULL),
('Project 02 - Zenith', 238077.00, 29, NULL),
('Project 03 - Zenith', 251175.00, 12, NULL),
('Project 04 - Orion', 249065.00, 17, NULL),
('Project 05 - Nova', 260957.00, 25, NULL),
('Project 06 - Atlas', 277185.00, 5, NULL),
('Project 07 - Nimbus', 312666.00, 20, NULL),
('Project 08 - Beacon', 325216.00, 13, NULL),
('Project 09 - Zenith', 345674.00, 17, NULL),
('Project 10 - Helix', 366256.00, 28, NULL),
('Project 11 - Atlas', 352507.00, 22, NULL),
('Project 12 - Aster', 377486.00, 25, NULL),
('Project 13 - Quasar', 382310.00, 10, NULL),
('Project 14 - Vertex', 400365.00, 15, NULL),
('Project 15 - Atlas', 422261.00, 17, NULL),
('Project 16 - Nimbus', 453271.00, 30, NULL),
('Project 17 - Beacon', 454558.00, 27, NULL),
('Project 18 - Aster', 489909.00, 7, NULL),
('Project 19 - Nimbus', 489504.00, 25, NULL),
('Project 20 - Nimbus', 515348.00, 25, NULL),
('Project 21 - Aster', 495037.00, 20, NULL),
('Project 22 - Quasar', 542021.00, 1, NULL),
('Project 23 - Beacon', 548788.00, 29, NULL),
('Project 24 - Helix', 555692.00, 2, NULL),
('Project 25 - Orion', 592182.00, 3, NULL),
('Project 26 - Beacon', 601849.00, 27, NULL),
('Project 27 - Beacon', 619911.00, 25, NULL),
('Project 28 - Nimbus', 608414.00, 22, NULL),
('Project 29 - Nova', 651031.00, 6, NULL),
('Project 30 - Helix', 664581.00, 28, NULL);

INSERT INTO Employee (ename, age, salaryid, deptid, ssn, projid) VALUES
('Mason Lewis', 35, 30, 18, '346578713', 25),
('Emily Garcia', 43, 1, 19, '393010310', 18),
('Mila Garcia', 54, 8, 9, '738299737', 22),
('Chloe Wilson', 28, 4, 22, '566701065', 14),
('Sophia Taylor', 34, 7, 18, '262473178', 15),
('Sophia Jones', 56, 27, 1, '326773602', 3),
('Penelope Johnson', 46, 9, 30, '746872343', 26),
('Noah Hill', 56, 2, 24, '009788208', 11),
('Ava Gonzalez', 26, 20, 3, '361939909', 22),
('Ava Ramirez', 59, 19, 17, '435346247', 11),
('Avery Phillips', 26, 1, 15, '911838425', 20),
('Emma Taylor', 45, 10, 6, '849808412', 15),
('Elizabeth Rodriguez', 28, 24, 18, '449353487', 5),
('Elizabeth Jones', 27, 21, 14, '400524278', 27),
('Michael Lewis', 57, 1, 4, '280598262', 3),
('Olivia Lee', 45, 29, 30, '053315869', 26),
('Daniel Hernandez', 37, 28, 6, '260256342', 26),
('William Davis', 46, 28, 2, '733754330', 28),
('Benjamin Wilson', 47, 11, 9, '145868501', 28),
('Elizabeth Gonzalez', 59, 9, 2, '965569816', 4),
('Aiden Wilson', 38, 2, 23, '088356159', 14),
('Avery Nelson', 29, 24, 29, '846564823', 10),
('Chloe Nelson', 46, 22, 24, '299468044', 29),
('Abigail Lewis', 59, 20, 21, '777387214', 11),
('Riley Nelson', 43, 3, 27, '343320037', 25),
('Ethan Campbell', 26, 15, 14, '936763201', 29),
('Victoria Thomas', 33, 26, 23, '708317278', 17),
('Lily Flores', 42, 25, 29, '986872774', 15),
('Jacob Taylor', 39, 25, 25, '734714345', 17),
('Avery Scott', 27, 5, 5, '623166587', 8),
('Chloe Jones', 35, 27, 14, '909670546', 13),
('Chloe Scott', 56, 26, 20, '373467065', 29),
('Benjamin Carter', 47, 24, 6, '729806990', 27),
('Ava Baker', 49, 5, 28, '204653755', 15),
('Jacob Sanchez', 39, 25, 27, '417080531', 14),
('James Brown', 23, 8, 7, '092327193', 27),
('Eleanor Mitchell', 38, 25, 12, '991241904', 6),
('Aiden Carter', 46, 13, 23, '193149190', 7),
('Aria Scott', 49, 22, 12, '850671657', 3),
('Michael Hernandez', 49, 6, 24, '498776945', 17);

UPDATE Project SET projhead = 1 WHERE pid = 1;
UPDATE Project SET projhead = 2 WHERE pid = 2;
UPDATE Project SET projhead = 3 WHERE pid = 3;
UPDATE Project SET projhead = 4 WHERE pid = 4;
UPDATE Project SET projhead = 5 WHERE pid = 5;
UPDATE Project SET projhead = 6 WHERE pid = 6;
UPDATE Project SET projhead = 7 WHERE pid = 7;
UPDATE Project SET projhead = 8 WHERE pid = 8;
UPDATE Project SET projhead = 9 WHERE pid = 9;
UPDATE Project SET projhead = 10 WHERE pid = 10;
UPDATE Project SET projhead = 11 WHERE pid = 11;
UPDATE Project SET projhead = 12 WHERE pid = 12;
UPDATE Project SET projhead = 13 WHERE pid = 13;
UPDATE Project SET projhead = 14 WHERE pid = 14;
UPDATE Project SET projhead = 15 WHERE pid = 15;
UPDATE Project SET projhead = 16 WHERE pid = 16;
UPDATE Project SET projhead = 17 WHERE pid = 17;
UPDATE Project SET projhead = 18 WHERE pid = 18;
UPDATE Project SET projhead = 19 WHERE pid = 19;
UPDATE Project SET projhead = 20 WHERE pid = 20;
UPDATE Project SET projhead = 21 WHERE pid = 21;
UPDATE Project SET projhead = 22 WHERE pid = 22;
UPDATE Project SET projhead = 23 WHERE pid = 23;
UPDATE Project SET projhead = 24 WHERE pid = 24;
UPDATE Project SET projhead = 25 WHERE pid = 25;
UPDATE Project SET projhead = 26 WHERE pid = 26;
UPDATE Project SET projhead = 27 WHERE pid = 27;
UPDATE Project SET projhead = 28 WHERE pid = 28;
UPDATE Project SET projhead = 29 WHERE pid = 29;
UPDATE Project SET projhead = 30 WHERE pid = 30;

INSERT INTO Salarytoemployee (eid, said, duedate, depositdate, tax, taxamount) VALUES
(1, 28, '2025-10-01', '2025-10-03', 12.00, 1125.00),
(2, 27, '2025-10-01', '2025-10-03', 10.00, 916.67),
(3, 9, '2025-10-01', '2025-10-03', 18.00, 975.00),
(4, 8, '2025-10-01', '2025-10-03', 18.00, 937.50),
(5, 19, '2025-10-01', '2025-10-03', 20.00, 1500.00),
(6, 22, '2025-10-01', '2025-10-03', 18.00, 1462.50),
(7, 11, '2025-10-01', '2025-10-03', 10.00, 583.33),
(8, 16, '2025-10-01', '2025-10-03', 15.00, 1031.25),
(9, 6, '2025-10-01', '2025-10-03', 18.00, 862.50),
(10, 7, '2025-10-01', '2025-10-03', 15.00, 750.00),
(11, 26, '2025-10-01', '2025-10-03', 15.00, 1343.75),
(12, 11, '2025-10-01', '2025-10-03', 15.00, 875.00),
(13, 29, '2025-10-01', '2025-10-03', 20.00, 1916.67),
(14, 23, '2025-10-01', '2025-10-03', 15.00, 1250.00),
(15, 18, '2025-10-01', '2025-10-03', 10.00, 729.17),
(16, 17, '2025-10-01', '2025-10-03', 12.00, 850.00),
(17, 3, '2025-10-01', '2025-10-03', 12.00, 500.00),
(18, 24, '2025-10-01', '2025-10-03', 18.00, 1537.50),
(19, 16, '2025-10-01', '2025-10-03', 20.00, 1375.00),
(20, 25, '2025-10-01', '2025-10-03', 12.00, 1050.00),
(21, 23, '2025-10-01', '2025-10-03', 18.00, 1500.00),
(22, 21, '2025-10-01', '2025-10-03', 18.00, 1425.00),
(23, 15, '2025-10-01', '2025-10-03', 10.00, 666.67),
(24, 3, '2025-10-01', '2025-10-03', 15.00, 625.00),
(25, 8, '2025-10-01', '2025-10-03', 18.00, 937.50),
(26, 23, '2025-10-01', '2025-10-03', 12.00, 1000.00),
(27, 10, '2025-10-01', '2025-10-03', 20.00, 1125.00),
(28, 12, '2025-10-01', '2025-10-03', 18.00, 1087.50),
(29, 18, '2025-10-01', '2025-10-03', 20.00, 1458.33),
(30, 12, '2025-10-01', '2025-10-03', 18.00, 1087.50),
(31, 24, '2025-10-01', '2025-10-03', 20.00, 1708.33),
(32, 11, '2025-10-01', '2025-10-03', 15.00, 875.00),
(33, 23, '2025-10-01', '2025-10-03', 18.00, 1500.00),
(34, 9, '2025-10-01', '2025-10-03', 15.00, 812.50),
(35, 9, '2025-10-01', '2025-10-03', 12.00, 650.00),
(36, 4, '2025-10-01', '2025-10-03', 12.00, 525.00),
(37, 11, '2025-10-01', '2025-10-03', 10.00, 583.33),
(38, 24, '2025-10-01', '2025-10-03', 20.00, 1708.33),
(39, 25, '2025-10-01', '2025-10-03', 12.00, 1050.00),
(40, 7, '2025-10-01', '2025-10-03', 12.00, 600.00);

INSERT INTO Vacation (eid, startdate, enddate, status, reason) VALUES
(31, '2025-08-05', '2025-08-12', 'APPROVED', 'Medical'),
(19, '2025-07-30', '2025-08-07', 'APPROVED', 'Family visit'),
(1, '2025-09-07', '2025-09-12', 'PENDING', 'Annual leave'),
(4, '2025-09-09', '2025-09-16', 'REJECTED', 'Medical'),
(32, '2025-07-14', '2025-07-17', 'REJECTED', 'Family visit'),
(31, '2025-08-31', '2025-09-10', 'PENDING', 'Medical'),
(4, '2025-08-02', '2025-08-12', 'APPROVED', 'Annual leave'),
(26, '2025-09-01', '2025-09-05', 'REJECTED', 'Travel'),
(4, '2025-07-20', '2025-07-25', 'REJECTED', 'Family visit'),
(6, '2025-08-01', '2025-08-05', 'REJECTED', 'Conference'),
(39, '2025-09-15', '2025-09-21', 'REJECTED', 'Conference'),
(29, '2025-08-26', '2025-09-02', 'REJECTED', 'Conference'),
(20, '2025-09-11', '2025-09-14', 'REJECTED', 'Travel'),
(7, '2025-07-27', '2025-08-02', 'PENDING', 'Travel'),
(6, '2025-07-21', '2025-07-27', 'APPROVED', 'Personal errand'),
(5, '2025-07-21', '2025-07-24', 'PENDING', 'Conference'),
(39, '2025-08-30', '2025-09-06', 'APPROVED', 'Medical'),
(19, '2025-08-06', '2025-08-16', 'APPROVED', 'Travel'),
(15, '2025-08-03', '2025-08-09', 'PENDING', 'Annual leave'),
(35, '2025-07-29', '2025-08-03', 'PENDING', 'Medical'),
(5, '2025-07-08', '2025-07-13', 'PENDING', 'Personal errand'),
(37, '2025-08-06', '2025-08-16', 'APPROVED', 'Conference'),
(20, '2025-08-21', '2025-08-28', 'REJECTED', 'Personal errand'),
(32, '2025-08-26', '2025-08-30', 'REJECTED', 'Annual leave'),
(28, '2025-08-11', '2025-08-18', 'APPROVED', 'Annual leave'),
(15, '2025-09-12', '2025-09-15', 'REJECTED', 'Family visit'),
(37, '2025-07-06', '2025-07-11', 'PENDING', 'Personal errand'),
(29, '2025-08-05', '2025-08-10', 'REJECTED', 'Conference'),
(32, '2025-07-12', '2025-07-22', 'PENDING', 'Conference'),
(22, '2025-08-11', '2025-08-15', 'APPROVED', 'Family visit'),
(27, '2025-09-02', '2025-09-09', 'REJECTED', 'Conference'),
(36, '2025-07-05', '2025-07-15', 'APPROVED', 'Family visit'),
(17, '2025-08-11', '2025-08-15', 'PENDING', 'Personal errand'),
(1, '2025-09-08', '2025-09-18', 'PENDING', 'Annual leave'),
(13, '2025-09-05', '2025-09-13', 'REJECTED', 'Conference'),
(29, '2025-07-07', '2025-07-13', 'PENDING', 'Personal errand'),
(9, '2025-08-06', '2025-08-16', 'REJECTED', 'Conference'),
(8, '2025-07-04', '2025-07-10', 'REJECTED', 'Medical'),
(20, '2025-09-09', '2025-09-12', 'REJECTED', 'Conference'),
(6, '2025-07-29', '2025-08-02', 'PENDING', 'Annual leave');


Show the department name of employees who are on vacation right now.
SELECT DISTINCT d.dname
FROM Employee e
JOIN Department d ON e.deptid = d.did
JOIN Vacation v ON e.eid = v.eid
WHERE CURDATE() BETWEEN v.startdate AND v.enddate AND v.status = 'APPROVED';