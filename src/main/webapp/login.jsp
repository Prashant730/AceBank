<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<%
    String savedAccount = "";
    Cookie[] cookies = request.getCookies();
    if (cookies != null) {
        for (Cookie c : cookies) {
            if ("rememberedAccount".equals(c.getName())) {
                savedAccount = c.getValue();
                pageContext.setAttribute("savedAccount", savedAccount);
            }
        }
    }
%>

<!DOCTYPE html>
<html lang="en" class="scroll-smooth">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login | AceBank</title>

    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdn.jsdelivr.net/npm/remixicon/fonts/remixicon.css" rel="stylesheet">

    <style>
        .parallax-bg {
            position: fixed; top: 0; left: 0; width: 100%; height: 120%;
            background-image: url('https://images.unsplash.com/photo-1559526324-593bc073d938');
            background-size: cover; background-position: center;
            z-index: -20; will-change: transform;
        }
        .parallax-overlay {
            position: fixed; inset: 0;
            background: linear-gradient(to bottom, rgba(11,17,32,0.85), rgba(11,17,32,0.95));
            z-index: -10;
        }
        .glass-card {
            background: rgba(255, 255, 255, 0.03);
            backdrop-filter: blur(12px);
            border: 1px solid rgba(20, 184, 166, 0.2);
        }
        @keyframes float {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-15px); }
        }
        .animate-float { animation: float 5s ease-in-out infinite; }

        .reveal {
            opacity: 0; transform: translateY(20px);
            transition: all 0.8s ease-out;
        }
        .reveal.active { opacity: 1; transform: translateY(0); }
    </style>
</head>

<body class="bg-[#0B1120] text-slate-200 overflow-x-hidden min-h-screen flex flex-col">

<div class="parallax-bg"></div>
<div class="parallax-overlay"></div>

<header class="fixed w-full z-40 bg-[#0B1120]/70 backdrop-blur-xl border-b border-teal-500/20">
    <div class="max-w-7xl mx-auto px-6 py-4 flex justify-between items-center">
        <h1 class="text-2xl font-bold tracking-wider bg-gradient-to-r from-teal-400 to-teal-600 bg-clip-text text-transparent">AceBank</h1>
        <nav>
            <ul class="flex items-center gap-8">
                <li><a href="index.jsp" class="hover:text-teal-400 transition font-medium">Home</a></li>
                <li><a href="sign-up.jsp" class="bg-teal-500 text-black px-6 py-2 rounded-full font-bold shadow-lg shadow-teal-500/30 hover:scale-105 transition">Sign Up</a></li>
            </ul>
        </nav>
    </div>
</header>

<main class="flex-1 flex items-center justify-center pt-24 px-6">
    <div class="w-full max-w-md reveal animate-float">
        <div class="glass-card rounded-[2.5rem] p-10 shadow-2xl relative overflow-hidden">
            <div class="absolute -top-10 -right-10 w-32 h-32 bg-teal-500/10 blur-3xl rounded-full"></div>

            <div class="text-center mb-10">
                <div class="inline-flex items-center justify-center w-16 h-16 rounded-2xl bg-teal-500/10 border border-teal-500/20 text-teal-400 mb-6">
                    <i class="ri-shield-user-line text-3xl"></i>
                </div>
                <h2 class="text-3xl font-bold text-white tracking-tight">Welcome Back</h2>
                <p class="text-slate-400 mt-2 text-sm">Securely log in to your AceBank portal</p>
            </div>

            <form action="Login" method="POST" class="space-y-6">
                <div>
                    <label for="accNo" class="block text-[10px] uppercase tracking-[0.2em] font-bold mb-2 text-teal-500/80">
                        Account Number
                    </label>
                    <input type="text" id="accNo" name="accountNumber"
                           value="${savedAccount}" required
                           placeholder="Enter Account Number"
                           class="w-full px-4 py-4 rounded-xl bg-[#0B1120]/50 border border-teal-500/20 text-white outline-none focus:border-teal-400 transition placeholder:text-slate-600">
                </div>

                <div>
                    <label for="pass" class="block text-[10px] uppercase tracking-[0.2em] font-bold mb-2 text-teal-500/80">
                        Password
                    </label>
                    <div class="relative">
                        <input type="password" id="pass" name="password"
                               required placeholder="••••••••"
                               class="w-full px-4 py-4 rounded-xl bg-[#0B1120]/50 border border-teal-500/20 text-white outline-none focus:border-teal-400 transition placeholder:text-slate-600">
                    </div>
                </div>

                <div class="flex justify-between items-center text-xs">
                    <label class="flex items-center gap-2 text-slate-400 cursor-pointer group">
                        <input type="checkbox" name="rememberMe" id="remember"
                               class="accent-teal-500 h-4 w-4 rounded border-teal-500/20"
                               <c:if test="${not empty savedAccount}">checked</c:if>>
                        <span class="group-hover:text-slate-200 transition">Remember Me</span>
                    </label>
                    <a href="reset-password.jsp" class="text-teal-400 hover:text-white transition">Forgot Password?</a>
                </div>

                <button type="submit"
                        class="w-full bg-teal-500 py-4 rounded-xl font-extrabold text-black shadow-lg shadow-teal-500/20 hover:scale-[1.02] hover:shadow-teal-500/40 transition-all active:scale-95">
                    Access Account
                </button>
            </form>

            <div class="mt-10 pt-8 border-t border-teal-500/10 text-center">
                <p class="text-slate-400 text-sm">
                    Don't have an account?
                    <a href="sign-up.jsp" class="text-teal-400 font-bold hover:underline">Join AceBank</a>
                </p>
            </div>
        </div>
    </div>
</main>

<footer class="py-8 text-center text-slate-500 text-[10px] uppercase tracking-[0.3em] opacity-60">
    &copy; 2026 AceBank International. All Systems Operational.
</footer>

<script>
    // Trigger reveal animation on load
    window.addEventListener('DOMContentLoaded', () => {
        document.querySelector('.reveal').classList.add('active');
    });

    // Parallax logic matching index.jsp
    window.addEventListener('scroll', () => {
        const bg = document.querySelector('.parallax-bg');
        if (bg) bg.style.transform = `translateY(${window.pageYOffset * 0.4}px)`;
    });
</script>

</body>
</html>