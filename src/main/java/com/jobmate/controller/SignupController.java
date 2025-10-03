package com.jobmate.controller;

import com.jobmate.dto.MemberDto;
import com.jobmate.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/member")
public class SignupController {

    @Autowired
    private MemberService memberService;

    // 회원가입 폼
    @GetMapping("/signup")
    public String signupForm(Model model) {
        if (!model.containsAttribute("member")) {
            model.addAttribute("member", new MemberDto());
        }
        return "signup"; // -> /WEB-INF/views/signup.jsp
    }

    // 회원가입 처리
    @PostMapping("/signup")
    public String doSignup(@ModelAttribute("member") MemberDto member,
                           RedirectAttributes ra,
                           Model model) {
        try {
            // 가입 처리 (DB 저장)
            memberService.register(member);

            // 성공 시 PRG 패턴 적용
            ra.addAttribute("username", member.getUsername());
            return "redirect:/member/success";

        } catch (Exception e) {
            model.addAttribute("error", "회원가입 실패: " + e.getMessage());
            return "signup";
        }
    }

    // 가입 성공 페이지
    @GetMapping("/success")
    public String success(@RequestParam(value = "username", required = false) String username,
                          Model model) {
        model.addAttribute("username", username);
        return "signup-success"; // -> /WEB-INF/views/signup-success.jsp
    }
}
