package com.jobmate.controller;

import com.jobmate.domain.JobPosting;
import com.jobmate.domain.MemberPreference;
import com.jobmate.domain.Member;
import com.jobmate.service.JobApiService;
import com.jobmate.mapper.MemberPreferenceMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class JobsController {

    @Autowired
    private JobApiService jobApiService;

    @Autowired
    private MemberPreferenceMapper memberPreferenceMapper;

    @GetMapping("/jobs/recommendations")
    public String recommendations(HttpSession session, Model model) {
        // ✅ 세션에서 로그인한 회원 가져오기
        Member member = (Member) session.getAttribute("loginMember");

        if (member == null) {
            model.addAttribute("error", "로그인이 필요합니다.");
            return "member/login"; // 로그인 페이지로 리다이렉트
        }

        // ✅ 회원 선호도 가져오기 (없으면 기본값)
        MemberPreference pref = memberPreferenceMapper.findByMemberId(member.getId());
        if (pref == null) {
            pref = new MemberPreference();
            pref.setRegionCodesCsv("11"); // 서울
            pref.setOccCodesCsv("024");   // IT/개발직
            pref.setKeyword("개발자");
        }

        // ✅ 고용24 API에서 공고 불러오기
        List<JobPosting> jobs = jobApiService.fetchJobs(pref);

        // ✅ JSP로 전달
        model.addAttribute("jobs", jobs);
        model.addAttribute("memberName", member.getName());
        model.addAttribute("pref", pref);

        System.out.println("✅ [INFO] " + member.getName() + "님 추천공고 수: " + jobs.size());
        return "jobs/recommendations";
    }
}
