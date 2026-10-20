package com.sms.dao;

import com.sms.config.DBConnection;
import com.sms.model.Marks;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * Data Access Object for Student Marks.
 */
public class MarksDAO {

    private static final String BASE_SELECT =
        "SELECT m.id, m.student_id, m.semester, m.subject_name, m.marks_obtained, m.max_marks, m.exam_type, m.created_at, " +
        "s.roll_no, CONCAT(s.first_name, ' ', s.last_name) AS student_name, c.course_code " +
        "FROM marks m " +
        "JOIN students s ON m.student_id = s.id " +
        "JOIN courses c ON s.course_id = c.id ";

    public List<Marks> findAll(Integer courseId, Integer semester, String keyword) throws SQLException {
        List<Marks> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder(BASE_SELECT).append("WHERE 1=1 ");
        List<Object> params = new ArrayList<>();

        if (courseId != null && courseId > 0) {
            sql.append("AND s.course_id = ? ");
            params.add(courseId);
        }
        if (semester != null && semester > 0) {
            sql.append("AND m.semester = ? ");
            params.add(semester);
        }
        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append("AND (s.roll_no LIKE ? OR s.first_name LIKE ? OR s.last_name LIKE ? OR m.subject_name LIKE ?) ");
            String pat = "%" + keyword.trim() + "%";
            params.add(pat);
            params.add(pat);
            params.add(pat);
            params.add(pat);
        }

        sql.append("ORDER BY s.roll_no ASC, m.semester ASC, m.subject_name ASC");

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

    public List<Marks> findByStudentId(int studentId) throws SQLException {
        List<Marks> list = new ArrayList<>();
        String sql = BASE_SELECT + "WHERE m.student_id = ? ORDER BY m.semester ASC, m.subject_name ASC";
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

    public List<Marks> findByStudentIdAndSemester(int studentId, int semester) throws SQLException {
        List<Marks> list = new ArrayList<>();
        String sql = BASE_SELECT + "WHERE m.student_id = ? AND m.semester = ? ORDER BY m.subject_name ASC";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, studentId);
            ps.setInt(2, semester);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapRow(rs));
            }
        } finally {
            DBConnection.close(rs, ps, conn);
        }
        return list;
    }

    public Marks findById(int id) throws SQLException {
        String sql = BASE_SELECT + "WHERE m.id = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();
            if (rs.next()) {
                return mapRow(rs);
            }
            return null;
        } finally {
            DBConnection.close(rs, ps, conn);
        }
    }

    public boolean insert(Marks marks) throws SQLException {
        String sql = "INSERT INTO marks (student_id, semester, subject_name, marks_obtained, max_marks, exam_type) " +
                     "VALUES (?, ?, ?, ?, ?, ?)";
        Connection conn = null;
        PreparedStatement ps = null;

        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, marks.getStudentId());
            ps.setInt(2, marks.getSemester());
            ps.setString(3, marks.getSubjectName());
            ps.setDouble(4, marks.getMarksObtained());
            ps.setDouble(5, marks.getMaxMarks());
            ps.setString(6, marks.getExamType());
            return ps.executeUpdate() > 0;
        } finally {
            DBConnection.close(ps, conn);
        }
    }

    public boolean update(Marks marks) throws SQLException {
        String sql = "UPDATE marks SET semester = ?, subject_name = ?, marks_obtained = ?, max_marks = ?, exam_type = ? " +
                     "WHERE id = ?";
        Connection conn = null;
        PreparedStatement ps = null;

        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, marks.getSemester());
            ps.setString(2, marks.getSubjectName());
            ps.setDouble(3, marks.getMarksObtained());
            ps.setDouble(4, marks.getMaxMarks());
            ps.setString(5, marks.getExamType());
            ps.setInt(6, marks.getId());
            return ps.executeUpdate() > 0;
        } finally {
            DBConnection.close(ps, conn);
        }
    }

    public boolean delete(int id) throws SQLException {
        String sql = "DELETE FROM marks WHERE id = ?";
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

    public int count() throws SQLException {
        String sql = "SELECT COUNT(*) FROM marks";
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

    public double getAveragePercentage() throws SQLException {
        String sql = "SELECT AVG((marks_obtained / max_marks) * 100) FROM marks WHERE max_marks > 0";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getDouble(1);
            }
            return 0.0;
        } finally {
            DBConnection.close(rs, ps, conn);
        }
    }

    private Marks mapRow(ResultSet rs) throws SQLException {
        Marks m = new Marks(
            rs.getInt("id"),
            rs.getInt("student_id"),
            rs.getInt("semester"),
            rs.getString("subject_name"),
            rs.getDouble("marks_obtained"),
            rs.getDouble("max_marks"),
            rs.getString("exam_type"),
            rs.getTimestamp("created_at")
        );
        m.setStudentRollNo(rs.getString("roll_no"));
        m.setStudentName(rs.getString("student_name"));
        m.setCourseCode(rs.getString("course_code"));
        return m;
    }
}
