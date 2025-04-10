USE hospital_management_system;

#Creating tables
#1
CREATE TABLE Patient (
    Patient_ID INT NOT NULL,
    Patient_FName VARCHAR(20) NOT NULL,
    Patient_LName VARCHAR(20) NOT NULL,
    Phone VARCHAR(12) NOT NULL,
    Blood_Type  VARCHAR(5) NOT NULL,
    Email VARCHAR(50),
    Gender  VARCHAR(10),
    Condition_ VARCHAR(30),
    Admission_Date DATE,
    Discharge_Date DATE,
    PRIMARY KEY (Patient_ID) 
);

#2
CREATE TABLE Department (
    Dept_ID INT NOT NULL,
    Dept_Head VARCHAR(20) NOT NULL,
    Dept_Name VARCHAR(15) NOT NULL,
    Emp_Count INT,
    PRIMARY  KEY (Dept_ID) 
  );
  
  #3
CREATE TABLE Staff (
    Emp_ID INT  NOT NULL,
    Emp_FName  VARCHAR(20) NOT NULL,
    Emp_LName  VARCHAR(20) NOT NULL,
    Date_Joining  DATE,
    Date_Seperation DATE,
    Emp_Type VARCHAR(15) NOT NULL,
    Email  VARCHAR(50),
    Address  VARCHAR(50) NOT NULL,
    Dept_ID  INT NOT NULL,
    SSN  INT NOT NULL,
    PRIMARY KEY (Emp_ID),
    FOREIGN KEY (Dept_ID) REFERENCES Department  (Dept_ID)
);
ALTER TABLE staff
RENAME COLUMN Date_Seperation to Date_Separation;

#4
CREATE TABLE Doctor (
    Doctor_ID INT NOT NULL,
    Qualifications VARCHAR(15) NOT NULL,
    Emp_ID INT NOT NULL,
    Specialization VARCHAR(20) NOT NULL,
	Dept_ID INT NOT NULL,
    PRIMARY KEY (Doctor_ID),
    FOREIGN KEY (Emp_ID) REFERENCES Staff (Emp_ID),
    FOREIGN KEY (Dept_ID) REFERENCES Department (Dept_ID)
);

#5
CREATE TABLE Nurse (
    Nurse_ID INT  NOT NULL,
    Patient_ID  INT  NOT NULL,
    Emp_ID  INT NOT NULL,
    Dept_ID INT NOT NULL,
    PRIMARY KEY(Nurse_ID),
    FOREIGN KEY (Patient_ID) REFERENCES Patient (Patient_ID),
    FOREIGN KEY (Emp_ID) REFERENCES Staff  (Emp_ID),
    FOREIGN KEY (Dept_ID) REFERENCES Department (Dept_ID)
);

#6
CREATE TABLE Emergency_Contact(
    Contact_ID INT  NOT NULL,
    Contact_Name VARCHAR(20) NOT NULL,
    Phone VARCHAR(12) NOT NULL,
    Relation VARCHAR(20) NOT NULL,
	Patient_ID  INT NOT NULL,
    PRIMARY KEY (Contact_ID),
    FOREIGN KEY (Patient_ID) REFERENCES Patient (Patient_ID)
);

 #7
  CREATE TABLE Payroll (
    Account_No VARCHAR(25) NOT NULL,
    Salary DECIMAL(10,2) NOT NULL,
    Bonus DECIMAL(10,2),
    Emp_ID INT NOT NULL,
    IBAN VARCHAR(25),
    PRIMARY KEY (Account_No),
    FOREIGN KEY (Emp_ID) REFERENCES Staff (Emp_ID)
   );
   
   #8
 CREATE TABLE  Lab_Screening (
    Lab_ID INT NOT NULL,
    Patient_ID  INT  NOT NULL,
	Technician_ID  INT  NOT NULL,
    Doctor_ID  INT NOT NULL,
	Test_Cost  DECIMAL(10,2),
	Date  DATE  NOT NULL,
	PRIMARY KEY (Lab_ID),
    FOREIGN KEY (Patient_ID) REFERENCES Patient (Patient_ID),
    FOREIGN KEY (Doctor_ID) REFERENCES Doctor (Doctor_ID)
);

#9
CREATE TABLE Insurance (
    Policy_Number VARCHAR(20) NOT NULL,
    Patient_ID INT NOT NULL,
    Ins_Code VARCHAR(20) NOT NULL,
    End_Date VARCHAR(10),
    Provider VARCHAR(20),
    Plan VARCHAR(20),
    Co_Pay  DECIMAL(10,2),
    Coverage VARCHAR(20),
    Maternity  BOOLEAN,
    Dental  BOOLEAN,
    Optical BOOLEAN,
    PRIMARY  KEY (Policy_Number),
    FOREIGN KEY (Patient_ID) REFERENCES Patient (Patient_ID)
);
ALTER TABLE Insurance MODIFY Coverage VARCHAR(30);

#10
CREATE TABLE Medicine (
    Medicine_ID INT  NOT NULL,
    M_Name VARCHAR(20) NOT NULL,
    M_Quantity INT NOT NULL,
    M_Cost  Decimal(10,2),
   PRIMARY KEY (Medicine_ID)
    );
    
#11
CREATE TABLE Prescription (
    Prescription_ID INT  NOT NULL,
    Patient_ID  INT  NOT NULL,
    Medicine_ID  INT  NOT NULL,
    Date  DATE,
    Dosage  INT,
    Doctor_ID INT NOT NULL,
    PRIMARY KEY (Prescription_ID),
    FOREIGN KEY (Patient_ID) REFERENCES Patient (Patient_ID),
    FOREIGN KEY (Doctor_ID) REFERENCES Doctor (Doctor_ID),
    FOREIGN KEY (Medicine_ID) REFERENCES Medicine (Medicine_ID)
);    

#12
CREATE TABLE Medical_History (
    Record_ID  INT NOT NULL,
    Patient_ID  INT NOT NULL,
	Allergies VARCHAR(50),
    Pre_Conditions VARCHAR(50),
    PRIMARY KEY (Record_ID),
    FOREIGN KEY (Patient_ID) REFERENCES Patient (Patient_ID)
);

#13
CREATE TABLE Appointment (
    Appt_ID INT  NOT NULL,
    Scheduled_On  DATETIME NOT NULL,
    Date  DATE,
    Time TIME,
    Doctor_ID INT NOT NULL,
    Patient_ID  INT NOT NULL,
    PRIMARY KEY (Appt_ID),
    FOREIGN KEY (Doctor_ID) REFERENCES Doctor (Doctor_ID), 
    FOREIGN KEY (Patient_ID) REFERENCES Patient (Patient_ID)
);

 #14
 CREATE TABLE  Room (
    Room_ID INT NOT NULL,
    Room_Type VARCHAR(50) NOT NULL,
    Patient_ID  INT  NOT NULL,
    Room_Cost  DECIMAL(10,2),
    PRIMARY KEY (Room_ID),
    FOREIGN KEY (Patient_ID) REFERENCES Patient (Patient_ID)
    );
    
#15
CREATE TABLE Bill (
    Bill_ID INT NOT NULL,
    Date  DATE,
    Room_Cost Decimal(10,2),
    Test_Cost  DECIMAL(10,2),
    Other_Charges  DECIMAL(10,2),
	M_Cost DECIMAL(10,2),
    Total  DECIMAL(10,2),
    Patient_ID INT NOT NULL,
    Remaining_Balance DECIMAL(10,2),
    Policy_Number VARCHAR(20) NOT NULL,
    PRIMARY KEY (Bill_ID),
    FOREIGN KEY (Patient_ID) REFERENCES Patient (Patient_ID),
    FOREIGN KEY (Policy_Number) REFERENCES Insurance (Policy_Number)
);

