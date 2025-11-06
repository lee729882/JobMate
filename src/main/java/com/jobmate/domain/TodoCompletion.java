package com.jobmate.domain;

import lombok.Data;
import java.time.LocalDateTime;

@Data
public class TodoCompletion {
    private Long id;
    private Long todoId;
    private String username;
    private String periodKey;       // 'ALL' or 'YYYYMMDD' or 'YYYYWW'
    private LocalDateTime completedAt;
}
