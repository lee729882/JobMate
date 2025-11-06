package com.jobmate.controller;

import com.jobmate.service.ChallengeService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.security.Principal;

@Controller
@RequestMapping("/member/challenge")
@RequiredArgsConstructor
public class ChallengeController {

    private final ChallengeService svc;

    /** 공용 미션 목록 표시 */
    @GetMapping
    public String list(Model model, Principal principal) {
        String username = (principal != null) ? principal.getName() : "guest";
        model.addAttribute("todos", svc.listActive());
        model.addAttribute("me", username);
        return "challenge"; // JSP 파일명 (challenge.jsp)
    }

    /** 미션 완료 버튼 처리 */
    @PostMapping("/complete")
    public String complete(@RequestParam Long todoId, Principal principal, RedirectAttributes ra) {
        String user = (principal != null) ? principal.getName() : "guest";
        try {
            int award = svc.complete(todoId, user);
            ra.addFlashAttribute("msg", "✅ 미션 완료! +" + award + "점 획득");
        } catch (Exception e) {
            ra.addFlashAttribute("err", "❌ " + e.getMessage());
        }
        return "redirect:/member/challenge";
    }
}
