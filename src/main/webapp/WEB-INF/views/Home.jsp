<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en" class="scroll-smooth">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard | AceBank</title>

    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdn.jsdelivr.net/npm/remixicon/fonts/remixicon.css" rel="stylesheet">

    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        navyDark: '#0B1120',
                        tealPrimary: '#14B8A6',
                        cyanSoft: '#06B6D4'
                    }
                }
            }
        }
    </script>

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
            border-radius: 24px;
        }
        .reveal {
            opacity: 0; transform: translateY(20px);
            transition: all 0.6s ease-out;
        }
        .reveal.active { opacity: 1; transform: translateY(0); }

        @keyframes glowPulse {
            0%, 100% { text-shadow: 0 0 5px rgba(20,184,166,0.3); }
            50% { text-shadow: 0 0 15px rgba(20,184,166,0.6); }
        }
        .balance-animate { animation: glowPulse 2.5s infinite ease-in-out; }

        .input-field {
            width: 100%; padding: 12px 16px; border-radius: 12px;
            background: rgba(11,17,32,0.6); border: 1px solid rgba(20,184,166,0.2);
            color: white; outline: none; transition: all 0.3s ease;
        }
        .input-field:focus { border-color: #14B8A6; background: rgba(11,17,32,0.8); }

        .btn-primary {
            background: #14B8A6; color: black; padding: 10px 16px;
            border-radius: 12px; font-weight: 700; transition: all 0.3s ease;
        }
        .btn-primary:hover { transform: translateY(-2px); box-shadow: 0 10px 20px rgba(20,184,166,0.3); }
    </style>
</head>

<body class="bg-navyDark text-slate-200 min-h-screen overflow-x-hidden">

<div class="parallax-bg"></div>
<div class="parallax-overlay"></div>

<header class="fixed w-full z-40 bg-[#0B1120]/70 backdrop-blur-xl border-b border-teal-500/20">
    <div class="max-w-7xl mx-auto px-6 py-4 flex justify-between items-center">
        <h1 class="text-2xl font-bold bg-gradient-to-r from-teal-400 via-cyan-400 to-teal-600 bg-clip-text text-transparent">AceBank</h1>
        <nav class="flex gap-6 items-center">
            <a href="ChangePassword.jsp" class="text-sm font-medium hover:text-teal-400 transition">Security</a>
            <a href="Logout" class="bg-red-500/10 text-red-400 px-4 py-2 rounded-full text-xs font-bold border border-red-500/20 hover:bg-red-500 hover:text-white transition">Logout</a>
        </nav>
    </div>
</header>

<main class="max-w-7xl mx-auto px-6 pt-28 pb-20 space-y-10 relative z-10">

    <div class="reveal">
        <h2 class="text-4xl font-extrabold">Welcome, <span class="text-teal-400">${sessionScope.firstName}</span></h2>
        <div class="flex items-center gap-3 mt-3">
            <span class="text-xs font-mono text-slate-500 uppercase tracking-widest">Account Number</span>
            <span class="bg-teal-500/10 text-teal-400 px-3 py-1 rounded-full border border-teal-500/20 text-xs font-bold">
                ${sessionScope.accountNumber}
            </span>
        </div>
    </div>

    <div class="grid md:grid-cols-2 lg:grid-cols-4 gap-6">
        <div class="glass-card p-6 reveal">
            <p class="text-[10px] uppercase tracking-widest text-slate-500 font-bold mb-2">Total Balance</p>
            <h1 class="text-4xl font-black text-teal-400 balance-animate">₹ ${sessionScope.balance}</h1>
            <div class="mt-4 flex items-center gap-2 text-[10px] text-green-400 font-bold">
                <i class="ri-shield-check-line"></i> SECURED BY ACE-NODE
            </div>
        </div>

        <div class="glass-card p-6 reveal">
            <h3 class="text-sm font-bold mb-4 flex items-center gap-2"><i class="ri-download-2-line text-teal-400"></i> Deposit</h3>
            <form action="home" method="post" class="space-y-3">
                <input type="text" name="deposit" placeholder="Amount (₹)" class="input-field text-sm" required>
                <button class="btn-primary w-full text-sm">Add Funds</button>
            </form>
        </div>

        <div class="glass-card p-6 reveal">
            <h3 class="text-sm font-bold mb-4 flex items-center gap-2"><i class="ri-send-plane-fill text-teal-400"></i> Transfer</h3>
            <form action="home" method="post" class="space-y-3">
                <input type="text" name="toAccount" placeholder="A/C Number" class="input-field text-sm" required>
                <input type="text" name="toAmount" placeholder="Amount (₹)" class="input-field text-sm" required>
                <button class="btn-primary w-full text-sm">Send Now</button>
            </form>
        </div>

        <div class="glass-card p-6 reveal">
            <h3 class="text-sm font-bold mb-4 flex items-center gap-2"><i class="ri-upload-2-line text-teal-400"></i> Withdraw</h3>
            <form action="home" method="post" class="space-y-3">
                <input type="text" name="withdraw" placeholder="Amount (₹)" class="input-field text-sm" required>
                <button class="btn-primary w-full text-sm">Cash Out</button>
            </form>
        </div>
    </div>

    <div class="grid md:grid-cols-4 gap-6">
        <div class="glass-card p-5 reveal text-center">
            <p class="text-[10px] text-slate-500 uppercase tracking-widest font-bold">Total In</p>
            <h2 id="totalDeposits" class="text-xl font-bold text-green-400 mt-1">₹ 0</h2>
        </div>
        <div class="glass-card p-5 reveal text-center">
            <p class="text-[10px] text-slate-500 uppercase tracking-widest font-bold">Total Out</p>
            <h2 id="totalWithdrawals" class="text-xl font-bold text-red-400 mt-1">₹ 0</h2>
        </div>
        <div class="glass-card p-5 reveal text-center">
            <p class="text-[10px] text-slate-500 uppercase tracking-widest font-bold">Net Growth</p>
            <h2 id="netChange" class="text-xl font-bold text-cyan-400 mt-1">₹ 0</h2>
        </div>
        <div class="glass-card p-5 reveal text-center">
            <p class="text-[10px] text-slate-500 uppercase tracking-widest font-bold">Activity</p>
            <h2 id="totalTransactions" class="text-xl font-bold text-teal-400 mt-1">0</h2>
        </div>
    </div>

    <div class="grid md:grid-cols-2 gap-8 mt-10">
        <div class="glass-card p-8 reveal border-l-4 border-l-cyan-500">
            <h3 class="text-xl font-bold mb-6 text-white flex items-center gap-2">
                <i class="ri-bank-line text-cyan-400"></i> Apply for Loan
            </h3>
            <form action="loan" method="post" class="space-y-4">
                <input type="text" name="loanAmount" placeholder="Loan Amount (₹)" class="input-field" required>
                <select name="loanTenure" class="input-field" required>
                    <option value="" class="bg-navyDark">Select Tenure</option>
                    <option value="6" class="bg-navyDark">6 Months</option>
                    <option value="12" class="bg-navyDark">12 Months</option>
                    <option value="24" class="bg-navyDark">24 Months</option>
                    <option value="36" class="bg-navyDark">36 Months</option>
                </select>
                <button class="btn-primary w-full">Submit Application</button>
            </form>
            <p class="text-[10px] text-slate-500 mt-4 italic font-bold tracking-widest uppercase">Fixed Interest Rate: 10% P.A.</p>
        </div>

        <div class="glass-card p-8 reveal border-l-4 border-l-teal-500">
            <h3 class="text-xl font-bold mb-6 text-white flex items-center gap-2">
                <i class="ri-file-list-3-line text-teal-400"></i> Active Loan Summary
            </h3>
            <div class="space-y-4 text-sm font-medium">
                <div class="flex justify-between border-b border-white/5 pb-2">
                    <span class="text-slate-400">Principal</span>
                    <span class="text-cyan-400">₹ ${sessionScope.loanAmount != null ? sessionScope.loanAmount : '0'}</span>
                </div>
                <div class="flex justify-between border-b border-white/5 pb-2">
                    <span class="text-slate-400">Monthly EMI</span>
                    <span class="text-green-400">₹ ${sessionScope.emi != null ? sessionScope.emi : '0'}</span>
                </div>
                <div class="flex justify-between border-b border-white/5 pb-2">
                    <span class="text-slate-400">Payable Balance</span>
                    <span class="text-red-400">₹ ${sessionScope.loanRemaining != null ? sessionScope.loanRemaining : '0'}</span>
                </div>
            </div>
            <form action="payEmi" method="post" class="mt-8">
                <button class="btn-primary w-full bg-transparent border border-teal-500 text-teal-400 hover:bg-teal-500 hover:text-black">
                    Pay Monthly EMI
                </button>
            </form>
        </div>
    </div>

    <c:if test="${not empty sessionScope.loanMessage}">
        <div id="loanAlert" class="reveal fixed top-24 right-6 z-50">
            <div class="px-6 py-4 rounded-2xl glass-card border ${sessionScope.loanMessageType == 'success' ? 'border-teal-500 shadow-teal-500/20' : 'border-red-500 shadow-red-500/20'}">
                <p class="font-bold text-sm flex items-center gap-2">
                    <i class="${sessionScope.loanMessageType == 'success' ? 'ri-checkbox-circle-fill text-teal-400' : 'ri-error-warning-fill text-red-400'} text-xl"></i>
                    ${sessionScope.loanMessage}
                </p>
            </div>
        </div>
        <script>
            setTimeout(() => {
                const alert = document.getElementById('loanAlert');
                if (alert) { alert.style.opacity = '0'; setTimeout(() => alert.remove(), 500); }
            }, 3000);
        </script>
        <% session.removeAttribute("loanMessage"); session.removeAttribute("loanMessageType"); %>
    </c:if>

    <section class="glass-card p-8 reveal">
        <div class="flex flex-col md:flex-row justify-between items-start md:items-center gap-4 mb-8">
            <h3 class="text-2xl font-bold tracking-tight">Recent Activity</h3>
            <button class="bg-white/5 hover:bg-white/10 px-5 py-2 rounded-full border border-white/10 text-xs font-bold transition">Export History</button>
        </div>

        <div class="overflow-x-auto">
            <table class="w-full text-sm text-left">
                <thead>
                    <tr class="text-slate-500 border-b border-teal-500/10">
                        <th class="pb-4 font-bold uppercase tracking-widest text-[10px]">Timestamp</th>
                        <th class="pb-4 font-bold uppercase tracking-widest text-[10px]">Category</th>
                        <th class="pb-4 font-bold uppercase tracking-widest text-[10px]">Reference</th>
                        <th class="pb-4 font-bold uppercase tracking-widest text-[10px] text-right">Amount</th>
                    </tr>
                </thead>
                <tbody class="divide-y divide-white/5">
                    <c:forEach var="tx" items="${sessionScope.transactionDetailsList}">
                        <tr class="hover:bg-white/5 transition">
                            <td class="py-4 text-slate-400 font-mono text-xs">${tx.createdAt()}</td>
                            <td class="py-4">
                                <span class="px-2 py-1 rounded text-[10px] font-black uppercase ${tx.txType() == 'DEPOSIT' ? 'bg-green-500/10 text-green-400' : 'bg-red-500/10 text-red-400'}">
                                    ${tx.txType()}
                                </span>
                            </td>
                            <td class="py-4 text-slate-300 font-medium">${tx.remark()}</td>
                            <td class="py-4 text-right font-bold text-white">₹ ${tx.amount()}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </section>

</main>

<footer class="py-10 text-center text-slate-500 text-[10px] uppercase tracking-[0.4em] opacity-40">
    &copy; 2026 AceBank International. All Systems Operational.
</footer>

<script>
    // Parallax logic
    window.addEventListener('scroll', () => {
        document.querySelector('.parallax-bg').style.transform = `translateY(${window.pageYOffset * 0.4}px)`;
    });

    // Reveal animations
    const observer = new IntersectionObserver((entries) => {
        entries.forEach(e => { if(e.isIntersecting) e.target.classList.add('active'); });
    }, { threshold: 0.1 });
    document.querySelectorAll('.reveal').forEach(el => observer.observe(el));

    // Stats Logic (Preserved)
    let depositTotal = 0;
    let withdrawTotal = 0;
    let transactionCount = 0;

    <c:forEach var="tx" items="${sessionScope.transactionDetailsList}">
        transactionCount++;
        if ("${tx.txType()}" === "DEPOSIT") {
            depositTotal += ${tx.amount()};
        } else if ("${tx.txType()}" === "WITHDRAWAL") {
            withdrawTotal += ${tx.amount()};
        }
    </c:forEach>

    document.getElementById("totalDeposits").innerText = "₹ " + depositTotal;
    document.getElementById("totalWithdrawals").innerText = "₹ " + withdrawTotal;
    document.getElementById("netChange").innerText = "₹ " + (depositTotal - withdrawTotal);
    document.getElementById("totalTransactions").innerText = transactionCount;
</script>

</body>
</html>