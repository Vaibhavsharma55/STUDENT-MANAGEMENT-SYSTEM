package com.sms.service;

import com.sms.dao.AttendanceDAO;
import com.sms.dao.MarksDAO;
import com.sms.dao.StudentDAO;
import com.sms.model.Marks;
import com.sms.model.Student;
import com.sms.model.StudentReport;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

/**
 * Service to aggregate data and generate student academic & attendance reports.
 */
public class ReportService {

    private final StudentDAO studentDAO;
    private final MarksDAO marksDAO;
    private final AttendanceDAO attendanceDAO;
    private final MarksService marksService;
    private final AttendanceService attendanceService;

    public ReportService() {
        this.studentDAO = new StudentDAO();
        this.marksDAO = new MarksDAO();
        this.attendanceDAO = new AttendanceDAO();
        this.marksService = new MarksService();
        this.attendanceService = new AttendanceService();
    }

    /**
     * Generates a comprehensive academic and attendance report for a given student.
     */
    public StudentReport generateStudentReport(int studentId, Integer semester) throws SQLException {
        Student student = studentDAO.findById(studentId);
        if (student == null) {
            return null;
        }

        StudentReport report = new StudentReport();
        report.setStudent(student);

        // Fetch marks
        List<Marks> marksList;
        if (semester != null && semester > 0) {
            marksList = marksDAO.findByStudentIdAndSemester(studentId, semester);
        } else {
            marksList = marksDAO.findByStudentId(studentId);
        }
        report.setMarksList(marksList);

        // Calculate marks aggregates
        Map<String, Object> marksAgg = marksService.calculateAggregates(marksList);
        report.setTotalMarksObtained((Double) marksAgg.get("totalObtained"));
        report.setTotalMaxMarks((Double) marksAgg.get("totalMax"));
        report.setOverallPercentage((Double) marksAgg.get("percentage"));
        report.setOverallGrade((String) marksAgg.get("grade"));
        report.setPerformanceStatus((String) marksAgg.get("performanceStatus"));

        // Calculate attendance stats
        Map<String, Object> attStats = attendanceService.getStudentAttendanceStats(studentId);
        report.setTotalAttendanceDays((Integer) attStats.getOrDefault("total", 0));
        report.setPresentDays((Integer) attStats.getOrDefault("present", 0));
        report.setAbsentDays((Integer) attStats.getOrDefault("absent", 0));
        report.setLateDays((Integer) attStats.getOrDefault("late", 0));
        report.setExcusedDays((Integer) attStats.getOrDefault("excused", 0));
        report.setAttendancePercentage((Double) attStats.getOrDefault("percentage", 0.0));

        return report;
    }
}
