<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Login | AceBank</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdn.jsdelivr.net/npm/remixicon/fonts/remixicon.css" rel="stylesheet">
    <style>
        body { background: #060b18; }
        .glass-card {
            background: rgba(255,255,255,0.03);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(20,184,166,0.15);
        }
        .glow { box-shadow: 0 0 60px rgba(20,184,166,0.08); }
        .input-field {
            background: rgba(15,28,46,0.8);
            border: 1px solid rgba(20,184,166,0.2);
            transition: all 0.3s;
        }
        .input-field:focus {
            border-color: #14b8a6;
            box-shadow: 0 0 0 3px rgba(20,184,166,0.1);
        }
        @keyframes float { 0%,100%{transform:translateY(0)} 50%{transform:translateY(-8px)} }
        .animate-float { animation: float 3s ease-in-out infinite; }
        @keyframes pulse-glow { 0%,100%{opacity:0.4} 50%{opacity:0.8} }
        .pulse-glow { animation: pulse-glow 3s ease-in-out infinite; }
    </style>
</head>
<body class="min-h-screen flex items-center justify-center px-4">

    <!-- Background Elements -->
    <div class="fixed inset-0 overflow-hidden pointer-events-none">
        <div class="absolute top-1/4 -left-20 w-72 h-72 bg-teal-500/5 rounded-full blur-[100px] pulse-glow"></div>
        <div class="absolute bottom-1/4 -right-20 w-96 h-96 bg-teal-600/5 rounded-full blur-[120px] pulse-glow" style="animation-delay:1.5s"></div>
    </div>

    <div class="relative z-10 w-full max-w-md">
        <!-- Logo -->
        <div class="text-center mb-8">
            <div class="inline-flex items-center justify-center w-16 h-16 rounded-2xl bg-teal-500/10 border border-teal-500/20 mb-4 animate-float">
                <i class="ri-shield-keyhole-line text-3xl text-teal-400"></i>
            </div>
            <h1 class="text-2xl font-bold bg-gradient-to-r from-teal-400 to-teal-600 bg-clip-text text-transparent">AceBank Admin</h1>
            <p class="text-slate-500 text-sm mt-1">Banking Management System</p>
        </div>

        <!-- Login Card -->
        <div class="glass-card glow rounded-3xl p-8">
            <h2 class="text-xl font-bold text-slate-200 mb-1">Welcome back</h2>
            <p class="text-slate-500 text-sm mb-6">Sign in to access the admin panel</p>

            <% if (request.getParameter("error") != null) { %>
                <div class="bg-red-500/10 border border-red-500/20 text-red-400 text-sm px-4 py-3 rounded-xl mb-4 flex items-center gap-2">
                    <i class="ri-error-warning-line"></i> Invalid credentials. Please try again.
                </div>
            <% } %>

            <form action="${pageContext.request.contextPath}/admin/login" method="POST" class="space-y-4">
                <div>
                    <label class="block text-xs font-semibold text-slate-400 uppercase tracking-wider mb-2">Username</label>
                    <div class="relative">
                        <i class="ri-user-3-line absolute left-4 top-1/2 -translate-y-1/2 text-slate-500"></i>
                        <input type="text" name="username" required placeholder="Enter admin username"
                               class="input-field w-full rounded-xl py-3 pl-11 pr-4 text-slate-200 outline-none text-sm">
                    </div>
                </div>

                <div>
                    <label class="block text-xs font-semibold text-slate-400 uppercase tracking-wider mb-2">Password</label>
                    <div class="relative">
                        <i class="ri-lock-2-line absolute left-4 top-1/2 -translate-y-1/2 text-slate-500"></i>
                        <input type="password" name="password" required placeholder="Enter password"
                               class="input-field w-full rounded-xl py-3 pl-11 pr-4 text-slate-200 outline-none text-sm">
                    </div>
                </div>

                <button type="submit"
                        class="w-full bg-gradient-to-r from-teal-500 to-teal-600 text-black font-bold py-3 rounded-xl
                               hover:shadow-lg hover:shadow-teal-500/25 hover:scale-[1.02] active:scale-95 transition-all mt-2">
                    <i class="ri-login-box-line mr-1"></i> Sign In
                </button>
            </form>

            <div class="mt-6 pt-4 border-t border-teal-500/10 text-center">
                <a href="${pageContext.request.contextPath}/" class="text-xs text-slate-500 hover:text-teal-400 transition">
                    <i class="ri-arrow-left-line"></i> Back to AceBank Home
                </a>
            </div>
        </div>

        <p class="text-center text-slate-600 text-xs mt-6">&copy; 2026 AceBank Admin Panel. Authorized personnel only.</p>
    </div>
</body>
</html>
