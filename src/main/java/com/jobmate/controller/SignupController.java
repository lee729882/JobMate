package com.jobmate.controller;

import com.jobmate.dto.MemberDto;
import com.jobmate.exception.DuplicateEmailException;
import com.jobmate.exception.DuplicateUsernameException;
import com.jobmate.service.MemberService;
import com.jobmate.domain.MemberPreference;
import com.jobmate.service.MemberPreferenceService;
import com.jobmate.mapper.ExcelCodeMapper;

import lombok.var;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import com.fasterxml.jackson.databind.ObjectMapper;

import javax.validation.Valid;

@Controller
@RequestMapping("/member")
public class SignupController {

    @Autowired
    private MemberService memberService;

    @Autowired
    private MemberPreferenceService preferenceService;

    // ✅ 회원가입 폼
    @GetMapping("/signup")
    public String signupForm(Model model) {
        if (!model.containsAttribute("member")) {
            model.addAttribute("member", new MemberDto());
        }

        // ✅ Excel → 계층형 Map (대분류 → [ {code,name} ])
        var occMap = ExcelCodeMapper.getGroupedOccupations();
        var regMap = ExcelCodeMapper.getGroupedRegions();

        try {
            ObjectMapper mapper = new ObjectMapper();
            String occJson = mapper.writeValueAsString(occMap);
            String regJson = mapper.writeValueAsString(regMap);

            // ✅ JSP에서 JSON 그대로 사용 가능하도록 모델에 추가
            model.addAttribute("occJson", occJson);
            model.addAttribute("regJson", regJson);

            System.out.println("📘 [DEBUG] 직종/지역 JSON 준비 완료: "
                + "직종=" + occMap.size() + " 지역=" + regMap.size());

        } catch (Exception e) {
            System.err.println("❌ [ERROR] Excel 코드 변환 실패:");
            e.printStackTrace();
        }

        return "signup";
    }

    // ✅ 회원가입 처리
    @PostMapping("/signup")
    public String doSignup(@Valid @ModelAttribute("member") MemberDto member,
                           BindingResult bindingResult,
                           RedirectAttributes ra,
                           Model model) {

        // 검증 실패 시에도 직종/지역 선택 목록을 유지
    	var occMap = ExcelCodeMapper.getGroupedOccupations();
    	var regMap = ExcelCodeMapper.getGroupedRegions();

        try {
            ObjectMapper mapper = new ObjectMapper();
            model.addAttribute("occJson", mapper.writeValueAsString(occMap));
            model.addAttribute("regJson", mapper.writeValueAsString(regMap));
        } catch (Exception e) {
            e.printStackTrace();
        }

        if (bindingResult.hasErrors()) {
            return "signup";
        }

        try {
            // 1️⃣ 회원 정보 저장
            memberService.register(member);

            // 2️⃣ 회원 ID 조회
            Long memberId = memberService.findByUsername(member.getUsername()).getId();

            // 3️⃣ 선호 정보 저장
            MemberPreference pref = new MemberPreference();
            pref.setMemberId(memberId);
            pref.setOccCodesCsv(member.getJobCodesCsv());
            pref.setRegionCodesCsv(member.getWorkRegionCodesCsv());
            pref.setEmploymentType(member.getEmploymentType());
            pref.setCareerLevel(member.getCareerLevel());
            pref.setKeyword(member.getKeyword());

            preferenceService.save(pref);

            // 4️⃣ 성공 페이지로 이동
            ra.addAttribute("username", member.getUsername());
            ra.addAttribute("memberId", memberId);
            return "redirect:/member/success";

        } catch (DuplicateUsernameException ex) {
            bindingResult.addError(new FieldError("member", "username", ex.getMessage()));
            return "signup";
        } catch (DuplicateEmailException ex) {
            bindingResult.addError(new FieldError("member", "email", ex.getMessage()));
            return "signup";
        } catch (Exception e) {
            bindingResult.reject("signupFailed", "회원가입 실패: " + e.getMessage());
            return "signup";
        }
    }

    // ✅ 가입 성공 페이지
    @GetMapping("/success")
    public String success(@RequestParam(value = "username", required = false) String username,
                          Model model) {
        model.addAttribute("username", username);
        return "signup-success";
    }
}
