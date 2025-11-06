package com.jobmate.domain;

import lombok.Data;
import java.time.LocalDateTime;

@Data
public class Todo {
    private Long id;
    private String username;
    private String title;
    private String content;
    private boolean completed;           // boolean으로(게터는 isCompleted)
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
}
