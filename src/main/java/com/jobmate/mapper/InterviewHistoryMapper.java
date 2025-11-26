package com.jobmate.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.jobmate.domain.InterviewHistory;

/**
 * 면접 기록 Mapper
 */
public interface InterviewHistoryMapper {

    // ① 새 기록 저장
    void insert(InterviewHistory history);

    // ② 로그인 아이디로 전체 목록 조회
    List<InterviewHistory> findByMemberId(@Param("memberId") String memberId);

    // ③ 상세보기 (id + memberId로 방어)
    InterviewHistory findByIdAndMemberId(@Param("id") Long id,
                                          @Param("memberId") String memberId);
}
