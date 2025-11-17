package com.jobmate.controller;

import com.jobmate.dto.MemberDto;
import com.jobmate.domain.Member;
import com.jobmate.domain.CommunityPost;
import com.jobmate.service.MemberService;
import com.jobmate.service.CommunityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;
import java.util.Base64;
import java.util.List;

@Controller
@RequestMapping("/member")
public class LoginController {

    @Autowired
    private MemberService memberService;

    @Autowired
    private CommunityService communityService;   // ⭐ 추가됨

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

    /** 🔥 프로필 페이지 */
    @GetMapping("/profile")
    public String profilePage(HttpSession session, Model model) {

        Member loginMember = (Member) session.getAttribute("loginMember");

        if (loginMember == null) {
            return "redirect:/member/login";
        }

        // 🔥 프로필 Base64 변환
        if (loginMember.getProfileImageBlob() != null) {
            String base64 = Base64.getEncoder().encodeToString(loginMember.getProfileImageBlob());
            model.addAttribute("profileBase64", base64);
        }

        // 🔥 "내가 좋아요한 게시물" 조회
        List<CommunityPost> likedPosts = communityService.getLikedPosts(loginMember.getId());
        model.addAttribute("likedPosts", likedPosts);

        model.addAttribute("member", loginMember);
        return "member/profile";
    }

    /** 🔥 프로필 업데이트 */
    @PostMapping("/profile/update")
    public String updateProfile(@RequestParam(value = "profileImageFile", required = false) MultipartFile profileImageFile,
                                Member member,
                                HttpSession session,
                                RedirectAttributes ra) {

        Member loginMember = (Member) session.getAttribute("loginMember");
        if (loginMember == null) {
            return "redirect:/member/login";
        }

        // 🔒 변경 불가 값 유지
        member.setId(loginMember.getId());
        member.setUsername(loginMember.getUsername());
        member.setPassword(loginMember.getPassword());

        try {
            if (profileImageFile != null && !profileImageFile.isEmpty()) {
                member.setProfileImageBlob(profileImageFile.getBytes());
            } else {
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
}
