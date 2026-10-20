# 🎓 Student Management System & Advanced Java Suite

[![Java](https://img.shields.io/badge/Java-Jakarta%20EE%2011%20%7C%20JDK%2017%2B-ED8B00?style=for-the-badge&logo=openjdk&logoColor=white)](https://www.oracle.com/java/)
[![Tomcat](https://img.shields.io/badge/Apache%20Tomcat-11.0.x-F8DC75?style=for-the-badge&logo=apache-tomcat&logoColor=black)](https://tomcat.apache.org/)
[![MySQL](https://img.shields.io/badge/MySQL-8.0%2B-4479A1?style=for-the-badge&logo=mysql&logoColor=white)](https://www.mysql.com/)
[![Bootstrap](https://img.shields.io/badge/Bootstrap-5.3-7952B3?style=for-the-badge&logo=bootstrap&logoColor=white)](https://getbootstrap.com/)
[![Architecture](https://img.shields.io/badge/Architecture-MVC%205--Layer-00599C?style=for-the-badge)](https://en.wikipedia.org/wiki/Model%E2%80%93view%E2%80%93controller)
[![License](https://img.shields.io/badge/License-MIT%20%2F%20Academic-green?style=for-the-badge)](LICENSE)

A production-grade, enterprise-ready **Student Management System (SMS)** web application accompanied by a comprehensive suite of **Advanced Java Practical Implementations** covering MVC architecture, Swing GUI desktop applications, TCP socket networking, JDBC database connectivity, and Remote Method Invocation (RMI).

---

## 📑 Table of Contents

- [Overview](#-overview)
- [Project Structure](#-project-structure)
- [Flagship Application: Student Management System (SMS)](#-flagship-application-student-management-system-sms)
  - [Key Features](#-key-features)
  - [Architecture (5-Layer MVC)](#-architecture-5-layer-mvc)
  - [Database Schema](#-database-schema)
  - [Default Admin Credentials](#-default-admin-credentials)
- [Advanced Java Practical Modules](#-advanced-java-practical-modules)
  - [1. Student Registration Form (Swing GUI)](#1--student-registration-form-swing-gui)
  - [2. MVC Calculator (Java Swing)](#2--mvc-calculator-java-swing)
  - [3. JDBC Database Connectivity](#3--jdbc-database-connectivity)
  - [4. TCP Client-Server Socket Communication](#4--tcp-client-server-socket-communication)
  - [5. Remote Method Invocation (RMI)](#5--remote-method-invocation-rmi)
- [Prerequisites & System Requirements](#-prerequisites--system-requirements)
- [Step-by-Step Setup & Execution](#-step-by-step-setup--execution)
  - [Setting Up Student Management System](#setting-up-student-management-system)
  - [Running the Advanced Java Modules](#running-the-advanced-java-modules)
- [Security & Engineering Best Practices](#-security--engineering-best-practices)
- [Author & Contribution](#-author--contribution)

---

## 🌟 Overview

This repository is designed as a complete masterclass in Java development, bridging the gap between foundational computer science concepts and full-stack web applications:

1. **Student Management System (SMS)**: A complete web portal for educational institutions that enables administrators to oversee student enrollments, academic courses, daily attendance registers, examination grades, and printable academic transcripts.
2. **Advanced Java Modules**: Focused practical implementations demonstrating core enterprise programming patterns, including distributed computing (RMI), client-server TCP networking, GUI event handling, and database interaction.

---

## 📁 Project Structure

```
STUDENT-MANAGEMENT-SYSTEM/
├── README.md                      # Complete repository overview and documentation
├── .gitignore                     # Git ignore rules for Maven, IDEs, and bytecode
│
├── StudentManagementSystem/       # 🎓 Flagship Enterprise Web Application
│   ├── pom.xml                    # Maven project configuration & dependencies
│   ├── database.sql               # MySQL database schema and initial seed data
│   ├── run.bat                    # Double-click launcher for Windows
│   ├── README.md                  # Dedicated SMS setup & presentation guide
│   └── src/
│       └── main/
│           ├── java/com/sms/
│           │   ├── config/        # DBConnection provider (Hikari/JDBC)
│           │   ├── controller/    # Jakarta EE Servlets (/students, /attendance, /marks, etc.)
│           │   ├── dao/           # Data Access Objects (CRUD with PreparedStatement)
│           │   ├── filter/        # AuthFilter (Session authentication & protection)
│           │   ├── model/         # JavaBeans / Data Transfer Objects
│           │   ├── service/       # Business logic, grade computations, and validations
│           │   └── util/          # PasswordUtil (BCrypt password encryption)
│           ├── resources/
│           │   └── db.properties  # Database connection properties
│           └── webapp/
│               ├── css/           # Modern custom stylesheet with @media print support
│               ├── js/            # Client-side validation & UI enhancement scripts
│               ├── index.jsp      # Application entry redirection
│               └── WEB-INF/
│                   ├── web.xml    # Servlet 6.0 deployment descriptor
│                   └── views/     # Modular JSP templates (dashboard, students, reports)
│
├── StudentRegistrationForm/       # 📝 Swing GUI Registration Application
│   ├── StudentRegistration.java   # Complete GUI form with validations and dialogs
│   └── README.md                  # Module guide
│
├── Calculator/                    # 🧮 MVC-Pattern Swing Desktop Calculator
│   ├── CalculatorModel.java       # Arithmetic and business logic
│   ├── CalculatorView.java        # Swing interface with buttons and display
│   ├── CalculatorController.java  # Event listener orchestrating View ↔ Model
│   ├── Main.java                  # Entry point for MVC Calculator
│   └── Readme.md                  # Module guide
│
├── JDBC/                          # 🗄️ Database Connectivity Reference
│   ├── JdbcDemo.java              # Direct MySQL connection, PreparedStatement insertion & queries
│   ├── App.java                   # Supporting entry point
│   └── Readme.md                  # Module guide
│
├── clientServer/                  # 🌐 TCP Socket Programming
│   ├── server.java                # Multi-stream ServerSocket implementation
│   ├── client.java                # Socket client connector
│   └── README.md                  # Module guide
│
└── RMI/                           # 📡 Remote Method Invocation
    ├── calculator.java            # Remote interface
    ├── calculatorImpl.java        # UnicastRemoteObject implementation
    ├── server.java                # RMI Registry binder
    ├── client.java                # Remote client lookup and invocation
    └── Readme.md                  # Module guide
```

---

## 🎓 Flagship Application: Student Management System (SMS)

The **Student Management System** is built on **Jakarta EE 11 / Servlet 6.1**, **JSP**, **JSTL 3.0**, **Bootstrap 5.3**, and **MySQL**, designed to run on **Apache Tomcat 11**.

### 🚀 Key Features

| Module | Features & Capabilities |
|---|---|
| **🔐 Admin Authentication** | Secure login/logout system; passwords hashed with **BCrypt** (salt cost factor 10); `AuthFilter` protects all admin routes against unauthorized direct URL access. |
| **📊 Dashboard Analytics** | High-contrast statistics cards displaying total active students, academic courses, daily attendance rate %, and institution examination averages; quick registration shortcuts. |
| **👥 Student Management** | Full CRUD capabilities; comprehensive personal and academic records; live search by Roll Number, Name, or Email; filtering by Course and Semester; cascading profile view. |
| **📚 Course & Department** | Manage academic programs (e.g., B.Tech CSE, IT, ECE, BCA); configure total semesters; built-in referential integrity protection prevents deleting courses with enrolled students. |
| **📅 Attendance Register** | Class-wide batch attendance sheet; 1-click **"Mark All Present"** and **"Mark All Absent"** utilities; daily log history; automated calculation of per-student attendance percentage. |
| **📝 Marks & Evaluation** | Grade entry across exams (Mid-Term, End-Semester, Theory, Practical); dynamic real-time percentage badge; automatic letter grade assignment (`A+`, `A`, `B`, `C`, `D`, `E`, `F`). |
| **📜 Printable Transcripts** | Official printable student report cards featuring institutional headers, complete course transcript, attendance summary, final division ranking, and official signature blocks with `@media print` styling. |
| **📈 Class Performance** | Aggregated class-wide report showing batch attendance and score distribution for coordinator review. |

---

### 🏗️ Architecture (5-Layer MVC)

```
                       Browser (Client)
                              │
                              ▼
        ┌───────────────────────────────────────────┐
        │       Controller Layer (Servlets)         │
        │   DashboardServlet, StudentServlet, etc.  │
        └─────────────────────┬─────────────────────┘
                              │
                              ▼
        ┌───────────────────────────────────────────┐
        │               Service Layer               │
        │   Business rules, grades, validations     │
        └─────────────────────┬─────────────────────┘
                              │
                              ▼
        ┌───────────────────────────────────────────┐
        │            DAO (Data Access Layer)        │
        │     PreparedStatement JDBC executions     │
        └─────────────────────┬─────────────────────┘
                              │
                              ▼
        ┌───────────────────────────────────────────┐
        │             MySQL Database                │
        │      (sms_db relational schema)           │
        └───────────────────────────────────────────┘
```

---

### 🗄️ Database Schema

The system utilizes an optimized relational schema in `sms_db`:

- **`admins`**: Administrator credentials, BCrypt hashes, and full names.
- **`courses`**: Course codes, names, semester counts, and departments.
- **`students`**: Personal details, roll numbers, contact info, branch, and current semester.
- **`attendance`**: Daily attendance records (`Present`, `Absent`, `Late`, `Excused`) linked to student and date.
- **`marks`**: Exam marks by subject and exam type with maximum marks, scored marks, and computed grade.

---

### 🔑 Default Admin Credentials

| Field | Credential |
|---|---|
| **Username** | `admin` |
| **Password** | `admin123` |
| **Role** | System Administrator |

---

## 📦 Advanced Java Practical Modules

### 1. 📝 Student Registration Form (Swing GUI)
- **Path:** `StudentRegistrationForm/`
- **Description:** A standalone desktop registration application with a graphical interface built using Java Swing.
- **Highlights:** Text fields, Radio button gender groups, Terms & Conditions checkbox, event-driven submit and clear buttons with `JOptionPane` error handling and summary dialogs.

### 2. 🧮 MVC Calculator (Java Swing)
- **Path:** `Calculator/`
- **Description:** A desktop calculator that strictly implements the **Model-View-Controller (MVC)** architectural pattern.
- **Structure:**
  - `CalculatorModel.java`: Encapsulates mathematical calculations.
  - `CalculatorView.java`: Renders Swing buttons and displays.
  - `CalculatorController.java`: Bridges user interactions to the model and updates the view.

### 3. 🗄️ JDBC Database Connectivity
- **Path:** `JDBC/`
- **Description:** Practical implementation of database interaction using the JDBC API with MySQL.
- **Highlights:** Secure queries with `PreparedStatement`, automated table record insertion, and processing database rows via `ResultSet`.

### 4. 🌐 TCP Client-Server Socket Communication
- **Path:** `clientServer/`
- **Description:** Network communication implementation demonstrating point-to-point TCP sockets.
- **Highlights:** Uses `ServerSocket` and `Socket` with `BufferedReader` and `PrintWriter` for bidirectional client-server message exchange over localhost port 5000.

### 5. 📡 Remote Method Invocation (RMI)
- **Path:** `RMI/`
- **Description:** Distributed computing application demonstrating Java RMI.
- **Highlights:** Remote interfaces extending `java.rmi.Remote`, implementation using `UnicastRemoteObject`, RMI registry binding with `Naming.rebind()`, and remote invocation from a client process.

---

## ⚙️ Prerequisites & System Requirements

| Tool | Recommended Version | Purpose |
|---|---|---|
| **Java JDK** | JDK 17, 21, or 24 | Application compilation & runtime |
| **Apache Tomcat** | Version 11.0.x | Web container for Jakarta EE 11 / Servlet 6.1 |
| **MySQL Server** | Version 8.0 or higher | Relational database backend |
| **Apache Maven** | Version 3.8+ or 3.9+ | Build and dependency lifecycle management |
| **IDE** | VS Code / IntelliJ IDEA / Eclipse | Development and debugging |

---

## 🚀 Step-by-Step Setup & Execution

### Setting Up Student Management System

#### Step 1: Initialize Database
Open your MySQL client (Workbench, CLI, or phpMyAdmin) and run:
```bash
mysql -u root -p < StudentManagementSystem/database.sql
```

#### Step 2: Configure Database Credentials
Verify database settings in `StudentManagementSystem/src/main/resources/db.properties`:
```properties
db.driver=com.mysql.cj.jdbc.Driver
db.url=jdbc:mysql://localhost:3306/sms_db?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC&characterEncoding=UTF-8
db.user=root
db.password=root
```
*(Adjust the password to match your local MySQL configuration).*

#### Step 3: Package the WAR File
Open your terminal inside the `StudentManagementSystem` directory:
```bash
cd StudentManagementSystem
mvn clean package
```
This produces `target/sms.war`.

#### Step 4: Deploy & Launch
- **Windows 1-Click Launch:** Double-click `run.bat` inside `StudentManagementSystem/`.
- **Manual Deployment:** Copy `target/sms.war` into your Tomcat `webapps/` folder and execute `startup.bat` or `catalina.sh run`.
- Navigate to: **`http://localhost:8080/sms/`**

---

### Running the Advanced Java Modules

#### 🧮 Calculator (MVC)
```bash
cd Calculator
javac *.java
java Main
```

#### 📝 Student Registration Form
```bash
cd StudentRegistrationForm
javac StudentRegistration.java
java StudentRegistration
```

#### 🌐 Client-Server Sockets
```bash
# Terminal 1: Run Server
cd clientServer
javac server.java
java server

# Terminal 2: Run Client
cd clientServer
javac client.java
java client
```

#### 🗄️ JDBC Demo
```bash
cd JDBC
javac JdbcDemo.java
java -cp ".;mysql-connector-java.jar" JdbcDemo
```

#### 📡 RMI (Remote Method Invocation)
```bash
cd RMI
javac *.java
rmiregistry &
java RMI.server
# In a second terminal:
java RMI.client
```

---

## 🛡️ Security & Engineering Best Practices

- **SQL Injection Prevention:** Every query in the DAO layer strictly uses parameterized `PreparedStatement` placeholders (`?`). No raw user input is ever concatenated into SQL commands.
- **Password Protection:** Admin passwords use `jBCrypt` with high-work-factor salt generation, preventing rainbow table attacks.
- **Session Control & Security Filters:** The `AuthFilter` intercepts every incoming HTTP request, ensuring unauthenticated sessions cannot reach administrative views or perform mutations.
- **Clean Code Architecture:** Clean separation between View (JSP), Controller (Servlets), Business Logic (Service layer), and Persistence (DAO layer).

---

## 👨‍💻 Author & Repository

- **Author:** [Vaibhav Sharma](https://github.com/Vaibhavsharma55)
- **GitHub Repository:** [Vaibhavsharma55/STUDENT-MANAGEMENT-SYSTEM](https://github.com/Vaibhavsharma55/STUDENT-MANAGEMENT-SYSTEM)

---

## 📄 License

This repository is distributed under the **MIT License** and is open for academic, educational, and developer reference.
