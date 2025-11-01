package com.jobmate.controller;

import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.jobmate.domain.Member;
import com.jobmate.service.FavoriteService;

@Controller
@RequestMapping("/favorite")
public class FavoriteController {

    @Autowired
    private FavoriteService favoriteService;

    @ResponseBody
    @PostMapping("/toggle")
    public String toggleFavorite(@RequestParam String empSource,
                                 @RequestParam String empSeqno,
                                 @RequestParam String empTitle,
                                 @RequestParam String empCompany,
                                 @RequestParam String empDeadline,
                                 HttpSession session) {

        Member loginMember = (Member) session.getAttribute("loginMember");
        if (loginMember == null) return "unauthorized";

        boolean exists = favoriteService.isFavorite(loginMember.getId(), empSource, empSeqno);
        if (exists) {
            favoriteService.removeFavorite(loginMember.getId(), empSource, empSeqno);
            return "removed";
        } else {
            favoriteService.addFavorite(loginMember.getId(), empSource, empSeqno, empTitle, empCompany, empDeadline);
            return "added";
        }
    }

    /** ✅ 찜 목록 보기 */
    @GetMapping("/list")
    public String favoriteList(HttpSession session, Model model) {
        Member member = (Member) session.getAttribute("loginMember");
        if (member == null) {
            return "redirect:/member/login";
        }

        // ✅ favoriteList.jsp와 이름을 일치시켜야 함
        model.addAttribute("favoriteList", favoriteService.getFavoriteList(member.getId()));
        return "favoriteList";
    }
}
