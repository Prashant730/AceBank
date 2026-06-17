package com.acebank.lite.util;

import java.sql.Connection;
import java.sql.SQLException;

/**
 * Thin wrapper kept for any legacy callers.
 * All connections are now routed through ConnectionManager,
 * which reads credentials from ConfigLoader (supports Render env vars).
 */
public class DBConnection {

    private DBConnection() {
    }

    public static Connection getConnection() throws SQLException {
        return ConnectionManager.getConnection();
    }
}
