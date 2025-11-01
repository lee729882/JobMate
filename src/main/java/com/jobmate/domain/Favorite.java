package com.jobmate.domain;

import lombok.Data;
import java.time.LocalDateTime;

@Data
public class Favorite {
    private Long id;
    private Long memberId;
    private String empSource;
    private String empSeqno;
    private String empTitle;
    private String empCompany;
    private String empDeadline;
    private LocalDateTime createdAt;
}
