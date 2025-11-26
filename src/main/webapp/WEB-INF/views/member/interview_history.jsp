<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>면접 기록 목록 - JobMate</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <style>
    main {
      max-width: 900px;
      margin: 40px auto;
      color: #e5e7eb;
      font-family: "Noto Sans KR", sans-serif;
    }
    h1 { font-size: 24px; margin-bottom: 20px; }

    .top-bar {
      display:flex;
      justify-content:space-between;
      align-items:center;
      margin-bottom:16px;
    }

    .btn-small {
      display:inline-block;
      padding:6px 12px;
      border-radius:999px;
      border:1px solid rgba(148,163,184,0.7);
      font-size:13px;
      color:#e5e7eb;
      text-decoration:none;
      background:rgba(15,23,42,0.9);
    }

    .btn-small:hover {
      background:rgba(30,64,175,0.8);
      border-color:#60a5fa;
    }

    table {
      width:100%;
      border-collapse:collapse;
      font-size:14px;
      background:rgba(15,23,42,0.85);
      border-radius:12px;
      overflow:hidden;
    }

    th, td {
      padding:10px 12px;
      border-bottom:1px solid rgba(51,65,85,0.8);
    }

    th {
      background:rgba(15,23,42,0.9);
      text-align:left;
      color:#cbd5e1;
    }

    tr:hover {
      background:rgba(30,64,175,0.3);
    }

    .empty {
      margin-top:20px;
      font-size:14px;
      color:#9ca3af;
    }

    .link-row {
      color:#e5e7eb;
      text-decoration:none;
      display:block;
      width:100%;
    }

    .question-preview {
      white-space:nowrap;
      overflow:hidden;
      text-overflow:ellipsis;
      max-width:500px;
      display:inline-block;
      vertical-align:middle;
    }
  </style>
</head>
<body>

<main>

  <div class="top-bar">
    <h1>내 면접 기록</h1>

    <!-- 면접 연습 페이지로 돌아가기 -->
    <a href="${pageContext.request.contextPath}/member/interview" class="btn-small">
      ← 면접 연습으로 돌아가기
    </a>
  </div>

  <c:if test="${empty historyList}">
    <p class="empty">저장된 면접 기록이 없습니다. 먼저 면접 AI 연습을 해보세요.</p>
  </c:if>

  <c:if test="${not empty historyList}">
    <table>
      <thead>
        <tr>
          <th style="width:80px;">번호</th>
          <th>질문</th>
          <th style="width:220px;">작성일시</th>
        </tr>
      </thead>
      <tbody>
        <c:forEach var="h" items="${historyList}" varStatus="st">
          <tr>
            <td>${st.count}</td>
            <td>
              <a class="link-row"
                 href="${pageContext.request.contextPath}/member/interview/history/${h.id}">
                <span class="question-preview">
                  ${h.question}
                </span>
              </a>
            </td>
            <td>${h.createdAt}</td> <%-- createdAt 그대로 출력 (LocalDateTime이면 문자열로 보임) --%>
          </tr>
        </c:forEach>
      </tbody>
    </table>
  </c:if>

</main>

</body>
</html>
