package com.sms.service;

import com.sms.dao.AttendanceDAO;
import com.sms.dao.StudentDAO;
import com.sms.model.Attendance;

import java.sql.Date;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Service handling student attendance logic.
 */
public class AttendanceService {

    private final AttendanceDAO attendanceDAO;
    private final StudentDAO studentDAO;

    public AttendanceService() {
        this.attendanceDAO = new AttendanceDAO();
        this.studentDAO = new StudentDAO();
    }

    public AttendanceService(AttendanceDAO attendanceDAO, StudentDAO studentDAO) {
        this.attendanceDAO = attendanceDAO;
        this.studentDAO = studentDAO;
    }

    public List<Attendance> getAttendanceByDate(Date date, Integer courseId, Integer semester) throws SQLException {
        if (date == null) {
            date = new Date(System.currentTimeMillis());
        }
        return attendanceDAO.findByDate(date, courseId, semester);
    }

    public List<Attendance> getAttendanceForStudent(int studentId) throws SQLException {
        return attendanceDAO.findByStudentId(studentId);
    }

    public void recordAttendance(Attendance att) throws SQLException {
        if (att.getStudentId() <= 0) {
            throw new IllegalArgumentException("Invalid student ID.");
        }
        if (att.getAttendanceDate() == null) {
            att.setAttendanceDate(new Date(System.currentTimeMillis()));
        }
        if (att.getStatus() == null || att.getStatus().trim().isEmpty()) {
            att.setStatus("Present");
        }
        attendanceDAO.recordOrUpdate(att);
    }

    public void recordBatchAttendance(List<Attendance> list) throws SQLException {
        if (list == null || list.isEmpty()) return;
        attendanceDAO.batchRecord(list);
    }

    public void deleteAttendance(int id) throws SQLException {
        attendanceDAO.delete(id);
    }

    public Map<String, Object> getStudentAttendanceStats(int studentId) throws SQLException {
        Map<String, Integer> raw = attendanceDAO.getStatsForStudent(studentId);
        Map<String, Object> result = new HashMap<>(raw);

        int total = raw.getOrDefault("total", 0);
        int present = raw.getOrDefault("present", 0);
        int late = raw.getOrDefault("late", 0);

        // Consider late as 0.5 or present with remark, standard academic practice: (present + 0.5 * late) / total
        double percentage = 0.0;
        if (total > 0) {
            percentage = ((present + (late * 0.5)) / total) * 100.0;
        }

        result.put("percentage", Math.round(percentage * 10.0) / 10.0);
        return result;
    }

    public Map<String, Integer> getTodayAttendanceSummary() throws SQLException {
        Map<String, Integer> summary = new HashMap<>();
        summary.put("presentToday", attendanceDAO.countPresentToday());
        summary.put("totalStudents", studentDAO.count());
        return summary;
    }
}
