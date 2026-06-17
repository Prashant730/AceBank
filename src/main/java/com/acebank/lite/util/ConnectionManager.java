package com.acebank.lite.util;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;
import org.apache.ibatis.jdbc.ScriptRunner;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.logging.Logger;

public final class ConnectionManager {

    private static boolean isSchemaInitialized = false;
    private static HikariDataSource dataSource;
    static final Logger log = Logger.getLogger(ConnectionManager.class.getName());

    private ConnectionManager() {
    }

    static {
        try {
            HikariConfig config = new HikariConfig();
            config.setJdbcUrl(ConfigLoader.getProperty(ConfigKeys.DB_URL));
            config.setUsername(ConfigLoader.getProperty(ConfigKeys.DB_USER));
            config.setPassword(ConfigLoader.getProperty(ConfigKeys.DB_PWD));
            config.setDriverClassName(ConfigLoader.getProperty(ConfigKeys.DB_MYSQL_DRIVER));

            // Connection pool settings for Render free tier
            config.setMaximumPoolSize(5);
            config.setMinimumIdle(2);
            config.setConnectionTimeout(10000);
            config.setIdleTimeout(300000);
            config.setMaxLifetime(600000);

            dataSource = new HikariDataSource(config);
            log.info("Connection pool initialized.");
        } catch (Exception e) {
            log.severe("Failed to initialize connection pool: " + e.getMessage());
        }
    }

    public static synchronized Connection getConnection() throws SQLException {
        Connection connection = dataSource.getConnection();

        // Run the script ONLY ONCE on the very first successful connection
        if (connection != null && !isSchemaInitialized) {
            String scriptPath = ConfigLoader.getProperty(ConfigKeys.DB_SCRIPT_PATH);
            if (scriptPath != null) {
                runInitScript(connection, scriptPath);
            }
            isSchemaInitialized = true;
        }

        return connection;
    }

    private static void runInitScript(Connection connection, String path) {
        String normalizedPath = path.startsWith("/") ? path : "/" + path;
        try (InputStream is = ConnectionManager.class.getResourceAsStream(normalizedPath)) {
            if (is == null) {
                log.warning("Script not found at: " + normalizedPath);
                return;
            }
            ScriptRunner runner = new ScriptRunner(connection);
            runner.setLogWriter(null);
            runner.setStopOnError(false);
            runner.runScript(new BufferedReader(new InputStreamReader(is)));
            log.info("SQL Schema checked/initialized.");
        } catch (Exception e) {
            log.severe("SQL Init Error: " + e.getMessage());
        }
    }
}