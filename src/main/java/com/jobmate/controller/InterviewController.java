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

/**
 * 면접 AI 연습 + 기록 조회 컨트롤러
 *
 * 실제 접속 URL 예시 (contextPath = /controller 일 때)
 *  - 면접 연습 화면     : GET  /controller/member/interview
 *  - 피드백 요청(AJAX) : POST /controller/member/interview/feedback
 *  - 기록 목록         : GET  /controller/member/interview/history
 *  - 기록 상세         : GET  /controller/member/interview/history/{id}
 */
@Controller
@RequestMapping("/member/interview")
public class InterviewController {

    @Autowired
    private InterviewAiService interviewAiService;

    @Autowired
    private InterviewHistoryService interviewHistoryService;

    /**
     * 면접 AI 연습 화면
     * GET /controller/member/interview
     */
    @GetMapping
    public String interviewPage() {
        return "member/interview"; // /WEB-INF/views/member/interview.jsp
    }

    /**
     * 면접 질문/답변을 받아 AI 피드백을 생성하고 DB에 기록까지 저장
     *
     * POST /controller/member/interview/feedback
     * 요청: JSON { "question": "...", "answer": "..." }
     * 응답: JSON { "feedback": "..." }
     */
    @PostMapping("/feedback")
    @ResponseBody
    public InterviewResponse getInterviewFeedback(@RequestBody InterviewRequest req,
                                                  HttpSession session) {

        String question = req.getQuestion();
        String answer   = req.getAnswer();

        // ★ 로그인 사용자 username 가져오기 (없으면 guest)
        String memberId = "guest";

        Object loginObj = session.getAttribute("loginMember"); // 세션 키는 프로젝트에 맞게
        if (loginObj instanceof Member) {
            Member loginMember = (Member) loginObj;
            memberId = loginMember.getUsername();   // ✅ username 사용
        }

        // ① AI 피드백 생성
        String feedback = interviewAiService.getFeedback(question, answer);

        // ② DB에 기록 저장
        InterviewHistory history = new InterviewHistory();
        history.setMemberId(memberId);  // InterviewHistory.memberId = String 가정
        history.setQuestion(question);
        history.setAnswer(answer);
        history.setFeedback(feedback);

        interviewHistoryService.save(history);

        // ③ 클라이언트로 피드백만 반환
        return new InterviewResponse(feedback);
    }

    /**
     * 내 면접 기록 목록 페이지
     * GET /controller/member/interview/history
     */
    @GetMapping("/history")
    public String historyList(HttpSession session, Model model) {

        String memberId = "guest";

        Object loginObj = session.getAttribute("loginMember");
        if (loginObj instanceof Member) {
            Member loginMember = (Member) loginObj;
            memberId = loginMember.getUsername();   // ✅ username 사용
        }

        model.addAttribute("historyList",
                interviewHistoryService.getListByMember(memberId));

        return "member/interview_history";  // /WEB-INF/views/member/interview_history.jsp
    }

    /**
     * 내 면접 기록 상세 페이지
     * GET /controller/member/interview/history/{id}
     */
    @GetMapping("/history/{id}")
    public String historyDetail(@PathVariable("id") Long id,
                                HttpSession session,
                                Model model) {

        String memberId = "guest";

        Object loginObj = session.getAttribute("loginMember");
        if (loginObj instanceof Member) {
            Member loginMember = (Member) loginObj;
            memberId = loginMember.getUsername();   // ✅ username 사용
        }

        InterviewHistory history =
                interviewHistoryService.getDetail(id, memberId);

        model.addAttribute("history", history);

        return "member/interview_history_detail";  // /WEB-INF/views/member/interview_history_detail.jsp
    }
}
