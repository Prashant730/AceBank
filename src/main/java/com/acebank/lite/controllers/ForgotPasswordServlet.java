package com.acebank.lite.controllers;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.util.Properties;
import java.util.Random;

import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/ForgotPasswordServlet")
public class ForgotPasswordServlet extends HttpServlet {


    private final String senderEmail = "ap9645605@gmail.com";
    private final String appPassword = "kjfe dgrv suzq tbma";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession();

        if ("send_otp".equals(action)) {
            String email = request.getParameter("email");

            // 1. Generate 6-digit OTP
            String otp = String.format("%06d", new Random().nextInt(999999));

            // 2. Save to session for verification later
            session.setAttribute("generated_otp", otp);
            session.setAttribute("reset_email", email);
            session.setAttribute("otp_sent", true);

            // 3. Send the actual Email
            try {
                sendEmail(email, otp);
                request.setAttribute("message", "OTP has been sent to " + email);
            } catch (Exception e) {
                request.setAttribute("message", "Error sending email: " + e.getMessage());
            }

            request.getRequestDispatcher("reset-password.jsp").forward(request, response);

        } else if ("verify_otp".equals(action)) {
            String userOtp = request.getParameter("otp");
            String sessionOtp = (String) session.getAttribute("generated_otp");
            String newPass = request.getParameter("newPassword");
            String email = (String) session.getAttribute("reset_email");

            if (userOtp != null && userOtp.equals(sessionOtp)) {

                // 4. Update Database
                boolean isUpdated = updatePasswordInDB(email, newPass);

                if (isUpdated) {
                    session.invalidate(); // Security: Clear session after success
                    response.sendRedirect("login.jsp?msg=reset_success");
                } else {
                    request.setAttribute("message", "Database error. Could not update password.");
                    request.getRequestDispatcher("reset-password.jsp").forward(request, response);
                }
            } else {
                request.setAttribute("message", "Invalid OTP. Please try again.");
                request.getRequestDispatcher("reset-password.jsp").forward(request, response);
            }
        }
    }

    private void sendEmail(String recipientEmail, String otp) throws MessagingException {
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        Session mailSession = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(senderEmail, appPassword);
            }
        });

        Message message = new MimeMessage(mailSession);
        message.setFrom(new InternetAddress(senderEmail));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipientEmail));
        message.setSubject("AceBank Security: Password Reset OTP");

        String htmlContent = "<div style='font-family: Arial; border: 1px solid #14b8a6; padding: 20px; border-radius: 10px;'>" +
                "<h2 style='color: #14b8a6;'>AceBank Security</h2>" +
                "<p>Your One-Time Password (OTP) for resetting your password is:</p>" +
                "<h1 style='letter-spacing: 5px; color: #333;'>" + otp + "</h1>" +
                "<p>This code will expire shortly. Do not share this with anyone.</p>" +
                "</div>";

        message.setContent(htmlContent, "text/html");
        Transport.send(message);
    }

    private boolean updatePasswordInDB(String email, String newPassword) {
        boolean rowUpdated = false;
        String sql = "UPDATE USERS SET PASSWORD_HASH = ? WHERE EMAIL = ?";

        try {
            String hashedPassword = com.acebank.lite.util.PasswordUtil.hashPassword(newPassword);
            try (Connection connection = com.acebank.lite.util.ConnectionManager.getConnection();
                 PreparedStatement statement = connection.prepareStatement(sql)) {

                statement.setString(1, hashedPassword);
                statement.setString(2, email);
                rowUpdated = statement.executeUpdate() > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return rowUpdated;
    }
}