package com.jobmate.controller;

import com.jobmate.domain.CommunityPost;
import com.jobmate.domain.Member;
import com.jobmate.service.CommunityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.Base64;
import java.util.List;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/community")
public class CommunityController {

    @Autowired
    private CommunityService communityService;

    @GetMapping("/{category}")
    public String communityPage(
            @PathVariable String category,
            Model model,
            HttpSession session) {

        Member loginUser = (Member) session.getAttribute("loginMember");

        if (loginUser == null) {
            return "redirect:/member/login";
        }

        // 🔥 1) 로그인 유저 프로필 Base64 변환
        String loginUserBase64 = null;
        if (loginUser.getProfileImageBlob() != null) {
            loginUserBase64 = Base64.getEncoder().encodeToString(loginUser.getProfileImageBlob());
        }

        model.addAttribute("profileBase64", loginUserBase64);
        model.addAttribute("loginUser", loginUser);
        model.addAttribute("category", category);

        // 🔥 2) 게시글 목록
        List<CommunityPost> rawPosts = communityService.getPostsByCategory(category);

        // 🔥 3) 게시글의 writerProfileBlob → Base64 변환
        List<CommunityPost> convertedPosts = rawPosts.stream().map(post -> {

            if (post.getWriterProfileBlob() != null) {
                String base64 = "data:image/png;base64," +
                        Base64.getEncoder().encodeToString(post.getWriterProfileBlob());
                post.setWriterProfileBase64(base64);  // 🔥 JSP에서 출력 가능하게 세팅
            }

            return post;
        }).collect(Collectors.toList());

        model.addAttribute("posts", convertedPosts);

        return "member/community";
    }


    @PostMapping("/{category}/write")
    public String writePost(
            @PathVariable String category,
            @RequestParam String title,
            @RequestParam String content,
            HttpSession session) {

        Member loginUser = (Member) session.getAttribute("loginMember");

        if (loginUser == null) {
            return "redirect:/member/login";
        }

        communityService.savePost(
                category,
                title,
                content,
                loginUser.getUsername(),
                loginUser.getProfileImageBlob()   // 🔥 writerProfileBlob 저장
        );

        return "redirect:/community/" + category;
    }

    @GetMapping("/{category}/{id}/delete")
    public String deletePost(
            @PathVariable String category,
            @PathVariable Long id,
            HttpSession session) {

        Member loginUser = (Member) session.getAttribute("loginMember");

        if (loginUser == null) {
            return "redirect:/member/login";
        }

        communityService.deletePost(id);
        return "redirect:/community/" + category;
    }

}
