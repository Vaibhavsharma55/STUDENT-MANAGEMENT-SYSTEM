package com.sms.util;

import org.mindrot.jbcrypt.BCrypt;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

/**
 * Utility class for hashing and verifying passwords securely.
 * Uses BCrypt with fallback support for legacy hashes.
 */
public class PasswordUtil {

    /**
     * Hashes a plain text password using BCrypt.
     *
     * @param plainPassword Plain text password
     * @return Secure BCrypt hash string
     */
    public static String hashPassword(String plainPassword) {
        if (plainPassword == null || plainPassword.isEmpty()) {
            throw new IllegalArgumentException("Password cannot be empty");
        }
        return BCrypt.hashpw(plainPassword, BCrypt.gensalt(10));
    }

    /**
     * Verifies a plain text password against a stored hash or password.
     *
     * @param plainPassword Plain text password entered by user
     * @param storedHash    Hashed password stored in the database
     * @return true if password matches, false otherwise
     */
    public static boolean checkPassword(String plainPassword, String storedHash) {
        if (plainPassword == null || storedHash == null) {
            return false;
        }

        // 1. If stored hash is standard BCrypt (starts with $2a$, $2b$, or $2y$)
        if (storedHash.startsWith("$2a$") || storedHash.startsWith("$2b$") || storedHash.startsWith("$2y$")) {
            try {
                return BCrypt.checkpw(plainPassword, storedHash);
            } catch (Exception e) {
                return false;
            }
        }

        // 2. Direct equality fallback (for initial plain-text seeding if any)
        if (plainPassword.equals(storedHash)) {
            return true;
        }

        // 3. SHA-256 fallback
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] bytes = md.digest(plainPassword.getBytes());
            StringBuilder sb = new StringBuilder();
            for (byte b : bytes) {
                sb.append(String.format("%02x", b));
            }
            return sb.toString().equalsIgnoreCase(storedHash);
        } catch (NoSuchAlgorithmException e) {
            return false;
        }
    }
}
