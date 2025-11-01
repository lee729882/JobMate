package com.jobmate.controller;

import com.jobmate.api.EmploymentResponse;
import com.jobmate.domain.Member;
import com.jobmate.service.EmploymentService;
import com.jobmate.service.FavoriteService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

import javax.servlet.http.HttpSession;

@Controller
public class DashboardController {

    @Autowired
    private EmploymentService employmentService;
    
    @Autowired
    private FavoriteService favoriteService;

    /** ✅ 대시보드 페이지 */
    @GetMapping("/member/dashboard")
    public String dashboard(@RequestParam(defaultValue = "1") int page, Model model, HttpSession session) {
        Member loginMember = (Member) session.getAttribute("loginMember");
        if (loginMember == null) return "redirect:/member/login";

        // ✅ 고용24 API에서 공채 리스트 6개씩 가져오기
        List<EmploymentResponse> jobs = employmentService.getEmploymentList(page, 6);

        model.addAttribute("loginMember", loginMember);
        model.addAttribute("employmentList", jobs);
        model.addAttribute("currentPage", page);
        
        // ✅ 찜 개수 불러오기
        int favoriteCount = favoriteService.getFavoriteCount(loginMember.getId());
        model.addAttribute("favoriteCount", favoriteCount);
        
        return "dashboard"; // /WEB-INF/views/dashboard.jsp
    }
}