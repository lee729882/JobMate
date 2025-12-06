package com.jobmate.service;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.RestTemplate;

import java.util.*;

/**
 * 면접 AI 서비스
 *  - 랜덤 질문 생성 (로컬)
 *  - OpenAI API를 이용한 피드백 생성
 */
@Service
public class InterviewAiService {

    // application.properties 등에 정의했다고 가정
    // openai.api.key=sk-xxxx...
    @Value("${openai.api.key}")
    private String openAiApiKey;

    private final RestTemplate restTemplate = new RestTemplate();

    private static final String OPENAI_URL = "https://api.openai.com/v1/chat/completions";

    /**
     * 면접 답변에 대한 AI 피드백 생성
     */
    public String getFeedback(String question, String answer) {

        // 1) 방어 코드: 질문/답변이 비어 있으면 바로 리턴
        if (question == null || question.trim().isEmpty()
                || answer == null || answer.trim().isEmpty()) {
            return "질문과 답변을 모두 입력해야 AI 피드백을 생성할 수 있습니다.";
        }

        // 2) OpenAI 요청 바디 구성
        Map<String, Object> body = new HashMap<>();
        body.put("model", "gpt-4o-mini");   // 사용 중인 모델 이름

        List<Map<String, String>> messages = new ArrayList<>();

        messages.add(Map.of(
                "role", "system",
                "content", "당신은 신입 개발자/취업 준비생을 돕는 면접관입니다. "
                         + "지원자의 답변을 보고 장점·보완점·예시 답변을 한국어로 정리해 주세요. "
                         + "너무 길지 않게, 항목별로 보기 좋게 bullet 형식으로 적어 주세요."
        ));

        String userContent =
                "면접 질문: " + question + "\n\n" +
                "지원자 답변: " + answer + "\n\n" +
                "위 답변에 대한 피드백을 작성해 주세요.";

        messages.add(Map.of(
                "role", "user",
                "content", userContent
        ));

        body.put("messages", messages);
        body.put("max_tokens", 500);

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);
        headers.set("Authorization", "Bearer " + openAiApiKey);
        
        HttpEntity<Map<String, Object>> entity = new HttpEntity<>(body, headers);

        try {
            // 3) OpenAI API 호출
            ResponseEntity<Map> response =
                    restTemplate.postForEntity(OPENAI_URL, entity, Map.class);

            if (!response.getStatusCode().is2xxSuccessful() || response.getBody() == null) {
                return "AI 피드백 생성 중 오류가 발생했습니다. (응답이 올바르지 않습니다)";
            }

            // 4) 응답 파싱: choices[0].message.content
            Map<String, Object> resBody = response.getBody();
            List<Map<String, Object>> choices =
                    (List<Map<String, Object>>) resBody.get("choices");
            if (choices == null || choices.isEmpty()) {
                return "AI 피드백 생성 중 오류가 발생했습니다. (choices 비어 있음)";
            }

            Map<String, Object> first = choices.get(0);
            Map<String, Object> message =
                    (Map<String, Object>) first.get("message");
            if (message == null) {
                return "AI 피드백 생성 중 오류가 발생했습니다. (message 없음)";
            }

            Object contentObj = message.get("content");
            String content = (contentObj != null) ? contentObj.toString() : null;

            if (content == null || content.trim().isEmpty()) {
                return "AI 피드백 생성 중 오류가 발생했습니다. (content 비어 있음)";
            }

            return content.trim();

        } catch (HttpClientErrorException e) {
            // ✅ 여기서 429/402 등을 친절한 문구로 변환
            if (e.getStatusCode() == HttpStatus.TOO_MANY_REQUESTS) {
                return "현재 OpenAI 사용량 제한(429)으로 인해 실시간 피드백을 생성할 수 없습니다.\n"
                        + "잠시 후 다시 시도해 주세요.";
            }
            if (e.getStatusCode() == HttpStatus.PAYMENT_REQUIRED) {
                return "OpenAI 계정의 크레딧 또는 결제 한도가 초과되어 AI 피드백을 생성할 수 없습니다.\n"
                        + "관리자에게 문의해 주세요.";
            }

            // 그 외 HTTP 에러
            e.printStackTrace();
            return "AI 피드백 생성 중 HTTP 오류가 발생했습니다. ("
                    + e.getStatusCode().value() + " " + e.getStatusCode().getReasonPhrase() + ")";
        } catch (Exception e) {
            // 기타 예외
            e.printStackTrace();
            return "AI 피드백 생성 중 예기치 못한 오류가 발생했습니다.";
        }
    }

    /**
     * 랜덤 면접 질문 생성 (로컬에서만, OpenAI 호출 X)
     */
    public String getRandomQuestion(String position, String careerType) {

        // 직무/경력에 따라 분기할 수도 있고, 일단 간단한 배열 사용
        List<String> baseQuestions = Arrays.asList(
                "본인의 강점과 약점에 대해 말씀해 주세요.",
                "팀 프로젝트에서 본인이 맡았던 역할과 기여한 점을 설명해 주세요.",
                "우리 회사(지원 회사)에 지원한 이유와 입사 후 목표를 말해 주세요.",
                "최근에 경험했던 가장 어려웠던 문제와, 이를 어떻게 해결했는지 설명해 주세요.",
                "본인이 했던 프로젝트 중 가장 기억에 남는 프로젝트를 소개해 주세요."
        );

        // 필요하면 position / careerType에 따라 다른 리스트를 선택해도 됨
        Random rnd = new Random();
        return baseQuestions.get(rnd.nextInt(baseQuestions.size()));
    }
}
