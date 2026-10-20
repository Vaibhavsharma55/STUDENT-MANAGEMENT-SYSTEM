package com.sms.config;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

/**
 * Singleton / Utility class to manage JDBC database connections to MySQL.
 */
public class DBConnection {

    private static String url;
    private static String username;
    private static String password;
    private static String driver;

    static {
        loadProperties();
    }

    private static void loadProperties() {
        Properties props = new Properties();
        try (InputStream in = DBConnection.class.getClassLoader().getResourceAsStream("db.properties")) {
            if (in != null) {
                props.load(in);
            }
        } catch (Exception e) {
            System.err.println("Warning: Could not read db.properties, using defaults: " + e.getMessage());
        }

        driver = props.getProperty("db.driver", "com.mysql.cj.jdbc.Driver");
        url = props.getProperty("db.url", "jdbc:mysql://localhost:3306/sms_db?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC&characterEncoding=UTF-8");
        username = props.getProperty("db.user", "root");
        password = props.getProperty("db.password", "root");

        try {
            Class.forName(driver);
        } catch (ClassNotFoundException e) {
            System.err.println("CRITICAL: MySQL JDBC Driver not found: " + e.getMessage());
        }
    }

    /**
     * Obtains a new database Connection.
     * Tries configured password first, then attempts empty password if connection fails.
     *
     * @return Connection object
     * @throws SQLException if connection cannot be established
     */
    public static Connection getConnection() throws SQLException {
        try {
            return DriverManager.getConnection(url, username, password);
        } catch (SQLException ex) {
            // If authentication failed with password "root", try empty password "" (standard XAMPP/default MySQL setup)
            if (password != null && !password.isEmpty()) {
                try {
                    return DriverManager.getConnection(url, username, "");
                } catch (SQLException ignored) {
                    // rethrow original exception
                }
            }
            throw ex;
        }
    }

    /**
     * Utility method to safely close JDBC resources.
     */
    public static void close(AutoCloseable... closeables) {
        for (AutoCloseable c : closeables) {
            if (c != null) {
                try {
                    c.close();
                } catch (Exception ignored) {
                }
            }
        }
    }
}
