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

    // ✅ 회원가입 폼
    @GetMapping("/signup")
    public String signupForm(Model model) {
        if (!model.containsAttribute("member")) {
            model.addAttribute("member", new MemberDto());
        }
        return "signup";
    }

    // ✅ 회원가입 처리
    @PostMapping("/signup")
    public String doSignup(@Valid @ModelAttribute("member") MemberDto member,
                           BindingResult bindingResult,
                           RedirectAttributes ra) {

        if (bindingResult.hasErrors()) {
            return "signup";
        }

        try {
            memberService.register(member);
            ra.addAttribute("username", member.getUsername());
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
