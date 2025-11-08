package com.jobmate.mapper;

import com.jobmate.domain.PublicTodo;
import org.apache.ibatis.annotations.*;
import java.util.List;
import java.util.Map;

@Mapper
public interface PublicTodoMapper {

    @Select({
        "SELECT ID, TITLE, CONTENT, DIFFICULTY, BASE_POINTS, START_DATE, END_DATE, REPEATABLE",
        "FROM PUBLIC_TODO",
        // 🔹 TIMESTAMP → DATE 캐스팅 + TRUNC 로 '하루' 단위 비교를 강제
        "WHERE NVL(TRUNC(CAST(START_DATE AS DATE)), DATE '1900-01-01') <= TRUNC(SYSDATE)",
        "  AND NVL(TRUNC(CAST(END_DATE   AS DATE)), DATE '9999-12-31') >= TRUNC(SYSDATE)",
        "ORDER BY ID DESC"
    })
    List<PublicTodo> findActive();

    @Select("SELECT * FROM PUBLIC_TODO WHERE ID=#{id}")
    PublicTodo findById(@Param("id") Long id);

    @Insert({
        "INSERT INTO PUBLIC_TODO ",
        "(ID, TITLE, CONTENT, DIFFICULTY, BASE_POINTS, START_DATE, END_DATE, REPEATABLE, CREATED_AT, UPDATED_AT)",
        "VALUES (PUBLIC_TODO_SEQ.NEXTVAL, #{title}, #{content}, #{difficulty}, #{basePoints},",
        "        #{startDate}, #{endDate}, #{repeatable}, SYSTIMESTAMP, SYSTIMESTAMP)"
    })
    @SelectKey(statement = "SELECT PUBLIC_TODO_SEQ.CURRVAL FROM DUAL",
               keyProperty = "id", before = false, resultType = Long.class)
    void insert(PublicTodo t);

    @Update({
        "UPDATE PUBLIC_TODO",
        "SET TITLE=#{title}, CONTENT=#{content}, DIFFICULTY=#{difficulty},",
        "    BASE_POINTS=#{basePoints}, START_DATE=#{startDate}, END_DATE=#{endDate},",
        "    REPEATABLE=#{repeatable}, UPDATED_AT=SYSTIMESTAMP",
        "WHERE ID=#{id}"
    })
    void update(PublicTodo t);

    @Delete("DELETE FROM PUBLIC_TODO WHERE ID=#{id}")
    void delete(@Param("id") Long id);
    
 // 점수/반복 규칙만 빠르게 조회 (서비스에서 사용)
    @Select("SELECT BASE_POINTS, REPEATABLE FROM PUBLIC_TODO WHERE ID = #{id}")
    Map<String, Object> getPointsAndRepeatable(@Param("id") Long id);

}
