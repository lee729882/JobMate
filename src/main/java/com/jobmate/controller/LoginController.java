package com.jobmate.controller;

import com.jobmate.dto.MemberDto;
import com.jobmate.domain.Member;
import com.jobmate.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/member")
public class LoginController {

    @Autowired
    private MemberService memberService;

    // 로그인 폼
    @GetMapping("/login")
    public String loginForm(Model model) {
        if (!model.containsAttribute("member")) {
            model.addAttribute("member", new MemberDto());
        }
        return "login"; // /WEB-INF/views/login.jsp
    }

    // 로그인 처리
    @PostMapping("/login")
    public String doLogin(@ModelAttribute("member") MemberDto memberDto,
                          HttpSession session,
                          RedirectAttributes ra,
                          Model model) {
        Member found = memberService.authenticate(memberDto.getUsername(), memberDto.getPassword());
        if (found == null) {
            model.addAttribute("error", "아이디 또는 비밀번호가 올바르지 않습니다.");
            return "login";
        }
        session.setAttribute("loginMember", found);
        ra.addFlashAttribute("loginMsg", found.getUsername() + "님 환영합니다!");
        return "redirect:/member/success"; // 성공 후 원하는 경로로 변경 가능
    }

    // 로그아웃
    @PostMapping("/logout")
    public String logout(HttpSession session, RedirectAttributes ra) {
        session.invalidate();
        ra.addFlashAttribute("loginMsg", "로그아웃 되었습니다.");
        return "redirect:/member/login";
    }
}
