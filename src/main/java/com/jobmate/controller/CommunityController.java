package com.jobmate.controller;

import com.jobmate.domain.CommunityPost;
import com.jobmate.domain.Member;
import com.jobmate.service.CommunityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.util.Base64;
import java.util.List;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/community")
public class CommunityController {

    @Autowired
    private CommunityService communityService;

    /** 🔥 커뮤니티 메인 페이지 */
    @GetMapping("/{category}")
    public String communityPage(
            @PathVariable String category,
            Model model,
            HttpSession session) {

        Member loginUser = (Member) session.getAttribute("loginMember");

        if (loginUser == null) {
            return "redirect:/member/login";
        }

        // 로그인 유저 프로필 Base64 변환
        String loginUserBase64 = null;
        if (loginUser.getProfileImageBlob() != null) {
            loginUserBase64 = Base64.getEncoder().encodeToString(loginUser.getProfileImageBlob());
        }

        model.addAttribute("profileBase64", loginUserBase64);
        model.addAttribute("loginUser", loginUser);
        model.addAttribute("category", category);

        // 게시글 목록 + 작성자 프로필 Base64 변환
        List<CommunityPost> rawPosts = communityService.getPostsByCategory(category);

        List<CommunityPost> convertedPosts = rawPosts.stream().map(post -> {

            // 작성자 프로필 이미지 Base64 처리
            if (post.getWriterProfileBlob() != null) {
                String base64 = "data:image/png;base64," +
                        Base64.getEncoder().encodeToString(post.getWriterProfileBlob());
                post.setWriterProfileBase64(base64);
            }

            // 게시글 이미지 Base64 처리
            if (post.getPostImageBlob() != null) {
                String base64 = "data:image/png;base64," +
                        Base64.getEncoder().encodeToString(post.getPostImageBlob());
                post.setPostImageBase64(base64);
            }

            return post;
        }).collect(Collectors.toList());

        model.addAttribute("posts", convertedPosts);

        return "member/community";
    }


    /** 🔥 게시물 작성 */
    @PostMapping("/{category}/write")
    public String writePost(
            @PathVariable String category,
            @RequestParam String title,
            @RequestParam String content,
            @RequestParam(value = "postImageFile", required = false) MultipartFile postImageFile,
            HttpSession session) {

        Member loginUser = (Member) session.getAttribute("loginMember");

        if (loginUser == null) {
            return "redirect:/member/login";
        }

        try {
            // 게시물 이미지 BLOB 생성
            byte[] postImageBytes = (postImageFile != null && !postImageFile.isEmpty())
                    ? postImageFile.getBytes()
                    : null;

            // 저장
            communityService.savePost(
                    category,
                    title,
                    content,
                    loginUser.getUsername(),
                    loginUser.getProfileImageBlob(),
                    postImageBytes // 🔥 게시물 이미지 BLOB
            );

        } catch (Exception e) {
            e.printStackTrace();
        }

        return "redirect:/community/" + category;
    }

    /** 🔥 게시물 삭제 */
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
