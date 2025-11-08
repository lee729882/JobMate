package com.jobmate.mapper;

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
}
