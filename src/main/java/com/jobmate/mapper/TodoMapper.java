package com.jobmate.mapper;

import com.jobmate.domain.Todo;
import org.apache.ibatis.annotations.*;
import java.util.List;

@Mapper
public interface TodoMapper {

  @Select({
    "SELECT ID, USERNAME, TITLE, CONTENT, COMPLETED, CREATED_AT, UPDATED_AT",
    "FROM JM_TODO",
    "WHERE USERNAME = #{username}",
    "ORDER BY CREATED_AT DESC"
  })
  List<Todo> findByUsername(@Param("username") String username);

  // ✅ 여기 부분이 핵심 (INSERT 수정됨)
  @Insert({
    "INSERT INTO JM_TODO (ID, USERNAME, TITLE, CONTENT, COMPLETED, CREATED_AT, UPDATED_AT)",
    "VALUES (JM_TODO_SEQ.NEXTVAL, #{username}, #{title}, #{content}, ",
    "        #{completedInt}, SYSTIMESTAMP, SYSTIMESTAMP)"
  })
  @SelectKey(statement = "SELECT JM_TODO_SEQ.CURRVAL FROM DUAL",
             keyProperty = "id", before = false, resultType = Long.class)
  void insertTodo(Todo todo);

  @Delete("DELETE FROM JM_TODO WHERE ID = #{id}")
  void deleteTodo(@Param("id") Long id);

  @Update({
    "UPDATE JM_TODO",
    "SET COMPLETED = CASE WHEN COMPLETED = 1 THEN 0 ELSE 1 END,",
    "    UPDATED_AT = SYSTIMESTAMP",
    "WHERE ID = #{id}"
  })
  void toggleCompleted(@Param("id") Long id);
}
