package com.jobmate.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.jobmate.domain.InterviewHistory;

/**
 * 면접 기록 Mapper
 */
public interface InterviewHistoryMapper {

    void insert(InterviewHistory history);

    List<InterviewHistory> findByMemberId(@Param("memberId") Long memberId); // ★ String -> Long

    InterviewHistory findByIdAndMemberId(@Param("id") Long id,
                                         @Param("memberId") Long memberId); // ★ String -> Long
}