#Inserting Data into tables#
INSERT INTO Patient (Patient_ID, Patient_FName, Patient_LName, Phone, Blood_Type, Email, Gender, Condition_, Admission_Date, Discharge_Date)
VALUES
(1, 'John', 'Doe', '555-1234', 'A+', 'john.doe@email.com', 'Male', 'Injury', '2023-01-01', '2023-01-10'),
(2, 'Jane', 'Smith', '555-5678', 'O-', 'jane.smith@email.com', 'Female', 'Flu', '2023-02-05', '2023-02-15'),
(3, 'Michael', 'Johnson', '555-8765', 'B+', 'michael.johnson@email.com', 'Male', 'Allergies', '2023-03-10', '2023-03-20'),
(4, 'Emily', 'Williams', '555-2345', 'AB-', 'emily.williams@email.com', 'Female', 'Headache', '2023-04-15', '2023-04-25'),
(5, 'Robert', 'Brown', '555-5432', 'A-', 'robert.brown@email.com', 'Male', 'Fracture', '2023-05-20', '2023-05-30'),
(6, 'Alice', 'Davis', '555-7890', 'O+', 'alice.davis@email.com', 'Female', 'Respiratory Infection', '2023-06-25', '2023-07-05'),
(7, 'Christopher', 'Miller', '555-4321', 'B-', 'chris.miller@email.com', 'Male', 'Back Pain', '2023-07-30', '2023-08-09'),
(8, 'Olivia', 'Jones', '555-9876', 'AB+', 'olivia.jones@email.com', 'Female', 'Concussion', '2023-09-04', '2023-09-14'),
(9, 'William', 'Wilson', '555-8765', 'A+', 'william.wilson@email.com', 'Male', 'Appendicitis', '2023-10-09', '2023-10-19'),
(10, 'Sophia', 'Moore', '555-6543', 'O-', 'sophia.moore@email.com', 'Female', 'Diabetes', '2023-11-14', '2023-11-24'),
(11, 'David', 'Taylor', '555-3210', 'B+', 'david.taylor@email.com', 'Male', 'Infection', '2023-12-19', '2023-12-29'),
(12, 'Emma', 'Anderson', '555-6789', 'AB-', 'emma.anderson@email.com', 'Female', 'Inflammation', '2024-01-24', '2024-02-03'),
(13, 'James', 'Martin', '555-2109', 'A-', 'james.martin@email.com', 'Male', 'Stomachache', '2024-02-28', '2024-03-09'),
(14, 'Grace', 'White', '555-7890', 'O+', 'grace.white@email.com', 'Female', 'Migraine', '2024-04-04', '2024-04-14'),
(15, 'Benjamin', 'Hall', '555-5432', 'B-', 'benjamin.hall@email.com', 'Male', 'COVID-19', '2024-05-09', '2024-05-19'),
(16, 'Lily', 'Young', '555-9876', 'AB+', 'lily.young@email.com', 'Female', 'Heart Attack', '2024-06-14', '2024-06-24'),
(17, 'Samuel', 'Bell', '555-2345', 'A+', 'samuel.bell@email.com', 'Male', 'Anxiety', '2024-07-19', '2024-07-29'),
(18, 'Ava', 'Clark', '555-8765', 'O-', 'ava.clark@email.com', 'Female', 'Dehydration', '2024-08-24', '2024-09-03'),
(19, 'Matthew', 'Turner', '555-4321', 'B+', 'matthew.turner@email.com', 'Male', 'Arthritis', '2024-09-28', '2024-10-08'),
(20, 'Chloe', 'Baker', '555-6543', 'AB-', 'chloe.baker@email.com', 'Female', 'High Blood Pressure', '2024-10-03', '2024-10-13'),
(21, 'Andrew', 'Adams', '555-3210', 'A-', 'andrew.adams@email.com', 'Male', 'Injury', '2024-11-07', '2024-11-17'),
(22, 'Isabella', 'Ward', '555-6789', 'O+', 'isabella.ward@email.com', 'Female', 'Flu', '2024-12-12', '2024-12-22'),
(23, 'Nathan', 'Fisher', '555-2109', 'B-', 'nathan.fisher@email.com', 'Male', 'Allergies', '2025-01-16', '2025-01-26'),
(24, 'Avery', 'Cooper', '555-7890', 'AB+', 'avery.cooper@email.com', 'Female', 'Headache', '2025-02-20', '2025-03-02'),
(25, 'Mia', 'Ross', '555-5432', 'AB-', 'mia.ross@email.com', 'Female', 'Fracture', '2025-03-27', '2025-04-06'),
(26, 'Jack', 'Harrison', '555-9876', 'O+', 'jack.harrison@email.com', 'Male', 'Respiratory Infection', '2025-04-01', '2025-04-11'),
(27, 'Sophie', 'Murray', '555-4321', 'A+', 'sophie.murray@email.com', 'Female', 'Back Pain', '2025-05-06', '2025-05-16'),
(28, 'Logan', 'Collins', '555-2109', 'B-', 'logan.collins@email.com', 'Male', 'Concussion', '2025-06-11', '2025-06-21'),
(29, 'Abigail', 'Perez', '555-6543', 'AB+', 'abigail.perez@email.com', 'Female', 'Appendicitis', '2025-07-16', '2025-07-26'),
(30, 'Elijah', 'Bailey', '555-3210', 'O-', 'elijah.bailey@email.com', 'Male', 'Diabetes', '2025-08-21', '2025-08-31'),
(31, 'Hannah', 'Morgan', '555-6789', 'B+', 'hannah.morgan@email.com', 'Female', 'Infection', '2025-09-25', '2025-10-05'),
(32, 'William', 'Reed', '555-8765', 'AB-', 'william.reed@email.com', 'Male', 'Inflammation', '2025-10-30', '2025-11-09'),
(33, 'Ava', 'Bryant', '555-2345', 'A-', 'ava.bryant@email.com', 'Female', 'Stomachache', '2025-12-04', '2025-12-14'),
(34, 'Mason', 'Lopez', '555-5432', 'O+', 'mason.lopez@email.com', 'Male', 'Migraine', '2026-01-08', '2026-01-18'),
(35, 'Harper', 'Hill', '555-7890', 'B-', 'harper.hill@email.com', 'Female', 'COVID-19', '2026-02-12', '2026-02-22'),
(36, 'Liam', 'Long', '555-4321', 'AB+', 'liam.long@email.com', 'Male', 'Heart Attack', '2026-03-19', '2026-03-29'),
(37, 'Ella', 'King', '555-9876', 'A+', 'ella.king@email.com', 'Female', 'Anxiety', '2026-04-23', '2026-05-03'),
(38, 'Aiden', 'Watson', '555-2109', 'O-', 'aiden.watson@email.com', 'Male', 'Dehydration', '2026-05-28', '2026-06-07'),
(39, 'Sofia', 'Richards', '555-6543', 'B+', 'sofia.richards@email.com', 'Female', 'Arthritis', '2026-06-02', '2026-06-12'),
(40, 'Connor', 'Bailey', '555-3210', 'AB-', 'connor.bailey@email.com', 'Male', 'High Blood Pressure', '2026-07-07', '2026-07-17'),
(41, 'Avery', 'Harrison', '555-6789', 'A-', 'avery.harrison@email.com', 'Female', 'Injury', '2026-08-11', '2026-08-21'),
(42, 'Lucas', 'Fisher', '555-8765', 'O+', 'lucas.fisher@email.com', 'Male', 'Flu', '2026-09-15', '2026-09-25'),
(43, 'Scarlett', 'Ward', '555-5432', 'B-', 'scarlett.ward@email.com', 'Female', 'Allergies', '2026-10-20', '2026-10-30'),
(44, 'Jackson', 'Cooper', '555-9876', 'AB+', 'jackson.cooper@email.com', 'Male', 'Headache', '2026-11-24', '2026-12-04'),
(45, 'Lily', 'Ross', '555-2345', 'AB-', 'lily.ross@email.com', 'Female', 'Fracture', '2026-12-29', '2027-01-08'),
(46, 'Grayson', 'Harrison', '555-5432', 'O+', 'grayson.harrison@email.com', 'Male', 'Respiratory Infection', '2027-01-03', '2027-01-13'),
(47, 'Zoe', 'Murray', '555-7890', 'A+', 'zoe.murray@email.com', 'Female', 'Back Pain', '2027-02-07', '2027-02-17'),
(48, 'Ethan', 'Collins', '555-4321', 'B-', 'ethan.collins@email.com', 'Male', 'Concussion', '2027-03-14', '2027-03-24'),
(49, 'Aria', 'Perez', '555-2109', 'AB+', 'aria.perez@email.com', 'Female', 'Appendicitis', '2027-04-18', '2027-04-28'),
(50, 'Logan', 'Hall', '555-6543', 'O-', 'logan.hall@email.com', 'Male', 'Diabetes','2027-05-23','2027-06-02');

INSERT INTO Department (Dept_ID, Dept_Head, Dept_Name, Emp_Count)
VALUES
(1, 'John Smith', 'Cardiology_1', 5),
(2, 'Isabella Fisher', 'Emergency_2', 5),
(3, 'James White', 'Diagnostic_3', 5),
(4, 'Emily Davis', 'Cardiology_4', 5),
(5, 'Mia Anderson', 'Emergency_5', 5),
(6, 'Lily Bell', 'Diagnostic_6', 5),
(7, 'Christopher Jones', 'Cardiology_7', 5),
(8, 'Logon Bryant', 'Emergency_8', 5),
(9, 'Matthew Barker', 'Diagnostic_9', 5),
(10, 'Sophia Taylor', 'Cardiology_10', 5);

