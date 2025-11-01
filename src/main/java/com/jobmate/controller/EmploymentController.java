package com.jobmate.controller;

import com.jobmate.api.EmploymentResponse;
import com.jobmate.domain.Member;
import com.jobmate.api.EmploymentDetailResponse;
import com.jobmate.service.EmploymentService;
import com.jobmate.service.FavoriteService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import java.util.List;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/member/employment") // ✅ 기본 경로
public class EmploymentController {

    @Autowired
    private EmploymentService employmentService;
    @Autowired
    private FavoriteService favoriteService;
    /** ✅ 공채속보 목록 */
    @GetMapping("/list")
    public String list(@RequestParam(defaultValue = "1") int page, Model model) {
        List<EmploymentResponse> jobs = employmentService.getEmploymentList(page, 10);
        model.addAttribute("jobs", jobs);
        model.addAttribute("currentPage", page);
        return "/employmentList"; // ✅ JSP: /WEB-INF/views/employmentList.jsp
    }

    /** ✅ 공채속보 상세 */
    @GetMapping("/detail/{empSeqno}")
    public String employmentDetail(@PathVariable String empSeqno,
                                   HttpSession session,
                                   Model model) {
        EmploymentDetailResponse detail = employmentService.getEmploymentDetail(empSeqno);
        model.addAttribute("job", detail);

        // ✅ 출처 지정 (현재는 고용24 API 기반)
        String empSource = "WORK24";
        model.addAttribute("empSource", empSource);

        // ✅ 로그인 사용자 확인
        Member loginMember = (Member) session.getAttribute("loginMember");

        boolean isFavorite = false;
        if (loginMember != null) {
            // ✅ 출처별로 찜 여부 체크
            isFavorite = favoriteService.isFavorite(loginMember.getId(), empSource, empSeqno);
        }

        model.addAttribute("isFavorite", isFavorite);
        return "/employmentDetail";
    }



}
