package com.jobmate.controller;

import com.jobmate.domain.Member;
import com.jobmate.service.CommunityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;

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

        // ✅ loginMember로 읽기
        Member loginUser = (Member) session.getAttribute("loginMember");

        model.addAttribute("loginUser", loginUser);
        model.addAttribute("category", category);
        model.addAttribute("posts", communityService.getPostsByCategory(category));

        return "member/community";
    }

    @PostMapping("/{category}/write")
    public String writePost(
            @PathVariable String category,
            @RequestParam String title,
            @RequestParam String content,
            HttpSession session) {

        // ✅ loginMember로 읽기
        Member loginUser = (Member) session.getAttribute("loginMember");

        if (loginUser == null) {
            return "redirect:/member/login";
        }

        String writer = loginUser.getUsername();
        String profileImage = loginUser.getProfileImage();

        communityService.savePost(category, title, content, writer, profileImage);

        return "redirect:/community/" + category;
    }

    @GetMapping("/{category}/{id}/delete")
    public String deletePost(
            @PathVariable String category,
            @PathVariable Long id,
            HttpSession session) {

        // ✅ loginMember로 읽기
        Member loginUser = (Member) session.getAttribute("loginMember");

        if (loginUser == null) {
            return "redirect:/member/login";
        }

        communityService.deletePost(id);

        return "redirect:/community/" + category;
    }
}
