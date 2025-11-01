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

    /** ✅ 로그인 폼 */
    @GetMapping("/login")
    public String loginForm(Model model) {
        if (!model.containsAttribute("member")) {
            model.addAttribute("member", new MemberDto());
        }
        return "login"; // /WEB-INF/views/login.jsp
    }

    /** ✅ 로그인 처리 */
    @PostMapping("/login")
    public String doLogin(@ModelAttribute("member") MemberDto memberDto,
                          HttpSession session,
                          RedirectAttributes ra,
                          Model model) {

        // 1️⃣ 회원 인증
        Member found = memberService.authenticate(memberDto.getUsername(), memberDto.getPassword());

        if (found == null) {
            model.addAttribute("error", "아이디 또는 비밀번호가 올바르지 않습니다.");
            return "login";
        }

        // 2️⃣ 로그인 성공 → 세션에 사용자 정보 저장
        session.setAttribute("loginMember", found);
        ra.addFlashAttribute("loginMsg", found.getUsername() + "님 환영합니다!");

        // 3️⃣ 로그인 성공 시 대시보드로 이동
        return "redirect:/member/dashboard";
    }

    /** ✅ 로그아웃 처리 */
    @PostMapping("/logout")
    public String logout(HttpSession session, RedirectAttributes ra) {
        session.invalidate();
        ra.addFlashAttribute("loginMsg", "로그아웃 되었습니다.");
        return "redirect:/member/login";
    }

    /** ✅ 로그인 후 사용자 전용 대시보드 */
    @GetMapping("/member/profile")
    public String dashboard(HttpSession session, Model model) {
        Member loginMember = (Member) session.getAttribute("loginMember");

        if (loginMember == null) {
            return "redirect:/member/login"; // 세션 만료 시 로그인 페이지로
        }

        model.addAttribute("loginMember", loginMember);
        return "dashboard"; // /WEB-INF/views/dashboard.jsp
    }

}
