<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<html>
<head>
  <meta charset="UTF-8"/>
  <title>공용 미션 관리 | JobMate</title>
  <style>
    body {
      font-family:"Pretendard",system-ui,sans-serif;
      background:linear-gradient(180deg,#0e1d3b 0%, #0f2a58 100%);
      color:#e9f2ff; padding:60px;
    }
    nav {
      margin-bottom:40px; font-size:17px;
    }
    nav a {
      margin-right:18px;
      color:#7fc8ff; text-decoration:none;
      font-weight:600; transition:.2s;
    }
    nav a:hover { color:#b4e1ff; }
    nav a:last-child { color:#ffd07f; }
    h1 { font-size:28px; font-weight:800; margin-bottom:24px; }

    .card {
      background:rgba(255,255,255,0.05);
      padding:25px 30px;
      border-radius:16px;
      box-shadow:0 4px 10px rgba(0,0,0,0.25);
      max-width:850px;
      margin-bottom:40px;
    }
    .form-row {
      display:flex; align-items:center;
      margin-bottom:12px;
    }
    .form-row label {
      width:100px; font-weight:600; color:#b9cae6;
    }
    input, select {
      flex:1; padding:8px 12px;
      border-radius:6px; border:none;
      background:rgba(255,255,255,.12);
      color:#e9f2ff;
    }
    input:focus, select:focus {
      outline:1px solid #4dc3ff;
    }
    button {
      background:linear-gradient(180deg,#2fb8ff,#249cff);
      border:none; border-radius:8px;
      padding:9px 16px; font-weight:700;
      color:#04243f; cursor:pointer;
      transition:0.25s;
    }
    button:hover { transform:translateY(-1px); opacity:0.9; }
    button.danger {
      background:linear-gradient(180deg,#ff8898,#ff6b81);
      color:#320a0e;
    }

    table {
      width:100%; border-collapse:collapse;
      margin-top:20px; background:rgba(255,255,255,0.05);
      border-radius:12px; overflow:hidden;
    }
    th, td {
      padding:14px 12px; text-align:center;
      border-bottom:1px solid rgba(255,255,255,0.08);
    }
    th {
      color:#9fb3d8; text-transform:uppercase;
      font-size:13px; letter-spacing:.3px;
    }
    tbody tr:hover {
      background:rgba(255,255,255,0.08);
    }
  </style>
</head>
<body>

  <!-- ✅ 상단 네비게이션 -->
  <nav>
    <a href="${pageContext.request.contextPath}/member/challenge">공용 미션</a>
    <a href="${pageContext.request.contextPath}/member/todo">To-Do | JobMate</a>
  </nav>

  <h1>🧩 공용 미션 관리</h1>

  <!-- 등록 폼 카드 -->
  <div class="card">
    <form action="${pageContext.request.contextPath}/admin/public-todo/add" method="post">
      <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

      <div class="form-row"><label>제목</label><input name="title" required></div>
      <div class="form-row"><label>내용</label><input name="content"></div>
      <div class="form-row"><label>난이도</label><input name="difficulty" type="number" min="1" max="5" value="1"></div>
      <div class="form-row"><label>기본점수</label><input name="basePoints" type="number" value="10"></div>
      <div class="form-row"><label>시작일</label><input name="startDate" type="date"></div>
      <div class="form-row"><label>종료일</label><input name="endDate" type="date"></div>
      <div class="form-row"><label>반복</label>
        <select name="repeatable">
          <option value="NONE">NONE</option>
          <option value="DAILY">DAILY</option>
          <option value="WEEKLY">WEEKLY</option>
        </select>
      </div>

      <div style="text-align:right; margin-top:20px;">
        <button type="submit">+ 등록</button>
      </div>
    </form>
  </div>

  <!-- 목록 카드 -->
  <div class="card">
    <h2 style="margin-bottom:20px;">📋 현재 미션</h2>
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
  </div>
</body>
</html>
