package com.jobmate.api;

import org.springframework.stereotype.Component;
import org.springframework.web.client.RestTemplate;

@Component
public class EmploymentApiClient {

    private final String BASE_URL = "https://www.work24.go.kr/cm/openApi/call/wk/";
    private final String AUTH_KEY = "12609451-c896-4243-a0b5-c4ff1cb2ffc7";

    private final RestTemplate restTemplate = new RestTemplate();

    public String getEmploymentList(int page, int size) {
        String url = BASE_URL + "callOpenApiSvcInfo210L21.do"
            + "?authKey=" + AUTH_KEY
            + "&callTp=L"
            + "&returnType=XML"
            + "&startPage=" + page
            + "&display=" + size;

        return restTemplate.getForObject(url, String.class);
    }

    public String getEmploymentDetail(String empSeqno) {
        String url = BASE_URL + "callOpenApiSvcInfo210D21.do"
            + "?authKey=" + AUTH_KEY
            + "&returnType=XML"
            + "&callTp=D"
            + "&empSeqno=" + empSeqno;

        System.out.println("✅ 상세 요청 URL: " + url);
        return restTemplate.getForObject(url, String.class);
    }

    
}
