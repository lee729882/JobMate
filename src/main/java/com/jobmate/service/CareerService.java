package com.jobmate.service;

import com.jobmate.api.CareerNetClient;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
@RequiredArgsConstructor
public class CareerService {

    private final CareerNetClient client;

    private static final String API_KEY = "32d92e60685b900007a922f2d89f5e8c";


    /** ======================================================
     * 1. 심리검사 목록 가져오기 (완전 수정)
     * ====================================================== */
    public List<Map<String, Object>> getTestList() {

        Map<String, Object> resp = client.getTests(API_KEY);
        if (resp == null || resp.get("result") == null) {
            return Collections.emptyList();
        }

        Object result = resp.get("result");

        if (result instanceof List) {
            List<Map<String, Object>> list = (List<Map<String, Object>>) result;

            // 🔥 qno=33만 남기기
            list.removeIf(t -> ((Number)t.get("qno")).intValue() != 33);

            return list;
        }

        return Collections.emptyList();
    }


    /** ======================================================
     * 2. 특정 심리검사 문항
     * ====================================================== */
    public Map<String, Object> getQuestions(int qno) {
        Map<String, Object> resp = client.getQuestions(API_KEY, qno);
        if (resp == null) return null;
        return (Map<String, Object>) resp.get("result");
    }


    /** ======================================================
     * 3. 검사 제출
     * ====================================================== */
    public Map<String, Object> submit(Map<String, String> body) {

        // CareerNet API는 Map<String,Object>를 요구하므로 변환
        Map<String, Object> convert = new HashMap<>();
        body.forEach(convert::put);

        return client.submit(convert);
    }

}
