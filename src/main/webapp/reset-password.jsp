<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Reset Password | AceBank</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-[#081221] text-slate-200 min-h-screen flex items-center justify-center">

    <div class="w-full max-w-md bg-[#0F1C2E]/90 backdrop-blur-2xl border border-teal-400/20 rounded-3xl p-10 shadow-2xl">

        <h2 class="text-3xl font-bold text-white text-center mb-6">Reset Access</h2>

        <%-- Display Error/Success Messages --%>
        <% String msg = (String) request.getAttribute("message");
           if(msg != null) { %>
            <div class="mb-4 p-3 rounded bg-teal-500/20 border border-teal-500 text-teal-300 text-sm">
                <%= msg %>
            </div>
        <% } %>

        <%-- STEP 1: Request OTP --%>
        <% if(session.getAttribute("otp_sent") == null) { %>
        <form action="ForgotPasswordServlet" method="POST" class="space-y-4">
            <input type="hidden" name="action" value="send_otp">
            <label class="block text-sm text-slate-300">Registered Email Address</label>
            <input type="email" name="email" required placeholder="name@email.com"
                   class="w-full px-4 py-3 rounded-xl bg-[#0B1120] border border-slate-700 focus:border-teal-400 outline-none">
            <button type="submit" class="w-full bg-teal-500 py-3 rounded-xl font-bold text-black hover:scale-105 transition">
                Send OTP
            </button>
        </form>

        <%-- STEP 2: Verify OTP & Change Password --%>
        <% } else { %>
        <form action="ForgotPasswordServlet" method="POST" class="space-y-4">
            <input type="hidden" name="action" value="verify_otp">

            <label class="block text-sm text-slate-300">Enter 6-Digit OTP</label>
            <input type="text" name="otp" required maxlength="6" class="w-full px-4 py-3 rounded-xl bg-[#0B1120] border border-slate-700 text-center text-2xl tracking-widest outline-none">

            <label class="block text-sm text-slate-300">New Password</label>
            <input type="password" name="newPassword" required class="w-full px-4 py-3 rounded-xl bg-[#0B1120] border border-slate-700 outline-none">

            <button type="submit" class="w-full bg-cyan-500 py-3 rounded-xl font-bold text-black hover:scale-105 transition">
                Update Password
            </button>
        </form>
        <% } %>
    </div>
</body>
</html>