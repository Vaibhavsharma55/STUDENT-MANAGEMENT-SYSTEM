package com.sms.model;

import java.util.ArrayList;
import java.util.List;

/**
 * Report model aggregating student details, academic marks, and attendance stats.
 */
public class StudentReport {
    private Student student;
    private List<Marks> marksList = new ArrayList<>();
    
    // Marks Aggregates
    private double totalMarksObtained;
    private double totalMaxMarks;
    private double overallPercentage;
    private String overallGrade;
    private String performanceStatus;

    // Attendance Aggregates
    private int totalAttendanceDays;
    private int presentDays;
    private int absentDays;
    private int lateDays;
    private int excusedDays;
    private double attendancePercentage;

    public StudentReport() {
    }

    public Student getStudent() {
        return student;
    }

    public void setStudent(Student student) {
        this.student = student;
    }

    public List<Marks> getMarksList() {
        return marksList;
    }

    public void setMarksList(List<Marks> marksList) {
        this.marksList = marksList;
    }

    public double getTotalMarksObtained() {
        return totalMarksObtained;
    }

    public void setTotalMarksObtained(double totalMarksObtained) {
        this.totalMarksObtained = totalMarksObtained;
    }

    public double getTotalMaxMarks() {
        return totalMaxMarks;
    }

    public void setTotalMaxMarks(double totalMaxMarks) {
        this.totalMaxMarks = totalMaxMarks;
    }

    public double getOverallPercentage() {
        return overallPercentage;
    }

    public void setOverallPercentage(double overallPercentage) {
        this.overallPercentage = overallPercentage;
    }

    public String getOverallGrade() {
        return overallGrade;
    }

    public void setOverallGrade(String overallGrade) {
        this.overallGrade = overallGrade;
    }

    public String getPerformanceStatus() {
        return performanceStatus;
    }

    public void setPerformanceStatus(String performanceStatus) {
        this.performanceStatus = performanceStatus;
    }

    public int getTotalAttendanceDays() {
        return totalAttendanceDays;
    }

    public void setTotalAttendanceDays(int totalAttendanceDays) {
        this.totalAttendanceDays = totalAttendanceDays;
    }

    public int getPresentDays() {
        return presentDays;
    }

    public void setPresentDays(int presentDays) {
        this.presentDays = presentDays;
    }

    public int getAbsentDays() {
        return absentDays;
    }

    public void setAbsentDays(int absentDays) {
        this.absentDays = absentDays;
    }

    public int getLateDays() {
        return lateDays;
    }

    public void setLateDays(int lateDays) {
        this.lateDays = lateDays;
    }

    public int getExcusedDays() {
        return excusedDays;
    }

    public void setExcusedDays(int excusedDays) {
        this.excusedDays = excusedDays;
    }

    public double getAttendancePercentage() {
        return attendancePercentage;
    }

    public void setAttendancePercentage(double attendancePercentage) {
        this.attendancePercentage = attendancePercentage;
    }
}
