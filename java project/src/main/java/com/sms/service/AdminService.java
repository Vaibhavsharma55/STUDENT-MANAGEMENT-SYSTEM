package com.sms.service;

import com.sms.dao.AdminDAO;
import com.sms.model.Admin;
import com.sms.util.PasswordUtil;

import java.sql.SQLException;

/**
 * Service handling Admin authentication and account operations.
 */
public class AdminService {

    private final AdminDAO adminDAO;

    public AdminService() {
        this.adminDAO = new AdminDAO();
    }

    public AdminService(AdminDAO adminDAO) {
        this.adminDAO = adminDAO;
    }

    /**
     * Authenticates an admin by username and password.
     */
    public Admin authenticate(String username, String plainPassword) throws SQLException {
        if (username == null || username.trim().isEmpty() || plainPassword == null || plainPassword.isEmpty()) {
            return null;
        }

        Admin admin = adminDAO.findByUsername(username.trim());
        if (admin != null && PasswordUtil.checkPassword(plainPassword, admin.getPassword())) {
            return admin;
        }
        return null;
    }

    /**
     * Changes password for an admin account.
     */
    public boolean changePassword(int adminId, String oldPassword, String newPassword) throws SQLException {
        if (newPassword == null || newPassword.trim().length() < 6) {
            throw new IllegalArgumentException("New password must be at least 6 characters long.");
        }
        String hashed = PasswordUtil.hashPassword(newPassword);
        return adminDAO.updatePassword(adminId, hashed);
    }
}
