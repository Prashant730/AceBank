package com.acebank.lite.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class IndexController {

    @GetMapping("/")
    public String index() {
        // Uses the view resolver: prefix=/WEB-INF/views/ suffix=.jsp
        // But index.jsp lives in webapp root, so we redirect to it directly
        return "redirect:/index.jsp";
    }
}
