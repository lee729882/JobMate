package com.jobmate.mapper;

import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.Param;

public interface RecentViewedMapper {

    void deleteDuplicate(
        @Param("memberId") Long memberId,
        @Param("empSeqno") String empSeqno
    );

    void addRecentViewed(
        @Param("memberId") Long memberId,
        @Param("empSource") String empSource,
        @Param("empSeqno") String empSeqno,
        @Param("empTitle") String empTitle,
        @Param("empCompany") String empCompany,
        @Param("empDeadline") String empDeadline
    );

    List<Map<String, Object>> getRecentViewedList(@Param("memberId") Long memberId);
}
