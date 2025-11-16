package com.jobmate.controller;

import com.jobmate.service.CareerService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;

import javax.servlet.http.*;
import java.util.*;

@Controller
@RequiredArgsConstructor
@RequestMapping("/controller/career/tests")
public class CareerController {

    private final CareerService service;


    /** 검사 목록 페이지 (API 호출 없음 → 직접 정의) */
    @GetMapping
    public String list(Model model) {

        List<Map<String, Object>> tests = new ArrayList<>();

        Map<String, Object> t = new HashMap<>();
        t.put("id", 6);
        t.put("title", "직업가치관검사 (대학생/일반)");
        t.put("desc", "대학생·취준생용 직업 추천 검사");
        tests.add(t);

        model.addAttribute("tests", tests);

        return "career/tests";
    }


    /** 문항 페이지 */
    @GetMapping("/{qno}")
    public String detail(
            @PathVariable int qno,
            @RequestParam(defaultValue = "1") int page,
            HttpSession session,
            Model model
    ) {

        Map<String, Object> test = service.getQuestions(qno);

        List<Map<String, Object>> questions =
                (List<Map<String, Object>>) test.get("questions");

        int pageSize = 10;
        int total = questions.size();
        int maxPage = (int) Math.ceil(total / (double) pageSize);

        int start = (page - 1) * pageSize;
        int end = Math.min(start + pageSize, total);

        List<Map<String, Object>> pageQuestions = questions.subList(start, end);

        /** 🔥🔥🔥 [추가됨] — CareerNet 제출 위해 qitemNo 전체 리스트 저장 */
        if (session.getAttribute("qitemNos") == null) {
            List<Integer> qitemNos = new ArrayList<>();
            for (Map<String, Object> q : questions) {
                qitemNos.add((Integer) q.get("no"));  // qitemNo 저장
            }
            session.setAttribute("qitemNos", qitemNos);
        }
        /** 🔥🔥🔥 끝 */

        Map<String, String> saved =
                (Map<String, String>) session.getAttribute("testAnswers");

        if (saved == null) saved = new HashMap<>();

        model.addAttribute("test", test);
        model.addAttribute("questions", pageQuestions);
        model.addAttribute("page", page);
        model.addAttribute("maxPage", maxPage);
        model.addAttribute("answers", saved);

        return "career/test-detail";
    }


    /** 답변 저장 */
    @PostMapping("/{qno}/save")
    public String save(
            @PathVariable int qno,
            @RequestParam int page,
            HttpServletRequest req,
            HttpSession session
    ) {

    	Map<String, String> saved =
    	        (Map<String, String>) session.getAttribute("testAnswers");

    	if (saved == null) saved = new HashMap<>();

    	for (Map.Entry<String, String[]> entry : req.getParameterMap().entrySet()) {

    	    String k = entry.getKey();
    	    String[] v = entry.getValue();

    	    if (!k.startsWith("answer_")) continue;

    	    if (v == null || v.length == 0 || v[0] == null || v[0].trim().isEmpty()) {
    	        continue;
    	    }

    	    saved.put(k, v[0]);
    	}

    	session.setAttribute("testAnswers", saved);

    	return "redirect:/controller/career/tests/" + qno + "?page=" + page;

    }


    @PostMapping("/submit")
    public String submit(
            @RequestParam String gender,
            @RequestParam String grade,
            HttpSession session,
            Model model) {

        Map<String, String> answers =
                (Map<String, String>) session.getAttribute("testAnswers");

        if (answers == null) answers = new HashMap<>();

        List<Integer> qitemNos = (List<Integer>) session.getAttribute("qitemNos");

        Map<String, Object> resp =
                service.submit(answers, gender, grade, qitemNos);

        System.out.println("======= SUBMIT RESPONSE =======");
        System.out.println("resp = " + resp);

        Object resultObject = resp.get("RESULT");
        System.out.println("RESULT = " + resultObject);

        if (resultObject instanceof Map) {
            Map map = (Map) resultObject;
            System.out.println("inspctSeq = " + map.get("inspctSeq"));
            System.out.println("url = " + map.get("url"));
        }

        System.out.println("==================================");

        session.removeAttribute("testAnswers");

        model.addAttribute("result", resp);
        return "career/test-submit";
    }

    
    @GetMapping("/result-view")
    public String resultView(@RequestParam int seq, Model model) {

        String url = "https://www.career.go.kr/cloud/w/inspect/value/report?seq="
                     + Base64.getEncoder().encodeToString(String.valueOf(seq).getBytes());

        model.addAttribute("url", url);

        return "career/test-result-view";
    }




}