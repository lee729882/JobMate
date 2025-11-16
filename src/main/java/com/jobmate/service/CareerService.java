package com.jobmate.service;

import com.jobmate.api.CareerNetClient;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
@RequiredArgsConstructor
public class CareerService {

    private final CareerNetClient client;

    private final String API_KEY = "32d92e60685b900007a922f2d89f5e8c";


    /** 검사 6번 문항 요청 */
    public Map<String, Object> getQuestions(int qno) {

        int qestrnSeq = 6;

        Map<String, Object> resp = client.getQuestions(API_KEY, qestrnSeq);

        List<Map<String, Object>> rawList =
                (List<Map<String, Object>>) resp.get("RESULT");

        List<Map<String, Object>> questions = new ArrayList<>();
        List<Integer> qitemNos = new ArrayList<>();

        for (Map<String, Object> r : rawList) {

            Map<String, Object> q = new HashMap<>();

            int qItemNo = (int) r.get("qitemNo");
            qitemNos.add(qItemNo);

            q.put("no", qItemNo);
            q.put("text", "두 개 가치 중에 자신에게 더 중요한 가치를 선택하세요.");

            List<Map<String, String>> choiceList = new ArrayList<>();

            for (int i = 1; i <= 10; i++) {

                String ansKey = String.format("answer%02d", i);
                String scoreKey = String.format("answerScore%02d", i);

                Object ansObj = r.get(ansKey);
                Object scoreObj = r.get(scoreKey);

                if (ansObj != null && scoreObj != null) {
                    Map<String, String> choice = new HashMap<>();
                    choice.put("text", ansObj.toString());
                    choice.put("val", scoreObj.toString());
                    choiceList.add(choice);
                }
            }

            q.put("choices", choiceList);
            questions.add(q);
        }

        // 전체 문항 번호 저장 → 제출 시 정렬을 위해
        resp.put("qitemNos", qitemNos);

        Map<String, Object> result = new HashMap<>();
        result.put("qno", qestrnSeq);
        result.put("questions", questions);
        result.put("qitemNos", qitemNos);
        result.put("qnm", "직업가치관검사 (대학생/일반)");
        result.put("summary", "당신의 가치관 기반으로 직무/직업을 추천합니다.");

        return result;
    }


    /** 검사 제출 */
    public Map<String, Object> submit(
            Map<String, String> answersMap,
            String gender,
            String grade,
            List<Integer> qitemNos
    ) {

        StringBuilder ans = new StringBuilder();

        int idx = 1;
        for (Integer qno : qitemNos) {
            String key = "answer_" + qno;
            String val = answersMap.get(key);

            if (val == null) val = "0";

            ans.append("B").append(idx).append("=").append(val).append(" ");
            idx++;
        }

        Map<String, Object> body = new HashMap<>();
        body.put("apikey", API_KEY);
        body.put("qestrnSeq", "6");
        body.put("trgetSe", "100208");   // 대학생
        body.put("gender", gender);
        body.put("grade", grade);
        body.put("startDtm", System.currentTimeMillis());
        body.put("answers", ans.toString().trim());

        return client.submit(body);
    }

}
