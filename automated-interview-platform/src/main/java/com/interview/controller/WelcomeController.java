package com.interview.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.Map;

@RestController
public class WelcomeController {

    @GetMapping("/")
    public Map<String, Object> welcome() {
        Map<String, Object> response = new HashMap<>();
        response.put("application", "Automated Interview Platform");
        response.put("version", "1.0.0");
        response.put("status", "Running");
        response.put("description", "A web-based application to streamline and automate the hiring process");
        
        Map<String, String> endpoints = new HashMap<>();
        endpoints.put("Register", "POST /api/auth/register");
        endpoints.put("Login", "POST /api/auth/login");
        endpoints.put("Public Test", "GET /api/test/all");
        endpoints.put("H2 Console", "GET /h2-console");
        
        response.put("availableEndpoints", endpoints);
        response.put("documentation", "See README.md for complete API documentation");
        
        return response;
    }

    @GetMapping("/health")
    public Map<String, String> health() {
        Map<String, String> status = new HashMap<>();
        status.put("status", "UP");
        status.put("timestamp", java.time.Instant.now().toString());
        return status;
    }
}
