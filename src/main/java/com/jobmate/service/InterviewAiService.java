package com.jobmate.service;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.stereotype.Service;
import org.springframework.web.client.HttpClientErrorException;   // ★ 429, 401 등 처리용
import org.springframework.web.client.RestTemplate;

import javax.annotation.PostConstruct;   // ★ 서버 시작 후 초기 확인용
import java.util.*;

/**
 * 면접 AI 피드백을 담당하는 서비스 클래스
 */
@Service
public class InterviewAiService {

    // ★ application.properties 에서 OpenAI API 키를 읽어옴
    //    application.properties 에는 다음처럼 설정되어 있어야 함:
    //    openai.api.key=sk-... (실제 키)
    @Value("${openai.api.key}")
    private String openAiApiKey;

    // ★ Java 8 호환: RestTemplate + Jackson 사용
    private final RestTemplate restTemplate = new RestTemplate();
    private final ObjectMapper objectMapper = new ObjectMapper();

    // ★ 서버가 뜰 때 한 번만 실행되어 키가 제대로 주입됐는지 확인
    @PostConstruct
    public void init() {
        if (openAiApiKey == null) {
            System.out.println("[InterviewAiService] openAiApiKey = null");
        } else {
            String prefix = openAiApiKey.length() > 10
                    ? openAiApiKey.substring(0, 10)
                    : openAiApiKey;
            System.out.println("[InterviewAiService] openAiApiKey prefix = " + prefix + "****");
        }
    }

    /**
     * 면접 질문 + 지원자의 답변을 받아서
     * OpenAI(ChatGPT)로 보내고 피드백 문자열을 반환
     */
    public String getFeedback(String question, String answer) {
        try {
            // ★ ChatGPT에게 전달할 프롬프트 구성
            String prompt =
                    "당신은 한국어를 사용하는 인사 담당 면접관입니다. " +
                    "아래 면접 질문과 지원자의 답변을 보고, " +
                    "1) 답변의 장점, 2) 보완할 점, 3) 더 좋게 말할 수 있는 예시 한두 문장을 " +
                    "10줄 이내로 한국어로 간단히 정리해 주세요.\n\n" +
                    "질문: " + question + "\n" +
                    "지원자 답변: " + answer;

            // === 1. 요청 바디(body) 생성 ===
            Map<String, Object> body = new HashMap<>();

            // 사용할 OpenAI 모델 (경량 + 저렴한 gpt-4o-mini)
            body.put("model", "gpt-4o-mini");  // ★ 필요하면 gpt-4o 등으로 교체 가능

            // messages 배열 (system + user)
            List<Map<String, String>> messages = new ArrayList<>();

            // 역할 설명
            Map<String, String> systemMsg = new HashMap<>();
            systemMsg.put("role", "system");
            systemMsg.put("content", "당신은 한국 기업의 인사 담당 면접관입니다.");
            messages.add(systemMsg);

            // 실제 질의 내용
            Map<String, String> userMsg = new HashMap<>();
            userMsg.put("role", "user");
            userMsg.put("content", prompt);
            messages.add(userMsg);

            body.put("messages", messages);
            body.put("max_tokens", 512);   // ★ 응답 최대 길이
            body.put("temperature", 0.4);  // ★ 창의성(0~2). 낮을수록 보수적

            // === 2. HTTP 헤더 설정 ===
            HttpHeaders headers = new HttpHeaders();
         // ✅ 수정 코드
            headers.setContentType(MediaType.APPLICATION_JSON);
            // setBearerAuth() 를 지원하지 않는 스프링 버전이라서 직접 Authorization 헤더를 설정
            headers.add("Authorization", "Bearer " + openAiApiKey);

            HttpEntity<Map<String, Object>> entity = new HttpEntity<>(body, headers);

            // === 3. OpenAI Chat Completions API 호출 ===
            String url = "https://api.openai.com/v1/chat/completions";
            ResponseEntity<String> response =
                    restTemplate.postForEntity(url, entity, String.class);

            // ★ 여기까지 왔다는 건 2xx 응답이라는 의미이지만,
            // 혹시 모를 상황을 위해 한 번 더 체크
            if (!response.getStatusCode().is2xxSuccessful()) {
                return "AI 피드백을 가져오는 중 오류가 발생했습니다. (status: "
                        + response.getStatusCodeValue() + ")";
            }

            // === 4. 응답 JSON 파싱 ===
            JsonNode root = objectMapper.readTree(response.getBody());
            JsonNode choices = root.path("choices");

            if (choices.isMissingNode() || !choices.isArray() || choices.size() == 0) {
                return "AI 응답이 비어 있습니다.";
            }

            String content = choices.get(0)
                    .path("message")
                    .path("content")
                    .asText();

            return content != null ? content.trim() : "AI 응답이 비어 있습니다.";

        } catch (HttpClientErrorException e) {
            // ★ OpenAI가 4xx 에러를 줄 때(401, 429 등) 여기로 들어옴
            System.out.println("[InterviewAiService] status = " + e.getStatusCode());
            System.out.println("[InterviewAiService] body   = " + e.getResponseBodyAsString());

            if (e.getStatusCode() == HttpStatus.TOO_MANY_REQUESTS) {
                // 429: 요청이 너무 많거나, 요금제/크레딧 한도 초과
                return "OpenAI 요청 한도(또는 크레딧)를 초과했습니다. " +
                       "OpenAI 대시보드의 Billing/Usage 설정을 확인한 뒤, 잠시 후 다시 시도해 주세요.";
            } else if (e.getStatusCode() == HttpStatus.UNAUTHORIZED) {
                // 401: API 키가 잘못됐거나 권한 없음
                return "OpenAI API 키가 잘못되었거나 권한이 없습니다. 서버 설정을 확인해 주세요.";
            } else if (e.getStatusCode() == HttpStatus.FORBIDDEN) {
                // 403: 프로젝트 설정/권한 문제
                return "OpenAI 프로젝트 권한 문제로 요청이 거부되었습니다. 프로젝트 설정을 확인해 주세요.";
            } else {
                // 그 외 4xx
                return "AI 서버에서 오류가 발생했습니다. (HTTP " +
                        e.getStatusCode().value() + ")";
            }

        } catch (Exception e) {
            // ★ 네트워크 문제, 파싱 오류 등 기타 예외
            e.printStackTrace();
            return "AI 피드백 생성 중 예기치 못한 오류가 발생했습니다.";
        }
    }
}