INSERT INTO Staff (Emp_ID, Emp_FName, Emp_LName, Date_Joining, Date_Separation, Emp_Type, Email, Address, Dept_ID, SSN)
VALUES
(1, 'John', 'Smith', '2022-01-01', NULL, 'Doctor', 'john.smith@email.com', '123 Main St', 1, '123456789'),
(2, 'Jane', 'Johnson', '2022-02-15', NULL, 'Nurse', 'jane.johnson@email.com', '456 Oak St', 2, '234567890'),
(3, 'Michael', 'Williams', '2022-03-10', NULL, 'Lab Technician', 'michael.williams@email.com', '789 Pine St', 3, '345678901'),
(4, 'Emily', 'Davis', '2022-04-25', NULL, 'Doctor', 'emily.davis@email.com', '321 Cedar St', 4, '456789012'),
(5, 'Robert', 'Brown', '2022-05-30', NULL, 'Nurse', 'robert.brown@email.com', '654 Elm St', 5, '567890123'),
(6, 'Alice', 'Miller', '2022-07-05', NULL, 'Lab Technician', 'alice.miller@email.com', '987 Maple St', 6, '678901234'),
(7, 'Christopher', 'Jones', '2022-08-09', NULL, 'Doctor', 'chris.jones@email.com', '159 Birch St', 7, '789012345'),
(8, 'Olivia', 'Wilson', '2022-09-14', NULL, 'Nurse', 'olivia.wilson@email.com', '753 Walnut St', 8, '890123456'),
(9, 'William', 'Moore', '2022-10-19', NULL, 'Lab Technician', 'william.moore@email.com', '246 Pine St', 9, '901234567'),
(10, 'Sophia', 'Taylor', '2022-11-24', NULL, 'Doctor', 'sophia.taylor@email.com', '864 Oak St', 10, '012345678'),
(11, 'David', 'Anderson', '2023-01-02', NULL, 'Nurse', 'david.anderson@email.com', '975 Cedar St', 1, '123456789'),
(12, 'Emma', 'Martin', '2023-02-03', NULL, 'Lab Technician', 'emma.martin@email.com', '321 Elm St', 2, '234567890'),
(13, 'James', 'White', '2023-03-09', NULL, 'Doctor', 'james.white@email.com', '654 Maple St', 3, '345678901'),
(14, 'Grace', 'Hall', '2023-04-14', NULL, 'Nurse', 'grace.hall@email.com', '987 Birch St', 4, '456789012'),
(15, 'Benjamin', 'Young', '2023-05-19', NULL, 'Lab Technician', 'benjamin.young@email.com', '159 Walnut St', 5, '567890123'),
(16, 'Lily', 'Bell', '2023-06-24', NULL, 'Doctor', 'lily.bell@email.com', '753 Pine St', 6, '678901234'),
(17, 'Samuel', 'Clark', '2023-07-29', NULL, 'Nurse', 'samuel.clark@email.com', '864 Oak St', 7, '789012345'),
(18, 'Ava', 'Turner', '2023-09-03', NULL, 'Lab Technician', 'ava.turner@email.com', '975 Cedar St', 8, '890123456'),
(19, 'Matthew', 'Baker', '2023-10-08', NULL, 'Doctor', 'matthew.baker@email.com', '246 Elm St', 9, '901234567'),
(20, 'Chloe', 'Adams', '2023-11-13', NULL, 'Nurse', 'chloe.adams@email.com', '321 Maple St', 10, '012345678'),
(21, 'Andrew', 'Ward', '2024-01-18', NULL, 'Lab Technician', 'andrew.ward@email.com', '654 Birch St', 1, '123456789'),
(22, 'Isabella', 'Fisher', '2024-02-23', NULL, 'Doctor', 'isabella.fisher@email.com', '987 Walnut St', 2, '234567890'),
(23, 'Nathan', 'Cooper', '2024-04-01', NULL, 'Nurse', 'nathan.cooper@email.com', '159 Pine St', 3, '345678901'),
(24, 'Avery', 'Murray', '2024-05-06', NULL, 'Lab Technician', 'avery.murray@email.com', '753 Oak St', 4, '456789012'),
(25, 'Mia', 'Anderson', '2024-06-11', NULL, 'Doctor', 'mia.anderson@email.com', '864 Cedar St', 5, '567890123'),
(26, 'Jack', 'Ross', '2024-07-16', NULL, 'Nurse', 'jack.ross@email.com', '975 Maple St', 6, '678901234'),
(27, 'Sophie', 'Harrison', '2024-08-21', NULL, 'Lab Technician', 'sophie.harrison@email.com', '246 Birch St', 7, '789012345'),
(28, 'Logan', 'Bryant', '2024-09-26', NULL, 'Doctor', 'logan.bryant@email.com', '321 Walnut St', 8, '890123456'),
(29, 'Abigail', 'Lopez', '2024-11-02', NULL, 'Nurse', 'abigail.lopez@email.com', '654 Pine St', 9, '901234567'),
(30, 'Elijah', 'Hill', '2024-12-07', NULL, 'Lab Technician', 'elijah.hill@email.com', '987 Oak St', 10, '012345678'),
(31, 'Hannah', 'Long', '2025-01-12', NULL, 'Doctor', 'hannah.long@email.com', '159 Cedar St', 1, '123456789'),
(32, 'William', 'King', '2025-02-17', NULL, 'Nurse', 'william.king@email.com', '753 Elm St', 2, '234567890'),
(33, 'Ava', 'Watson', '2025-03-24', NULL, 'Lab Technician', 'ava.watson@email.com', '864 Maple St', 3, '345678901'),
(34, 'Mason', 'Richards', '2025-04-29', NULL, 'Doctor', 'mason.richards@email.com', '975 Birch St', 4, '456789012'),
(35, 'Harper', 'Bailey', '2025-06-04', NULL, 'Nurse', 'harper.bailey@email.com', '246 Walnut St', 5, '567890123'),
(36, 'Liam', 'Harrison', '2025-07-09', NULL, 'Lab Technician', 'liam.harrison@email.com', '321 Pine St', 6, '678901234'),
(37, 'Ella', 'Fisher', '2025-08-14', NULL, 'Doctor', 'ella.fisher@email.com', '654 Oak St', 7, '789012345'),
(38, 'Aiden', 'Ward', '2025-09-19', NULL, 'Nurse', 'aiden.ward@email.com', '753 Cedar St', 8, '890123456'),
(39, 'Sofia', 'Adams', '2025-10-24', NULL, 'Lab Technician', 'sofia.adams@email.com', '864 Elm St', 9, '901234567'),
(40, 'Connor', 'Turner', '2025-11-29', NULL, 'Doctor', 'connor.turner@email.com', '975 Maple St', 10, '012345678'),
(41, 'Avery', 'Baker', '2026-01-03', NULL, 'Nurse', 'avery.baker@email.com', '159 Birch St', 1, '123456789'),
(42, 'Lucas', 'Ward', '2026-02-07', NULL, 'Lab Technician', 'lucas.ward@email.com', '246 Walnut St', 2, '234567890'),
(43, 'Scarlett', 'Fisher', '2026-03-14', NULL, 'Doctor', 'scarlett.fisher@email.com', '321 Pine St', 3, '345678901'),
(44, 'Jackson', 'Cooper', '2026-04-19', NULL, 'Nurse', 'jackson.cooper@email.com', '654 Oak St', 4, '456789012'),
(45, 'Lily', 'Ross', '2026-05-24', NULL, 'Lab Technician', 'lily.ross@email.com', '753 Cedar St', 5, '567890123'),
(46, 'Grayson', 'Harrison', '2026-06-29', NULL, 'Doctor', 'grayson.harrison@email.com', '864 Elm St', 6, '678901234'),
(47, 'Zoe', 'Murray', '2026-08-03', NULL, 'Nurse', 'zoe.murray@email.com', '975 Maple St', 7, '789012345'),
(48, 'Ethan', 'Collins', '2026-09-07', NULL, 'Lab Technician', 'ethan.collins@email.com', '159 Birch St', 8, '890123456'),
(49, 'Aria', 'Perez', '2026-10-12', NULL, 'Doctor', 'aria.perez@email.com', '246 Walnut St', 9, '901234567'),
(50, 'Logan', 'Hall', '2026-11-17', NULL, 'Nurse', 'logan.hall@email.com', '321 Pine St', 10, '012345678');

INSERT INTO Doctor (Doctor_ID, Qualifications, Emp_ID, Specialization, Dept_ID)
VALUES
(101, 'MD', 1, 'General Medicine', 1),
(40, 'MD', 4, 'General Medicine', 4),
(70, 'MD', 7, 'General Medicine', 7),
(102, 'MD', 10, 'General Medicine', 10),
(130, 'MD', 13, 'General Medicine', 2),
(160, 'MD', 16, 'General Medicine', 5),
(190, 'MD', 19, 'General Medicine', 8),
(220, 'MD', 22, 'General Medicine', 1),
(250, 'MD', 25, 'General Medicine', 4),
(280, 'MD', 28, 'General Medicine', 7),
(310, 'MD', 31, 'General Medicine', 10),
(340, 'MD', 34, 'General Medicine', 2),
(370, 'MD', 37, 'General Medicine', 5),
(400, 'MD', 40, 'General Medicine', 8),
(430, 'MD', 43, 'General Medicine', 1),
(460, 'MD', 46, 'General Medicine', 4),
(490, 'MD', 49, 'General Medicine', 7);

