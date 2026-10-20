# 🎓 Student Management System (SMS)

A complete, beginner-friendly **Student Management System** built with **Java (Jakarta EE 11 / Servlet 6.1)**, **JSP**, **JDBC**, **MySQL**, **HTML5**, **Bootstrap 5.3**, and **Apache Tomcat 11**.

Designed following the industry-standard **MVC Architecture** with distinct Model, View, Controller, Service, and DAO layers.

---

## 🌟 Features Implemented

1. **Admin Authentication & Session Protection**:
   - Secure login and logout system.
   - Passwords hashed using industry-standard **BCrypt**.
   - `AuthFilter` protects all admin pages and prevents unauthorized access.
   - Automatic session expiration and CSRF/encoding handling.
2. **Interactive Dashboard**:
   - High-contrast, modern blue-and-white dashboard cards.
   - Live metrics: Total Students, Total Courses, Today's Attendance count & rate, and Average Exam Scores.
   - Quick action shortcuts and recently registered students list.
3. **Student Management (CRUD & Search)**:
   - Add new students with comprehensive personal, contact, and academic details.
   - View complete student profile with attendance rates and subject marks.
   - Edit student details with validation.
   - Delete students (with automatic cascade for associated marks and attendance).
   - Search students dynamically by Roll Number, Name, or Email, with filters for Course and Semester.
4. **Courses & Semester Management**:
   - Manage academic programs (e.g., B.Tech CSE, IT, ECE, ME, BCA).
   - Configure total semesters and department descriptions.
   - Integrity checks to prevent deleting courses that have enrolled students.
5. **Student Attendance Register**:
   - Batch class attendance marking sheet with 1-click **"All Present"** and **"All Absent"** buttons.
   - Attendance statuses: `Present`, `Absent`, `Late`, `Excused` with remarks.
   - Daily attendance history log with date, course, and semester filters.
   - Automated attendance percentage calculation per student.
6. **Marks & Academic Evaluations**:
   - Enter marks for examinations (Semester Exam, Mid-Term, Practical & Theory, Quizzes).
   - Real-time client-side percentage calculator badge.
   - Automated percentage computation and letter grade assignment (`A+`, `A`, `B`, `C`, `D`, `E`, `F`).
   - Edit, delete, and filter marks records.
7. **Student Academic Reports**:
   - **Printable Student Report Card / Transcript**:
     - Official university/institution header.
     - Student profile and enrollment details.
     - Working attendance summary with total days, present days, and attendance rate %.
     - Subject-wise transcript with max marks, scored marks, percentage, and grade.
     - Aggregate totals, overall percentage, and performance division standing (`Distinction`, `First Division`, etc.).
     - Signature blocks for Class Coordinator, HOD, and Controller of Examinations.
     - Built-in `@media print` CSS rules so pressing **"Print / Save PDF"** outputs a clean report without navbars or footers.
   - **Class Summary Performance Report**:
     - Overview comparing all students in a semester with attendance and marks averages.

---

## 🏗️ Architecture & Project Structure

The project strictly follows the **5-Layer MVC Architecture**:

```
Client (Browser)
     │
     ▼
[Controller Layer] (Servlets & AuthFilter)
     │
     ▼
[Service Layer] (Business Validations, Percentage & Grade Calculations)
     │
     ▼
[DAO Layer] (JDBC Data Access with PreparedStatement)
     │
     ▼
[MySQL Database] (sms_db)
     │
     ▲
[View Layer] (JSP, JSTL 3.0, Bootstrap 5.3, Custom CSS)
```

### Directory Structure

```
StudentManagementSystem/
├── database.sql                  <- Complete SQL schema and seed data
├── pom.xml                       <- Maven dependencies & compiler setup
├── README.md                     <- Setup and documentation
├── run.bat                       <- Double-click launcher for Windows
└── src/
    └── main/
        ├── java/com/sms/
        │   ├── config/
        │   │   └── DBConnection.java        <- JDBC connection provider
        │   ├── model/
        │   │   ├── Admin.java               <- Admin bean
        │   │   ├── Course.java              <- Course bean
        │   │   ├── Student.java             <- Student bean
        │   │   ├── Attendance.java          <- Attendance bean
        │   │   ├── Marks.java               <- Marks bean
        │   │   └── StudentReport.java       <- Consolidated Report DTO
        │   ├── dao/
        │   │   ├── AdminDAO.java            <- Admin database operations
        │   │   ├── CourseDAO.java           <- Course database operations
        │   │   ├── StudentDAO.java          <- Student database operations
        │   │   ├── AttendanceDAO.java       <- Attendance database operations
        │   │   └── MarksDAO.java            <- Marks database operations
        │   ├── service/
        │   │   ├── AdminService.java        <- Authentication logic
        │   │   ├── CourseService.java       <- Course business logic
        │   │   ├── StudentService.java      <- Student business logic
        │   │   ├── AttendanceService.java   <- Attendance aggregations
        │   │   ├── MarksService.java        <- Grade & score calculations
        │   │   └── ReportService.java       <- Consolidated report generator
        │   ├── controller/
        │   │   ├── LoginServlet.java        <- /login
        │   │   ├── LogoutServlet.java       <- /logout
        │   │   ├── DashboardServlet.java    <- /dashboard
        │   │   ├── StudentServlet.java      <- /students
        │   │   ├── CourseServlet.java       <- /courses
        │   │   ├── AttendanceServlet.java   <- /attendance
        │   │   ├── MarksServlet.java        <- /marks
        │   │   └── ReportServlet.java       <- /reports
        │   ├── filter/
        │   │   └── AuthFilter.java          <- Session protection filter
        │   └── util/
        │       └── PasswordUtil.java        <- BCrypt password hasher
        ├── resources/
        │   └── db.properties                <- Database connection properties
        └── webapp/
            ├── index.jsp                    <- Redirects to dashboard/login
            ├── css/
            │   └── custom.css               <- Blue & white theme + print styles
            ├── js/
            │   └── main.js                  <- Interactive JS helpers
            └── WEB-INF/
                ├── web.xml                  <- Deployment descriptor (Servlet 6.0)
                └── views/
                    ├── common/
                    │   ├── header.jsp       <- Reusable HTML header
                    │   ├── navbar.jsp       <- Reusable top navigation & alerts
                    │   └── footer.jsp       <- Reusable footer & JS scripts
                    ├── student/
                    │   ├── list.jsp         <- Directory & search
                    │   ├── form.jsp         <- Add / Edit student form
                    │   └── view.jsp         <- Student detailed profile
                    ├── course/
                    │   ├── list.jsp         <- Programs list
                    │   └── form.jsp         <- Add / Edit course form
                    ├── attendance/
                    │   ├── list.jsp         <- Daily attendance register
                    │   └── record.jsp       <- Interactive batch recording sheet
                    ├── marks/
                    │   ├── list.jsp         <- Recorded marks list
                    │   └── form.jsp         <- Subject marks entry form
                    ├── report/
                    │   ├── student-report.jsp <- Official printable report card
                    │   └── class-report.jsp   <- Class comparison overview
                    ├── dashboard.jsp        <- Admin home dashboard
                    ├── login.jsp            <- Admin login screen
                    └── error.jsp            <- Graceful error display page
```

