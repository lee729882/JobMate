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

    private static final String BASE = "https://www.career.go.kr/inspct/openapi/v2";

    /** 1. 심리검사 목록 요청 */
    public Map<String, Object> getTests(String apiKey) {
        String url = BASE + "/tests?apikey=" + apiKey;
        return restTemplate.getForObject(url, Map.class);
    }

    /** 2. 특정 심리검사 문항 요청 */
    public Map<String, Object> getQuestions(String apiKey, int qno) {
        String url = BASE + "/test?apikey=" + apiKey + "&q=" + qno;
        return restTemplate.getForObject(url, Map.class);
    }

    /** 3. 검사 제출 요청 */
    public Map<String, Object> submit(Map<String, Object> body) {

        String url = BASE + "/report";

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_JSON);

        HttpEntity<Map<String, Object>> entity = new HttpEntity<>(body, headers);

        ResponseEntity<Map> response = restTemplate.postForEntity(url, entity, Map.class);

        return response.getBody();
    }
}
