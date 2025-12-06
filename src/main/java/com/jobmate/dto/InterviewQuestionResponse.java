// [추가] API로 생성한 면접 질문을 클라이언트에 보내기 위한 DTO
package com.jobmate.dto;

public class InterviewQuestionResponse {

    // [추가] 실제 면접 질문 텍스트
    private String question;

    public InterviewQuestionResponse() {}

    public InterviewQuestionResponse(String question) {
        this.question = question;
    }

    public String getQuestion() {
        return question;
    }

    public void setQuestion(String question) {
        this.question = question;
    }
}
