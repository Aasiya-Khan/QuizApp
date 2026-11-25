package com.quizapp.util;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class DBConnection {

    // Reads db.properties from the resources folder
    private static Properties loadProperties() {
        Properties props = new Properties();
        try (InputStream in = DBConnection.class.getResourceAsStream("/db.properties")) {
            if (in == null) {
                throw new RuntimeException("db.properties not found in src/main/resources");
            }
            props.load(in);
        } catch (IOException e) {
            throw new RuntimeException("Could not read db.properties", e);
        }
        return props;
    }

    // Opens a new connection to MySQL
    public static Connection getConnection() throws SQLException {
        Properties p = loadProperties();
        String url = "jdbc:mysql://" + p.getProperty("db.host") + ":"
                + p.getProperty("db.port") + "/" + p.getProperty("db.name");
        return DriverManager.getConnection(url, p.getProperty("db.user"), p.getProperty("db.password"));
    }
}