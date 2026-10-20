package com.sms.dao;

import com.sms.config.DBConnection;
import com.sms.model.Admin;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Data Access Object for Admin entities.
 */
public class AdminDAO {

    public Admin findByUsername(String username) throws SQLException {
        String sql = "SELECT id, username, password, full_name, email, created_at FROM admins WHERE username = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, username);
            rs = ps.executeQuery();

            if (rs.next()) {
                return new Admin(
                    rs.getInt("id"),
                    rs.getString("username"),
                    rs.getString("password"),
                    rs.getString("full_name"),
                    rs.getString("email"),
                    rs.getTimestamp("created_at")
                );
            }
            return null;
        } finally {
            DBConnection.close(rs, ps, conn);
        }
    }

    public boolean create(Admin admin) throws SQLException {
        String sql = "INSERT INTO admins (username, password, full_name, email) VALUES (?, ?, ?, ?)";
        Connection conn = null;
        PreparedStatement ps = null;

        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, admin.getUsername());
            ps.setString(2, admin.getPassword());
            ps.setString(3, admin.getFullName());
            ps.setString(4, admin.getEmail());
            return ps.executeUpdate() > 0;
        } finally {
            DBConnection.close(ps, conn);
        }
    }

    public boolean updatePassword(int id, String newHashedPassword) throws SQLException {
        String sql = "UPDATE admins SET password = ? WHERE id = ?";
        Connection conn = null;
        PreparedStatement ps = null;

        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setString(1, newHashedPassword);
            ps.setInt(2, id);
            return ps.executeUpdate() > 0;
        } finally {
            DBConnection.close(ps, conn);
        }
    }
}
