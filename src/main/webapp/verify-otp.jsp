<form action="verifyOtp" method="POST" class="space-y-6">

    <input type="hidden" name="email" value="${email}" />

    <!-- OTP -->
    <div>
        <label class="block text-sm mb-2 text-slate-300">Enter OTP</label>
        <input type="text" name="otp" required
               class="w-full px-4 py-3 rounded-xl bg-[#0B1120]
                      border border-slate-700 focus:border-teal-400
                      focus:ring-2 focus:ring-teal-400/30 outline-none">
    </div>

    <!-- New Password -->
    <div>
        <label class="block text-sm mb-2 text-slate-300">New Password</label>
        <input type="password" name="newPassword" required
               class="w-full px-4 py-3 rounded-xl bg-[#0B1120]
                      border border-slate-700 focus:border-teal-400
                      focus:ring-2 focus:ring-teal-400/30 outline-none">
    </div>

    <button type="submit"
            class="w-full bg-gradient-to-r from-teal-400 via-cyan-400 to-teal-500
                   py-3 rounded-xl font-semibold text-black">
        Verify & Reset
    </button>

</form>