package com.jobmate.controller;

import javax.servlet.http.HttpSession;

import com.jobmate.domain.InterviewHistory;
import com.jobmate.dto.InterviewRequest;
import com.jobmate.dto.InterviewResponse;
import com.jobmate.domain.Member;
import com.jobmate.service.InterviewAiService;
import com.jobmate.service.InterviewHistoryService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/member/interview")
public class InterviewController {

    @Autowired
    private InterviewAiService interviewAiService;

    @Autowired
    private InterviewHistoryService interviewHistoryService;

    @GetMapping
    public String interviewPage() {
        return "member/interview";
    }

    @PostMapping("/feedback")
    @ResponseBody
    public InterviewResponse getInterviewFeedback(@RequestBody InterviewRequest req,
                                                  HttpSession session) {

        String question = req.getQuestion();
        String answer   = req.getAnswer();

        // ✅ 로그인 사용자 PK(Long) 가져오기
        Long memberId = null;

        Object loginObj = session.getAttribute("loginMember");
        if (loginObj instanceof Member) {
            Member loginMember = (Member) loginObj;
            memberId = loginMember.getId();   // ★ getId() (PK) 사용
        }

        // ✅ 비로그인(guest)은 저장하지 않도록 처리 (NOT NULL 대응)
        if (memberId == null) {
            return new InterviewResponse("로그인 후 이용 가능합니다.");
        }

        String feedback = interviewAiService.getFeedback(question, answer);

        InterviewHistory history = new InterviewHistory();
        history.setMemberId(memberId);   // ★ InterviewHistory.memberId 를 Long으로 바꾼다는 전제
        history.setQuestion(question);
        history.setAnswer(answer);
        history.setFeedback(feedback);

        interviewHistoryService.save(history);

        return new InterviewResponse(feedback);
    }

    @GetMapping("/history")
    public String historyList(HttpSession session, Model model) {

        Long memberId = null;

        Object loginObj = session.getAttribute("loginMember");
        if (loginObj instanceof Member) {
            Member loginMember = (Member) loginObj;
            memberId = loginMember.getId();
        }

        if (memberId == null) {
            model.addAttribute("historyList", java.util.Collections.emptyList());
            return "member/interview_history";
        }

        model.addAttribute("historyList",
                interviewHistoryService.getListByMember(memberId));

        return "member/interview_history";
    }

    @GetMapping("/history/{id}")
    public String historyDetail(@PathVariable("id") Long id,
                                HttpSession session,
                                Model model) {

        Long memberId = null;

        Object loginObj = session.getAttribute("loginMember");
        if (loginObj instanceof Member) {
            Member loginMember = (Member) loginObj;
            memberId = loginMember.getId();
        }

        if (memberId == null) {
            return "redirect:/member/login";
        }

        InterviewHistory history =
                interviewHistoryService.getDetail(id, memberId);

        model.addAttribute("history", history);

        return "member/interview_history_detail";
    }
}
