package com.jobmate.api;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;
import org.springframework.http.*;

import java.util.Map;

@Component
@RequiredArgsConstructor
public class CareerNetClient {

    private final RestTemplate restTemplate;

    // 문항 목록 API (v1)
    private static final String BASE_V1 = "https://www.career.go.kr/inspct/openapi/test";

    /** 문항 요청 (q=6 고정) */
    public Map<String, Object> getQuestions(String apiKey, int qestrnSeq) {

        String url = BASE_V1 + "/questions?apikey=" + apiKey + "&q=" + qestrnSeq;

        return restTemplate.getForObject(url, Map.class);
    }


    /** 검사 제출 (반드시 /test/report 로 보내야 함) */
    public Map<String, Object> submit(Map<String, Object> body) {

        String url = BASE_V1 + "/report";   // ★ 정답 엔드포인트

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);

        HttpEntity<Map<String, Object>> entity =
                new HttpEntity<>(body, headers);

        ResponseEntity<Map> response =
                restTemplate.postForEntity(url, entity, Map.class);

        return response.getBody();
    }
}

