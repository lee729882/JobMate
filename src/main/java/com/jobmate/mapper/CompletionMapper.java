package com.jobmate.mapper;

import com.jobmate.domain.TodoCompletion;
import org.apache.ibatis.annotations.*;

@Mapper
public interface CompletionMapper {

    @Insert({
        "INSERT INTO TODO_COMPLETION ",
        "(ID, TODO_ID, USERNAME, PERIOD_KEY, COMPLETED_AT) ",
        "VALUES (TODO_COMPLETION_SEQ.NEXTVAL, #{todoId}, #{username}, #{periodKey}, SYSTIMESTAMP)"
    })
    @SelectKey(statement = "SELECT TODO_COMPLETION_SEQ.CURRVAL FROM DUAL",
               keyProperty = "id", before = false, resultType = Long.class)
    void insert(TodoCompletion c);

    @Select({
        "SELECT COUNT(*) FROM TODO_COMPLETION",
        "WHERE TODO_ID=#{todoId} AND USERNAME=#{username} AND PERIOD_KEY=#{periodKey}"
    })
    int exists(@Param("todoId") Long todoId,
               @Param("username") String username,
               @Param("periodKey") String periodKey);
}
