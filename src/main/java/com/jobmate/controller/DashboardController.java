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

@Controller
public class DashboardController {

    @Autowired
    private EmploymentService employmentService;
    
    @Autowired
    private FavoriteService favoriteService;
    
    @Autowired
    private UserScoreMapper userScoreMapper;  // ✅ Object 말고 정확한 타입으로 선언

    /** ✅ 대시보드 페이지 */
    @GetMapping("/member/dashboard")
    public String dashboard(@RequestParam(defaultValue = "1") int page, Model model, HttpSession session) {

        // ✅ 로그인 정보 확인
        Member loginMember = (Member) session.getAttribute("loginMember");
        if (loginMember == null) return "redirect:/member/login";

        // ✅ 고용24 API에서 공채 리스트 6개씩 가져오기
        List<EmploymentResponse> jobs = employmentService.getEmploymentList(page, 6);

        model.addAttribute("loginMember", loginMember);
        model.addAttribute("employmentList", jobs);
        model.addAttribute("currentPage", page);
        
        // ✅ 찜 개수 불러오기
        int favoriteCount = favoriteService.getFavoriteCount(loginMember.getId());
        model.addAttribute("favoriteCount", favoriteCount);
        
        // ✅ JobMate 점수 (username 필드명은 프로젝트에 맞게 조정)
        String username = loginMember.getUsername();   // ← 필요 시 getEmail() 등으로 수정
        Integer total = userScoreMapper.getTotal(username);  // ⚠️ null 방지 위해 Integer 사용
        int jobmateScore = (total == null) ? 0 : total;      // ✅ null일 경우 0으로 보정
        model.addAttribute("jobmateScore", jobmateScore);    // ✅ JSP에서 ${jobmateScore} 로 표시 가능

        // ✅ JSP 파일 경로 (/WEB-INF/views/dashboard.jsp)
        return "dashboard";
    }
}
