package com.sms.dao;

import com.sms.config.DBConnection;
import com.sms.model.Attendance;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Data Access Object for Student Attendance.
 */
public class AttendanceDAO {

    public List<Attendance> findByStudentId(int studentId) throws SQLException {
        List<Attendance> list = new ArrayList<>();
        String sql = "SELECT a.id, a.student_id, a.attendance_date, a.status, a.remarks, a.created_at, " +
                     "s.roll_no, CONCAT(s.first_name, ' ', s.last_name) AS student_name, c.course_code " +
                     "FROM attendance a " +
                     "JOIN students s ON a.student_id = s.id " +
                     "JOIN courses c ON s.course_id = c.id " +
                     "WHERE a.student_id = ? " +
                     "ORDER BY a.attendance_date DESC";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, studentId);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapRow(rs));
            }
        } finally {
            DBConnection.close(rs, ps, conn);
        }
        return list;
    }

    public List<Attendance> findByDate(Date date, Integer courseId, Integer semester) throws SQLException {
        List<Attendance> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
            "SELECT a.id, a.student_id, a.attendance_date, a.status, a.remarks, a.created_at, " +
            "s.roll_no, CONCAT(s.first_name, ' ', s.last_name) AS student_name, c.course_code " +
            "FROM attendance a " +
            "JOIN students s ON a.student_id = s.id " +
            "JOIN courses c ON s.course_id = c.id " +
            "WHERE a.attendance_date = ? "
        );
        List<Object> params = new ArrayList<>();
        params.add(date);

        if (courseId != null && courseId > 0) {
            sql.append("AND s.course_id = ? ");
            params.add(courseId);
        }
        if (semester != null && semester > 0) {
            sql.append("AND s.current_semester = ? ");
            params.add(semester);
        }

        sql.append("ORDER BY s.roll_no ASC");

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql.toString());
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapRow(rs));
            }
        } finally {
            DBConnection.close(rs, ps, conn);
        }
        return list;
    }

    public boolean recordOrUpdate(Attendance att) throws SQLException {
        String sql = "INSERT INTO attendance (student_id, attendance_date, status, remarks) " +
                     "VALUES (?, ?, ?, ?) " +
                     "ON DUPLICATE KEY UPDATE status = VALUES(status), remarks = VALUES(remarks)";
        Connection conn = null;
        PreparedStatement ps = null;

        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, att.getStudentId());
            ps.setDate(2, att.getAttendanceDate());
            ps.setString(3, att.getStatus());
            ps.setString(4, att.getRemarks());
            return ps.executeUpdate() > 0;
        } finally {
            DBConnection.close(ps, conn);
        }
    }

    public void batchRecord(List<Attendance> list) throws SQLException {
        String sql = "INSERT INTO attendance (student_id, attendance_date, status, remarks) " +
                     "VALUES (?, ?, ?, ?) " +
                     "ON DUPLICATE KEY UPDATE status = VALUES(status), remarks = VALUES(remarks)";
        Connection conn = null;
        PreparedStatement ps = null;

        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false);
            ps = conn.prepareStatement(sql);

            for (Attendance att : list) {
                ps.setInt(1, att.getStudentId());
                ps.setDate(2, att.getAttendanceDate());
                ps.setString(3, att.getStatus());
                ps.setString(4, att.getRemarks() != null ? att.getRemarks() : "");
                ps.addBatch();
            }

            ps.executeBatch();
            conn.commit();
        } catch (SQLException e) {
            if (conn != null) {
                try { conn.rollback(); } catch (SQLException ignored) {}
            }
            throw e;
        } finally {
            if (conn != null) {
                try { conn.setAutoCommit(true); } catch (SQLException ignored) {}
            }
            DBConnection.close(ps, conn);
        }
    }

    public boolean delete(int id) throws SQLException {
        String sql = "DELETE FROM attendance WHERE id = ?";
        Connection conn = null;
        PreparedStatement ps = null;

        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } finally {
            DBConnection.close(ps, conn);
        }
    }

    public Map<String, Integer> getStatsForStudent(int studentId) throws SQLException {
        Map<String, Integer> stats = new HashMap<>();
        stats.put("total", 0);
        stats.put("present", 0);
        stats.put("absent", 0);
        stats.put("late", 0);
        stats.put("excused", 0);

        String sql = "SELECT status, COUNT(*) AS cnt FROM attendance WHERE student_id = ? GROUP BY status";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, studentId);
            rs = ps.executeQuery();
            int total = 0;
            while (rs.next()) {
                String status = rs.getString("status").toLowerCase();
                int cnt = rs.getInt("cnt");
                total += cnt;
                stats.put(status, cnt);
            }
            stats.put("total", total);
        } finally {
            DBConnection.close(rs, ps, conn);
        }
        return stats;
    }

    public int countPresentToday() throws SQLException {
        String sql = "SELECT COUNT(*) FROM attendance WHERE attendance_date = CURRENT_DATE() AND status = 'Present'";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
            return 0;
        } finally {
            DBConnection.close(rs, ps, conn);
        }
    }

    private Attendance mapRow(ResultSet rs) throws SQLException {
        Attendance a = new Attendance(
            rs.getInt("id"),
            rs.getInt("student_id"),
            rs.getDate("attendance_date"),
            rs.getString("status"),
            rs.getString("remarks"),
            rs.getTimestamp("created_at")
        );
        a.setStudentRollNo(rs.getString("roll_no"));
        a.setStudentName(rs.getString("student_name"));
        a.setCourseCode(rs.getString("course_code"));
        return a;
    }
}
