package com.sms.dao;

import com.sms.config.DBConnection;
import com.sms.model.Student;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * Data Access Object for Students.
 */
public class StudentDAO {

    private static final String BASE_SELECT =
        "SELECT s.id, s.roll_no, s.first_name, s.last_name, s.email, s.phone, " +
        "s.gender, s.dob, s.course_id, s.current_semester, s.address, s.created_at, " +
        "c.course_code, c.course_name " +
        "FROM students s " +
        "JOIN courses c ON s.course_id = c.id ";

    public List<Student> findAll(String keyword, Integer courseId, Integer semester) throws SQLException {
        List<Student> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder(BASE_SELECT).append("WHERE 1=1 ");
        List<Object> params = new ArrayList<>();

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append("AND (s.roll_no LIKE ? OR s.first_name LIKE ? OR s.last_name LIKE ? OR s.email LIKE ?) ");
            String pattern = "%" + keyword.trim() + "%";
            params.add(pattern);
            params.add(pattern);
            params.add(pattern);
            params.add(pattern);
        }

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

    public List<Student> findRecent(int limit) throws SQLException {
        List<Student> list = new ArrayList<>();
        String sql = BASE_SELECT + "ORDER BY s.id DESC LIMIT ?";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, limit);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapRow(rs));
            }
        } finally {
            DBConnection.close(rs, ps, conn);
        }
        return list;
    }

    public Student findById(int id) throws SQLException {
        String sql = BASE_SELECT + "WHERE s.id = ?";
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

    public Student findByRollNo(String rollNo) throws SQLException {
        String sql = BASE_SELECT + "WHERE s.roll_no = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, rollNo);
            rs = ps.executeQuery();
            if (rs.next()) {
                return mapRow(rs);
            }
            return null;
        } finally {
            DBConnection.close(rs, ps, conn);
        }
    }

    public Student findByEmail(String email) throws SQLException {
        String sql = BASE_SELECT + "WHERE s.email = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            rs = ps.executeQuery();
            if (rs.next()) {
                return mapRow(rs);
            }
            return null;
        } finally {
            DBConnection.close(rs, ps, conn);
        }
    }

    public boolean insert(Student student) throws SQLException {
        String sql = "INSERT INTO students (roll_no, first_name, last_name, email, phone, gender, dob, course_id, current_semester, address) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        Connection conn = null;
        PreparedStatement ps = null;

        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, student.getRollNo());
            ps.setString(2, student.getFirstName());
            ps.setString(3, student.getLastName());
            ps.setString(4, student.getEmail());
            ps.setString(5, student.getPhone());
            ps.setString(6, student.getGender());
            ps.setDate(7, student.getDob());
            ps.setInt(8, student.getCourseId());
            ps.setInt(9, student.getCurrentSemester());
            ps.setString(10, student.getAddress());
            return ps.executeUpdate() > 0;
        } finally {
            DBConnection.close(ps, conn);
        }
    }

    public boolean update(Student student) throws SQLException {
        String sql = "UPDATE students SET roll_no = ?, first_name = ?, last_name = ?, email = ?, phone = ?, " +
                     "gender = ?, dob = ?, course_id = ?, current_semester = ?, address = ? WHERE id = ?";
        Connection conn = null;
        PreparedStatement ps = null;

        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, student.getRollNo());
            ps.setString(2, student.getFirstName());
            ps.setString(3, student.getLastName());
            ps.setString(4, student.getEmail());
            ps.setString(5, student.getPhone());
            ps.setString(6, student.getGender());
            ps.setDate(7, student.getDob());
            ps.setInt(8, student.getCourseId());
            ps.setInt(9, student.getCurrentSemester());
            ps.setString(10, student.getAddress());
            ps.setInt(11, student.getId());
            return ps.executeUpdate() > 0;
        } finally {
            DBConnection.close(ps, conn);
        }
    }

    public boolean delete(int id) throws SQLException {
        String sql = "DELETE FROM students WHERE id = ?";
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
        String sql = "SELECT COUNT(*) FROM students";
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

    private Student mapRow(ResultSet rs) throws SQLException {
        Student s = new Student(
            rs.getInt("id"),
            rs.getString("roll_no"),
            rs.getString("first_name"),
            rs.getString("last_name"),
            rs.getString("email"),
            rs.getString("phone"),
            rs.getString("gender"),
            rs.getDate("dob"),
            rs.getInt("course_id"),
            rs.getInt("current_semester"),
            rs.getString("address"),
            rs.getTimestamp("created_at")
        );
        s.setCourseCode(rs.getString("course_code"));
        s.setCourseName(rs.getString("course_name"));
        return s;
    }
}
