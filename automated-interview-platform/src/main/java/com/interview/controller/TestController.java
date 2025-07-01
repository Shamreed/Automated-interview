package com.interview.controller;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@CrossOrigin(origins = "*", maxAge = 3600)
@RestController
@RequestMapping("/api/test")
public class TestController {
    @GetMapping("/all")
    public String allAccess() {
        return "Public Content.";
    }

    @GetMapping("/candidate")
    @PreAuthorize("hasRole('CANDIDATE') or hasRole('HR') or hasRole('ADMIN')")
    public String candidateAccess() {
        return "Candidate Content.";
    }

    @GetMapping("/hr")
    @PreAuthorize("hasRole('HR') or hasRole('ADMIN')")
    public String hrAccess() {
        return "HR Content.";
    }

    @GetMapping("/admin")
    @PreAuthorize("hasRole('ADMIN')")
    public String adminAccess() {
        return "Admin Content.";
    }
}
