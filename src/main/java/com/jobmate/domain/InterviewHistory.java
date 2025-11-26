package com.jobmate.domain;

import java.util.Date;

/**
 * 면접 AI 기록(질문 + 답변 + 피드백)을 저장하는 엔티티
 */
public class InterviewHistory {

    private Long id;          // PK
    private String memberId;  // 로그인 아이디
    private String question;  // 면접 질문
    private String answer;    // 나의 답변
    private String feedback;  // AI 피드백
    private Date createdAt;   // 생성시각

    // === getter / setter ===
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getMemberId() {
        return memberId;
    }

    public void setMemberId(String memberId) {
        this.memberId = memberId;
    }

    public String getQuestion() {
        return question;
    }

    public void setQuestion(String question) {
        this.question = question;
    }

    public String getAnswer() {
        return answer;
    }

    public void setAnswer(String answer) {
        this.answer = answer;
    }

    public String getFeedback() {
        return feedback;
    }

    public void setFeedback(String feedback) {
        this.feedback = feedback;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }
}
