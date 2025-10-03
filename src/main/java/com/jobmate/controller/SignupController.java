package com.jobmate.controller;

import com.jobmate.dto.MemberDto;
import com.jobmate.exception.DuplicateEmailException;
import com.jobmate.exception.DuplicateUsernameException;
import com.jobmate.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import javax.validation.Valid;  

@Controller
@RequestMapping("/member")
public class SignupController {

    @Autowired
    private MemberService memberService;

    // 회원가입 폼
    @GetMapping("/signup")
    public String signupForm(Model model) {
        if (!model.containsAttribute("member")) {
            model.addAttribute("member", new MemberDto());
        }
        return "signup"; // -> /WEB-INF/views/signup.jsp
    }

    // 회원가입 처리
    @PostMapping("/signup")
    public String doSignup(@Valid @ModelAttribute("member") MemberDto member,
                           BindingResult bindingResult,
                           RedirectAttributes ra,
                           Model model) {
        // 1) DTO 검증 에러(@Valid) 있으면 바로 폼으로
        if (bindingResult.hasErrors()) {
            return "signup";
        }

        try {
            memberService.register(member);

            // 성공 시 PRG
            ra.addAttribute("username", member.getUsername());
            return "redirect:/member/success";

        } catch (DuplicateUsernameException ex) {
            // username 필드에 바인딩 에러 추가
            bindingResult.addError(new FieldError("member", "username", ex.getMessage()));
            return "signup";

        } catch (DuplicateEmailException ex) {
            // email 필드에 바인딩 에러 추가
            bindingResult.addError(new FieldError("member", "email", ex.getMessage()));
            return "signup";

        } catch (Exception e) {
            // 알 수 없는 에러는 글로벌 에러로
            bindingResult.reject("signupFailed", "회원가입 실패: " + e.getMessage());
            return "signup";
        }
    }

    // 가입 성공 페이지
    @GetMapping("/success")
    public String success(@RequestParam(value = "username", required = false) String username,
                          Model model) {
        model.addAttribute("username", username);
        return "signup-success"; // -> /WEB-INF/views/signup-success.jsp
    }
}
