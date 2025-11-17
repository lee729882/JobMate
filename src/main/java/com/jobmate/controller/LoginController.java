package com.jobmate.controller;

import com.jobmate.dto.MemberDto;
import com.jobmate.domain.Member;
import com.jobmate.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;
import java.util.Base64;

@Controller
@RequestMapping("/member")
public class LoginController {

    @Autowired
    private MemberService memberService;

    /** 로그인 화면 */
    @GetMapping("/login")
    public String loginForm(Model model) {
        if (!model.containsAttribute("member")) {
            model.addAttribute("member", new MemberDto());
        }
        return "login";
    }

    /** 로그인 처리 */
    @PostMapping("/login")
    public String doLogin(@ModelAttribute("member") MemberDto memberDto,
                          HttpSession session,
                          RedirectAttributes ra,
                          Model model) {

        Member found = memberService.authenticate(memberDto.getUsername(), memberDto.getPassword());

        if (found == null) {
            model.addAttribute("error", "아이디 또는 비밀번호가 잘못되었습니다.");
            return "login";
        }

        session.setAttribute("loginMember", found);
        ra.addFlashAttribute("loginMsg", found.getUsername() + "님 환영합니다!");

        return "redirect:/member/dashboard";
    }

    /** 로그아웃 */
    @PostMapping("/logout")
    public String logout(HttpSession session, RedirectAttributes ra) {
        session.invalidate();
        ra.addFlashAttribute("loginMsg", "로그아웃 되었습니다.");
        return "redirect:/member/login";
    }

    /** 프로필 페이지 */
    @GetMapping("/profile")
    public String profilePage(HttpSession session, Model model) {

        Member loginMember = (Member) session.getAttribute("loginMember");

        if (loginMember == null) {
            return "redirect:/member/login";
        }

        // 🔥 BLOB → Base64 변환
        if (loginMember.getProfileImageBlob() != null) {
            String base64 = Base64.getEncoder().encodeToString(loginMember.getProfileImageBlob());
            model.addAttribute("profileBase64", base64);
        }

        model.addAttribute("member", loginMember);
        return "member/profile";
    }

    /** 프로필 업데이트 (BLOB 방식) */
    @PostMapping("/profile/update")
    public String updateProfile(@RequestParam(value = "profileImageFile", required = false) MultipartFile profileImageFile,
                                Member member,
                                HttpSession session,
                                RedirectAttributes ra) {

        Member loginMember = (Member) session.getAttribute("loginMember");
        if (loginMember == null) {
            return "redirect:/member/login";
        }

        // 🔒 변경 불가 항목 유지
        member.setId(loginMember.getId());
        member.setUsername(loginMember.getUsername());
        member.setPassword(loginMember.getPassword());

        try {
            if (profileImageFile != null && !profileImageFile.isEmpty()) {
                // 🔥 파일 → byte[]
                member.setProfileImageBlob(profileImageFile.getBytes());
            } else {
                // 🔥 기존 이미지 유지
                member.setProfileImageBlob(loginMember.getProfileImageBlob());
            }

        } catch (Exception e) {
            e.printStackTrace();
            ra.addFlashAttribute("msg", "프로필 이미지 처리 중 오류 발생!");
        }

        // 🔥 DB 업데이트
        memberService.updateProfile(member);

        // 🔥 세션 업데이트
        Member updated = memberService.findById(member.getId());
        session.setAttribute("loginMember", updated);

        ra.addFlashAttribute("msg", "프로필이 수정되었습니다!");
        return "redirect:/member/profile";
    }
    
    // 비밀번호 찾기 페이지 (GET)
    @GetMapping("/findPw")
    public String findPwForm() {
        return "findPw";  // JSP 경로: /WEB-INF/views/member/findPw.jsp
    }

    // 비밀번호 찾기 처리 (POST)
    @PostMapping("/findPw")
    public String findPw(@RequestParam("username") String username,
                         @RequestParam("email") String email,
                         Model model) {

        boolean ok = memberService.sendTempPassword(username, email);

        if(ok){
            model.addAttribute("msg", "임시 비밀번호가 이메일로 발송되었습니다.");
        } else {
            model.addAttribute("error", "아이디 또는 이메일 정보가 일치하지 않습니다.");
        }

        return "findPw";
    }

}
