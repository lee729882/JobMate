package com.jobmate.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.*;

@Mapper
public interface UserScoreMapper {

    @Select("SELECT NVL(MAX(TOTAL_SCORE), 0) FROM USER_SCORE WHERE USERNAME = #{username}")
    Integer getTotal(@Param("username") String username);
    
    @Select("SELECT COUNT(*) FROM USER_SCORE WHERE USERNAME = #{username}")
    int exists(@Param("username") String username);


    @Insert({
        "INSERT INTO USER_SCORE (ID, USERNAME, TOTAL_SCORE, UPDATED_AT)",
        "VALUES (USER_SCORE_SEQ.NEXTVAL, #{username}, 0, SYSTIMESTAMP)"
    })
    void createRow(@Param("username") String username);

    @Update({
        "MERGE INTO USER_SCORE u ",
        "USING (SELECT #{username} AS USERNAME, #{delta} AS DELTA FROM DUAL) x ",
        "ON (u.USERNAME = x.USERNAME) ",
        "WHEN MATCHED THEN ",
        "  UPDATE SET u.TOTAL_SCORE = u.TOTAL_SCORE + x.DELTA, u.UPDATED_AT = SYSTIMESTAMP ",
        "WHEN NOT MATCHED THEN ",
        "  INSERT (ID, USERNAME, TOTAL_SCORE, UPDATED_AT) ",
        "  VALUES (USER_SCORE_SEQ.NEXTVAL, x.USERNAME, x.DELTA, SYSTIMESTAMP)"
    })
    void addScore(@Param("username") String username, @Param("delta") int delta);
    
    @Select({
        "SELECT user_rank, total_cnt",
        "FROM (",
        "  SELECT USERNAME, TOTAL_SCORE,",
        "         DENSE_RANK() OVER (ORDER BY TOTAL_SCORE DESC) AS user_rank",
        "  FROM USER_SCORE",
        ") s",
        "CROSS JOIN (SELECT COUNT(*) AS total_cnt FROM USER_SCORE) c",
        "WHERE s.USERNAME = #{username}"
    })
    Map<String, Object> getRankInfo(@Param("username") String username);
    
    @Select({
        "SELECT * FROM (",
        "  SELECT ",
        "    m.NAME                     AS USER_NAME,",
        "    m.USERNAME                 AS USERNAME,",
        "    m.CAREER_TYPE              AS CAREER_TYPE,",
        "    NVL(u.TOTAL_SCORE, 0)      AS TOTAL_SCORE,",
        "    DENSE_RANK() OVER (",
        "      ORDER BY NVL(u.TOTAL_SCORE, 0) DESC",
        "    ) AS RANK_IN_TYPE",
        "  FROM MEMBER m",
        "  LEFT JOIN USER_SCORE u ON m.USERNAME = u.USERNAME", // ← 점수 없으면 NULL → 0 처리
        "  WHERE m.CAREER_TYPE = #{careerType}",
        ")",
        "ORDER BY RANK_IN_TYPE, USER_NAME"
    })
    List<Map<String, Object>> findTypeRanking(@Param("careerType") String careerType);
}
