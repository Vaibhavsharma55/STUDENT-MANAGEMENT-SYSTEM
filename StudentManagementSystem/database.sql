-- ================================================================
-- Student Management System Database Schema & Initial Data
-- Compatible with MySQL 8.0+ / MariaDB 10.4+
-- ================================================================

CREATE DATABASE IF NOT EXISTS sms_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE sms_db;

-- ----------------------------------------------------------------
-- 1. Table: admins
-- ----------------------------------------------------------------
DROP TABLE IF EXISTS marks;
DROP TABLE IF EXISTS attendance;
DROP TABLE IF EXISTS students;
DROP TABLE IF EXISTS courses;
DROP TABLE IF EXISTS admins;

CREATE TABLE admins (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------------------------------------------
-- 2. Table: courses
-- ----------------------------------------------------------------
CREATE TABLE courses (
    id INT AUTO_INCREMENT PRIMARY KEY,
    course_code VARCHAR(20) NOT NULL UNIQUE,
    course_name VARCHAR(100) NOT NULL,
    total_semesters INT NOT NULL DEFAULT 8,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------------------------------------------
-- 3. Table: students
-- ----------------------------------------------------------------
CREATE TABLE students (
    id INT AUTO_INCREMENT PRIMARY KEY,
    roll_no VARCHAR(30) NOT NULL UNIQUE,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(20) NOT NULL,
    gender VARCHAR(10) NOT NULL,
    dob DATE NOT NULL,
    course_id INT NOT NULL,
    current_semester INT NOT NULL DEFAULT 1,
    address TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_student_course FOREIGN KEY (course_id) 
        REFERENCES courses(id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------------------------------------------
-- 4. Table: attendance
-- ----------------------------------------------------------------
CREATE TABLE attendance (
    id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    attendance_date DATE NOT NULL,
    status ENUM('Present', 'Absent', 'Late', 'Excused') NOT NULL DEFAULT 'Present',
    remarks VARCHAR(255) DEFAULT '',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_attendance_student FOREIGN KEY (student_id) 
        REFERENCES students(id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT uq_student_date UNIQUE (student_id, attendance_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------------------------------------------
-- 5. Table: marks
-- ----------------------------------------------------------------
CREATE TABLE marks (
    id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    semester INT NOT NULL,
    subject_name VARCHAR(100) NOT NULL,
    marks_obtained DECIMAL(5,2) NOT NULL,
    max_marks DECIMAL(5,2) NOT NULL DEFAULT 100.00,
    exam_type VARCHAR(50) NOT NULL DEFAULT 'Semester Exam',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_marks_student FOREIGN KEY (student_id) 
        REFERENCES students(id) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------------------------------------------
-- SEED DATA
-- ----------------------------------------------------------------

-- Admin Account: username = admin, password = admin123
INSERT INTO admins (username, password, full_name, email) VALUES
('admin', '$2a$10$FuUbb0DG4qfycILor7qezuxysvRdnOyjeC3Iio3ExThKUH4D0L4qi', 'System Administrator', 'admin@sms.edu');

-- Courses
INSERT INTO courses (course_code, course_name, total_semesters, description) VALUES
('CSE', 'B.Tech Computer Science & Engineering', 8, 'Four-year undergraduate degree focusing on software development, algorithms, AI, and systems programming.'),
('IT', 'B.Tech Information Technology', 8, 'Comprehensive program covering web applications, cloud infrastructure, networking, and cybersecurity.'),
('ECE', 'B.Tech Electronics & Communication Engineering', 8, 'Study of microprocessors, signal processing, IoT embedded systems, and telecommunications.'),
('ME', 'B.Tech Mechanical Engineering', 8, 'Focuses on thermodynamics, mechanics, robotics, manufacturing systems, and CAD/CAM.'),
('BCA', 'Bachelor of Computer Applications', 6, 'Three-year undergraduate program covering core database management, software development, and web technologies.');

-- Students
INSERT INTO students (roll_no, first_name, last_name, email, phone, gender, dob, course_id, current_semester, address) VALUES
('CS202401', 'Aarav', 'Sharma', 'aarav.sharma@example.com', '9876543210', 'Male', '2004-05-15', 1, 4, '124 MG Road, Bengaluru, Karnataka'),
('CS202402', 'Diya', 'Patel', 'diya.patel@example.com', '9876543211', 'Female', '2004-08-22', 1, 4, '45 Park Avenue, Ahmedabad, Gujarat'),
('CS202403', 'Rohan', 'Verma', 'rohan.verma@example.com', '9876543212', 'Male', '2003-11-10', 1, 6, '78 Civil Lines, Jaipur, Rajasthan'),
('IT202401', 'Ananya', 'Iyer', 'ananya.iyer@example.com', '9876543213', 'Female', '2004-01-30', 2, 3, '12 TTK Road, Chennai, Tamil Nadu'),
('IT202402', 'Kabir', 'Singh', 'kabir.singh@example.com', '9876543214', 'Male', '2003-09-18', 2, 5, '89 Model Town, Delhi'),
('EC202401', 'Sneha', 'Mukherjee', 'sneha.m@example.com', '9876543215', 'Female', '2004-03-25', 3, 2, '34 Salt Lake, Kolkata, West Bengal'),
('ME202401', 'Vikram', 'Rathore', 'vikram.r@example.com', '9876543216', 'Male', '2003-07-14', 4, 4, '56 Station Road, Pune, Maharashtra');

-- Attendance records
INSERT INTO attendance (student_id, attendance_date, status, remarks) VALUES
(1, '2026-10-15', 'Present', 'Attended all lectures'),
(1, '2026-10-16', 'Present', 'On time'),
(1, '2026-10-17', 'Present', 'Lab completed'),
(1, '2026-10-18', 'Absent', 'Medical leave'),
(1, '2026-10-19', 'Present', 'Regular'),
(1, '2026-10-20', 'Present', 'Active in class'),

(2, '2026-10-15', 'Present', 'On time'),
(2, '2026-10-16', 'Present', 'On time'),
(2, '2026-10-17', 'Present', 'Lab completed'),
(2, '2026-10-18', 'Present', 'On time'),
(2, '2026-10-19', 'Present', 'On time'),
(2, '2026-10-20', 'Present', 'On time'),

(3, '2026-10-15', 'Present', 'On time'),
(3, '2026-10-16', 'Late', '15 mins late'),
(3, '2026-10-17', 'Absent', 'No notice'),
(3, '2026-10-18', 'Present', 'On time'),
(3, '2026-10-19', 'Present', 'On time'),
(3, '2026-10-20', 'Present', 'On time'),

(4, '2026-10-18', 'Present', 'Regular'),
(4, '2026-10-19', 'Present', 'Regular'),
(4, '2026-10-20', 'Present', 'Regular'),

(5, '2026-10-18', 'Present', 'Regular'),
(5, '2026-10-19', 'Absent', 'Family emergency'),
(5, '2026-10-20', 'Present', 'Regular');

-- Marks records
INSERT INTO marks (student_id, semester, subject_name, marks_obtained, max_marks, exam_type) VALUES
-- Aarav Sharma (Semester 4)
(1, 4, 'Data Structures & Algorithms', 88.50, 100.00, 'Semester Exam'),
(1, 4, 'Database Management Systems', 92.00, 100.00, 'Semester Exam'),
(1, 4, 'Operating Systems', 81.00, 100.00, 'Semester Exam'),
(1, 4, 'Computer Networks', 79.50, 100.00, 'Semester Exam'),
(1, 4, 'Java Enterprise Programming', 95.00, 100.00, 'Practical & Theory'),

-- Diya Patel (Semester 4)
(2, 4, 'Data Structures & Algorithms', 94.00, 100.00, 'Semester Exam'),
(2, 4, 'Database Management Systems', 96.50, 100.00, 'Semester Exam'),
(2, 4, 'Operating Systems', 89.00, 100.00, 'Semester Exam'),
(2, 4, 'Computer Networks', 91.00, 100.00, 'Semester Exam'),
(2, 4, 'Java Enterprise Programming', 98.00, 100.00, 'Practical & Theory'),

-- Rohan Verma (Semester 6)
(3, 6, 'Compiler Design', 74.00, 100.00, 'Semester Exam'),
(3, 6, 'Cloud Computing', 82.50, 100.00, 'Semester Exam'),
(3, 6, 'Information Security', 68.00, 100.00, 'Semester Exam'),
(3, 6, 'Software Engineering', 85.00, 100.00, 'Semester Exam'),

-- Ananya Iyer (Semester 3)
(4, 3, 'Object Oriented Programming', 86.00, 100.00, 'Semester Exam'),
(4, 3, 'Discrete Mathematics', 78.00, 100.00, 'Semester Exam'),
(4, 3, 'Computer Architecture', 80.50, 100.00, 'Semester Exam');