INSERT INTO Nurse (Nurse_ID, Patient_ID, Emp_ID, Dept_ID)
VALUES
(2, 1, 2, 2),
(5, 2, 5, 5),
(8, 3, 8, 8),
(11, 4, 11, 1),
(14, 5, 14, 4),
(17, 6, 17, 7),
(20, 7, 20, 10),
(23, 8, 23, 2),
(26, 9, 26, 5),
(29, 10, 29, 8),
(32, 11, 32, 1),
(35, 12, 35, 4),
(38, 13, 38, 7),
(41, 14, 41, 10),
(44, 15, 44, 2),
(47, 16, 47, 5),
(50, 17, 50, 8);

INSERT INTO Emergency_Contact (Contact_ID, Contact_Name, Phone, Relation, Patient_ID)
VALUES
(10, 'John Doe', '555-1234', 'Parent', 1),
(20, 'Jane Smith', '555-5678', 'Sibling', 2),
(30, 'Robert Johnson', '555-8765', 'Parent', 3),
(40, 'Emily Davis', '555-4321', 'Sibling', 4),
(50, 'Michael Wilson', '555-9876', 'Parent', 5),
(60, 'Alice Taylor', '555-3456', 'Sibling', 6),
(70, 'David Brown', '555-6789', 'Parent', 7),
(80, 'Susan Miller', '555-2345', 'Sibling', 8),
(90, 'Chris Anderson', '555-7890', 'Parent', 9),
(100, 'Emma White', '555-9012', 'Sibling', 10),
(110, 'Mark Thompson', '555-5432', 'Sibling', 11),
(120, 'Laura Harris', '555-8765', 'Parent', 12),
(130, 'Brian Jackson', '555-2345', 'Sibling', 13),
(140, 'Olivia Johnson', '555-7890', 'Parent', 14),
(150, 'Alex Turner', '555-4321', 'Sibling', 15),
(160, 'Grace Martin', '555-5678', 'Parent', 16),
(170, 'Edward Smith', '555-8765', 'Sibling', 17),
(180, 'Sophia Walker', '555-2345', 'Parent', 18),
(190, 'Nathan Taylor', '555-7890', 'Sibling', 19),
(200, 'Ava Davis', '555-5678', 'Parent', 20),
(210, 'Andrew White', '555-8765', 'Sibling', 21),
(220, 'Ella Wilson', '555-2345', 'Parent', 22),
(230, 'Jack Harris', '555-7890', 'Sibling', 23),
(240, 'Lily Brown', '555-5678', 'Parent', 24),
(250, 'Owen Johnson', '555-8765', 'Sibling', 25),
(260, 'Chloe Turner', '555-2345', 'Parent', 26),
(270, 'Aiden Martin', '555-7890', 'Sibling', 27),
(280, 'Sophie Anderson', '555-5678', 'Parent', 28),
(290, 'James Miller', '555-8765', 'Sibling', 29),
(300, 'Emma Taylor', '555-2345', 'Parent', 30),
(310, 'Liam Davis', '555-7890', 'Sibling', 31),
(320, 'Isabella Wilson', '555-5678', 'Parent', 32),
(330, 'Logan Harris', '555-8765', 'Sibling', 33),
(340, 'Olivia Smith', '555-2345', 'Parent', 34),
(350, 'Michael Turner', '555-7890', 'Sibling', 35),
(360, 'Emily Walker', '555-5678', 'Parent', 36),
(370, 'Matthew White', '555-8765', 'Sibling', 37),
(380, 'Ava Taylor', '555-2345', 'Parent', 38),
(390, 'Noah Brown', '555-7890', 'Sibling', 39),
(400, 'Sophia Johnson', '555-5678', 'Parent', 40),
(410, 'Lucas Martin', '555-8765', 'Sibling', 41),
(420, 'Grace Anderson', '555-2345', 'Parent', 42),
(430, 'Liam Wilson', '555-7890', 'Sibling', 43),
(440, 'Isabella Harris', '555-5678', 'Parent', 44),
(450, 'Oliver Davis', '555-8765', 'Sibling', 45),
(460, 'Ava Smith', '555-2345', 'Parent', 46),
(470, 'Emma Turner', '555-7890', 'Sibling', 47),
(480, 'Logan Walker', '555-5678', 'Parent', 48),
(490, 'Mia White', '555-8765', 'Sibling', 49),
(500, 'Ethan Johnson', '555-2345', 'Parent', 50);

INSERT INTO Payroll (Account_No, Salary, Bonus, Emp_ID, IBAN)
VALUES
(9078881226, 100000.00, 20000.00, 1, 'IBAN1'),
(7798155825, 80000.00, 15000.00, 2, 'IBAN2'),
(3215909832, 75000.00, 10000.00, 3, 'IBAN3'),
(5478999830, 100000.00, 20000.00, 4, 'IBAN4'),
(1124642741, 80000.00, 15000.00, 5, 'IBAN5'),
(3324799295, 75000.00, 10000.00, 6, 'IBAN6'),
(1943051877, 100000.00, 20000.00, 7, 'IBAN7'),
(6943185735, 80000.00, 15000.00, 8, 'IBAN8'),
(6037285462, 75000.00, 10000.00, 9, 'IBAN9'),
(6920320928, 100000.00, 20000.00, 10, 'IBAN10'),
(6746791335, 80000.00, 15000.00, 11, 'IBAN11'),
(3275178591, 75000.00, 10000.00, 12, 'IBAN12'),
(2460124675, 100000.00, 20000.00, 13, 'IBAN13'),
(1566676915, 80000.00, 15000.00, 14, 'IBAN14'),
(7894056216, 75000.00, 10000.00, 15, 'IBAN15'),
(7213923343, 100000.00, 20000.00, 16, 'IBAN16'),
(8482865504, 80000.00, 15000.00, 17, 'IBAN17'),
(8299659684, 75000.00, 10000.00, 18, 'IBAN18'),
(9133654166, 100000.00, 20000.00, 19, 'IBAN19'),
(7990167969, 80000.00, 15000.00, 20, 'IBAN20'),
(1402638832, 75000.00, 10000.00, 21, 'IBAN21'),
(7217524343, 100000.00, 20000.00, 22, 'IBAN22'),
(5635787218, 80000.00, 15000.00, 23, 'IBAN23'),
(3852377223, 75000.00, 10000.00, 24, 'IBAN24'),
(2220438658, 100000.00, 20000.00, 25, 'IBAN25'),
(8158948225, 80000.00, 15000.00, 26, 'IBAN26'),
(8943225868, 75000.00, 10000.00, 27, 'IBAN27'),
(6924673181, 100000.00, 20000.00, 28, 'IBAN28'),
(4812086849, 80000.00, 15000.00, 29, 'IBAN29'),
(9156320684, 75000.00, 10000.00, 30, 'IBAN30'),
(4627645892, 100000.00, 20000.00, 31, 'IBAN31'),
(2855482761, 80000.00, 15000.00, 32, 'IBAN32'),
(7128238884, 75000.00, 10000.00, 33, 'IBAN33'),
(3604687263, 100000.00, 20000.00, 34, 'IBAN34'),
(9014144488, 80000.00, 15000.00, 35, 'IBAN35'),
(8137431734, 75000.00, 10000.00, 36, 'IBAN36'),
(5021302401, 100000.00, 20000.00, 37, 'IBAN37'),
(2996743941, 80000.00, 15000.00, 38, 'IBAN38'),
(4824682087, 75000.00, 10000.00, 39, 'IBAN39'),
(3080884504, 100000.00, 20000.00, 40, 'IBAN40'),
(9874273823, 80000.00, 15000.00, 41, 'IBAN41'),
(1088886261, 75000.00, 10000.00, 42, 'IBAN42'),
(6951983527, 100000.00, 20000.00, 43, 'IBAN43'),
(2460106576, 80000.00, 15000.00, 44, 'IBAN44'),
(4279040386, 75000.00, 10000.00, 45, 'IBAN45'),
(8197540732, 100000.00, 20000.00, 46, 'IBAN46'),
(7213079469, 80000.00, 15000.00, 47, 'IBAN47'),
(6445704972, 75000.00, 10000.00, 48, 'IBAN48'),
(8274661485, 100000.00, 20000.00, 49, 'IBAN49'),
(7930115091, 80000.00, 15000.00, 50, 'IBAN50');

