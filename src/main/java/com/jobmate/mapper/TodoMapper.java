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
  
  /** ✅ 오늘 추가한 To-Do 개수 */
  @Select({
      "SELECT COUNT(*)",
      "FROM JM_TODO",
      "WHERE USERNAME = #{username}",
      "  AND TRUNC(CREATED_AT) = TRUNC(SYSDATE)"
  })
  int countCreatedToday(@Param("username") String username);

  // ✅ 여기 부분이 핵심 (INSERT 수정됨)
  @Insert({
    "INSERT INTO JM_TODO (ID, USERNAME, TITLE, CONTENT, COMPLETED, CREATED_AT, UPDATED_AT)",
    "VALUES (JM_TODO_SEQ.NEXTVAL, #{username}, #{title}, #{content}, ",
    "        #{completedInt}, SYSTIMESTAMP, SYSTIMESTAMP)"
  })
  @SelectKey(statement = "SELECT JM_TODO_SEQ.CURRVAL FROM DUAL",
             keyProperty = "id", before = false, resultType = Long.class)
  void insertTodo(Todo todo);

  @Delete({
	    "DELETE FROM JM_TODO",
	    "WHERE ID = #{id} AND USERNAME = #{username}"
	})
	int deleteTodo(@Param("id") Long id, @Param("username") String username);

  
//✅ 오늘 해당 사용자가 만든 투두 개수 (하루 10개 제한 체크용)
@Select({
 "SELECT COUNT(*)",
 "FROM JM_TODO",
 "WHERE USERNAME = #{username}",
 "  AND TRUNC(CREATED_AT) = TRUNC(SYSDATE)"
})
int countToday(@Param("username") String username);
//↑ 서비스에서 이 이름으로 호출하도록 맞추는 걸 추천
//(이미 countToday로 쓰고 있다면 서비스 쪽 메서드 호출명만 바꾸면 됩니다)


//✅ 완료 상태만 빠르게 확인(점수 중복 방지 + 본인 데이터만 확인)
@Select({
"SELECT ID, USERNAME, COMPLETED",
"FROM JM_TODO",
"WHERE ID = #{id} AND USERNAME = #{username}"
})
Todo findSimple(@Param("id") Long id, @Param("username") String username);


//✅ 완료 상태를 명시적으로 변경(본인 것만 업데이트)
@Update({
"UPDATE JM_TODO",
"SET COMPLETED = #{completedInt},",
"    UPDATED_AT = SYSTIMESTAMP",
"WHERE ID = #{id} AND USERNAME = #{username}"
})
int updateCompleted(@Param("id") Long id,
                 @Param("username") String username,
                 @Param("completedInt") int completedInt);
 
/** ✅ 완료처리 (0→1로 바뀔 때만 적용, 본인 것만) */
@Update({
  "UPDATE JM_TODO",
  "SET COMPLETED = 1, UPDATED_AT = SYSTIMESTAMP",
  "WHERE ID = #{id} AND USERNAME = #{username} AND COMPLETED = 0"
})
int completeOnce(@Param("id") Long id, @Param("username") String username);


  /*
  @Update({
    "UPDATE JM_TODO",
    "SET COMPLETED = CASE WHEN COMPLETED = 1 THEN 0 ELSE 1 END,",
    "    UPDATED_AT = SYSTIMESTAMP",
    "WHERE ID = #{id}"
  })
  void toggleCompleted(@Param("id") Long id);
  */
}
