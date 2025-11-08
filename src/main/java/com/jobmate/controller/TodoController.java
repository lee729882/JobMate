package com.jobmate.controller;

import com.jobmate.service.TodoService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;
import com.jobmate.domain.Member;

@Controller
@RequestMapping("/member/todo")
@RequiredArgsConstructor
public class TodoController {

  private final TodoService todoService;

  @GetMapping
  public String list(Model model, HttpSession session) {
    Member login = (Member) session.getAttribute("loginMember");
    if (login == null) return "redirect:/member/login";
    model.addAttribute("todos", todoService.list(login.getUsername()));
    return "todo";  // todo.jsp
  }

  /** ✅ 새 할 일 추가 (하루 10개 제한) */
  @PostMapping("/add")
  public String add(@RequestParam String title,
                    @RequestParam(required=false, defaultValue="") String content,
                    HttpSession session, RedirectAttributes ra) {
    Member login = (Member) session.getAttribute("loginMember");
    if (login == null) return "redirect:/member/login";

    try {
      todoService.add(login.getUsername(), title, content);
      ra.addFlashAttribute("msg", "할 일이 추가되었어요!");
    } catch (IllegalStateException e) {
      ra.addFlashAttribute("err", e.getMessage());
    }
    return "redirect:/member/todo";
  }

  @PostMapping("/delete")
  public String delete(@RequestParam Long id, RedirectAttributes ra) {
    todoService.delete(id);
    ra.addFlashAttribute("msg", "삭제 완료!");
    return "redirect:/member/todo";
  }

  /** ✅ 완료 버튼 (최초 1회만 +1점) */
  @PostMapping("/complete")
  public String complete(@RequestParam Long id, HttpSession session, RedirectAttributes ra) {
    Member login = (Member) session.getAttribute("loginMember");
    if (login == null) return "redirect:/member/login";

    int gained = todoService.complete(id, login.getUsername());
    if (gained == 1) {
      ra.addFlashAttribute("msg", "✅ 완료! +1점 적립");
    } else {
      ra.addFlashAttribute("msg", "이미 완료한 항목입니다.");
    }
    return "redirect:/member/todo";
  }
}
