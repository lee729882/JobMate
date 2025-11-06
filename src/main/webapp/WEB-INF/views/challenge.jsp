<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<html>
<head>
  <meta charset="UTF-8"/>
  <title>공용 미션 | JobMate</title>
  <style>
    body {
      font-family: "Pretendard", system-ui, sans-serif;
      background: linear-gradient(160deg, #24a1ff, #1a2e63);
      color: #e9f2ff;
      padding: 60px 40px;
    }
    h1 { font-size: 32px; font-weight: 800; margin-bottom: 20px; }
    table {
      width: 100%;
      border-collapse: collapse;
      margin-top: 12px;
      border-radius: 10px;
      overflow: hidden;
      box-shadow: 0 6px 20px rgba(0,0,0,.25);
    }
    th, td { padding: 16px; text-align: left; }
    th {
      background: rgba(0,0,0,.2);
      text-transform: uppercase;
      font-size: 13px;
      color: #9fb3d8;
      letter-spacing: 0.4px;
    }
    tr:nth-child(even){ background: rgba(255,255,255,.05); }
    tr:hover{ background: rgba(255,255,255,.08); transition: .2s; }
    button {
      background: linear-gradient(180deg,#2fb8ff,#249cff);
      border: none;
      border-radius: 8px;
      padding: 8px 12px;
      color: #04243f;
      font-weight: 800;
      cursor: pointer;
    }
    button:hover { opacity: .9; }
    .msg { padding: 10px; border-radius: 8px; margin: 10px 0; font-weight:700; }
    .msg.ok { background: rgba(41,209,127,.15); color:#29d17f; }
    .msg.err { background: rgba(255,107,129,.15); color:#ff6b81; }
  </style>
</head>
<body>
  <h1>💪 공용 미션</h1>

  <c:if test="${not empty msg}">
    <div class="msg ok">${msg}</div>
  </c:if>
  <c:if test="${not empty err}">
    <div class="msg err">${err}</div>
  </c:if>

  <c:choose>
    <c:when test="${empty todos}">
      <div style="padding:20px;">현재 진행 중인 미션이 없습니다.</div>
    </c:when>
    <c:otherwise>
      <table>
        <thead>
          <tr>
            <th>제목</th>
            <th>난이도</th>
            <th>점수</th>
            <th>반복</th>
            <th>기간</th>
            <th>완료</th>
          </tr>
        </thead>
        <tbody>
          <c:forEach var="t" items="${todos}">
            <tr>
              <td>
                <strong>${t.title}</strong><br/>
                <small style="color:#9fb3d8">${t.content}</small>
              </td>
              <td>${t.difficulty}</td>
              <td>${t.basePoints}</td>
              <td>${t.repeatable}</td>
              <td>
                <c:if test="${not empty t.startDate}">
                  ${t.startDate}
                </c:if>
                <c:if test="${not empty t.endDate}">
                  ~ ${t.endDate}
                </c:if>
              </td>
              <td>
                <form action="${pageContext.request.contextPath}/member/challenge/complete" method="post">
                  <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                  <input type="hidden" name="todoId" value="${t.id}"/>
                  <button type="submit">완료</button>
                </form>
              </td>
            </tr>
          </c:forEach>
        </tbody>
      </table>
    </c:otherwise>
  </c:choose>
</body>
</html>
