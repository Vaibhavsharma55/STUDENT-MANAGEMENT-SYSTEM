package com.sms.dao;

import com.sms.config.DBConnection;
import com.sms.model.Course;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * Data Access Object for Courses.
 */
public class CourseDAO {

    public List<Course> findAll() throws SQLException {
        List<Course> list = new ArrayList<>();
        String sql = "SELECT id, course_code, course_name, total_semesters, description, created_at FROM courses ORDER BY course_code ASC";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapRow(rs));
            }
        } finally {
            DBConnection.close(rs, ps, conn);
        }
        return list;
    }

    public Course findById(int id) throws SQLException {
        String sql = "SELECT id, course_code, course_name, total_semesters, description, created_at FROM courses WHERE id = ?";
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

    public Course findByCode(String code) throws SQLException {
        String sql = "SELECT id, course_code, course_name, total_semesters, description, created_at FROM courses WHERE course_code = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, code);
            rs = ps.executeQuery();
            if (rs.next()) {
                return mapRow(rs);
            }
            return null;
        } finally {
            DBConnection.close(rs, ps, conn);
        }
    }

    public boolean insert(Course course) throws SQLException {
        String sql = "INSERT INTO courses (course_code, course_name, total_semesters, description) VALUES (?, ?, ?, ?)";
        Connection conn = null;
        PreparedStatement ps = null;

        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, course.getCourseCode());
            ps.setString(2, course.getCourseName());
            ps.setInt(3, course.getTotalSemesters());
            ps.setString(4, course.getDescription());
            return ps.executeUpdate() > 0;
        } finally {
            DBConnection.close(ps, conn);
        }
    }

    public boolean update(Course course) throws SQLException {
        String sql = "UPDATE courses SET course_code = ?, course_name = ?, total_semesters = ?, description = ? WHERE id = ?";
        Connection conn = null;
        PreparedStatement ps = null;

        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, course.getCourseCode());
            ps.setString(2, course.getCourseName());
            ps.setInt(3, course.getTotalSemesters());
            ps.setString(4, course.getDescription());
            ps.setInt(5, course.getId());
            return ps.executeUpdate() > 0;
        } finally {
            DBConnection.close(ps, conn);
        }
    }

    public boolean delete(int id) throws SQLException {
        String sql = "DELETE FROM courses WHERE id = ?";
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
        String sql = "SELECT COUNT(*) FROM courses";
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

    public boolean hasStudents(int courseId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM students WHERE course_id = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, courseId);
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
            return false;
        } finally {
            DBConnection.close(rs, ps, conn);
        }
    }

    private Course mapRow(ResultSet rs) throws SQLException {
        return new Course(
            rs.getInt("id"),
            rs.getString("course_code"),
            rs.getString("course_name"),
            rs.getInt("total_semesters"),
            rs.getString("description"),
            rs.getTimestamp("created_at")
        );
    }
}
