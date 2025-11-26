package com.jobmate.domain;

import java.util.Date;

import lombok.Data;

/**
 * 면접 AI 기록(질문 + 답변 + 피드백)을 저장하는 엔티티
 */
@Data
public class InterviewHistory {

    private Long id;          // PK
    private Long memberId;  // 로그인 아이디
    private String question;  // 면접 질문
    private String answer;    // 나의 답변
    private String feedback;  // AI 피드백
    private Date createdAt;   // 생성시각

  
}
