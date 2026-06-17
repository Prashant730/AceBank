<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Error - AceBank</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdn.jsdelivr.net/npm/remixicon/fonts/remixicon.css" rel="stylesheet">
    <style>
        body { background: #060b18; }
        .glass-card {
            background: rgba(255,255,255,0.03);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(20,184,166,0.15);
        }
    </style>
</head>
<body class="min-h-screen flex items-center justify-center px-4 text-slate-200">

    <div class="glass-card rounded-3xl p-10 max-w-md w-full text-center">

        <%-- Show error code if available --%>
        <% Integer errorCode = (Integer) request.getAttribute("errorCode");
           String errorTitle = (String) request.getAttribute("errorTitle");
           String errorMessage = (String) request.getAttribute("errorMessage");
        %>

        <% if (errorCode != null && errorCode > 0) { %>
            <p class="text-6xl font-extrabold text-red-400 mb-2"><%= errorCode %></p>
        <% } else { %>
            <div class="inline-flex items-center justify-center w-16 h-16 rounded-2xl bg-red-500/10 border border-red-500/20 mb-4">
                <i class="ri-error-warning-line text-3xl text-red-400"></i>
            </div>
        <% } %>

        <h2 class="text-xl font-bold text-white mb-2">
            <%= (errorTitle != null && !errorTitle.isEmpty()) ? errorTitle : "Something Went Wrong" %>
        </h2>
        <p class="text-slate-400 text-sm mb-8">
            <%= (errorMessage != null && !errorMessage.isEmpty()) ? errorMessage : "An unexpected error occurred. Please try again or contact support." %>
        </p>

        <div class="flex flex-col sm:flex-row items-center justify-center gap-3">
            <a href="${pageContext.request.contextPath}/"
               class="bg-teal-500 text-black font-bold px-6 py-2.5 rounded-xl hover:scale-105 transition text-sm">
                <i class="ri-home-4-line mr-1"></i>Go Home
            </a>
            <a href="javascript:history.back()"
               class="border border-teal-500/20 text-teal-400 font-bold px-6 py-2.5 rounded-xl hover:bg-teal-500/10 transition text-sm">
                <i class="ri-arrow-left-line mr-1"></i>Go Back
            </a>
        </div>

        <p class="text-slate-600 text-xs mt-8">&copy; 2026 AceBank International</p>
    </div>

</body>
</html>