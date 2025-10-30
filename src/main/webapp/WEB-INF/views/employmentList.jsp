<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>공채 정보 | JobMate</title>
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
      background: radial-gradient(1200px 800px at 20% 10%, #1b2a4a 0%, #0d1426 60%),
                  linear-gradient(135deg, var(--bg1), var(--bg2));
      background-blend-mode: screen, normal;
      font-family:"Noto Sans KR", system-ui, Segoe UI, sans-serif;
      display:flex;
      flex-direction:column;
    }

    /* ✅ 상단 헤더 (대시보드와 동일) */
    header {
      display:flex;
      align-items:center;
      justify-content:space-between;
      padding:18px 36px;
      background:rgba(15,25,45,.6);
      backdrop-filter:blur(8px);
      border-bottom:1px solid rgba(255,255,255,.1);
    }

    .logo {
      font-size:22px;
      font-weight:800;
      color:#fff;
      display:flex;
      align-items:center;
      gap:10px;
    }

    .logo .mark {
      width:30px; height:30px; border-radius:8px;
      background:conic-gradient(from 180deg at 50% 50%, #22d3ee, #60a5fa, #a78bfa, #22d3ee);
      box-shadow:0 0 25px #22d3ee55;
    }

    .user-info {
      display:flex;
      align-items:center;
      gap:20px;
      color:#e6eefc;
      font-size:14px;
    }

    .logout-btn {
      background:#ef4444;
      color:white;
      border:none;
      padding:8px 14px;
      border-radius:10px;
      cursor:pointer;
    }

    main {
      flex:1;
      display:flex;
      flex-direction:column;
      align-items:center;
      padding:60px 20px;
    }

    /* ✅ 제목 */
    .page-header {
      width:min(100%, 1000px);
      margin-bottom:30px;
      text-align:center;
    }

    .page-header h1 {
      color:#fff;
      font-size:28px;
      text-shadow:0 0 10px #22d3ee55;
      font-weight:700;
    }

    /* ✅ 테이블 카드 */
    .table-card {
      width:min(100%, 1000px);
      background:var(--card);
      border:1px solid var(--line);
      border-radius:18px;
      box-shadow:0 8px 30px rgba(0,0,0,0.35);
      backdrop-filter:blur(10px);
      padding:30px;
    }

    table {
      width:100%;
      border-collapse:collapse;
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

    .pagination {
      margin-top:25px;
      text-align:center;
    }

    .pagination a, .pagination span {
      margin:0 10px;
      color:#cbd5e1;
      text-decoration:none;
      font-weight:500;
    }

    .pagination a:hover {
      color:var(--accent);
      text-decoration:underline;
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
  <div class="logo">
    <div class="mark"></div>
    JobMate
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
  <div class="page-header">
    <h1>📢 최신 공채속보</h1>
  </div>

  <c:if test="${empty jobs}">
    <div class="table-card" style="text-align:center; padding:40px;">
      불러올 공채 정보가 없습니다. (API 연결 확인 필요)
    </div>
  </c:if>

  <c:if test="${not empty jobs}">
    <div class="table-card">
      <table>
        <thead>
          <tr>
            <th>기업명</th>
            <th>공고명</th>
            <th>기업구분</th>
            <th>고용형태</th>
            <th>마감일</th>
          </tr>
        </thead>
        <tbody>
          <c:forEach var="job" items="${jobs}">
            <tr onclick="location.href='${pageContext.request.contextPath}/member/employment/detail/${job.empSeqno}'">
              <td>${job.empBusiNm}</td>
              <td>${job.empWantedTitle}</td>
              <td>${job.coClcdNm}</td>
              <td>${job.empWantedTypeNm}</td>
              <td>${job.empWantedEndt}</td>
            </tr>
          </c:forEach>
        </tbody>
      </table>

      <!-- ✅ 페이지 네비게이션 -->
      <div class="pagination">
        <c:if test="${currentPage > 1}">
          <a href="${pageContext.request.contextPath}/member/employment/list?page=${currentPage - 1}">◀ 이전</a>
        </c:if>
        <span>현재 ${currentPage} 페이지</span>
        <a href="${pageContext.request.contextPath}/member/employment/list?page=${currentPage + 1}">다음 ▶</a>
      </div>
    </div>
  </c:if>
</main>

<footer>
  © 2025 JobMate. All rights reserved.
</footer>

</body>
</html>
