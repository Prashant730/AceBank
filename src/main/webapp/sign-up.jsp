<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en" class="scroll-smooth">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign Up | AceBank</title>

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
        .animate-float { animation: float 6s ease-in-out infinite; }

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
                <li><a href="login.jsp" class="hover:text-teal-400 transition font-medium">Login</a></li>
            </ul>
        </nav>
    </div>
</header>

<main class="flex-1 flex items-center justify-center pt-32 pb-12 px-6">
    <div class="w-full max-w-2xl reveal animate-float">
        <div class="glass-card rounded-[2.5rem] p-8 md:p-12 shadow-2xl relative overflow-hidden">

            <div class="absolute -bottom-10 -left-10 w-32 h-32 bg-teal-500/10 blur-3xl rounded-full"></div>

            <div class="text-center mb-10">
                <div class="inline-flex items-center justify-center w-16 h-16 rounded-2xl bg-teal-500/10 border border-teal-500/20 text-teal-400 mb-6">
                    <i class="ri-user-add-line text-3xl"></i>
                </div>
                <h2 class="text-3xl font-bold text-white tracking-tight">Create Account</h2>
                <p class="text-slate-400 mt-2 text-sm">Join thousands managing their money smarter</p>
            </div>

            <% String error = request.getParameter("error");
               if (error != null && !error.isEmpty()) { %>
                <div class="bg-red-500/10 border border-red-500/20 text-red-400 text-sm px-5 py-3 rounded-xl mb-6 flex items-center gap-2">
                    <i class="ri-error-warning-line text-lg"></i>
                    <span><%= error %></span>
                </div>
            <% } %>

            <form action="signup" method="POST" class="space-y-5">

                <div class="grid md:grid-cols-2 gap-5">
                    <div>
                        <label class="block text-[10px] uppercase tracking-[0.2em] font-bold mb-2 text-teal-500/80 ml-1">First Name</label>
                        <input type="text" name="firstName" required
                               placeholder="Enter first name"
                               class="w-full px-4 py-3.5 rounded-xl bg-[#0B1120]/50 border border-teal-500/20 text-white outline-none focus:border-teal-400 transition placeholder:text-slate-600">
                    </div>

                    <div>
                        <label class="block text-[10px] uppercase tracking-[0.2em] font-bold mb-2 text-teal-500/80 ml-1">Last Name</label>
                        <input type="text" name="lastName" required
                               placeholder="Enter last name"
                               class="w-full px-4 py-3.5 rounded-xl bg-[#0B1120]/50 border border-teal-500/20 text-white outline-none focus:border-teal-400 transition placeholder:text-slate-600">
                    </div>
                </div>

                <div>
                    <label class="block text-[10px] uppercase tracking-[0.2em] font-bold mb-2 text-teal-500/80 ml-1">Aadhar Number</label>
                    <input type="text" name="aadharNumber" maxlength="12" required
                           placeholder="12-digit UIDAI number"
                           class="w-full px-4 py-3.5 rounded-xl bg-[#0B1120]/50 border border-teal-500/20 text-white outline-none focus:border-teal-400 transition placeholder:text-slate-600">
                </div>

                <div>
                    <label class="block text-[10px] uppercase tracking-[0.2em] font-bold mb-2 text-teal-500/80 ml-1">Email Address</label>
                    <input type="email" name="email" required
                           placeholder="name@example.com"
                           class="w-full px-4 py-3.5 rounded-xl bg-[#0B1120]/50 border border-teal-500/20 text-white outline-none focus:border-teal-400 transition placeholder:text-slate-600">
                </div>

                <div>
                    <label class="block text-[10px] uppercase tracking-[0.2em] font-bold mb-2 text-teal-500/80 ml-1">Secure Password</label>
                    <input type="password" name="password" minlength="10" required
                           placeholder="Minimum 10 characters"
                           class="w-full px-4 py-3.5 rounded-xl bg-[#0B1120]/50 border border-teal-500/20 text-white outline-none focus:border-teal-400 transition placeholder:text-slate-600">
                </div>

                <div class="pt-4">
                    <button type="submit"
                            class="w-full bg-teal-500 py-4 rounded-xl font-extrabold text-black shadow-lg shadow-teal-500/20 hover:scale-[1.02] hover:shadow-teal-500/40 transition-all active:scale-95">
                        Create Ace Account
                    </button>
                </div>
            </form>

            <div class="mt-8 pt-8 border-t border-teal-500/10 text-center text-sm text-slate-400">
                Already have an account?
                <a href="login.jsp" class="text-teal-400 font-bold hover:underline">Login here</a>
            </div>
        </div>
    </div>
</main>

<footer class="py-6 text-center text-slate-500 text-[10px] uppercase tracking-[0.3em] opacity-60">
    &copy; 2026 AceBank International. Secure Digital Banking.
</footer>

<script>
    // Trigger reveal animation
    window.addEventListener('DOMContentLoaded', () => {
        document.querySelector('.reveal').classList.add('active');
    });

    // Parallax logic
    window.addEventListener('scroll', () => {
        const bg = document.querySelector('.parallax-bg');
        if (bg) bg.style.transform = `translateY(${window.pageYOffset * 0.4}px)`;
    });
</script>

</body>
</html>