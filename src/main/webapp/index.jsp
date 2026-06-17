<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en" class="scroll-smooth">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AceBank | Future of Digital Banking</title>

    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://unpkg.com/@lottiefiles/lottie-player@latest/dist/lottie-player.js"></script>
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
        .reveal {
            opacity: 0; transform: translateY(30px);
            transition: all 0.8s ease-out;
        }
        .reveal.active { opacity: 1; transform: translateY(0); }

        @keyframes float {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-20px); }
        }
        .animate-float { animation: float 4s ease-in-out infinite; }

        #chat-window.active {
            opacity: 1; transform: translateY(0); pointer-events: auto;
        }
    </style>
</head>

<body class="bg-[#0B1120] text-slate-200 overflow-x-hidden">

<div class="parallax-bg"></div>
<div class="parallax-overlay"></div>

<div class="fixed bottom-8 right-8 z-50">
    <button onclick="toggleChat()" class="w-14 h-14 bg-teal-500 rounded-full shadow-2xl shadow-teal-500/50 flex items-center justify-center text-black hover:scale-110 transition-transform active:scale-95">
        <i class="ri-customer-service-2-fill text-2xl"></i>
    </button>
</div>

<div id="chat-window" class="fixed bottom-24 right-8 w-80 md:w-96 h-[500px] glass-card rounded-3xl z-50 translate-y-10 opacity-0 pointer-events-none transition-all duration-500 flex flex-col overflow-hidden shadow-2xl">
    <div class="p-4 bg-teal-500/20 border-b border-teal-500/20 flex justify-between items-center">
        <div class="flex items-center gap-3">
            <div class="w-8 h-8 bg-teal-500 rounded-full flex items-center justify-center text-black">
                <i class="ri-robot-line"></i>
            </div>
            <div>
                <p class="text-sm font-bold">Ace Assistant</p>
                <p class="text-[10px] text-teal-400">Online | AI Powered</p>
            </div>
        </div>
        <button onclick="toggleChat()" class="text-slate-400 hover:text-white"><i class="ri-close-line text-xl"></i></button>
    </div>
    <div id="chat-body" class="flex-1 p-4 overflow-y-auto space-y-4 text-sm">
        <div class="bg-teal-500/10 border border-teal-500/20 p-3 rounded-2xl rounded-tl-none max-w-[85%]">
            Hello! 👋 I'm your AceBank assistant. How can I help you today?
        </div>
    </div>
    <div class="p-4 border-t border-teal-500/10 bg-[#0B1120]/50">
        <div class="relative">
            <input type="text" id="chat-input" placeholder="Type your query..."
                   class="w-full bg-[#0F1C2E] border border-teal-500/20 rounded-full py-2 px-4 pr-10 outline-none focus:border-teal-400 transition text-sm">
            <button onclick="sendMessage()" class="absolute right-2 top-1/2 -translate-y-1/2 text-teal-400">
                <i class="ri-send-plane-2-fill"></i>
            </button>
        </div>
    </div>
</div>

<header class="fixed w-full z-40 bg-[#0B1120]/70 backdrop-blur-xl border-b border-teal-500/20">
    <div class="max-w-7xl mx-auto px-6 py-4 flex justify-between items-center">
        <h1 class="text-2xl font-bold tracking-wider bg-gradient-to-r from-teal-400 to-teal-600 bg-clip-text text-transparent">AceBank</h1>
        <nav>
            <ul class="flex items-center gap-8">
                <li><a href="login.jsp" class="hover:text-teal-400 transition font-medium">Login</a></li>
                <li><a href="sign-up.jsp" class="bg-teal-500 text-black px-6 py-2 rounded-full font-bold shadow-lg shadow-teal-500/30 hover:scale-105 transition">Sign Up</a></li>
            </ul>
        </nav>
    </div>
</header>

<section class="min-h-screen flex items-center pt-24">
    <div class="max-w-7xl mx-auto px-6 grid md:grid-cols-2 gap-12 items-center">
        <div class="reveal">
            <span class="text-xs px-3 py-1 rounded-full bg-teal-500/10 border border-teal-400/30 text-teal-400 uppercase tracking-widest">Trusted by 2M+ Users</span>
            <h1 class="mt-6 text-6xl md:text-7xl font-extrabold leading-tight">Banking Made <br/><span class="text-teal-400">Brighter.</span></h1>
            <p class="mt-6 text-slate-400 text-lg max-w-lg">Seamless digital banking with bank-grade security. Join the future of finance today.</p>
            <div class="mt-10 flex gap-4">
                <a href="sign-up.jsp" class="bg-teal-500 text-black px-8 py-3 rounded-full font-bold hover:shadow-2xl hover:shadow-teal-500/40 transition">Open Account</a>
                <a href="#features" class="px-8 py-3 rounded-full border border-teal-500/30 hover:bg-teal-500/10 transition">Features</a>
            </div>
        </div>
        <div class="relative reveal flex justify-center">

            <lottie-player src="https://assets3.lottiefiles.com/packages/lf20_jcikwtux.json" speed="1" style="width: 100%; max-width: 450px;" loop autoplay></lottie-player>
        </div>
    </div>
