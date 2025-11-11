package com.jobmate.service;

import com.jobmate.domain.Todo;
import com.jobmate.mapper.TodoMapper;
import com.jobmate.mapper.UserScoreMapper;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
public class TodoService {

  private final TodoMapper todoMapper;
  private final UserScoreMapper userScoreMapper;

  /** 목록 */
  public List<Todo> list(String username) {
    return todoMapper.findByUsername(username);
  }

  /** ✅ 하루 10개 제한을 지키며 추가 */
  @Transactional
  public void add(String username, String title, String content) {
    int today = todoMapper.countCreatedToday(username);
    if (today >= 10) {
      throw new IllegalStateException("오늘은 더 이상 할 일을 추가할 수 없어요. (최대 10개)");
    }

    Todo t = new Todo();
    t.setUsername(username);
    t.setTitle(title);
    t.setContent(content);
    // 도메인에 boolean completed가 있다면 completedInt 세터 같이 사용
    t.setCompleted(false);           // 편의
    t.setCompletedInt(0);            // 실제 DB 저장용
    
    todoMapper.insertTodo(t);
  }

  /** 삭제 */
  @Transactional
  public void delete(Long id, String username) {
    todoMapper.deleteTodo(id, username);
  }

  /**
   * ✅ 완료 처리 + 점수 적립(최초 1회만 +1점)
   * @return 적립 점수 (1 또는 0)
   */
  @Transactional
  public int complete(Long id, String username) {
	// 본인 데이터만 조회
      Todo simple = todoMapper.findSimple(id, username);
      if (simple == null) {
          throw new IllegalArgumentException("할 일을 찾을 수 없거나 권한이 없습니다.");
      }
      if (simple.getCompletedInt() == 1) {
          return 0; // 이미 완료 → 점수 적립 X
      }

    int changed = todoMapper.completeOnce(id, username); // 0->1로 바뀔 때만 1
    if (changed == 1) {
      userScoreMapper.addScore(username, 1);   // 최초 완료 보상 +1
      return 1;
    }
    return 0;
  }
}
