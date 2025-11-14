package com.jobmate.controller;

import com.jobmate.service.CareerService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.*;

@Controller
@RequiredArgsConstructor
@RequestMapping("/controller/career/tests")
public class CareerController {

    private final CareerService service;

    /** 📌 검사 목록 */
    @GetMapping
    public String list(Model model) {
        List<Map<String, Object>> tests = service.getTestList();
        model.addAttribute("tests", tests);
        return "career/tests";
    }

    /** 📌 상세(페이지 분할) */
    @GetMapping("/{qno}")
    public String detail(
            @PathVariable int qno,
            @RequestParam(defaultValue = "1") int page,
            HttpSession session,
            Model model
    ) {

        // 전체 테스트 정보
        Map<String, Object> test = service.getQuestions(qno);
        List<Map<String, Object>> questions = (List<Map<String, Object>>) test.get("questions");

        int pageSize = 10;  // 🔥 한 페이지에 10문항
        int total = questions.size();
        int maxPage = (int) Math.ceil(total / (double) pageSize);

        int start = (page - 1) * pageSize;
        int end = Math.min(start + pageSize, total);

        // 🔥 현재 페이지 문항만 subList 로 잘라서 전달
        List<Map<String, Object>> pageQuestions = questions.subList(start, end);

        // 🔥 기존 응답 가져오기(세션)
        Map<String, String> savedAnswers = 
                (Map<String, String>) session.getAttribute("testAnswers");
        if (savedAnswers == null) savedAnswers = new HashMap<>();

        model.addAttribute("test", test);
        model.addAttribute("questions", pageQuestions);
        model.addAttribute("page", page);
        model.addAttribute("maxPage", maxPage);

        model.addAttribute("answers", savedAnswers); // 🔥 JSP에서 라디오 pre-check

        return "career/test-detail";
    }

    /** 📌 다음 페이지 이동 시 답변 저장 (세션) */
    @RequestMapping("/{qno}/save")
    public String saveAnswers(
            @PathVariable int qno,
            @RequestParam int page,
            HttpServletRequest req,
            HttpSession session
    ) {

        Map<String, String> saved = (Map<String, String>) session.getAttribute("testAnswers");
        if (saved == null) {
            saved = new HashMap<>();
        }

        // 🔥 람다 제거 → 일반 for문 (오류 완전 해결)
        for (Map.Entry<String, String[]> entry : req.getParameterMap().entrySet()) {

            String k = entry.getKey();
            String[] v = entry.getValue();

            if (k.startsWith("answer_")) {

                String value = (v != null && v.length > 0) ? v[0] : "";

                saved.put(k, value);
            }
        }

        session.setAttribute("testAnswers", saved);

        return "redirect:/controller/career/tests/" + qno + "?page=" + page;
    }

    /** 📌 제출 */
    @PostMapping("/submit")
    public String submit(HttpSession session, Model model) {

        // 🔥 세션 저장된 답변 그대로 가져오기
        Map<String, String> body =
                (Map<String, String>) session.getAttribute("testAnswers");

        if (body == null) body = new HashMap<>();

        // 🔥 서비스 호출
        Map<String, Object> resp = service.submit(body);

        // 🔥 제출 후 세션 초기화
        session.removeAttribute("testAnswers");

        model.addAttribute("result", resp);

        return "career/test-submit";
    }
}
