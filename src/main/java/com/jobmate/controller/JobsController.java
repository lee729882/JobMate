package com.jobmate.controller;

import com.jobmate.domain.Member;
import com.jobmate.dto.JobPosting;
import com.jobmate.service.JobAggregationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class JobsController {

    @Autowired
    private JobAggregationService jobAggService;

    @GetMapping("/jobs/recommendations")
    public String recommendations(HttpSession session, Model model) {
        Member login = (Member) session.getAttribute("LOGIN_MEMBER");
        if (login == null) return "redirect:/member/login";

        List<JobPosting> jobs = jobAggService.getRecommendations(login.getId(), 1, 20);
        model.addAttribute("jobs", jobs);
        return "jobs/recommendations";
    }
}
