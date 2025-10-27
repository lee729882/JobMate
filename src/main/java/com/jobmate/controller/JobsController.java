package com.jobmate.controller;

import com.jobmate.dto.JobPosting;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/jobs")
public class JobsController {

    @GetMapping("/recommendations")
    public String recommendations(HttpSession session, Model model) {
        // ✅ 로그인 여부 확인
        Object loginMember = session.getAttribute("loginMember");
        if (loginMember == null) {
            // 로그인 안 됐을 경우 다시 로그인 페이지로
            return "redirect:/member/login";
        }

        // ✅ (임시) 샘플 추천 채용 공고 리스트 생성
        List<JobPosting> jobs = new ArrayList<>();

        JobPosting sample1 = new JobPosting();
        sample1.setTitle("백엔드 개발자 (Spring, Oracle)");
        sample1.setCompany("잡메이트 주식회사");
        sample1.setRegionName("서울 강남구");
        sample1.setEmploymentType("정규직");
        sample1.setCareerLevel("신입");
        sample1.setSalaryText("연봉 3,500만원 이상");
        sample1.setSource("잡코리아");
        sample1.setDetailUrl("https://www.jobkorea.co.kr/Recruit/GI_Read/12345678");
        sample1.setPostedAt("2025-10-25");
        sample1.setDeadlineAt("2025-11-15");
        jobs.add(sample1);

        JobPosting sample2 = new JobPosting();
        sample2.setTitle("데이터 분석가 (Python, SQL)");
        sample2.setCompany("데이터랩스");
        sample2.setRegionName("부산 해운대구");
        sample2.setEmploymentType("계약직");
        sample2.setCareerLevel("경력 3년↑");
        sample2.setSalaryText("협의 후 결정");
        sample2.setSource("사람인");
        sample2.setDetailUrl("https://www.saramin.co.kr/zf_user/jobs/relay/view?rec_idx=87654321");
        sample2.setPostedAt("2025-10-22");
        sample2.setDeadlineAt("2025-11-10");
        jobs.add(sample2);

        // ✅ JSP로 jobs 리스트 전달
        model.addAttribute("jobs", jobs);
        model.addAttribute("pageTitle", "맞춤 채용 추천");

        // ✅ JSP 위치: /WEB-INF/views/jobs/recommendations.jsp
        return "jobs/recommendations";
    }
}
