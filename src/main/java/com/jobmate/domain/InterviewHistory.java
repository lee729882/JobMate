package com.jobmate.domain;

import java.time.LocalDateTime;
import lombok.Data;

@Data
public class InterviewHistory {

    private Long id;          // PK
    private Long memberId;    // ★ FK : Member.id (Long)

    private String question;
    private String answer;
    private String feedback;

    private LocalDateTime createdAt;
}
