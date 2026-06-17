package com.acebank.lite.controllers;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HealthController {

  @GetMapping("/health")
  public String health() {
    return "AceBank is running!";
  }

  @GetMapping("/test")
  public String test() {
    return "Routing works!";
  }
}
