<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Create New Password | AceBank</title>

    <!-- Tailwind CSS -->
    <script src="https://cdn.tailwindcss.com"></script>
</head>

<body class="bg-gradient-to-br from-slate-950 via-slate-900 to-slate-800
             flex items-center justify-center min-h-screen text-white">

<div class="w-full max-w-md bg-slate-900/70 backdrop-blur-xl
            border border-slate-700 rounded-3xl shadow-2xl p-8">

    <!-- Header -->
    <div class="text-center mb-8">
        <h1 class="text-3xl font-bold text-teal-400">AceBank</h1>
        <p class="text-slate-400 text-sm mt-2">Create New Password</p>
    </div>

    <!-- Error Message -->
    <%
        String error = request.getParameter("error");
        if (error != null) {
    %>
        <div class="bg-red-500/20 text-red-400 text-sm p-3 rounded-lg mb-4 text-center">
            <%= error %>
        </div>
    <%
        }
    %>

    <!-- Password Form -->
    <form action="updatePassword" method="POST" onsubmit="return validatePasswords()">

        <!-- Hidden Phone Field -->
        <input type="hidden" name="phone"
               value="<%= request.getParameter("phone") %>">

        <!-- New Password -->
        <div class="mb-4">
            <label class="text-sm text-slate-400">New Password</label>
            <input type="password" id="newPassword" name="newPassword" required
                   class="w-full mt-2 px-4 py-3 rounded-xl
                          bg-slate-800 border border-slate-600
                          focus:outline-none focus:ring-2 focus:ring-teal-400">
        </div>

        <!-- Confirm Password -->
        <div class="mb-6">
            <label class="text-sm text-slate-400">Confirm Password</label>
            <input type="password" id="confirmPassword" required
                   class="w-full mt-2 px-4 py-3 rounded-xl
                          bg-slate-800 border border-slate-600
                          focus:outline-none focus:ring-2 focus:ring-cyan-400">
        </div>

        <!-- Submit Button -->
        <button type="submit"
                class="w-full bg-teal-400 hover:bg-teal-500
                       text-black font-semibold py-3 rounded-xl
                       transition duration-300">
            Update Password
        </button>

    </form>

    <!-- Back -->
    <div class="text-center mt-6">
        <a href="login.jsp"
           class="text-slate-400 hover:text-teal-400 text-sm transition">
            Back to Login
        </a>
    </div>

</div>

<script>
    function validatePasswords() {

        const password = document.getElementById("newPassword").value;
        const confirmPassword = document.getElementById("confirmPassword").value;

        if (password.length < 6) {
            alert("Password must be at least 6 characters long.");
            return false;
        }

        if (password !== confirmPassword) {
            alert("Passwords do not match.");
            return false;
        }

        return true;
    }
</script>

</body>
</html>