---

## ⚙️ Prerequisites

1. **Java Development Kit (JDK)**: JDK 17, 21, or 24.
2. **Apache Tomcat**: Version 11.0.x (Jakarta EE 11 / Servlet 6.1 compatible).
3. **MySQL Server / MariaDB**: Version 8.0+ or MariaDB 10.4+.
4. **Apache Maven**: Version 3.8+ or 3.9+.

---

## 🚀 Quick Setup & Installation

### Step 1: Set Up MySQL Database

1. Open MySQL Command Line, MySQL Workbench, or phpMyAdmin.
2. Execute the included `database.sql` script:
   ```bash
   mysql -u root -p < database.sql
   ```
   *(Or copy and paste the contents of `database.sql` into your SQL console and click Execute).*

3. Verify database configuration in `src/main/resources/db.properties`:
   ```properties
   db.driver=com.mysql.cj.jdbc.Driver
   db.url=jdbc:mysql://localhost:3306/sms_db?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC&characterEncoding=UTF-8
   db.user=root
   db.password=root
   ```
   *Note: If your MySQL `root` user has a blank/empty password or a different password, adjust `db.password` accordingly. The system automatically attempts empty password fallback if `root` authentication fails.*

---

### Step 2: Build the Application using Maven

Open your terminal or command prompt in the `StudentManagementSystem` directory:

```bash
mvn clean package
```

This compiles all Java classes and creates `target/sms.war`.

---

### Step 3: Deploy to Apache Tomcat 11

#### Option A: 1-Click Launch (Windows)
Double-click `run.bat` inside the `StudentManagementSystem` folder. It will build the WAR, copy it to Tomcat, start Tomcat, and launch your browser!

#### Option B: Manual Tomcat Deployment
1. Copy `target/sms.war` into your Tomcat `webapps` directory:
   ```bash
   copy target\sms.war "C:\path\to\apache-tomcat-11.0.x\webapps\sms.war"
   ```
2. Start Tomcat by executing `bin/startup.bat` (Windows) or `bin/catalina.sh run` (Linux/Mac).
3. Open your browser and navigate to:
   ```
   http://localhost:8080/sms/
   ```

---

## 🔑 Default Admin Credentials

| Field | Value |
|---|---|
| **Username** | `admin` |
| **Password** | `admin123` |
| **Role** | System Administrator |

---

## 📋 Viva & Academic Presentation Q&A Guide

**Q: Why do we use Jakarta packages instead of javax?**
> Tomcat 10 and 11 implement Jakarta EE 10/11 specifications, where the package namespace shifted from `javax.servlet` to `jakarta.servlet`. Our application uses Servlet 6.1 and Jakarta JSTL 3.0 (`jakarta.tags.core`), making it 100% compatible with modern Tomcat 11.

**Q: How is SQL Injection prevented?**
> Every database operation across all DAOs (`StudentDAO`, `MarksDAO`, `AttendanceDAO`, `AdminDAO`, `CourseDAO`) uses JDBC `PreparedStatement` with parameterized placeholders (`?`). User inputs are never concatenated directly into SQL query strings.

**Q: How is password security handled?**
> Passwords are encrypted using BCrypt (`jBCrypt`) with a salt cost factor of 10. BCrypt includes a unique salt in each hash and protects against rainbow table and brute-force attacks.

**Q: How does the Service layer benefit this project?**
> The Service layer isolates business logic (e.g. validating marks boundaries, preventing deletion of courses with enrolled students, aggregating attendance rates, and calculating percentage grades) from the Controller (which handles HTTP requests) and the DAO (which handles SQL execution).

---

## 📜 License
This project is open-source and free for academic and educational use.
