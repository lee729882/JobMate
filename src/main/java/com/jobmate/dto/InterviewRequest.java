package com.jobmate.dto;

/**
 * JS에서 보내는 요청 바디와 매핑
 * { "question": "...", "answer": "..." }
 */
public class InterviewRequest {

    private String question;
    private String answer;

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
}
