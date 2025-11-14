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
import java.io.File;

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

        model.addAttribute("member", loginMember);
        return "member/profile";
    }

    /** 프로필 업데이트 */
    @PostMapping("/profile/update")
    public String updateProfile(@RequestParam(value = "profileImageFile", required = false) MultipartFile profileImageFile,
                                Member member,
                                HttpSession session,
                                RedirectAttributes ra) {

        Member loginMember = (Member) session.getAttribute("loginMember");

        if (loginMember == null) {
            return "redirect:/member/login";
        }

        // ============================================
        // ★ 필수: ID / username / password 유지
        // ============================================
        member.setId(loginMember.getId());
        member.setUsername(loginMember.getUsername());
        member.setPassword(loginMember.getPassword());

        // ============================================
        // 🔥 프로필 이미지 업로드 처리
        // ============================================
        if (profileImageFile != null && !profileImageFile.isEmpty()) {
            try {
                // 실제 서버 경로
                String uploadDir = session.getServletContext().getRealPath("/resources/profile/");
                File dir = new File(uploadDir);
                if (!dir.exists()) dir.mkdirs();

                // 저장 파일명
                String fileName = "profile_" + loginMember.getId() + "_" +
                        System.currentTimeMillis() + "_" +
                        profileImageFile.getOriginalFilename();

                File saveFile = new File(uploadDir, fileName);

                // 파일 저장
                profileImageFile.transferTo(saveFile);

                // DB에는 상대경로 저장 (JSP에서 불러올 수 있는 경로)
                String webPath = "/resources/profile/" + fileName;
                member.setProfileImage(webPath);

            } catch (Exception e) {
                e.printStackTrace();
                ra.addFlashAttribute("msg", "프로필 이미지 저장 중 오류 발생!");
            }
        } else {
            // 새 이미지 업로드 안 했으면 기존 이미지 그대로 사용
            member.setProfileImage(loginMember.getProfileImage());
        }

        // ============================================
        // 🔥 DB 저장
        // ============================================
        memberService.updateProfile(member);

        // ============================================
        // 🔥 수정 내용 다시 세션에 반영
        // ============================================
        Member updated = memberService.findById(member.getId());
        session.setAttribute("loginMember", updated);

        ra.addFlashAttribute("msg", "프로필이 수정되었습니다!");
        return "redirect:/member/profile";
    }
}
