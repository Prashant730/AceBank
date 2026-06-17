package com.acebank.lite.controllers;

import com.acebank.lite.util.ConnectionManager;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.sql.Connection;
import java.sql.Statement;

@RestController
public class HealthController {

  @GetMapping("/health")
  public String health() {
    return "AceBank is running!";
  }

  @GetMapping("/test")
  public String test() {
    return "Routing works!";
  }

  @GetMapping("/reset-db")
  public String resetDatabase() {
    try (Connection conn = ConnectionManager.getConnection();
        Statement stmt = conn.createStatement()) {

      // Drop all tables
      stmt.execute("DROP TABLE IF EXISTS TRANSACTIONS CASCADE");
      stmt.execute("DROP TABLE IF EXISTS ACCOUNTS CASCADE");
      stmt.execute("DROP TABLE IF EXISTS USERS CASCADE");

      // Recreate tables
      stmt.execute(
          "CREATE TABLE USERS (USER_ID SERIAL PRIMARY KEY, FIRST_NAME VARCHAR(255) NOT NULL, LAST_NAME VARCHAR(255) NOT NULL, AADHAAR_NO VARCHAR(12) UNIQUE NOT NULL, EMAIL VARCHAR(255) UNIQUE NOT NULL, PASSWORD_HASH VARCHAR(255) NOT NULL, CREATED_AT TIMESTAMP DEFAULT CURRENT_TIMESTAMP)");

      stmt.execute(
          "CREATE TABLE ACCOUNTS (ACCOUNT_NO INT PRIMARY KEY, USER_ID INT, ACCOUNT_TYPE VARCHAR(10) NOT NULL DEFAULT 'SAVINGS' CHECK (ACCOUNT_TYPE IN ('SAVINGS', 'CHECKING', 'LOAN')), BALANCE DECIMAL(15, 2) NOT NULL DEFAULT 0.00, STATUS VARCHAR(10) NOT NULL DEFAULT 'ACTIVE' CHECK (STATUS IN ('ACTIVE', 'BLOCKED', 'CLOSED')), FOREIGN KEY (USER_ID) REFERENCES USERS(USER_ID) ON DELETE CASCADE)");

      stmt.execute(
          "CREATE TABLE TRANSACTIONS (ID SERIAL PRIMARY KEY, SENDER_ACCOUNT INT NULL, RECEIVER_ACCOUNT INT NULL, AMOUNT DECIMAL(15, 2) NOT NULL, TX_TYPE VARCHAR(15) NOT NULL CHECK (TX_TYPE IN ('TRANSFER', 'DEPOSIT', 'WITHDRAWAL')), REMARK VARCHAR(255), CREATED_AT TIMESTAMP DEFAULT CURRENT_TIMESTAMP, FOREIGN KEY (SENDER_ACCOUNT) REFERENCES ACCOUNTS(ACCOUNT_NO))");

      return "✅ Database reset successfully! All tables dropped and recreated. Try signing up now.";

    } catch (Exception e) {
      return "❌ Error: " + e.getMessage();
    }
  }

  @GetMapping("/db-status")
  public String checkDatabase() {
    try (Connection conn = ConnectionManager.getConnection();
        Statement stmt = conn.createStatement()) {

      var rs1 = stmt.executeQuery("SELECT COUNT(*) FROM USERS");
      rs1.next();
      int userCount = rs1.getInt(1);

      var rs2 = stmt.executeQuery("SELECT COUNT(*) FROM ACCOUNTS");
      rs2.next();
      int accountCount = rs2.getInt(1);

      var rs3 = stmt.executeQuery("SELECT COUNT(*) FROM TRANSACTIONS");
      rs3.next();
      int txCount = rs3.getInt(1);

      return String.format("📊 Users: %d | Accounts: %d | Transactions: %d", userCount, accountCount, txCount);

    } catch (Exception e) {
      return "❌ Error: " + e.getMessage();
    }
  }
}
