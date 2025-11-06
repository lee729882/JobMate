<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<html>
<head>
  <meta charset="UTF-8"/>
  <title>공용 미션 관리 | JobMate</title>
  <style>
    body { font-family:"Pretendard",system-ui,sans-serif; background:#0e1d3b; color:#e9f2ff; padding:40px; }
    h1 { font-size:28px; font-weight:800; margin-bottom:18px; }
    input, select {
      padding:8px 10px; border-radius:6px; border:none;
      background:rgba(255,255,255,.1); color:#e9f2ff;
    }
    table { width:100%; border-collapse:collapse; margin-top:20px; }
    th, td { padding:12px; border-bottom:1px solid rgba(255,255,255,.1); }
    th { color:#9fb3d8; text-transform:uppercase; font-size:13px; letter-spacing:.3px; }
    button {
      background:linear-gradient(180deg,#2fb8ff,#249cff);
      border:none; border-radius:8px; padding:8px 12px;
      font-weight:700; color:#04243f; cursor:pointer;
    }
    button.danger { background:linear-gradient(180deg,#ff8898,#ff6b81); color:#320a0e; }
  </style>
</head>
<body>
  <h1>🧩 공용 미션 관리</h1>

  <form action="${pageContext.request.contextPath}/admin/public-todo/add" method="post">
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

    <div>제목 <input name="title" required></div>
    <div>내용 <input name="content"></div>
    <div>난이도 <input name="difficulty" type="number" min="1" max="5" value="1"></div>
    <div>기본점수 <input name="basePoints" type="number" value="10"></div>
    <div>시작일 <input name="startDate" type="date"></div>
    <div>종료일 <input name="endDate" type="date"></div>
    <div>반복 
      <select name="repeatable">
        <option value="NONE">NONE</option>
        <option value="DAILY">DAILY</option>
        <option value="WEEKLY">WEEKLY</option>
      </select>
    </div>
    <br/>
    <button type="submit">+ 등록</button>
  </form>

  <h2 style="margin-top:40px;">📋 현재 미션</h2>
  <table>
    <thead>
      <tr><th>ID</th><th>제목</th><th>난이도</th><th>점수</th><th>반복</th><th>기간</th><th>삭제</th></tr>
    </thead>
    <tbody>
      <c:forEach var="t" items="${todos}">
        <tr>
          <td>${t.id}</td>
          <td>${t.title}</td>
          <td>${t.difficulty}</td>
          <td>${t.basePoints}</td>
          <td>${t.repeatable}</td>
          <td>
            <c:if test="${not empty t.startDate}">${t.startDate}</c:if>
            <c:if test="${not empty t.endDate}"> ~ ${t.endDate}</c:if>
          </td>
          <td>
            <form action="${pageContext.request.contextPath}/admin/public-todo/delete" method="post">
              <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
              <input type="hidden" name="id" value="${t.id}"/>
              <button class="danger" type="submit">삭제</button>
            </form>
          </td>
        </tr>
      </c:forEach>
    </tbody>
  </table>
</body>
</html>
