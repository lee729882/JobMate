package com.jobmate.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/member/community")
public class MemberCommunitySelectController {

    @GetMapping("/select")
    public String selectPage() {
        return "member/community_select";  // ★ JSP 파일명과 일치하도록 수정
    }
}