</section>



<section id="features" class="py-24 relative overflow-hidden">
    <div class="max-w-7xl mx-auto px-6">
        <div class="text-center mb-16 reveal">
            <h2 class="text-4xl md:text-5xl font-bold">Smart Banking <span class="text-teal-400">Simplified</span></h2>
            <p class="mt-4 text-slate-400">Everything you need to manage your money in one place.</p>
        </div>

        <div class="grid md:grid-cols-3 gap-8">
            <div class="glass-card p-8 rounded-3xl reveal border-t-4 border-t-teal-500">
                <div class="w-12 h-12 bg-teal-500/20 rounded-xl flex items-center justify-center text-teal-400 mb-6">
                    <i class="ri-shield-flash-line text-2xl"></i>
                </div>
                <h3 class="text-xl font-bold mb-3">Security</h3>
                <p class="text-slate-400 leading-relaxed">Your data is protected by 256-bit encryption and multi-factor authentication at every step.</p>
            </div>

            <div class="glass-card p-8 rounded-3xl reveal border-t-4 border-t-teal-500">
                <div class="w-12 h-12 bg-teal-500/20 rounded-xl flex items-center justify-center text-teal-400 mb-6">
                    <i class="ri-flashlight-line text-2xl"></i>
                </div>
                <h3 class="text-xl font-bold mb-3">Instant Transfers</h3>
                <p class="text-slate-400 leading-relaxed">Send and receive money instantly across the globe with zero
                hidden fees and real-time alerts.</p>
            </div>

            <div class="glass-card p-8 rounded-3xl reveal border-t-4 border-t-teal-500">
                <div class="w-12 h-12 bg-teal-500/20 rounded-xl flex items-center justify-center text-teal-400 mb-6">
                    <i class="ri-pie-chart-2-line text-2xl"></i>
                </div>
                <h3 class="text-xl font-bold mb-3">Smart Personal Loans</h3>
                <p class="text-slate-400 leading-relaxed">Get funded in under 24 hours with interest rates starting at
                <span class="text-teal-400 font-bold">8.5% p.a.</span> No paperwork, all digital.</p>
            </div>
        </div>
    </div>
</section>

<section class="py-24 relative overflow-hidden">
    <div class="max-w-5xl mx-auto px-6">
        <div class="reveal glass-card p-12 md:p-20 rounded-[3rem] border-teal-500/40 text-center relative overflow-hidden">

            <div class="absolute -top-24 -left-24 w-64 h-64 bg-teal-500/10 rounded-full blur-[80px]"></div>
            <div class="absolute -bottom-24 -right-24 w-64 h-64 bg-teal-600/10 rounded-full blur-[80px]"></div>

            <div class="relative z-10">
                <h2 class="text-4xl md:text-6xl font-extrabold mb-6 tracking-tight">
                    Ready to <span class="text-teal-400">Step into</span> <br> the Future?
                </h2>
                <p class="text-slate-400 text-lg md:text-xl mb-10 max-w-2xl mx-auto leading-relaxed">
                    Join over 2 million users who are already banking smarter. Setting up your account takes less than 3 minutes.
                </p>

                <div class="flex flex-col sm:flex-row items-center justify-center gap-6">
                    <a href="sign-up.jsp" class="group relative px-10 py-4 bg-teal-500 text-black font-extrabold rounded-full overflow-hidden transition-all hover:scale-105 active:scale-95 shadow-xl shadow-teal-500/20">
                        <span class="relative z-10 flex items-center gap-2">
                            Create Free Account <i class="ri-arrow-right-line transition-transform group-hover:translate-x-1"></i>
                        </span>
                    </a>
                    <a href="login.jsp" class="text-slate-300 font-bold hover:text-teal-400 transition-colors">
                        Already have an account? Log In
                    </a>
                </div>

                <div class="mt-12 flex items-center justify-center gap-8 grayscale opacity-50">
                    <div class="flex items-center gap-2"><i class="ri-shield-check-line text-2xl"></i> <span class="text-[10px] font-bold uppercase tracking-widest">PCI DSS Compliant</span></div>
                    <div class="flex items-center gap-2"><i class="ri-fingerprint-line text-2xl"></i> <span class="text-[10px] font-bold uppercase tracking-widest">Biometric Secure</span></div>
                </div>
            </div>
        </div>
    </div>
</section>

