package com.jobmate.service;

import java.util.List;

import com.jobmate.domain.InterviewHistory;

/**
 * 면접 기록 비즈니스 로직
 */
public interface InterviewHistoryService {

    void save(InterviewHistory history);

    List<InterviewHistory> getListByMember(Long memberId);   // ★ String -> Long

    InterviewHistory getDetail(Long id, Long memberId);      // ★ String -> Long
}
