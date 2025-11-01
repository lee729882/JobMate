<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>찜한 공고 | JobMate</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<style>
:root {
  --bg1:#0ea5e9; --bg2:#6366f1;
  --card:#0b1220aa; --line:#2a3250;
  --text:#e6eefc; --muted:#b6c4e9; --accent:#22d3ee;
  --btn:#2563eb; --error:#ef4444;
}

body {
  margin:0;
  min-height:100vh;
  color:var(--text);
  background:radial-gradient(1200px 800px at 20% 10%, #1b2a4a 0%, #0d1426 60%),
             linear-gradient(135deg, var(--bg1), var(--bg2));
  background-blend-mode:screen, normal;
  font-family:"Noto Sans KR", system-ui, Segoe UI, sans-serif;
  display:flex;
  flex-direction:column;
}

/* ✅ 상단 헤더 */
header {
  display:flex;
  align-items:center;
  justify-content:space-between;
  padding:18px 36px;
  background:rgba(15,25,45,.6);
  backdrop-filter:blur(8px);
  border-bottom:1px solid rgba(255,255,255,.1);
}

.left-nav { display:flex; align-items:center; gap:40px; }

.logo {
  font-size:22px; font-weight:800; color:#fff;
  display:flex; align-items:center; gap:10px; text-decoration:none;
}
.logo .mark {
  width:30px; height:30px; border-radius:8px;
  background:conic-gradient(from 180deg at 50% 50%, #22d3ee, #60a5fa, #a78bfa, #22d3ee);
  box-shadow:0 0 25px #22d3ee55;
}
.logo:hover { opacity:0.8; transition:0.2s; }

nav.menu { display:flex; gap:30px; }
.menu a {
  color:#cbd5e1; text-decoration:none; font-size:15px;
  transition:.2s;
}
.menu a:hover, .menu a.active { color:#22d3ee; }

.user-info {
  display:flex; align-items:center; gap:16px;
  color:#e6eefc; font-size:14px;
}

.logout-btn {
  background:#ef4444; color:white; border:none;
  padding:8px 14px; border-radius:10px; cursor:pointer;
}

/* ✅ 메인 카드 */
main {
  flex:1;
  display:flex;
  justify-content:center;
  align-items:flex-start;
  padding:60px 20px;
}

.card {
  width:min(100%, 1000px);
  background:var(--card);
  border:1px solid var(--line);
  border-radius:18px;
  box-shadow:0 8px 30px rgba(0,0,0,0.35);
  backdrop-filter:blur(10px);
  padding:40px 50px;
}

h1 {
  font-size:26px;
  font-weight:700;
  color:#fff;
  text-shadow:0 0 10px #22d3ee55;
  display:flex;
  align-items:center;
  gap:10px;
}

h1 span {
  font-size:22px;
}

table {
  width:100%;
  border-collapse:collapse;
  margin-top:25px;
  color:var(--text);
  font-size:14px;
}

th, td {
  padding:14px;
  text-align:left;
  border-bottom:1px solid rgba(255,255,255,0.08);
}

th {
  background:rgba(255,255,255,0.06);
  color:#a5b4fc;
  font-weight:600;
  font-size:15px;
  border-bottom:2px solid rgba(255,255,255,0.15);
}

tr:hover {
  background:rgba(255,255,255,0.08);
  cursor:pointer;
  transition:all .25s;
}

.empty-message {
  text-align:center;
  color:#cbd5e1;
  margin-top:40px;
  font-size:15px;
}

footer {
  text-align:center;
  padding:20px;
  color:#94a3b8;
  font-size:13px;
}
</style>
</head>

<body>
<header>
  <div class="left-nav">
    <a href="${pageContext.request.contextPath}/member/dashboard" class="logo">
      <div class="mark"></div> JobMate
    </a>
    <nav class="menu">
      <a href="${pageContext.request.contextPath}/member/dashboard">대시보드</a>
      <a href="${pageContext.request.contextPath}/member/todo">To-Do</a>
      <a href="${pageContext.request.contextPath}/member/interview">면접 AI</a>
      <a href="${pageContext.request.contextPath}/member/profile">My Profile</a>
      <a href="${pageContext.request.contextPath}/member/community">취업 커뮤니티</a>
    </nav>
  </div>

  <div class="user-info">
    <div>
      <strong><c:out value="${loginMember.name}"/></strong>
      (<c:out value="${loginMember.username}"/>) 님 |
      <c:out value="${loginMember.careerType == 'EXP' ? '경력직' : '신입'}"/> |
      <c:out value="${loginMember.phone}"/>
    </div>
    <form action="${pageContext.request.contextPath}/member/logout" method="post">
      <button type="submit" class="logout-btn">로그아웃</button>
    </form>
  </div>
</header>

<main>
  <div class="card">
    <h1>❤️ 찜한 공고 목록</h1>

    <c:if test="${empty favoriteList}">
      <p class="empty-message">아직 찜한 공고가 없습니다.</p>
    </c:if>

    <c:if test="${not empty favoriteList}">
      <table>
        <thead>
          <tr>
            <th>기업명</th>
            <th>공고명</th>
            <th>마감일</th>
            <th>출처</th>
          </tr>
        </thead>
        <tbody>
          <c:forEach var="fav" items="${favoriteList}">
            <tr onclick="location.href='${pageContext.request.contextPath}/member/employment/detail/${fav.empSeqno}'">
              <td>${fav.empCompany}</td>
              <td>${fav.empTitle}</td>
              <td>${fav.empDeadline}</td>
              <td>${fav.empSource}</td>
            </tr>
          </c:forEach>
        </tbody>
      </table>
    </c:if>
  </div>
</main>

<footer>
  © 2025 JobMate. All rights reserved.
</footer>
</body>
</html>
