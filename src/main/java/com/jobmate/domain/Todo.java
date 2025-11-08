package com.jobmate.domain;

import lombok.Data;
import java.time.LocalDateTime;

@Data
public class Todo {
    private Long id;
    private String username;
    private String title;
    private String content;
    private boolean completed;
    private int completedInt; 
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    // ⬇️ DB INSERT용 보조 게터
    public int getCompletedInt() {
        return this.completed ? 1 : 0;
    }
}
