package com.acebank.lite.controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/loan")
public class LoanServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        try {
            double loanAmount = Double.parseDouble(request.getParameter("loanAmount"));
            int tenure = Integer.parseInt(request.getParameter("loanTenure"));

            // Example: 10% annual interest
            double annualInterestRate = 0.10;

            // Simple EMI Calculation
            double totalInterest = loanAmount * annualInterestRate * (tenure / 12.0);
            double totalPayable = loanAmount + totalInterest;
            double calculatedEmi = Math.round((totalPayable / tenure) * 100.0) / 100.0;

            // Store in session
            session.setAttribute("loanAmount", loanAmount);
            session.setAttribute("loanTenure", tenure);
            session.setAttribute("emi", calculatedEmi);
            session.setAttribute("loanRemaining", totalPayable);

            // Set Success Message
            session.setAttribute("loanMessage", "Loan applied successfully!");
            session.setAttribute("loanMessageType", "success");

        } catch (Exception e) {
            session.setAttribute("loanMessage", "Error applying for loan. Please check inputs.");
            session.setAttribute("loanMessageType", "error");
        }

        // Redirect back to dashboard
        // Replace: response.sendRedirect(request.getContextPath() + "/Home.jsp");

// With this Forward logic:
        request.getRequestDispatcher("/WEB-INF/views/Home.jsp").forward(request, response);
    }
}