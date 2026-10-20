package com.sms.service;

import com.sms.dao.MarksDAO;
import com.sms.model.Marks;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Service for handling marks, percentage calculations, and grading logic.
 */
public class MarksService {

    private final MarksDAO marksDAO;

    public MarksService() {
        this.marksDAO = new MarksDAO();
    }

    public MarksService(MarksDAO marksDAO) {
        this.marksDAO = marksDAO;
    }

    public List<Marks> getAllMarks(Integer courseId, Integer semester, String keyword) throws SQLException {
        return marksDAO.findAll(courseId, semester, keyword);
    }

    public List<Marks> getMarksForStudent(int studentId) throws SQLException {
        return marksDAO.findByStudentId(studentId);
    }

    public List<Marks> getMarksForStudentAndSemester(int studentId, int semester) throws SQLException {
        return marksDAO.findByStudentIdAndSemester(studentId, semester);
    }

    public Marks getMarksById(int id) throws SQLException {
        return marksDAO.findById(id);
    }

    public void addMarks(Marks marks) throws SQLException {
        validateMarks(marks);
        marksDAO.insert(marks);
    }

    public void updateMarks(Marks marks) throws SQLException {
        validateMarks(marks);
        marksDAO.update(marks);
    }

    public void deleteMarks(int id) throws SQLException {
        marksDAO.delete(id);
    }

    public int getTotalMarksRecords() throws SQLException {
        return marksDAO.count();
    }

    public double getAveragePercentage() throws SQLException {
        double avg = marksDAO.getAveragePercentage();
        return Math.round(avg * 10.0) / 10.0;
    }

    /**
     * Calculates aggregate totals, percentage, and overall grade for a list of marks.
     */
    public Map<String, Object> calculateAggregates(List<Marks> list) {
        Map<String, Object> map = new HashMap<>();
        double totalObtained = 0.0;
        double totalMax = 0.0;

        if (list != null) {
            for (Marks m : list) {
                totalObtained += m.getMarksObtained();
                totalMax += m.getMaxMarks();
            }
        }

        double percentage = 0.0;
        if (totalMax > 0) {
            percentage = (totalObtained / totalMax) * 100.0;
        }

        percentage = Math.round(percentage * 100.0) / 100.0;
        String grade = determineGrade(percentage);
        String status = determinePerformanceStatus(percentage);

        map.put("totalObtained", totalObtained);
        map.put("totalMax", totalMax);
        map.put("percentage", percentage);
        map.put("grade", grade);
        map.put("performanceStatus", status);

        return map;
    }

    public String determineGrade(double pct) {
        if (pct >= 90) return "A+";
        if (pct >= 80) return "A";
        if (pct >= 70) return "B";
        if (pct >= 60) return "C";
        if (pct >= 50) return "D";
        if (pct >= 40) return "E";
        return "F";
    }

    public String determinePerformanceStatus(double pct) {
        if (pct >= 75) return "Distinction";
        if (pct >= 60) return "First Division";
        if (pct >= 50) return "Second Division";
        if (pct >= 40) return "Pass";
        return "Fail / Needs Improvement";
    }

    private void validateMarks(Marks m) {
        if (m.getStudentId() <= 0) {
            throw new IllegalArgumentException("Valid student is required.");
        }
        if (m.getSemester() <= 0) {
            throw new IllegalArgumentException("Semester must be greater than zero.");
        }
        if (m.getSubjectName() == null || m.getSubjectName().trim().isEmpty()) {
            throw new IllegalArgumentException("Subject name is required.");
        }
        if (m.getMaxMarks() <= 0) {
            throw new IllegalArgumentException("Maximum marks must be greater than zero.");
        }
        if (m.getMarksObtained() < 0) {
            throw new IllegalArgumentException("Marks obtained cannot be negative.");
        }
        if (m.getMarksObtained() > m.getMaxMarks()) {
            throw new IllegalArgumentException("Marks obtained (" + m.getMarksObtained() + 
                ") cannot exceed maximum marks (" + m.getMaxMarks() + ").");
        }

        m.setSubjectName(m.getSubjectName().trim());
        if (m.getExamType() == null || m.getExamType().trim().isEmpty()) {
            m.setExamType("Semester Exam");
        } else {
            m.setExamType(m.getExamType().trim());
        }
    }
}
