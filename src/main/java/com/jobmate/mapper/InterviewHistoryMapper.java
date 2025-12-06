package com.jobmate.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.jobmate.domain.InterviewHistory;

public interface InterviewHistoryMapper {

    // 새 기록 저장
    void insert(InterviewHistory history);

    // ✅ memberId를 Long으로
    List<InterviewHistory> findByMemberId(@Param("memberId") Long memberId);

    // ✅ 여기도 Long으로
    InterviewHistory findByIdAndMemberId(@Param("id") Long id,
                                         @Param("memberId") Long memberId);
}
