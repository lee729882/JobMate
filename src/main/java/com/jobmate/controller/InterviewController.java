package com.jobmate.controller;

import java.util.HashMap;
import java.util.Map;

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

    /** 면접 AI 연습 화면 */
    @GetMapping
    public String interviewPage() {
        return "member/interview";
    }

    /** 피드백 + 기록 저장 */
    @PostMapping("/feedback")
    @ResponseBody
    public InterviewResponse getInterviewFeedback(@RequestBody InterviewRequest req,
                                                  HttpSession session) {

        String question = req.getQuestion();
        String answer   = req.getAnswer();

        // 로그인 회원 PK(Long) 추출
        Long memberId = null;
        Object loginObj = session.getAttribute("loginMember");

        if (loginObj instanceof Member) {
            Member loginMember = (Member) loginObj;
            memberId = loginMember.getId();            // ★ PK(Long)
        }

        if (memberId == null) {
            return new InterviewResponse("로그인 후 이용 가능합니다.");
        }

        // 1) AI 피드백 생성 (예외는 내부에서 처리하도록 구현)
        String feedback = interviewAiService.getFeedback(question, answer);

        // 2) DB 저장
        InterviewHistory history = new InterviewHistory();
        history.setMemberId(memberId);
        history.setQuestion(question);
        history.setAnswer(answer);
        history.setFeedback(feedback);

        interviewHistoryService.save(history);

        // 3) 피드백 반환
        return new InterviewResponse(feedback);
    }

    /** 내 면접 기록 목록 */
    @GetMapping("/history")
    public String historyList(HttpSession session, Model model) {

        Long memberId = null;
        Object loginObj = session.getAttribute("loginMember");

        if (loginObj instanceof Member) {
            memberId = ((Member) loginObj).getId();
        }

        if (memberId == null) {
            model.addAttribute("historyList", java.util.Collections.emptyList());
            return "member/interview_history";
        }

        model.addAttribute("historyList",
                interviewHistoryService.getListByMember(memberId));

        return "member/interview_history";
    }

    /** 내 면접 기록 상세 */
    @GetMapping("/history/{id}")
    public String historyDetail(@PathVariable("id") Long id,
                                HttpSession session,
                                Model model) {

        Long memberId = null;
        Object loginObj = session.getAttribute("loginMember");

        if (loginObj instanceof Member) {
            memberId = ((Member) loginObj).getId();
        }

        if (memberId == null) {
            return "redirect:/member/login";
        }

        InterviewHistory history =
                interviewHistoryService.getDetail(id, memberId);

        model.addAttribute("history", history);

        return "member/interview_history_detail";
    }

    /** 랜덤 질문 API */
    @PostMapping("/question")
    @ResponseBody
    public Map<String, String> getRandomQuestion(HttpSession session) {

        Member loginMember = (Member) session.getAttribute("loginMember");
        String careerType = (loginMember != null) ? loginMember.getCareerType() : null;

        String position = "서버·네트워크 개발 직무";

        String question = interviewAiService.getRandomQuestion(position, careerType);

        Map<String, String> result = new HashMap<>();
        result.put("question", question);
        return result;
    }
}
