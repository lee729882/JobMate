package com.jobmate.service;

import com.jobmate.domain.PublicTodo;
import com.jobmate.mapper.PublicTodoMapper;
import com.jobmate.mapper.CompletionMapper;
import com.jobmate.mapper.UserScoreMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.time.temporal.WeekFields;
import java.util.List;
import java.util.Locale;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class ChallengeService {

    private final PublicTodoMapper publicTodoMapper;
    private final CompletionMapper completionMapper;
    private final UserScoreMapper userScoreMapper;

    /** 오늘 기준 활성 공용 미션 목록 그대로 반환 (추가 필터 X) */
    public List<PublicTodo> listActive() {
        return publicTodoMapper.findActive();
    }

    /** 컨트롤러에서 호출하는 얇은 래퍼 */
    @Transactional
    public int complete(Long publicTodoId, String username) {
        return completePublicMission(publicTodoId, username);
    }

    /**
     * 공용 미션 완료 시 점수 적립 처리
     * @param publicTodoId 미션 ID
     * @param username     현재 로그인 사용자
     * @return 적립된 점수 (이미 완료된 미션이면 0)
     */
    @Transactional
    public int completePublicMission(Long publicTodoId, String username) {
        // 1) 미션 기본점수, 반복규칙 조회
        Map<String, Object> row = publicTodoMapper.getPointsAndRepeatable(publicTodoId);
        if (row == null) {
            throw new IllegalArgumentException("존재하지 않는 미션입니다. ID=" + publicTodoId);
        }
        int basePoints = ((Number) row.get("BASE_POINTS")).intValue();
        String repeatable = (String) row.get("REPEATABLE"); // NONE / DAILY / WEEKLY

        // 2) 반복 규칙 기반 기간키 생성 (중복완료 방지)
        String periodKey = buildPeriodKey(repeatable);

        // 3) 이미 완료했는지 확인
        // ─ mapper 메서드명이 프로젝트에 따라 exists(...) 혹은 alreadyDone(...) 일 수 있어요.
        int doneCount;
        try {
            // alreadyDone(username, todoId, periodKey) 형태가 있는 경우
            doneCount = completionMapper.alreadyDone(username, publicTodoId, periodKey);
        } catch (Throwable ignore) {
            // exists(todoId, username, periodKey) 형태가 있는 경우
            doneCount = completionMapper.exists(publicTodoId, username, periodKey);
        }
        if (doneCount > 0) return 0;

        // 4) 완료 기록 저장 (시그니처는 프로젝트에 맞춰 사용)
        try {
            completionMapper.insert(username, publicTodoId, basePoints, periodKey);
        } catch (Throwable ignore) {
            // 예전 버전이 TodoCompletion 엔티티를 받는다면 여기에 맞춰 생성하여 insert 해주세요.
            // TodoCompletion c = new TodoCompletion(...); completionMapper.insert(c);
            throw new IllegalStateException("CompletionMapper.insert 시그니처를 프로젝트에 맞게 조정해 주세요.");
        }

        // 5) 유저 점수 row 보장 + 점수 누적
        ensureUserRow(username);
        userScoreMapper.addScore(username, basePoints);

        return basePoints;
    }

    /** 유저 점수 행이 없을 경우 생성 */
    private void ensureUserRow(String username) {
        // exists(String username) 가 0/1 반환하도록 구현되어 있어야 합니다.
        if (userScoreMapper.exists(username) == 0) {
            userScoreMapper.createRow(username);
        }
    }

    /** 반복 규칙에 따라 중복완료를 구분하는 키 생성 */
    private String buildPeriodKey(String repeat) {
        LocalDate today = LocalDate.now();
        if ("DAILY".equalsIgnoreCase(repeat)) {
            return today.toString(); // 예: 2025-11-08
        } else if ("WEEKLY".equalsIgnoreCase(repeat)) {
            WeekFields wf = WeekFields.of(Locale.KOREA);
            int week = today.get(wf.weekOfWeekBasedYear());
            return today.getYear() + "W" + week; // 예: 2025W45
        }
        return "ONCE"; // NONE(1회성)
    }
}
