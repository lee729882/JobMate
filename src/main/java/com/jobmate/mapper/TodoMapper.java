package com.jobmate.mapper;

import com.jobmate.domain.Todo;
import org.apache.ibatis.annotations.*;
import java.util.List;

@Mapper
public interface TodoMapper {

  @Select({
    "SELECT ID, USERNAME, TITLE, CONTENT, COMPLETED, CREATED_AT, UPDATED_AT",
    "FROM TODO",
    "WHERE USERNAME = #{username}",
    "ORDER BY CREATED_AT DESC"
  })
  List<Todo> findByUsername(@Param("username") String username);

  @Insert({
    "INSERT INTO TODO (ID, USERNAME, TITLE, CONTENT, COMPLETED, CREATED_AT, UPDATED_AT)",
    "VALUES (DEFAULT, #{username}, #{title}, #{content},",
    "        CASE WHEN #{completed} THEN 1 ELSE 0 END, SYSTIMESTAMP, SYSTIMESTAMP)"
  })
  @Options(useGeneratedKeys = true, keyProperty = "id")
  void insertTodo(Todo todo);

  @Delete("DELETE FROM TODO WHERE ID = #{id}")
  void deleteTodo(@Param("id") Long id);

@Update({
    "UPDATE TODO",
    "SET COMPLETED = CASE WHEN COMPLETED = 1 THEN 0 ELSE 1 END,",
    "    UPDATED_AT = SYSTIMESTAMP",
    "WHERE ID = #{id}"
  })
  void toggleCompleted(@Param("id") Long id);
}
