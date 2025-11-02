package com.jobmate.controller;

import com.jobmate.domain.Member;
import com.jobmate.service.RecentViewedService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/member/recent")
public class RecentViewedController {

    @Autowired
    private RecentViewedService recentViewedService;

    @GetMapping("/list")
    public String recentList(HttpSession session, Model model) {
        Member loginMember = (Member) session.getAttribute("loginMember");
        if (loginMember == null) {
            return "redirect:/member/login";
        }

        List<Map<String, Object>> recentList =
                recentViewedService.getRecentViewedList(loginMember.getId());

        System.out.println("최근 본 공고 리스트 = " + recentList);

        model.addAttribute("recentList", recentList);

        // ✅ JSP가 /WEB-INF/views/member/recentViewedList.jsp 에 있을 경우:
        return "recentViewedList";
    }
}
