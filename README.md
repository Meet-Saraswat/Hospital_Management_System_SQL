# Hospital_Management_System_SQL
A relational database project designed to manage hospital operations, built using MySQL as a part of project for the course Database Management System.

## 📌 Project Overview

The project involves the end-to-end design of a database for a hospital setting — from conceptual modeling and entity relationships to schema creation, normalization, and SQL implementation. The system focuses on:
- Appointment scheduling
- Patient records and billing
- Staff assignments
- Lab screenings, medical history, and prescriptions

## 📁 Project Components

### 🔸 1. Conceptual Design

- **EER Diagram** with detailed assumptions
- **Crow Foot Notation** for depicting entity relationships clearly

### 🔸 2. Logical Design

- **Relational Schema** showing foreign/primary key relationships
- Data formats for each table
- Schema includes:
  - `Patient`, `Doctor`, `Staff`, `Nurse`, `Appointment`, `Room`
  - `Medicine`, `Prescription`, `Medical_History`, `Emergency_Contact`
  - `Insurance`, `Bill`, `Payroll`, `Department`, `Lab_Screening`

### 🔸 3. Normalization (Up to 3NF)

Tables have been validated through:
- 1NF: Atomic attributes
- 2NF: Full functional dependency
- 3NF: Removal of transitive dependencies

> Includes detailed functional dependency mappings and explanations for each table.



## 🛠️ Technologies Used
- MySQL
- SQL
- ER Modeling
- Relational Database Design

## 📊 Features
- Patient management
- Staff & Department tracking
- Appointments & Billing
- Lab tests & Prescription management
- Insurance and medical history tracking
