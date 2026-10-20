package com.sms.model;

import java.sql.Date;
import java.sql.Timestamp;

/**
 * Attendance model representing a daily attendance record.
 */
public class Attendance {
    private int id;
    private int studentId;
    private Date attendanceDate;
    private String status; // Present, Absent, Late, Excused
    private String remarks;
    private Timestamp createdAt;

    // Display fields from Student join
    private String studentRollNo;
    private String studentName;
    private String courseCode;

    public Attendance() {
    }

    public Attendance(int id, int studentId, Date attendanceDate, String status, String remarks, Timestamp createdAt) {
        this.id = id;
        this.studentId = studentId;
        this.attendanceDate = attendanceDate;
        this.status = status;
        this.remarks = remarks;
        this.createdAt = createdAt;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getStudentId() {
        return studentId;
    }

    public void setStudentId(int studentId) {
        this.studentId = studentId;
    }

    public Date getAttendanceDate() {
        return attendanceDate;
    }

    public void setAttendanceDate(Date attendanceDate) {
        this.attendanceDate = attendanceDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public String getStudentRollNo() {
        return studentRollNo;
    }

    public void setStudentRollNo(String studentRollNo) {
        this.studentRollNo = studentRollNo;
    }

    public String getStudentName() {
        return studentName;
    }

    public void setStudentName(String studentName) {
        this.studentName = studentName;
    }

    public String getCourseCode() {
        return courseCode;
    }

    public void setCourseCode(String courseCode) {
        this.courseCode = courseCode;
    }
}
