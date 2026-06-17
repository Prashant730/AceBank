package com.acebank.lite.models;

import java.math.BigDecimal;
import java.time.LocalDateTime;

public record UserAccountInfo(
    int userId,
    String firstName,
    String lastName,
    String email,
    String aadhaarNo,
    LocalDateTime createdAt,
    Integer accountNo,
    BigDecimal balance,
    String status,
    String accountType
) {}