INSERT INTO lab_screening (Lab_ID, Patient_ID, Technician_ID, Doctor_ID, Test_Cost, Date)
VALUES
(1, 1, 6, 101, 75, '2023-12-05'),
(2, 2, 3, 101, 50, '2023-12-06'),
(3, 3, 9, 280, 80, '2023-12-07'),
(4, 4, 7, 220, 60, '2023-12-08'),
(5, 5, 8, 70, 70, '2023-12-09'),
(6, 6, 2, 102, 65, '2023-12-10'),
(7, 7, 1, 220, 55, '2023-12-11'),
(8, 8, 7, 250, 60, '2023-12-12'),
(9, 9, 4, 370, 75, '2023-12-13'),
(10, 10, 1, 250, 50, '2023-12-14');

INSERT INTO insurance (Policy_Number, Patient_ID, Ins_Code, End_Date, Provider, Plan, Co_Pay, Coverage, Maternity, Dental, Optical)
VALUES
('A123456', 1, 'INS001', '2024-12-31', 'XYZ Insurance', 'Standard Plan', 20.00, 'Health Insurance', true, false, false),
('B789012', 2, 'INS002', '2024-11-30', 'ABC Insurance', 'Extended Plan', 30.00, 'Health and Dental Insurance', false, true, false),
('C345678', 3, 'INS003', '2024-10-31', 'DEF Insurance', 'Basic Plan', 15.00, 'Health Insurance', true, false, true),
('D901234', 4, 'INS004', '2024-09-30', 'GHI Insurance', 'Family Plan', 25.00, 'Health and Dental Insurance', true, true, true),
('E567890', 5, 'INS005', '2024-08-31', 'JKL Insurance', 'Standard Plan', 20.00, 'Health Insurance', false, false, true),
('F123789', 6, 'INS006', '2024-07-31', 'MNO Insurance', 'Extended Plan', 30.00, 'Health and Dental Insurance', true, true, true),
('G456321', 7, 'INS007', '2024-06-30', 'PQR Insurance', 'Basic Plan', 15.00, 'Health Insurance', false, true, false),
('H987654', 8, 'INS008', '2024-05-31', 'STU Insurance', 'Family Plan', 25.00, 'Health and Dental Insurance', true, false, true),
('I234567', 9, 'INS009', '2024-04-30', 'VWX Insurance', 'Standard Plan', 20.00, 'Health Insurance', false, true, false),
('J876543', 10, 'INS010', '2024-03-31', 'YZA Insurance', 'Extended Plan', 30.00, 'Health and Dental Insurance', true, true, true),
('K432765', 11, 'INS011', '2024-02-29', 'BCE Insurance', 'Basic Plan', 15.00, 'Health Insurance', false, false, true),
('L987123', 12, 'INS012', '2024-01-31', 'RTY Insurance', 'Family Plan', 25.00, 'Health and Dental Insurance', true, false, true),
('M654321', 13, 'INS013', '2023-12-31', 'UIO Insurance', 'Standard Plan', 20.00, 'Health Insurance', false, true, false),
('N321789', 14, 'INS014', '2023-11-30', 'PAS Insurance', 'Extended Plan', 30.00, 'Health and Dental Insurance', true, true, true),
('O876543', 15, 'INS015', '2023-10-31', 'FGE Insurance', 'Basic Plan', 15.00, 'Health Insurance', false, false, true),
('P123456', 16, 'INS016', '2023-09-30', 'HJK Insurance', 'Family Plan', 25.00, 'Health and Dental Insurance', true, true, true),
('Q789012', 17, 'INS017', '2023-08-31', 'LKJ Insurance', 'Standard Plan', 20.00, 'Health Insurance', false, true, false),
('R345678', 18, 'INS018', '2023-07-31', 'QWE Insurance', 'Extended Plan', 30.00, 'Health and Dental Insurance', true, false, true),
('S901234', 19, 'INS019', '2023-06-30', 'ZXC Insurance', 'Basic Plan', 15.00, 'Health Insurance', true, true, false),
('T567890', 20, 'INS020', '2023-05-31', 'VBN Insurance', 'Family Plan', 25.00, 'Health and Dental Insurance', false, true, true),
('U123789', 21, 'INS021', '2023-04-30', 'MVC Insurance', 'Standard Plan', 20.00, 'Health Insurance', false, false, true),
('V456321', 22, 'INS022', '2023-03-31', 'POI Insurance', 'Extended Plan', 30.00, 'Health and Dental Insurance', true, true, true),
('W987654', 23, 'INS023', '2023-02-28', 'LNU Insurance', 'Basic Plan', 15.00, 'Health Insurance', false, true, false),
('X234567', 24, 'INS024', '2023-01-31', 'SDQ Insurance', 'Family Plan', 25.00, 'Health and Dental Insurance', true, false, true),
('Y876543', 25, 'INS025', '2022-12-31', 'GFT Insurance', 'Standard Plan', 20.00, 'Health Insurance', true, true, false),
('Z432765', 26, 'INS026', '2022-11-30', 'JHY Insurance', 'Extended Plan', 30.00, 'Health and Dental Insurance', false, true, true),
('AA987123', 27, 'INS027', '2022-10-31', 'RWS Insurance', 'Basic Plan', 15.00, 'Health Insurance', true, false, true),
('BB654321', 28, 'INS028', '2022-09-30', 'XJY Insurance', 'Family Plan', 25.00, 'Health and Dental Insurance', false, false, true),
('CC321789', 29, 'INS029', '2022-08-31', 'KLN Insurance', 'Standard Plan', 20.00, 'Health Insurance', true, true, false),
('DD901234', 30, 'INS030', '2022-07-31', 'OPU Insurance', 'Extended Plan', 30.00, 'Health and Dental Insurance', false, true, true),
('EE567890', 31, 'INS031', '2022-06-30', 'ZNB Insurance', 'Basic Plan', 15.00, 'Health Insurance', true, false, true),
('FF123456', 32, 'INS032', '2022-05-31', 'LMG Insurance', 'Family Plan', 25.00, 'Health and Dental Insurance', false, true, true),
('GG789012', 33, 'INS033', '2022-04-30', 'TYU Insurance', 'Standard Plan', 20.00, 'Health Insurance', true, false, true),
('HH345678', 34, 'INS034', '2022-03-31', 'QAX Insurance', 'Extended Plan', 30.00, 'Health and Dental Insurance', true, true, false),
('II901234', 35, 'INS035', '2022-02-28', 'ZVB Insurance', 'Basic Plan', 15.00, 'Health Insurance', false, false, true),
('JJ567890', 36, 'INS036', '2022-01-31', 'WXC Insurance', 'Family Plan', 25.00, 'Health and Dental Insurance', true, true, true),
('KK123789', 37, 'INS037', '2021-12-31', 'URP Insurance', 'Standard Plan', 20.00, 'Health Insurance', false, true, false),
('LL456321', 38, 'INS038', '2021-11-30', 'TQO Insurance', 'Extended Plan', 30.00, 'Health and Dental Insurance', true, false, true),
('MM987654', 39, 'INS039', '2021-10-31', 'INO Insurance', 'Basic Plan', 15.00, 'Health Insurance', false, true, false),
('NN234567', 40, 'INS040', '2021-09-30', 'PLM Insurance', 'Family Plan', 25.00, 'Health and Dental Insurance', true, true, true),
('OO876543', 41, 'INS041', '2021-08-31', 'YPL Insurance', 'Standard Plan', 20.00, 'Health Insurance', true, true, false),
('PP123456', 42, 'INS042', '2021-07-31', 'KSJ Insurance', 'Extended Plan', 30.00, 'Health and Dental Insurance', false, true, true),
('QQ789012', 43, 'INS043', '2021-06-30', 'TNK Insurance', 'Basic Plan', 15.00, 'Health Insurance', true, false, true),
('RR345678', 44, 'INS044', '2021-05-31', 'MSO Insurance', 'Family Plan', 25.00, 'Health and Dental Insurance', false, true, false),
('SS901234', 45, 'INS045', '2021-04-30', 'AHZ Insurance', 'Standard Plan', 20.00, 'Health Insurance', true, true, false),
('TT567890', 46, 'INS046', '2021-03-31', 'FDG Insurance', 'Extended Plan', 30.00, 'Health and Dental Insurance', false, true, true),
('UU123789', 47, 'INS047', '2021-02-28', 'VXD Insurance', 'Basic Plan', 15.00, 'Health Insurance', true, false, true),
('VV456321', 48, 'INS048', '2021-01-31', 'YBC Insurance', 'Family Plan', 25.00, 'Health and Dental Insurance', true, false, true),
('WW987654', 49, 'INS049', '2020-12-31', 'LMN Insurance', 'Standard Plan', 20.00, 'Health Insurance', true, true, false),
('XX234567', 50, 'INS050', '2020-11-30', 'JKL Insurance', 'Extended Plan', 30.00, 'Health and Dental Insurance', false, true, true);

