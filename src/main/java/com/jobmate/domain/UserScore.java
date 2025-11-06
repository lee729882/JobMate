package com.jobmate.domain;

import lombok.Data;

@Data
public class UserScore {
    private Long id;
    private String username;
    private int totalScore;
}
