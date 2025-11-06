package com.jobmate.mapper;

import com.jobmate.domain.UserScore;
import org.apache.ibatis.annotations.*;

@Mapper
public interface UserScoreMapper {

    @Select("SELECT ID, USERNAME, TOTAL_SCORE FROM USER_SCORE WHERE USERNAME=#{username}")
    UserScore find(@Param("username") String username);

    @Update({
        "MERGE INTO USER_SCORE u",
        "USING (SELECT #{username} AS USERNAME, #{delta} AS DELTA FROM DUAL) x",
        "ON (u.USERNAME = x.USERNAME)",
        "WHEN MATCHED THEN",
        "  UPDATE SET u.TOTAL_SCORE = u.TOTAL_SCORE + x.DELTA, u.UPDATED_AT = SYSTIMESTAMP",
        "WHEN NOT MATCHED THEN",
        "  INSERT (ID, USERNAME, TOTAL_SCORE, UPDATED_AT)",
        "  VALUES (USER_SCORE_SEQ.NEXTVAL, x.USERNAME, x.DELTA, SYSTIMESTAMP)"
    })
    void addScore(@Param("username") String username, @Param("delta") int delta);
}
