package com.jobmate.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
// 컨텍스트 경로(/controller) 뒤의 루트 경로들을 넉넉히 커버
@RequestMapping
public class HomeController {

    // /controller       → 매칭
    // /controller/      → 매칭
    // /controller/index → 매칭
    // /controller/home  → 매칭
	@GetMapping({"/", "/home", "/index"})
	public String index() {
	    return "redirect:/member/signup";
	}

}