INSERT INTO Medicine (Medicine_ID, M_Name, M_Quantity, M_Cost)
VALUES
(1, 'Aspirin', 100, 5.99),
(2, 'Ibuprofen', 50, 8.49),
(3, 'Acetaminophen', 75, 6.25),
(4, 'Amoxicillin', 30, 12.75),
(5, 'Ciprofloxacin', 20, 15.99),
(6, 'Lisinopril', 40, 9.75),
(7, 'Atorvastatin', 60, 22.50),
(8, 'Levothyroxine', 90, 18.75),
(9, 'Metformin', 120, 14.99),
(10, 'Losartan', 50, 11.25),
(11, 'Omeprazole', 80, 10.49),
(12, 'Esomeprazole', 25, 28.75),
(13, 'Ranitidine', 60, 7.99),
(14, 'Cetirizine', 40, 9.25),
(15, 'Fluoxetine', 30, 15.50),
(16, 'Paroxetine', 20, 19.99),
(17, 'Sertraline', 45, 12.75),
(18, 'Warfarin', 50, 13.99),
(19, 'Furosemide', 35, 8.99),
(20, 'Prednisone', 15, 16.25);

INSERT INTO Prescription (Prescription_ID, Patient_ID, Medicine_ID, Date, Dosage, Doctor_ID)
VALUES
(13, 1, 1, '2023-12-05', 2, 101),
(23, 2, 3, '2023-12-06', 1, 101),
(33, 32, 6, '2023-12-07', 1, 101),
(43, 18, 10, '2023-12-08', 2, 220),
(53, 49, 15, '2023-12-09', 1, 310),
(63, 31, 7, '2023-12-10', 2, 400),
(73, 25, 14, '2023-12-11', 1, 310),
(83, 50, 18, '2023-12-12', 1, 370),
(93, 11, 9, '2023-12-13', 2, 310),
(103, 40, 5, '2023-12-14', 1, 250),
(113, 30, 13, '2023-12-15', 1, 250),
(123, 20, 2, '2023-12-16', 2, 250),
(133, 28, 4, '2023-12-17', 1, 310),
(143, 16, 16, '2023-12-18', 1, 460),
(153, 27, 20, '2023-12-19', 2, 460),
(163, 34, 8, '2023-12-20', 1, 490),
(173, 43, 19, '2023-12-21', 1, 430),
(183, 29, 12, '2023-12-22', 2, 370),
(193, 22, 17, '2023-12-23', 1, 220),
(203, 34, 11, '2023-12-24', 1, 130),
(213, 36, 1, '2023-12-25', 2, 220),
(223, 48, 6, '2023-12-26', 1, 102),
(233, 26, 9, '2023-12-27', 1, 102),
(243, 29, 15, '2023-12-28', 2, 160),
(253, 45, 3, '2023-12-29', 1, 490),
(263, 10, 7, '2023-12-30', 1, 250),
(273, 2, 14, '2023-12-31', 2, 310),
(283, 3, 20, '2024-01-01', 1, 280),
(293, 4, 10, '2024-01-02', 1, 220),
(303, 5, 5, '2024-01-03', 2, 70),
(313, 1, 13, '2024-01-04', 1, 40),
(323, 2, 2, '2024-01-05', 1, 101),
(333, 3, 18, '2024-01-06', 2, 130),
(343, 4, 16, '2024-01-07', 1, 70),
(353, 6, 12, '2024-01-08', 1, 102),
(363, 7, 19, '2024-01-09', 2, 220),
(373, 8, 8, '2024-01-10', 1, 250),
(383, 9, 4, '2024-01-11', 1, 370),
(393, 1, 11, '2024-01-12', 2, 400),
(403, 32, 1, '2024-01-13', 1, 490),
(413, 30, 14, '2024-01-14', 1, 430),
(423, 50, 9, '2024-01-15', 2, 160),
(433, 26, 20, '2024-01-16', 1, 130),
(443, 28, 3, '2024-01-17', 1, 190),
(453, 29, 6, '2024-01-18', 2, 250),
(463, 1, 15, '2024-01-19', 1, 160),
(473, 24, 5, '2024-01-20', 1, 430),
(483, 46, 17, '2024-01-21', 2, 130),
(493, 35, 7, '2024-01-22', 1, 340),
(503, 19, 10, '2024-01-23', 1, 490);

INSERT INTO Medical_History (Record_ID, Patient_ID, Allergies, Pre_Conditions)
VALUES
(11, 1, 'Penicillin', 'None'),
(21, 2, 'None', 'Asthma'),
(31, 3, 'Sulfa Drugs', 'High Blood Pressure'),
(41, 4, 'Pollen', 'None'),
(51, 5, 'Shellfish', 'Diabetes'),
(61, 6, 'None', 'Heart Disease'),
(71, 7, 'Peanuts', 'High Cholesterol'),
(81, 8, 'None', 'Anemia'),
(91, 9, 'Dust Mites', 'Arthritis'),
(101, 10, 'Cats', 'Depression'),
(111, 11, 'Mold', 'None'),
(121, 12, 'None', 'Thyroid Disorder'),
(131, 13, 'None', 'None'),
(141, 14, 'Eggs', 'None'),
(151, 15, 'None', 'Migraines'),
(161, 16, 'Tree Nuts', 'None'),
(171, 17, 'None', 'Obesity'),
(181, 18, 'None', 'Back Pain'),
(191, 19, 'Latex', 'None'),
(201, 20, 'None', 'Respiratory Infections'),
(211, 21, 'None', 'Allergic Rhinitis'),
(221, 22, 'None', 'Anxiety'),
(231, 23, 'None', 'Insomnia'),
(241, 24, 'None', 'GERD'),
(251, 25, 'None', 'Joint Pain'),
(261, 26, 'None', 'None'),
(271, 27, 'None', 'Acne'),
(281, 28, 'None', 'Seasonal Allergies'),
(291, 29, 'None', 'None'),
(301, 30, 'None', 'None'),
(311, 31, 'None', 'ADHD'),
(321, 32, 'None', 'PTSD'),
(331, 33, 'None', 'IBS'),
(341, 34, 'None', 'Psoriasis'),
(351, 35, 'None', 'None'),
(361, 36, 'None', 'None'),
(371, 37, 'None', 'None'),
(381, 38, 'None', 'None'),
(391, 39, 'None', 'None'),
(401, 40, 'None', 'None'),
(411, 41, 'None', 'None'),
(421, 42, 'None', 'None'),
(431, 43, 'None', 'None'),
(441, 44, 'None', 'None'),
(451, 45, 'None', 'None'),
(461, 46, 'None', 'None'),
(471, 47, 'None', 'None'),
(481, 48, 'None', 'None'),
(491, 49, 'None', 'None'),
(501, 50, 'None', 'None');

