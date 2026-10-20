package com.sms.model;

import java.sql.Timestamp;

/**
 * Marks model representing academic performance in a subject.
 */
public class Marks {
    private int id;
    private int studentId;
    private int semester;
    private String subjectName;
    private double marksObtained;
    private double maxMarks;
    private String examType;
    private Timestamp createdAt;

    // Display fields from Student join
    private String studentRollNo;
    private String studentName;
    private String courseCode;

    public Marks() {
        this.maxMarks = 100.00;
        this.examType = "Semester Exam";
    }

    public Marks(int id, int studentId, int semester, String subjectName, double marksObtained, 
                 double maxMarks, String examType, Timestamp createdAt) {
        this.id = id;
        this.studentId = studentId;
        this.semester = semester;
        this.subjectName = subjectName;
        this.marksObtained = marksObtained;
        this.maxMarks = maxMarks;
        this.examType = examType;
        this.createdAt = createdAt;
    }

    public double getPercentage() {
        if (maxMarks <= 0) return 0.0;
        return (marksObtained / maxMarks) * 100.0;
    }

    public String getGrade() {
        double pct = getPercentage();
        if (pct >= 90) return "A+";
        if (pct >= 80) return "A";
        if (pct >= 70) return "B";
        if (pct >= 60) return "C";
        if (pct >= 50) return "D";
        if (pct >= 40) return "E";
        return "F";
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

    public int getSemester() {
        return semester;
    }

    public void setSemester(int semester) {
        this.semester = semester;
    }

    public String getSubjectName() {
        return subjectName;
    }

    public void setSubjectName(String subjectName) {
        this.subjectName = subjectName;
    }

    public double getMarksObtained() {
        return marksObtained;
    }

    public void setMarksObtained(double marksObtained) {
        this.marksObtained = marksObtained;
    }

    public double getMaxMarks() {
        return maxMarks;
    }

    public void setMaxMarks(double maxMarks) {
        this.maxMarks = maxMarks;
    }

    public String getExamType() {
        return examType;
    }

    public void setExamType(String examType) {
        this.examType = examType;
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
