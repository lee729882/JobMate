package com.jobmate.controller;

import com.jobmate.domain.Member;
import com.jobmate.mapper.UserScoreMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/member")
@RequiredArgsConstructor
public class RankingController {

    private final UserScoreMapper userScoreMapper;

    /** 직렬별 JobMate 랭킹 페이지 */
    @GetMapping("/ranking")
    public String ranking(Model model, HttpSession session) {

        Member loginMember = (Member) session.getAttribute("loginMember");
        if (loginMember == null) {
            return "redirect:/member/login";
        }

        String username   = loginMember.getUsername();
        String careerType = loginMember.getCareerType(); // 이미 대시보드에서 쓰던 필드

        // 같은 직렬에 속한 사람들의 랭킹 리스트
        List<Map<String, Object>> rankingList =
                userScoreMapper.findTypeRanking(careerType);

        int myRank  = 0;
        int myScore = 0;

        // 내 랭킹/점수 찾기
        for (Map<String, Object> row : rankingList) {
            String rowUser = (String) row.get("USERNAME");
            if (username.equals(rowUser)) {
                Number r = (Number) row.get("RANK_IN_TYPE");
                Number s = (Number) row.get("TOTAL_SCORE");
                if (r != null) myRank  = r.intValue();
                if (s != null) myScore = s.intValue();
                break;
            }
        }

        model.addAttribute("loginMember", loginMember);
        model.addAttribute("careerType", careerType);
        model.addAttribute("rankingList", rankingList);
        model.addAttribute("myRank", myRank);
        model.addAttribute("myScore", myScore);

        return "ranking";   // /WEB-INF/views/ranking.jsp 로 포워드
    }
}
