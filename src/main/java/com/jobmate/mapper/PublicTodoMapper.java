package com.jobmate.mapper;

import com.jobmate.domain.PublicTodo;
import org.apache.ibatis.annotations.*;
import java.util.List;

@Mapper
public interface PublicTodoMapper {

    @Select({
        "SELECT ID, TITLE, CONTENT, DIFFICULTY, BASE_POINTS, START_DATE, END_DATE, REPEATABLE",
        "FROM PUBLIC_TODO",
        "WHERE (START_DATE IS NULL OR START_DATE <= TRUNC(SYSDATE))",
        "  AND (END_DATE IS NULL OR END_DATE >= TRUNC(SYSDATE))",
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
}
