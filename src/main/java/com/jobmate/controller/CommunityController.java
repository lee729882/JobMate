package com.jobmate.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/member/community")
public class CommunityController {

    // ✅ 커뮤니티 선택 페이지 (의료, 금융, 개발자, 공기업 선택)
    @GetMapping("/select")
    public String selectCommunity() {
        return "member/community_select";
    }

    // ✅ 각 카테고리별 커뮤니티 게시판 페이지
    @GetMapping("/{category}")
    public ModelAndView communityPage(@PathVariable String category) {
        ModelAndView mv = new ModelAndView("member/community_board");
        mv.addObject("category", category);
        return mv;
    }
}
