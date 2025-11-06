package com.jobmate.controller;

import com.jobmate.domain.PublicTodo;
import com.jobmate.mapper.PublicTodoMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/admin/public-todo")
@RequiredArgsConstructor
public class AdminPublicTodoController {

    private final PublicTodoMapper m;

    /** 미션 목록 + 등록 폼 */
    @GetMapping
    public String list(Model model) {
        model.addAttribute("todos", m.findActive());
        model.addAttribute("todo", new PublicTodo());
        return "admin_public_todo"; // JSP 이름
    }

    /** 미션 등록 */
    @PostMapping("/add")
    public String add(@ModelAttribute PublicTodo t) {
        if (t.getDifficulty() <= 0) t.setDifficulty(1);
        if (t.getBasePoints() <= 0) t.setBasePoints(10);
        m.insert(t);
        return "redirect:/admin/public-todo";
    }

    /** 미션 삭제 */
    @PostMapping("/delete")
    public String delete(@RequestParam Long id) {
        m.delete(id);
        return "redirect:/admin/public-todo";
    }
}
