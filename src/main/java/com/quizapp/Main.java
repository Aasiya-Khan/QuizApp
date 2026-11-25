package com.quizapp;

import com.quizapp.util.DBConnection;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

public class Main {
    public static void main(String[] args) throws Exception {
        try (Connection conn = DBConnection.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery("SELECT COUNT(*) FROM quizzes")) {
            rs.next();
            System.out.println("Connected! Quizzes in database: " + rs.getInt(1));
        }
    }
}