INSERT INTO Appointment (Appt_ID, Scheduled_On, Date, Time, Doctor_ID, Patient_ID)
VALUES
(1, '2023-12-02 14:24:16', '2023-12-13', '21:00:00', 101, 1),
(2, '2023-12-02 14:24:16', '2023-12-15', '14:00:00', 101, 2),
(3, '2023-12-02 14:24:16', '2023-12-18', '10:00:00', 101, 32),
(4, '2023-12-02 14:24:16', '2023-12-10', '16:00:00', 220, 18),
(5, '2023-12-02 14:24:16', '2023-12-18', '22:00:00', 310, 49),
(6, '2023-12-02 14:24:16', '2023-12-08', '19:00:00', 400, 31),
(7, '2023-12-02 14:24:16', '2023-12-13', '13:00:00', 310, 25),
(8, '2023-12-02 14:24:16', '2023-12-09', '15:00:00', 370, 50),
(9, '2023-12-02 14:24:16', '2023-12-11', '17:00:00', 310, 11),
(10, '2023-12-02 14:24:16', '2023-12-10', '12:00:00', 250, 40),
(11, '2023-12-02 14:24:16', '2023-12-15', '08:00:00', 250, 30),
(12, '2023-12-02 14:24:16', '2023-12-19', '14:00:00', 250, 20),
(13, '2023-12-02 14:24:16', '2023-12-17', '09:00:00', 310, 28),
(14, '2023-12-02 14:24:16', '2023-12-13', '10:00:00', 460, 16),
(15, '2023-12-02 14:24:16', '2023-12-18', '11:00:00', 460, 27),
(16, '2023-12-02 14:24:16', '2023-12-12', '15:00:00', 490, 34),
(17, '2023-12-02 14:24:16', '2023-12-14', '18:00:00', 430, 43),
(18, '2023-12-02 14:24:16', '2023-12-08', '21:00:00', 370, 29),
(19, '2023-12-02 14:24:16', '2023-12-16', '12:00:00', 220, 22),
(20, '2023-12-02 14:24:16', '2023-12-10', '14:00:00', 130, 34),
(21, '2023-12-02 14:24:16', '2023-12-15', '18:00:00', 220, 36),
(22, '2023-12-02 14:24:16', '2023-12-14', '19:00:00', 102, 48),
(23, '2023-12-02 14:24:16', '2023-12-11', '15:00:00', 102, 26),
(24, '2023-12-02 14:24:16', '2023-12-09', '09:00:00', 160, 29),
(25, '2023-12-02 14:24:16', '2023-12-11', '08:00:00', 490, 45),
(26, '2023-12-02 14:24:16', '2023-12-16', '21:00:00', 250, 10),
(27, '2023-12-02 14:24:16', '2023-12-14', '22:00:00', 310, 2),
(28, '2023-12-02 14:24:16', '2023-12-12', '08:00:00', 280, 3),
(29, '2023-12-02 14:24:16', '2023-12-13', '09:00:00', 220, 4),
(30, '2023-12-02 14:24:16', '2023-12-10', '15:00:00', 70, 5),
(31, '2023-12-02 14:24:16', '2023-12-12', '11:00:00', 40, 1),
(32, '2023-12-02 14:24:16', '2023-12-14', '12:00:00', 101, 2),
(33, '2023-12-02 14:24:16', '2023-12-16', '13:00:00', 130, 3),
(34, '2023-12-02 14:24:16', '2023-12-08', '14:00:00', 70, 4),
(35, '2023-12-02 14:24:16', '2023-12-09', '14:00:00', 102, 6),
(36, '2023-12-02 14:24:16', '2023-12-11', '15:00:00', 220, 7),
(37, '2023-12-02 14:24:16', '2023-12-12', '16:00:00', 250, 8),
(38, '2023-12-02 14:24:16', '2023-12-17', '17:00:00', 370, 9),
(39, '2023-12-02 14:24:16', '2023-12-15', '08:00:00', 400, 1),
(40, '2023-12-02 14:24:16', '2023-12-16', '10:00:00', 490, 32),
(41, '2023-12-02 14:24:16', '2023-12-16', '13:00:00', 430, 30),
(42, '2023-12-02 14:24:16', '2023-12-10', '20:00:00', 160, 50),
(43, '2023-12-02 14:24:16', '2023-12-07', '20:00:00', 130, 26),
(44, '2023-12-02 14:24:16', '2023-12-15', '20:00:00', 190, 28),
(45, '2023-12-02 14:24:16', '2023-12-08', '22:00:00', 250, 29),
(46, '2023-12-02 14:24:16', '2023-12-17', '12:00:00', 160, 1),
(47, '2023-12-02 14:24:16', '2023-12-14', '16:00:00', 430, 24),
(48, '2023-12-02 14:24:16', '2023-12-08', '08:00:00', 130, 46),
(49, '2023-12-02 14:24:16', '2023-12-09', '09:00:00', 340, 35),
(50, '2023-12-02 14:24:16', '2023-12-13', '10:00:00', 490, 19);

INSERT INTO Room (Room_ID, Room_Type, Patient_ID, Room_Cost)
VALUES
(101, 'Premium', 1, 150.00),
(205, 'Deluxe', 2, 200.00),
(307, 'Deluxe', 3, 200.00),
(415, 'Executive', 4, 250.00),
(503, 'Deluxe', 5, 200.00),
(621, 'Executive', 6, 250.00),
(713, 'Premium', 7, 150.00),
(809, 'Deluxe', 8, 200.00),
(912, 'Executive', 9, 250.00),
(103, 'Premium', 10, 150.00),
(204, 'Deluxe', 11, 200.00),
(306, 'Executive', 12, 250.00),
(401, 'Premium', 13, 150.00),
(507, 'Deluxe', 14, 200.00),
(601, 'Executive', 15, 250.00),
(706, 'Premium', 16, 150.00),
(804, 'Deluxe', 17, 200.00),
(903, 'Executive', 18, 250.00),
(110, 'Premium', 19, 150.00),
(209, 'Deluxe', 20, 200.00),
(301, 'Executive', 21, 250.00),
(413, 'Premium', 22, 150.00),
(515, 'Deluxe', 23, 200.00),
(602, 'Executive', 24, 250.00),
(707, 'Premium', 25, 150.00),
(805, 'Deluxe', 26, 200.00),
(900, 'Executive', 27, 250.00),
(1001, 'Premium', 28, 150.00),
(1204, 'Deluxe', 29, 200.00),
(1301, 'Executive', 30, 250.00),
(1402, 'Premium', 31, 150.00),
(1505, 'Deluxe', 32, 200.00),
(1607, 'Executive', 33, 250.00),
(1713, 'Premium', 34, 150.00),
(1821, 'Deluxe', 35, 200.00),
(1908, 'Executive', 36, 250.00),
(2011, 'Premium', 37, 150.00),
(2120, 'Deluxe', 38, 200.00),
(2225, 'Executive', 39, 250.00),
(2317, 'Premium', 40, 150.00),
(2411, 'Deluxe', 41, 200.00),
(2520, 'Executive', 42, 250.00),
(2602, 'Premium', 43, 150.00),
(2705, 'Deluxe', 44, 200.00),
(2806, 'Executive', 45, 250.00),
(2921, 'Premium', 46, 150.00),
(3011, 'Deluxe', 47, 200.00),
(3115, 'Executive', 48, 250.00),
(3220, 'Premium', 49, 150.00),
(3315, 'Deluxe', 50, 200.00);

INSERT INTO bill (Bill_ID, Date, Room_Cost, Test_Cost, Other_Charges, M_Cost, Total, Patient_ID, Remaining_Balance, Policy_Number)
VALUES
(60, '2023-12-05', 150, 75, 20, 5.99, 250.99, 1, 150, 'A123456'),
(61, '2023-12-06', 200, 50, 25, 12.75, 287.75, 2, 200, 'B789012'),
(62, '2023-12-07', 200, 80, 15, 6.25, 301.25, 3, 175, 'C345678'),
(63, '2023-12-08', 250, 60, 20, 9.75, 339.75, 4, 180, 'D901234'),
(64, '2023-12-09', 200, 70, 25, 14.99, 309.99, 5, 190, 'E567890'),
(65, '2023-12-10', 250, 65, 20, 22.5, 357.5, 6, 220, 'F123789'),
(66, '2023-12-11', 150, 55, 15, 18.75, 238.75, 7, 160, 'G456321'),
(67, '2023-12-12', 200, 60, 20, 12.75, 292.75, 8, 200, 'H987654'),
(68, '2023-12-13', 250, 75, 25, 14.99, 364.99, 9, 180, 'I234567'),
(69, '2023-12-14', 150, 50, 20, 10.49, 230.49, 10, 195, 'J876543'),
(70, '2023-12-15', 200, NULL, 15, 28.75, 243.75, 11, 150, 'K432765'),
(71, '2023-12-16', 250, NULL, 20, 7.99, 277.99, 12, 190, 'L987123'),
(72, '2023-12-17', 150, NULL, 25, 9.25, 184.25, 13, 180, 'M654321'),
(73, '2023-12-18', 200, NULL, 20, 15.5, 235.5, 14, 200, 'N321789'),
(74, '2023-12-19', 250, NULL, 15, 19.99, 284.99, 15, 160, 'O876543'),
(75, '2023-12-20', 150, NULL, 20, 15.99, 185.99, 16, 40, 'P123456'),
(76, '2023-12-21', 200, NULL, 25, 7.99, 232.99, 17, 180, 'Q789012'),
(77, '2023-12-22', 250, NULL, 20, 11.25, 281.25, 18, 195, 'R345678'),
(78, '2023-12-23', 150, NULL, 25, 10.49, 185.49, 19, 180, 'S901234'),
(79, '2023-12-24', 200, NULL, 20, 28.75, 248.75, 20, 205, 'T567890'),
(80, '2023-12-25', 250, NULL, 15, 9.75, 274.75, 21, 155, 'U123789'),
(81, '2023-12-26', 150, NULL, 20, 18.75, 188.75, 22, 200, 'V456321'),
(82, '2023-12-27', 200, NULL, 25, 14.99, 239.99, 23, 180, 'W987654'),
(83, '2023-12-28', 250, NULL, 20, 15.5, 285.5, 24, 200, 'X234567'),
(84, '2023-12-29', 150, NULL, 15, 16.25, 181.25, 25, 160, 'Y876543'),
(85, '2023-12-30', 200, NULL, 20, 9.99, 229.99, 26, 200, 'Z432765'),
(86, '2023-12-31', 250, NULL, 25, 12.75, 287.75, 27, 180, 'AA987123'),
(87, '2024-01-01', 150, NULL, 20, 18.75, 188.75, 28, 70, 'BB654321'),
(88, '2024-01-02', 200, NULL, 15, 16.99, 231.99, 29, 160, 'CC321789'),
(89, '2024-01-03', 250, NULL, 20, 10.25, 280.25, 30, 200, 'DD901234'),
(90, '2024-01-04', 150, NULL, 25, 8.99, 183.99, 31, 180, 'EE567890'),
(91, '2024-01-05', 200, NULL, 20, 14.99, 234.99, 32, 195, 'FF123456'),
(92, '2024-01-06', 250, NULL, 15, 25.75, 290.75, 33, 160, 'GG789012'),
(93, '2024-01-07', 150, NULL, 20, 18.75, 188.75, 34, 30, 'HH345678'),
(94, '2024-01-08', 200, NULL, 25, 11.99, 236.99, 35, 180, 'II901234'),
(95, '2024-01-09', 250, NULL, 20, 13.75, 283.75, 36, 195, 'JJ567890'),
(96, '2024-01-10', 150, NULL, 15, 9.99, 174.99, 37, 160, 'KK123789'),
(97, '2024-01-11', 200, NULL, 20, 17.25, 237.25, 38, 200, 'LL456321'),
(98, '2024-01-12', 250, NULL, 25, 18.75, 293.75, 39, 180, 'MM987654'),
(99, '2024-01-13', 150, NULL, 20, 10.99, 180.99, 40, 40, 'NN234567'),
(100, '2024-01-14', 200, NULL, 15, 22.5, 237.5, 41, 160, 'OO876543'),
(101, '2024-01-15', 250, NULL, 20, 15.25, 285.25, 42, 200, 'PP123456'),
(102, '2024-01-16', 150, NULL, 25, 18.99, 193.99, 43, 180, 'QQ789012'),
(103, '2024-01-17', 200, NULL, 20, 10.75, 230.75, 44, 195, 'RR345678'),
(104, '2024-01-18', 250, NULL, 15, 9.99, 274.99, 45, 160, 'SS901234'),
(105, '2024-01-19', 150, NULL, 20, 18.75, 188.75, 46, 55, 'TT567890'),
(106, '2024-01-20', 200, NULL, 25, 15.99, 240.99, 47, 180, 'UU123789'),
(107, '2024-01-21', 250, NULL, 20, 9.75, 279.75, 48, 195, 'VV456321'),
(108, '2024-01-22', 150, NULL, 15, 12.25, 177.25, 49, 160, 'WW987654'),
(109, '2024-01-23', 200, NULL, 20, 16.99, 236.99, 50, 200, 'XX234567');


