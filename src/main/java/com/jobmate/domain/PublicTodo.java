package com.jobmate.domain;

import lombok.Data;
import java.sql.Date;

@Data
public class PublicTodo {
    private Long id;
    private String title;
    private String content;
    private int difficulty;    // 1~5
    private int basePoints;    // 기본 점수
    private Date startDate;
    private Date endDate;
    private String repeatable; // NONE / DAILY / WEEKLY
}
