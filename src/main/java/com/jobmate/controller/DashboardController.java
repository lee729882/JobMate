package com.jobmate.controller;

import com.jobmate.api.EmploymentResponse;
import com.jobmate.domain.Member;
import com.jobmate.mapper.UserScoreMapper;
import com.jobmate.service.EmploymentService;
import com.jobmate.service.FavoriteService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

@Controller
public class DashboardController {

    @Autowired
    private EmploymentService employmentService;

    @Autowired
    private FavoriteService favoriteService;

    @Autowired
    private UserScoreMapper userScoreMapper;  // ✅ 정확한 타입

    /** ✅ 대시보드 페이지 */
    @GetMapping("/member/dashboard")
    public String dashboard(@RequestParam(defaultValue = "1") int page,
                            Model model,
                            HttpSession session) {

        // ✅ 로그인 정보 확인
        Member loginMember = (Member) session.getAttribute("loginMember");
        if (loginMember == null) {
            return "redirect:/member/login";
        }

        String username   = loginMember.getUsername();
        String careerType = loginMember.getCareerType();   // NEW / EXP

        // ✅ 고용24 API에서 공채 리스트 6개씩 가져오기
        List<EmploymentResponse> jobs = employmentService.getEmploymentList(page, 6);

        model.addAttribute("loginMember", loginMember);
        model.addAttribute("employmentList", jobs);
        model.addAttribute("currentPage", page);

        // ✅ 찜 개수 불러오기
        int favoriteCount = favoriteService.getFavoriteCount(loginMember.getId());
        model.addAttribute("favoriteCount", favoriteCount);

        // ✅ JobMate 점수 (USER_SCORE 기준)
        Integer totalScore = userScoreMapper.getTotal(username);   // null 가능
        int jobmateScore = (totalScore == null) ? 0 : totalScore;  // null이면 0점
        model.addAttribute("jobmateScore", jobmateScore);

        // ✅ 랭킹 / 상위 퍼센트 계산 (같은 CAREER_TYPE 내에서만)
        int myRank = 0;
        int totalCnt = 0;
        int topPercent = 0;

        // ⭐ Mapper 쿼리는 getRankInfo(username, careerType) 로 바꿔 둔 상태여야 함
        Map<String, Object> rankInfo = userScoreMapper.getRankInfo(username, careerType);

        if (rankInfo != null) {
            Number r = (Number) rankInfo.get("USER_RANK");
            Number t = (Number) rankInfo.get("TOTAL_CNT");
            Number s = (Number) rankInfo.get("TOTAL_SCORE");

            if (r != null) myRank = r.intValue();
            if (t != null) totalCnt = t.intValue();
            if (s != null) jobmateScore = s.intValue();  // DB 기준 점수로 덮어쓰기(선택)
        }

        // ✅ 상위 퍼센트 계산 (1위면 100%)
        if (totalCnt > 0 && myRank > 0) {
            double ratio = (double) (totalCnt - myRank + 1) / totalCnt;
            topPercent = (int) Math.round(ratio * 100);
        }

        model.addAttribute("myRank", myRank);
        model.addAttribute("rankTotalCnt", totalCnt);
        model.addAttribute("rankTopPercent", topPercent);

        // ✅ JSP 파일 경로 (/WEB-INF/views/dashboard.jsp)
        return "dashboard";
    }
}