USE hospital_management_system;

# NAMES OF ALL THE TABLES CREATED
# 1)Patient
# 2)Department
# 3)Staff
# 4)Doctor
# 5)Nurse
# 6)Emergency Contact 
# 7)Payroll
# 8)Lab Screening
# 9)Insurance 
# 10)Medicine
# 11)Prescription
# 12)Medical History
# 13)Appointment
# 14)Room
# 15)Bill


# Query 1 : The hospital management wants to calculate the total revenue generated
# by the hospital, including room charges, lab screening charges, and other
# miscellaneous charges, for a specific date range.

SELECT DATE_FORMAT(b.Date, '%Y-%m-%d') AS Billing_Date,     
SUM(b.Room_Cost + b.Test_Cost + b.Other_Charges + b.M_Cost) AS Total_Revenue 
FROM bill b
WHERE	b.Date BETWEEN '2023-12-01' AND '2023-12-31' 
GROUP BY	DATE_FORMAT(b.Date, '%Y-%m-%d')
ORDER BY	DATE_FORMAT(b.Date, '%Y-%m-%d');

# Query 2: A hospital administrator wants to retrieve information about a specific
# patient, including their personal details, insurance information, room history, lab
# screening details, and billing history. This comprehensive query will provide a detailed
# overview of the patient's interactions with the hospital. (Retrieve Patient Information
# and Associated Bills)

SELECT p.Patient_ID, p.Patient_FName, p.Patient_LName, p.Gender, p.Phone, i.Policy_Number, i.Ins_Code, i.Plan, 
	i.Co_Pay, i.Coverage, r.Room_ID, r.Room_Type, r.Room_Cost, l.Lab_ID, l.Test_Cost, l.Date AS Lab_Screening_Date, 
    b.Bill_ID, b.Date AS Billing_Date, b.Room_Cost AS Billing_Room_Cost, b.Test_Cost AS Billing_Test_Cost, 
    b.Other_Charges, b.M_Cost, b.Total, b.Remaining_Balance
FROM patient p
JOIN insurance i ON p.Patient_ID = i.Patient_ID
LEFT JOIN room r ON p.Patient_ID = r.Patient_ID
LEFT JOIN lab_screening l ON p.Patient_ID = l.Patient_ID
LEFT JOIN bill b ON p.Patient_ID = b.Patient_ID
WHERE p.Patient_ID = 1;  -- Replace with the desired Patient_ID;

# Query 3: Retrieve Patient Information for those who are currently prescribed with
# Aspirin.

SELECT DISTINCT P.Patient_ID, P.Patient_FName, P.Patient_LName, Pre.Dosage
FROM Patient P
INNER JOIN Prescription Pre ON P.Patient_ID = Pre.Patient_ID
INNER JOIN Medicine M ON Pre.Medicine_ID = M.Medicine_ID
WHERE M.M_Name = 'Aspirin';

# Query 4: Retrieve doctors and their associated department.

SELECT D.Doctor_ID, D.Qualifications, D.Specialization, D.Dept_ID, Dep.Dept_Name
FROM Doctor D
JOIN Department Dep ON D.Dept_ID = Dep.Dept_ID;

# Query 5:  Retrieve total number of appointments for each doctor by date.

SELECT A.Date, A.Doctor_ID, COUNT(*) AS TotalAppointments
FROM Appointment A
GROUP BY A.Date, A.Doctor_ID
ORDER BY A.Date, A.Doctor_ID;

# Query 6:  Retrieve emergency contact details along with patient information.

SELECT EC.Contact_ID, EC.Contact_Name, EC.Phone, EC.Relation, P.Patient_FName, P.Patient_LName
FROM Emergency_Contact EC
JOIN Patient P ON EC.Patient_ID = P.Patient_ID;

# QUERY 7:  Retrieve the names and contact information of patients who have a medical history related to allergies.

SELECT Patient_FName,Patient_LName,Phone
FROM Patient
JOIN Medical_History ON Patient.Patient_ID = Medical_History.Patient_ID
WHERE Medical_History.Allergies IS NOT NULL;

# QUERY 8: Find the total bill amount paid by patients who have insurance coverage.

SELECT Patient_FName, COALESCE(SUM(Bill.Total), 0) AS TotalBillPaid
FROM Patient
LEFT JOIN Bill ON Patient.Patient_ID = Bill.Patient_ID
LEFT JOIN Insurance ON Patient.Patient_ID = Insurance.Patient_ID
GROUP BY Patient.Patient_FName;

# Query 9: Retrieve the prescription details along with patient information.

 SELECT Prescription.Prescription_ID, Prescription.Date, Patient.Patient_ID, Patient.Patient_FName,
		Patient.Patient_LName, Medicine.Medicine_ID, Medicine.M_Name, Prescription.Dosage
FROM Prescription
JOIN Patient ON Prescription.Patient_ID = Patient.Patient_ID
JOIN Medicine ON Prescription.Medicine_ID = Medicine.Medicine_ID;

# Query 10: Calculate the total cost of prescriptions for each patient.

SELECT Patient.Patient_ID, Patient.Patient_FName, Patient.Patient_LName,SUM(Medicine.M_Cost * Prescription.Dosage) AS Total_Prescription_Cost
FROM Patient
JOIN Prescription ON Patient.Patient_ID = Prescription.Patient_ID
JOIN Medicine ON Prescription.Medicine_ID = Medicine.Medicine_ID
GROUP BY Patient.Patient_ID, Patient.Patient_FName, Patient.Patient_LName;

# Query 11: Retrieve the information of the patients who have an outstanding bill
# balance to notify them.

SELECT distinct pt.Patient_ID, pt.Patient_FName, pt.Patient_LName, pt.phone, pt.email, bill.Remaining_Balance
FROM patient pt 
JOIN appointment apt ON pt.patient_id = apt.Patient_ID
JOIN bill ON bill.Patient_ID = pt.patient_id
WHERE bill.Remaining_Balance > 0;

#Query 12:  Retrieve the phone number of the male patients who are O+ and are free
# from allergies for future blood donation.

SELECT pt.Patient_ID, pt.Patient_FName, pt.Patient_LName, pt.phone 
FROM patient pt 
JOIN medical_history mh ON pt.Patient_ID = mh.Patient_ID
WHERE Gender ='Male'
AND allergies = 'None'
AND Blood_Type = 'O+';

 
