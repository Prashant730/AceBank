package com.acebank.lite.controllers;

import com.acebank.lite.models.AdminStats;
import com.acebank.lite.models.Transaction;
import com.acebank.lite.models.UserAccountInfo;
import com.acebank.lite.util.ConnectionManager;
import jakarta.servlet.http.HttpSession;
import lombok.extern.java.Log;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@Log
@Controller
@RequestMapping("/admin")
public class AdminController {

    private static final String ADMIN_USER = "admin";
    private static final String ADMIN_PASS = "admin123";

    @GetMapping("/login")
    public String showLogin() {
        return "forward:/admin-login.jsp";
    }

    @PostMapping("/login")
    public String processLogin(@RequestParam String username,
                                @RequestParam String password,
                                HttpSession session) {
        if (ADMIN_USER.equals(username) && ADMIN_PASS.equals(password)) {
            session.setAttribute("isAdmin", true);
            session.setAttribute("adminUser", username);
            return "redirect:/admin/dashboard";
        }
        return "redirect:/admin/login?error=true";
    }

    @GetMapping("/dashboard")
    public String dashboard(Model model, HttpSession session) {
        if (!isAdmin(session)) return "redirect:/admin/login";

        try {
            model.addAttribute("stats", getStats());
            model.addAttribute("users", getAllUsers());
            model.addAttribute("transactions", getRecentTransactions());
        } catch (Exception e) {
            log.severe("Admin dashboard error: " + e.getMessage());
            model.addAttribute("stats", new AdminStats(0, 0, BigDecimal.ZERO, 0));
            model.addAttribute("users", List.of());
            model.addAttribute("transactions", List.of());
        }

        return "AdminDashboard";
    }

    @PostMapping("/toggle-status")
    public String toggleStatus(@RequestParam int accountNo,
                               @RequestParam String currentStatus,
                               HttpSession session) {
        if (!isAdmin(session)) return "redirect:/admin/login";

        String newStatus = "ACTIVE".equals(currentStatus) ? "BLOCKED" : "ACTIVE";

        try (Connection conn = ConnectionManager.getConnection();
             PreparedStatement ps = conn.prepareStatement(
                 "UPDATE ACCOUNTS SET STATUS = ? WHERE ACCOUNT_NO = ?")) {
            ps.setString(1, newStatus);
            ps.setInt(2, accountNo);
            ps.executeUpdate();
            log.info("Account " + accountNo + " status changed to " + newStatus);
        } catch (SQLException e) {
            log.severe("Failed to toggle account status: " + e.getMessage());
        }

        return "redirect:/admin/dashboard";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.removeAttribute("isAdmin");
        session.removeAttribute("adminUser");
        return "redirect:/admin/login";
    }

    private boolean isAdmin(HttpSession session) {
        return Boolean.TRUE.equals(session.getAttribute("isAdmin"));
    }

    // ---- Data Access ----

    private AdminStats getStats() throws SQLException {
        String sql = "SELECT " +
            "(SELECT COUNT(*) FROM USERS) as totalUsers, " +
            "(SELECT COUNT(*) FROM ACCOUNTS) as totalAccounts, " +
            "(SELECT COALESCE(SUM(BALANCE), 0) FROM ACCOUNTS) as totalBalance, " +
            "(SELECT COUNT(*) FROM TRANSACTIONS) as totalTransactions";

        try (Connection conn = ConnectionManager.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            if (rs.next()) {
                return new AdminStats(
                    rs.getLong("totalUsers"),
                    rs.getLong("totalAccounts"),
                    rs.getBigDecimal("totalBalance"),
                    rs.getLong("totalTransactions")
                );
            }
        }
        return new AdminStats(0, 0, BigDecimal.ZERO, 0);
    }

    private List<UserAccountInfo> getAllUsers() throws SQLException {
        String sql = "SELECT u.USER_ID, u.FIRST_NAME, u.LAST_NAME, u.EMAIL, u.AADHAAR_NO, u.CREATED_AT, " +
                     "a.ACCOUNT_NO, a.BALANCE, a.STATUS, a.ACCOUNT_TYPE " +
                     "FROM USERS u LEFT JOIN ACCOUNTS a ON u.USER_ID = a.USER_ID " +
                     "ORDER BY u.CREATED_AT DESC";

        List<UserAccountInfo> users = new ArrayList<>();
        try (Connection conn = ConnectionManager.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                users.add(new UserAccountInfo(
                    rs.getInt("USER_ID"),
                    rs.getString("FIRST_NAME"),
                    rs.getString("LAST_NAME"),
                    rs.getString("EMAIL"),
                    rs.getString("AADHAAR_NO"),
                    rs.getTimestamp("CREATED_AT") != null ? rs.getTimestamp("CREATED_AT").toLocalDateTime() : null,
                    rs.getObject("ACCOUNT_NO") != null ? rs.getInt("ACCOUNT_NO") : null,
                    rs.getBigDecimal("BALANCE"),
                    rs.getString("STATUS"),
                    rs.getString("ACCOUNT_TYPE")
                ));
            }
        }
        return users;
    }

    private List<Transaction> getRecentTransactions() throws SQLException {
        String sql = "SELECT * FROM TRANSACTIONS ORDER BY CREATED_AT DESC LIMIT 50";

        List<Transaction> txList = new ArrayList<>();
        try (Connection conn = ConnectionManager.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                txList.add(new Transaction(
                    rs.getInt("ID"),
                    rs.getObject("SENDER_ACCOUNT") != null ? rs.getInt("SENDER_ACCOUNT") : null,
                    rs.getObject("RECEIVER_ACCOUNT") != null ? rs.getInt("RECEIVER_ACCOUNT") : null,
                    rs.getBigDecimal("AMOUNT"),
                    rs.getString("TX_TYPE"),
                    rs.getString("REMARK"),
                    rs.getTimestamp("CREATED_AT") != null ? rs.getTimestamp("CREATED_AT").toLocalDateTime() : null
                ));
            }
        }
        return txList;
    }
}
