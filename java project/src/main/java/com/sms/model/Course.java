package com.sms.model;

import java.sql.Timestamp;

/**
 * Course model representing an academic program (e.g. B.Tech CSE).
 */
public class Course {
    private int id;
    private String courseCode;
    private String courseName;
    private int totalSemesters;
    private String description;
    private Timestamp createdAt;

    public Course() {
    }

    public Course(int id, String courseCode, String courseName, int totalSemesters, String description) {
        this.id = id;
        this.courseCode = courseCode;
        this.courseName = courseName;
        this.totalSemesters = totalSemesters;
        this.description = description;
    }

    public Course(int id, String courseCode, String courseName, int totalSemesters, String description, Timestamp createdAt) {
        this.id = id;
        this.courseCode = courseCode;
        this.courseName = courseName;
        this.totalSemesters = totalSemesters;
        this.description = description;
        this.createdAt = createdAt;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getCourseCode() {
        return courseCode;
    }

    public void setCourseCode(String courseCode) {
        this.courseCode = courseCode;
    }

    public String getCourseName() {
        return courseName;
    }

    public void setCourseName(String courseName) {
        this.courseName = courseName;
    }

    public int getTotalSemesters() {
        return totalSemesters;
    }

    public void setTotalSemesters(int totalSemesters) {
        this.totalSemesters = totalSemesters;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
}
