package com.jobmate.mapper;

import org.apache.ibatis.annotations.*;

import com.jobmate.domain.TodoCompletion;

@Mapper
public interface CompletionMapper {

    @Select({
        "SELECT COUNT(*)",
        "FROM TODO_COMPLETION",
        "WHERE USERNAME = #{username}",
          "AND TODO_ID   = #{todoId}",
          "AND PERIOD_KEY= #{periodKey}"
    })
    int alreadyDone(@Param("username") String username,
                    @Param("todoId") Long todoId,
                    @Param("periodKey") String periodKey);

    @Insert({
        "INSERT INTO TODO_COMPLETION",
          "(ID, TODO_ID, USERNAME, POINTS, PERIOD_KEY, COMPLETED_AT)",
        "VALUES",
          "(TODO_COMPLETION_SEQ.NEXTVAL, #{todoId}, #{username}, #{points}, #{periodKey}, SYSTIMESTAMP)"
    })
    void insert(@Param("username") String username,
                @Param("todoId")   Long todoId,
                @Param("points")   int points,
                @Param("periodKey") String periodKey);

	int exists(Long todoId, String username, String periodKey);

	void insert(TodoCompletion c);
}
