package com.jobmate.controller;

import com.jobmate.domain.Todo;
import com.jobmate.service.TodoService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.security.Principal;
import java.util.List;

@Controller
@RequestMapping("/member/todo")
public class TodoController {
    private final TodoService svc;
    public TodoController(TodoService svc) { this.svc = svc; }

    @GetMapping
    public String list(Model model, Principal principal){
        String username = principal != null ? principal.getName() : "guest";
        model.addAttribute("todos", svc.getTodos(username));
        model.addAttribute("todo", new Todo());
        return "todo";
    }

    @PostMapping("/add")
    public String add(@ModelAttribute Todo todo, Principal principal){
        // 1) 로그인 안 되어 있어도 안전하게
        String username = (principal != null) ? principal.getName() : "guest";
        todo.setUsername(username);

        // 2) 제목/내용 가벼운 정리(공백 방지)
        if (todo.getTitle() != null)  todo.setTitle(todo.getTitle().trim());
        if (todo.getContent() != null) todo.setContent(todo.getContent().trim());

        // 3) 저장
        svc.addTodo(todo);

        // 4) 리스트로 리다이렉트
        return "redirect:/member/todo";
    }


    @PostMapping("/toggle")
    public String toggle(@RequestParam Long id){
        svc.toggleCompleted(id);
        return "redirect:/member/todo";
    }

    @PostMapping("/delete")
    public String delete(@RequestParam Long id){
        svc.deleteTodo(id);
        return "redirect:/member/todo";
    }
}
