package com.acebank.lite.util;

import java.io.IOException;
import java.io.InputStream;
import java.util.Map;
import java.util.Properties;

public class ConfigLoader {
    private static final Properties properties = new Properties();

    /**
     * Maps property-file keys to their Render/environment variable equivalents.
     * Render injects uppercase, underscore-separated names.
     */
    private static final Map<String, String> ENV_KEY_MAP = Map.of(
            ConfigKeys.DB_URL, "DB_URL",
            ConfigKeys.DB_USER, "DB_USER",
            ConfigKeys.DB_PWD, "DB_PASSWORD",
            ConfigKeys.MAIL_ADDR, "MAIL_ADDRESS",
            ConfigKeys.MAIL_PWD, "MAIL_APP_PASSWORD");

    static {
        try (InputStream is = ConfigLoader.class.getClassLoader()
                .getResourceAsStream(ConfigKeys.DEV_PROPERTIES)) {

            if (is == null) {
                throw new RuntimeException("Could not find " + ConfigKeys.DEV_PROPERTIES);
            }
            properties.load(is);

        } catch (IOException e) {
            throw new RuntimeException("Failed to load configuration", e);
        }
    }

    /**
     * Returns a property value.
     * Resolution order:
     * 1. Known Render env var name (from ENV_KEY_MAP)
     * 2. Auto-derived env var name (dots → underscores, uppercased)
     * 3. application-dev.properties value
     */
    public static String getProperty(String key) {
        // 1. Check explicit Render env var mapping
        String envKey = ENV_KEY_MAP.get(key);
        if (envKey != null) {
            String val = System.getenv(envKey);
            if (val != null && !val.isBlank())
                return val;
        }

        // 2. Auto-derive: "db.url" → "DB_URL"
        String derivedKey = key.replace(".", "_").toUpperCase();
        String derivedVal = System.getenv(derivedKey);
        if (derivedVal != null && !derivedVal.isBlank())
            return derivedVal;

        // 3. Fall back to properties file
        return properties.getProperty(key);
    }
}
