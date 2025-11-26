package com.jobmate.service;

import java.util.List;

import com.jobmate.domain.InterviewHistory;

/**
 * 면접 기록 비즈니스 로직
 */
public interface InterviewHistoryService {

    // 기록 저장
    void save(InterviewHistory history);

    // 회원별 전체 목록
    List<InterviewHistory> getListByMember(String memberId);

    // 상세보기
    InterviewHistory getDetail(Long id, String memberId);
}
