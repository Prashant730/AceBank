package com.acebank.lite;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.ServletComponentScan;

@SpringBootApplication
@ServletComponentScan
public class AceBankApplication {

    public static void main(String[] args) {
        SpringApplication.run(AceBankApplication.class, args);
    }
}
