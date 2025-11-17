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
import java.util.Map;

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

        // 게시물 목록
        List<CommunityPost> posts = communityService.getPostsByCategory(category, loginUser.getId());
        model.addAttribute("posts", posts);

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
            byte[] postImageBytes = null;

            if (postImageFile != null && !postImageFile.isEmpty()) {
                postImageBytes = postImageFile.getBytes();
            }

            communityService.savePost(
                    category,
                    title,
                    content,
                    loginUser.getUsername(),
                    loginUser.getProfileImageBlob(),
                    postImageBytes
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
        if (loginUser == null) return "redirect:/member/login";

        CommunityPost post = communityService.getPost(id, loginUser.getId());
        if (post == null) return "redirect:/community/" + category;

        if (!post.getWriter().equals(loginUser.getUsername())) {
            return "redirect:/community/" + category + "?error=forbidden";
        }

        communityService.deletePost(id);
        return "redirect:/community/" + category;
    }

    /** ❤️ 좋아요 토글 */
    @PostMapping("/{category}/{postId}/like")
    @ResponseBody
    public Map<String, Object> toggleLike(
            @PathVariable String category,
            @PathVariable Long postId,
            HttpSession session) {

        Member loginUser = (Member) session.getAttribute("loginMember");

        if (loginUser == null) {
            return Map.of("status", "NOT_LOGGED_IN");
        }

        boolean liked = communityService.toggleLike(postId, loginUser.getId());
        int newCount = communityService.getLikeCount(postId);

        return Map.of(
                "status", liked ? "LIKED" : "UNLIKED",
                "likeCount", newCount,
                "postId", postId
        );
    }

    /** 🔥 게시글 수정(JSON 결과 반환) */
    @PostMapping("/{category}/{id}/edit")
    @ResponseBody
    public Map<String, Object> editPost(
            @PathVariable String category,
            @PathVariable Long id,
            @RequestParam String title,
            @RequestParam String content,
            @RequestParam(value = "postImageFile", required = false) MultipartFile postImageFile,
            HttpSession session) {

        Member loginUser = (Member) session.getAttribute("loginMember");
        if (loginUser == null) {
            return Map.of("status", "NOT_LOGIN");
        }

        CommunityPost post = communityService.getPost(id, loginUser.getId());
        if (post == null) {
            return Map.of("status", "NO_POST");
        }

        if (!post.getWriter().equals(loginUser.getUsername())) {
            return Map.of("status", "FORBIDDEN");
        }

        try {
            byte[] newImg = post.getPostImageBlob();
            if (postImageFile != null && !postImageFile.isEmpty()) {
                newImg = postImageFile.getBytes();
            }

            communityService.updatePost(id, title, content, newImg);

            String base64Image = null;
            if (newImg != null) {
                base64Image = "data:image/png;base64," +
                        Base64.getEncoder().encodeToString(newImg);
            }

            return Map.of(
                    "status", "OK",
                    "title", title,
                    "content", content,
                    "imageBase64", base64Image
            );

        } catch (Exception e) {
            e.printStackTrace();
            return Map.of("status", "ERROR");
        }
    }
}