<footer class="pt-24 pb-12 border-t border-teal-500/10">
    <div class="max-w-7xl mx-auto px-6">
        <div class="grid md:grid-cols-4 gap-12 mb-16">
            <div class="col-span-1 md:col-span-1">
                <h1 class="text-2xl font-bold bg-gradient-to-r from-teal-400 to-teal-600 bg-clip-text text-transparent mb-6">AceBank</h1>
                <p class="text-slate-400 text-sm leading-relaxed">
                    Revolutionizing the way you interact with your money. Fast, secure, and always open.
                </p>
            </div>
            <div>
                <h4 class="font-bold mb-6">Products</h4>
                <ul class="space-y-4 text-sm text-slate-400">
                    <li><a href="#" class="hover:text-teal-400 transition">Digital Savings</a></li>
                    <li><a href="#" class="hover:text-teal-400 transition">Credit Cards</a></li>
                    <li><a href="#" class="hover:text-teal-400 transition">Crypto Wallet</a></li>
                </ul>
            </div>
            <div>
                <h4 class="font-bold mb-6">Company</h4>
                <ul class="space-y-4 text-sm text-slate-400">
                    <li><a href="#" class="hover:text-teal-400 transition">About Us</a></li>
                    <li><a href="#" class="hover:text-teal-400 transition">Careers</a></li>
                    <li><a href="#" class="hover:text-teal-400 transition">Privacy Policy</a></li>
                </ul>
            </div>
            <div>
                <h4 class="font-bold mb-6">Stay Connected</h4>
                <div class="flex gap-4 mb-6">
                    <a href="#" class="w-10 h-10 rounded-full glass-card flex items-center justify-center hover:bg-teal-500 hover:text-black transition"><i class="ri-twitter-fill"></i></a>
                    <a href="#" class="w-10 h-10 rounded-full glass-card flex items-center justify-center hover:bg-teal-500 hover:text-black transition"><i class="ri-linkedin-fill"></i></a>
                    <a href="#" class="w-10 h-10 rounded-full glass-card flex items-center justify-center hover:bg-teal-500 hover:text-black transition"><i class="ri-instagram-line"></i></a>
                </div>
                <p class="text-xs text-slate-500">Subscribe to our newsletter for updates.</p>
            </div>
        </div>
        <div class="text-center text-slate-500 text-xs border-t border-teal-500/5 pt-8">
            &copy; 2026 AceBank International. All Rights Reserved. Licensed by Central Bank.
        </div>
    </div>
</footer>

<script>
    // Toggle Chat Window
    function toggleChat() {
        document.getElementById('chat-window').classList.toggle('active');
    }

    // Send Message Logic
    function sendMessage() {
        const input = document.getElementById('chat-input');
        const body = document.getElementById('chat-body');
        if (!input.value.trim()) return;

        body.innerHTML += `<div class="bg-slate-700/50 p-3 rounded-2xl rounded-tr-none max-w-[80%] ml-auto text-right text-white">${input.value}</div>`;
        const userText = input.value.toLowerCase();
        input.value = "";
        body.scrollTop = body.scrollHeight;

        setTimeout(() => {
            let reply = "That's a great question! Let me check that for you.";
            if(userText.includes("hello")) reply = "Hi Anurag! How can AceBank help you today?";
            if(userText.includes("loan")) reply = "We offer personal loans starting at 8.5% interest!";
            if(userText.includes("card")) reply = "Our Ace Platinum card offers 5% cashback on all transactions.";

            body.innerHTML += `<div class="bg-teal-500/10 border border-teal-500/20 p-3 rounded-2xl rounded-tl-none max-w-[85%] text-slate-200">${reply}</div>`;
            body.scrollTop = body.scrollHeight;
        }, 800);
    }

    // Scroll Animations
    const observer = new IntersectionObserver((entries) => {
        entries.forEach(e => { if(e.isIntersecting) e.target.classList.add('active'); });
    }, { threshold: 0.1 });
    document.querySelectorAll('.reveal').forEach(el => observer.observe(el));

    // Counter Animation
    const counters = document.querySelectorAll('.counter');
    counters.forEach(c => {
        const update = () => {
            const target = +c.getAttribute('data-target');
            const count = +c.innerText.replace(/,/g, '');
            const inc = target / 100;
            if (count < target) {
                c.innerText = Math.ceil(count + inc).toLocaleString();
                setTimeout(update, 20);
            } else { c.innerText = target.toLocaleString() + '+'; }
        };
        const cObs = new IntersectionObserver((e) => { if(e[0].isIntersecting) update(); });
        cObs.observe(c);
    });

    // Parallax
    window.addEventListener('scroll', () => {
        document.querySelector('.parallax-bg').style.transform = `translateY(${window.pageYOffset * 0.4}px)`;
    });
</script>



</body>
</html>