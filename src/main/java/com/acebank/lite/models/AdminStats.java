package com.acebank.lite.models;

import java.math.BigDecimal;

public record AdminStats(
    long totalUsers,
    long totalAccounts,
    BigDecimal totalBalance,
    long totalTransactions
) {}
