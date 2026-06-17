<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard | AceBank</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://cdn.jsdelivr.net/npm/remixicon/fonts/remixicon.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        * { font-family: 'Inter', sans-serif; }
        body { background: #060b18; }
        .glass { background: rgba(255,255,255,0.02); backdrop-filter: blur(12px); border: 1px solid rgba(20,184,166,0.1); }
        .stat-card { background: linear-gradient(135deg, rgba(20,184,166,0.05), rgba(20,184,166,0.02)); border: 1px solid rgba(20,184,166,0.12); transition: all 0.3s; }
        .stat-card:hover { border-color: rgba(20,184,166,0.3); transform: translateY(-2px); box-shadow: 0 8px 30px rgba(20,184,166,0.08); }
        .tab-btn { transition: all 0.3s; }
        .tab-btn.active { background: rgba(20,184,166,0.15); color: #14b8a6; border-color: rgba(20,184,166,0.3); }
        .table-row { transition: background 0.2s; }
        .table-row:hover { background: rgba(20,184,166,0.04); }
        .badge-active { background: rgba(16,185,129,0.15); color: #34d399; border: 1px solid rgba(16,185,129,0.2); }
        .badge-blocked { background: rgba(239,68,68,0.15); color: #f87171; border: 1px solid rgba(239,68,68,0.2); }
        .badge-deposit { background: rgba(16,185,129,0.12); color: #34d399; }
        .badge-withdrawal { background: rgba(251,191,36,0.12); color: #fbbf24; }
        .badge-transfer { background: rgba(96,165,250,0.12); color: #60a5fa; }
        .action-btn { transition: all 0.2s; }
        .action-btn:hover { transform: scale(1.05); }
        ::-webkit-scrollbar { width: 6px; }
        ::-webkit-scrollbar-track { background: transparent; }
        ::-webkit-scrollbar-thumb { background: rgba(20,184,166,0.2); border-radius: 10px; }
    </style>
</head>
<body class="text-slate-300 min-h-screen">

<!-- Header -->
<header class="sticky top-0 z-50 glass border-b border-teal-500/10">
    <div class="max-w-7xl mx-auto px-6 py-3 flex justify-between items-center">
        <div class="flex items-center gap-3">
            <div class="w-9 h-9 bg-teal-500/15 rounded-xl flex items-center justify-center">
                <i class="ri-shield-keyhole-line text-teal-400 text-lg"></i>
            </div>
            <div>
                <h1 class="text-lg font-bold bg-gradient-to-r from-teal-400 to-teal-500 bg-clip-text text-transparent leading-tight">AceBank Admin</h1>
                <p class="text-[10px] text-slate-500 uppercase tracking-widest">Management System</p>
            </div>
        </div>
        <div class="flex items-center gap-4">
            <div class="hidden sm:flex items-center gap-2 text-sm text-slate-400">
                <div class="w-7 h-7 bg-teal-500/10 rounded-full flex items-center justify-center">
                    <i class="ri-admin-line text-teal-400 text-xs"></i>
                </div>
                <span class="font-medium">${sessionScope.adminUser}</span>
            </div>
            <a href="${pageContext.request.contextPath}/admin/logout"
               class="text-xs bg-red-500/10 text-red-400 border border-red-500/15 px-3 py-1.5 rounded-lg hover:bg-red-500/20 transition">
                <i class="ri-logout-box-r-line mr-1"></i>Logout
            </a>
        </div>
    </div>
</header>

<main class="max-w-7xl mx-auto px-6 py-8">

    <!-- Stats Cards -->
    <div class="grid grid-cols-2 lg:grid-cols-4 gap-4 mb-8">
        <div class="stat-card rounded-2xl p-5">
            <div class="flex items-center justify-between mb-3">
                <div class="w-10 h-10 bg-blue-500/10 rounded-xl flex items-center justify-center">
                    <i class="ri-group-line text-blue-400 text-xl"></i>
                </div>
                <i class="ri-arrow-right-up-line text-teal-500/40"></i>
            </div>
            <p class="text-2xl font-extrabold text-white">${stats.totalUsers()}</p>
            <p class="text-xs text-slate-500 mt-1 uppercase tracking-wider">Total Users</p>
        </div>
        <div class="stat-card rounded-2xl p-5">
            <div class="flex items-center justify-between mb-3">
                <div class="w-10 h-10 bg-teal-500/10 rounded-xl flex items-center justify-center">
                    <i class="ri-bank-card-line text-teal-400 text-xl"></i>
                </div>
                <i class="ri-arrow-right-up-line text-teal-500/40"></i>
            </div>
            <p class="text-2xl font-extrabold text-white">${stats.totalAccounts()}</p>
            <p class="text-xs text-slate-500 mt-1 uppercase tracking-wider">Accounts</p>
        </div>
        <div class="stat-card rounded-2xl p-5">
            <div class="flex items-center justify-between mb-3">
                <div class="w-10 h-10 bg-emerald-500/10 rounded-xl flex items-center justify-center">
                    <i class="ri-money-rupee-circle-line text-emerald-400 text-xl"></i>
                </div>
                <i class="ri-arrow-right-up-line text-teal-500/40"></i>
            </div>
            <p class="text-2xl font-extrabold text-white">
                <fmt:formatNumber value="${stats.totalBalance()}" type="currency" currencySymbol="&#8377;" maxFractionDigits="0"/>
            </p>
            <p class="text-xs text-slate-500 mt-1 uppercase tracking-wider">Total Balance</p>
        </div>
        <div class="stat-card rounded-2xl p-5">
            <div class="flex items-center justify-between mb-3">
                <div class="w-10 h-10 bg-amber-500/10 rounded-xl flex items-center justify-center">
                    <i class="ri-exchange-line text-amber-400 text-xl"></i>
                </div>
                <i class="ri-arrow-right-up-line text-teal-500/40"></i>
            </div>
            <p class="text-2xl font-extrabold text-white">${stats.totalTransactions()}</p>
            <p class="text-xs text-slate-500 mt-1 uppercase tracking-wider">Transactions</p>
        </div>
    </div>

    <!-- Tabs -->
    <div class="flex gap-2 mb-6">
        <button onclick="switchTab('users')" id="tab-users"
                class="tab-btn active text-sm font-semibold px-5 py-2.5 rounded-xl border border-transparent">
            <i class="ri-group-line mr-1.5"></i>Users & Accounts
        </button>
        <button onclick="switchTab('transactions')" id="tab-transactions"
                class="tab-btn text-sm font-semibold px-5 py-2.5 rounded-xl border border-transparent text-slate-500">
            <i class="ri-exchange-funds-line mr-1.5"></i>Transactions
        </button>
    </div>

    <!-- Users Tab -->
    <div id="panel-users" class="glass rounded-2xl overflow-hidden">
        <div class="px-6 py-4 border-b border-teal-500/10 flex items-center justify-between">
            <h2 class="font-bold text-white"><i class="ri-group-line text-teal-400 mr-2"></i>All Users</h2>
            <span class="text-xs text-slate-500">${users.size()} records</span>
        </div>
        <div class="overflow-x-auto">
            <table class="w-full text-sm">
                <thead>
                    <tr class="text-xs text-slate-500 uppercase tracking-wider border-b border-teal-500/5">
                        <th class="text-left px-6 py-3">User</th>
                        <th class="text-left px-4 py-3">Email</th>
                        <th class="text-left px-4 py-3">Account No</th>
                        <th class="text-right px-4 py-3">Balance</th>
                        <th class="text-center px-4 py-3">Type</th>
                        <th class="text-center px-4 py-3">Status</th>
                        <th class="text-center px-4 py-3">Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="u" items="${users}">
                    <tr class="table-row border-b border-white/[0.02]">
                        <td class="px-6 py-3.5">
                            <div class="flex items-center gap-3">
                                <div class="w-8 h-8 rounded-full bg-teal-500/10 flex items-center justify-center text-teal-400 text-xs font-bold flex-shrink-0">
                                    ${u.firstName().substring(0,1)}${u.lastName().substring(0,1)}
                                </div>
                                <div>
                                    <p class="font-semibold text-white text-sm">${u.firstName()} ${u.lastName()}</p>
                                    <p class="text-[10px] text-slate-500">ID: ${u.userId()}</p>
                                </div>
                            </div>
                        </td>
                        <td class="px-4 py-3.5 text-slate-400">${u.email()}</td>
                        <td class="px-4 py-3.5">
                            <c:choose>
                                <c:when test="${u.accountNo() != null}">
                                    <span class="font-mono text-teal-400 text-xs bg-teal-500/5 px-2 py-1 rounded">${u.accountNo()}</span>
                                </c:when>
                                <c:otherwise><span class="text-slate-600 text-xs">N/A</span></c:otherwise>
                            </c:choose>
                        </td>
                        <td class="px-4 py-3.5 text-right font-semibold text-white">
                            <c:choose>
                                <c:when test="${u.balance() != null}">
                                    <fmt:formatNumber value="${u.balance()}" type="currency" currencySymbol="&#8377;"/>
                                </c:when>
                                <c:otherwise>-</c:otherwise>
                            </c:choose>
                        </td>
                        <td class="px-4 py-3.5 text-center">
                            <c:if test="${u.accountType() != null}">
                                <span class="text-[10px] uppercase tracking-wider text-slate-400">${u.accountType()}</span>
                            </c:if>
                        </td>
                        <td class="px-4 py-3.5 text-center">
                            <c:choose>
                                <c:when test="${u.status() == 'ACTIVE'}">
                                    <span class="badge-active text-[10px] font-bold uppercase px-2.5 py-1 rounded-full">Active</span>
                                </c:when>
                                <c:when test="${u.status() == 'BLOCKED'}">
                                    <span class="badge-blocked text-[10px] font-bold uppercase px-2.5 py-1 rounded-full">Blocked</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="text-slate-600 text-xs">-</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td class="px-4 py-3.5 text-center">
                            <c:if test="${u.accountNo() != null}">
                                <form action="${pageContext.request.contextPath}/admin/toggle-status" method="POST" style="display:inline">
                                    <input type="hidden" name="accountNo" value="${u.accountNo()}">
                                    <input type="hidden" name="currentStatus" value="${u.status()}">
                                    <c:choose>
                                        <c:when test="${u.status() == 'ACTIVE'}">
                                            <button type="submit" class="action-btn text-xs bg-red-500/10 text-red-400 border border-red-500/15 px-3 py-1.5 rounded-lg hover:bg-red-500/20"
                                                    onclick="return confirm('Block account ${u.accountNo()}?')">
                                                <i class="ri-forbid-line mr-0.5"></i>Block
                                            </button>
                                        </c:when>
                                        <c:otherwise>
                                            <button type="submit" class="action-btn text-xs bg-emerald-500/10 text-emerald-400 border border-emerald-500/15 px-3 py-1.5 rounded-lg hover:bg-emerald-500/20"
                                                    onclick="return confirm('Unblock account ${u.accountNo()}?')">
                                                <i class="ri-check-line mr-0.5"></i>Unblock
                                            </button>
                                        </c:otherwise>
                                    </c:choose>
                                </form>
                            </c:if>
                        </td>
                    </tr>
                    </c:forEach>
                    <c:if test="${empty users}">
                    <tr>
                        <td colspan="7" class="text-center py-12 text-slate-600">
                            <i class="ri-user-unfollow-line text-3xl block mb-2"></i>No users found
                        </td>
                    </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Transactions Tab -->
    <div id="panel-transactions" class="glass rounded-2xl overflow-hidden hidden">
        <div class="px-6 py-4 border-b border-teal-500/10 flex items-center justify-between">
            <h2 class="font-bold text-white"><i class="ri-exchange-funds-line text-teal-400 mr-2"></i>Recent Transactions</h2>
            <span class="text-xs text-slate-500">${transactions.size()} records</span>
        </div>
        <div class="overflow-x-auto">
            <table class="w-full text-sm">
                <thead>
                    <tr class="text-xs text-slate-500 uppercase tracking-wider border-b border-teal-500/5">
                        <th class="text-left px-6 py-3">ID</th>
                        <th class="text-left px-4 py-3">Type</th>
                        <th class="text-left px-4 py-3">Sender</th>
                        <th class="text-left px-4 py-3">Receiver</th>
                        <th class="text-right px-4 py-3">Amount</th>
                        <th class="text-left px-4 py-3">Remark</th>
                        <th class="text-left px-6 py-3">Date</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="tx" items="${transactions}">
                    <tr class="table-row border-b border-white/[0.02]">
                        <td class="px-6 py-3.5 font-mono text-xs text-slate-500">#${tx.id()}</td>
                        <td class="px-4 py-3.5">
                            <c:choose>
                                <c:when test="${tx.txType() == 'DEPOSIT'}">
                                    <span class="badge-deposit text-[10px] font-bold uppercase px-2.5 py-1 rounded-full">Deposit</span>
                                </c:when>
                                <c:when test="${tx.txType() == 'WITHDRAWAL'}">
                                    <span class="badge-withdrawal text-[10px] font-bold uppercase px-2.5 py-1 rounded-full">Withdrawal</span>
                                </c:when>
                                <c:when test="${tx.txType() == 'TRANSFER'}">
                                    <span class="badge-transfer text-[10px] font-bold uppercase px-2.5 py-1 rounded-full">Transfer</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="text-slate-400 text-xs">${tx.txType()}</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td class="px-4 py-3.5">
                            <c:choose>
                                <c:when test="${tx.senderAccount() != null}">
                                    <span class="font-mono text-xs text-slate-300">${tx.senderAccount()}</span>
                                </c:when>
                                <c:otherwise><span class="text-slate-600">-</span></c:otherwise>
                            </c:choose>
                        </td>
                        <td class="px-4 py-3.5">
                            <c:choose>
                                <c:when test="${tx.receiverAccount() != null}">
                                    <span class="font-mono text-xs text-slate-300">${tx.receiverAccount()}</span>
                                </c:when>
                                <c:otherwise><span class="text-slate-600">-</span></c:otherwise>
                            </c:choose>
                        </td>
                        <td class="px-4 py-3.5 text-right font-semibold text-emerald-400">
                            <fmt:formatNumber value="${tx.amount()}" type="currency" currencySymbol="&#8377;"/>
                        </td>
                        <td class="px-4 py-3.5 text-slate-400 text-xs">${tx.remark()}</td>
                        <td class="px-6 py-3.5 text-xs text-slate-500">${tx.createdAt()}</td>
                    </tr>
                    </c:forEach>
                    <c:if test="${empty transactions}">
                    <tr>
                        <td colspan="7" class="text-center py-12 text-slate-600">
                            <i class="ri-exchange-line text-3xl block mb-2"></i>No transactions yet
                        </td>
                    </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>

</main>

<!-- Footer -->
<footer class="max-w-7xl mx-auto px-6 py-6 text-center text-xs text-slate-600 border-t border-teal-500/5 mt-8">
    &copy; 2026 AceBank Management System. All rights reserved.
</footer>

<script>
    function switchTab(tab) {
        document.getElementById('panel-users').classList.add('hidden');
        document.getElementById('panel-transactions').classList.add('hidden');
        document.getElementById('tab-users').classList.remove('active');
        document.getElementById('tab-users').classList.add('text-slate-500');
        document.getElementById('tab-transactions').classList.remove('active');
        document.getElementById('tab-transactions').classList.add('text-slate-500');

        document.getElementById('panel-' + tab).classList.remove('hidden');
        document.getElementById('tab-' + tab).classList.add('active');
        document.getElementById('tab-' + tab).classList.remove('text-slate-500');
    }
</script>

</body>
</html>
