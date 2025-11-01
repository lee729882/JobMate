package com.jobmate.mapper;

import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface FavoriteMapper {

    boolean checkFavorite(@Param("memberId") Long memberId,
                          @Param("source") String source,
                          @Param("empSeqno") String empSeqno);

    void addFavorite(@Param("memberId") Long memberId,
                     @Param("source") String source,
                     @Param("empSeqno") String empSeqno,
                     @Param("title") String title,
                     @Param("company") String company,
                     @Param("deadline") String deadline);

    void removeFavorite(@Param("memberId") Long memberId,
                        @Param("source") String source,
                        @Param("empSeqno") String empSeqno);

    List<Map<String, Object>> getFavorites(@Param("memberId") Long memberId);

    int countFavorites(@Param("memberId") Long memberId);
}
