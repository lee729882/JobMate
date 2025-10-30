package com.jobmate.controller;

import com.jobmate.api.EmploymentResponse;
import com.jobmate.api.EmploymentDetailResponse;
import com.jobmate.service.EmploymentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import java.util.List;

@Controller
@RequestMapping("/member/employment") // ✅ 기본 경로
public class EmploymentController {

    @Autowired
    private EmploymentService employmentService;

    /** ✅ 공채속보 목록 */
    @GetMapping("/list")
    public String list(@RequestParam(defaultValue = "1") int page, Model model) {
        List<EmploymentResponse> jobs = employmentService.getEmploymentList(page, 10);
        model.addAttribute("jobs", jobs);
        model.addAttribute("currentPage", page);
        return "/employmentList"; // ✅ JSP: /WEB-INF/views/employmentList.jsp
    }

    /** ✅ 공채속보 상세 */
    @GetMapping("/detail/{empSeqno}") // ✅ 여기 수정
    public String employmentDetail(@PathVariable String empSeqno, Model model) {
        EmploymentDetailResponse detail = employmentService.getEmploymentDetail(empSeqno);
        model.addAttribute("job", detail);
        return "/employmentDetail"; // ✅ JSP: /WEB-INF/views/employmentDetail.jsp
    }
}
