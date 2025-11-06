package com.jobmate.service;

import com.jobmate.domain.PublicTodo;
import com.jobmate.domain.TodoCompletion;
import com.jobmate.mapper.PublicTodoMapper;
import com.jobmate.mapper.CompletionMapper;
import com.jobmate.mapper.UserScoreMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.temporal.IsoFields;

@Service
@RequiredArgsConstructor
public class ChallengeService {

    private final PublicTodoMapper todoMapper;
    private final CompletionMapper completionMapper;
    private final UserScoreMapper scoreMapper;

    /** 활성 미션 목록 불러오기 */
    public java.util.List<PublicTodo> listActive() {
        return todoMapper.findActive();
    }

    /** 미션 완료 처리 및 점수 계산 */
    public int complete(Long todoId, String username) {
        PublicTodo t = todoMapper.findById(todoId);
        if (t == null) throw new IllegalArgumentException("존재하지 않는 미션입니다.");

        LocalDate today = LocalDate.now();

        // 기간 확인
        if (t.getStartDate() != null && today.isBefore(t.getStartDate().toLocalDate()))
            throw new IllegalStateException("아직 시작되지 않은 미션입니다.");
        if (t.getEndDate() != null && today.isAfter(t.getEndDate().toLocalDate()))
            throw new IllegalStateException("종료된 미션입니다.");

        // 반복 규칙에 따른 periodKey 생성
        String repeat = (t.getRepeatable() == null) ? "NONE" : t.getRepeatable().toUpperCase();
        String periodKey;
        switch (repeat) {
            case "DAILY":
                periodKey = today.format(DateTimeFormatter.ofPattern("yyyyMMdd"));
                break;
            case "WEEKLY":
                int week = (int) IsoFields.WEEK_OF_WEEK_BASED_YEAR.getFrom(today);
                periodKey = today.getYear() + String.format("%02d", week);
                break;
            default:
                periodKey = "ALL";
        }

        // 중복 완료 확인
        if (completionMapper.exists(todoId, username, periodKey) > 0)
            throw new IllegalStateException("이미 완료한 미션입니다.");

        // 완료 기록 저장
        TodoCompletion c = new TodoCompletion();
        c.setTodoId(todoId);
        c.setUsername(username);
        c.setPeriodKey(periodKey);
        completionMapper.insert(c);

        // 점수 계산 (기본점수 × 난이도 계수)
        double factor = 1.0 + (Math.max(1, t.getDifficulty()) - 1) * 0.25;
        int award = (int) Math.round(t.getBasePoints() * factor);

        // 점수 누적
        scoreMapper.addScore(username, award);

        return award;
    }
}
