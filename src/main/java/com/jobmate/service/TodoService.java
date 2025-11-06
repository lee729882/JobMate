package com.jobmate.service;

import com.jobmate.domain.Todo;
import com.jobmate.mapper.TodoMapper;

import lombok.RequiredArgsConstructor;

import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TodoService {
    private final TodoMapper m;
    public TodoService(TodoMapper m){ this.m = m; }

    public List<Todo> getTodos(String username){ return m.findByUsername(username); }
    public void addTodo(Todo t){ m.insertTodo(t); }
    public void deleteTodo(Long id){ m.deleteTodo(id); }
    public void toggleCompleted(Long id){ m.toggleCompleted(id); }
}
