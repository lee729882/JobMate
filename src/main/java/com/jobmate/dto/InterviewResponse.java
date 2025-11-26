package com.jobmate.dto;

/**
 * AI 피드백 응답용 DTO
 */
public class InterviewResponse {

    private String feedback;

    public InterviewResponse() {
    }

    public InterviewResponse(String feedback) {
        this.feedback = feedback;
    }

    public String getFeedback() {
        return feedback;
    }

    public void setFeedback(String feedback) {
        this.feedback = feedback;
    }
}
