<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>직렬별 랭킹 | JobMate</title>
  <style>
    :root{
      --bg1:#24a1ff; --bg2:#1a2e63;
      --card1:#182a4d; --card2:#1b2f57;
      --text:#e9f2ff; --muted:#9fb3d8;
      --accent:#35b4ff; --danger:#fb7185;
    }
    body{
      margin:0;
      font-family:"Pretendard",system-ui,-apple-system,Segoe UI,Roboto,sans-serif;
      color:var(--text);
      background:linear-gradient(160deg,var(--bg1),var(--bg2));
      -webkit-font-smoothing:antialiased;
    }
    .header{
      position:fixed; inset:0 0 auto 0; z-index:100;
      background:linear-gradient(180deg,#122549,#0d1e3f);
      border-bottom:1px solid rgba(255,255,255,.08);
    }
    .nav{
      max-width:1180px; margin:0 auto; padding:16px 20px;
      display:flex; align-items:center; justify-content:space-between;
    }
    .brand{display:flex;align-items:center;gap:10px;font-weight:900;}
    .logo{width:32px;height:32px;border-radius:10px;
      background:linear-gradient(135deg,#60a5fa,#a855f7);}
    .menu a{color:var(--muted);text-decoration:none;margin-right:20px;font-weight:700;}
    .menu a.active{color:#fff;}
    .right button{
      padding:8px 14px;border-radius:999px;border:1px solid rgba(255,255,255,.2);
      background:transparent;color:var(--text);cursor:pointer;font-weight:600;
    }

    main{max-width:1180px;margin:110px auto 60px;padding:0 20px;}
    .title-wrap{margin-bottom:18px;}
    .title{font-size:28px;font-weight:900;margin-bottom:4px;}
    .subtitle{color:var(--muted);font-size:14px;}
    .highlight{color:#facc15;font-weight:800;}

    .card{
      background:linear-gradient(180deg,var(--card1),var(--card2));
      border-radius:18px;
      border:1px solid rgba(255,255,255,.08);
      box-shadow:0 10px 26px rgba(0,0,0,.35);
      padding:20px 22px;
    }

    table{width:100%;border-collapse:collapse;margin-top:10px;font-size:14px;}
    th,td{padding:10px 12px;text-align:left;}
    thead th{color:var(--muted);border-bottom:1px solid rgba(255,255,255,.12);font-size:13px;}
    tbody tr{border-bottom:1px solid rgba(255,255,255,.06);}
    tbody tr.me{background:rgba(37, 99, 235, 0.35);}
    tbody tr:hover{background:rgba(255,255,255,.03);}
    .rank-badge{
      display:inline-flex;align-items:center;justify-content:center;
      min-width:40px;border-radius:999px;
      background:rgba(15,118,255,.18);color:#bfdbfe;font-weight:700;font-size:13px;
    }
    .rank-top3{background:#facc15;color:#1f2937;}
    .score{font-weight:700;color:var(--accent);}
    .me-label{
      display:inline-block;margin-left:6px;padding:2px 7px;
      border-radius:999px;background:rgba(56,189,248,.2);color:#e0f2fe;
      font-size:11px;font-weight:700;
    }
  </style>
</head>
<body>
<header class="header">
  <div class="nav">
    <div class="brand">
      <div class="logo"></div>
      <div>JobMate</div>
    </div>
    <div class="menu">
      <a href="${pageContext.request.contextPath}/member/dashboard">대시보드</a>
      <a href="${pageContext.request.contextPath}/member/todo">To-Do</a>
      <a class="active" href="#">직렬별 랭킹</a>
    </div>
    <div class="right">
      <button onclick="location.href='${pageContext.request.contextPath}/member/dashboard'">
        ← 대시보드
      </button>
    </div>
  </div>
</header>

<main>
  <div class="title-wrap">
    <div class="title">
      직렬별 JobMate 랭킹
    </div>
    <div class="subtitle">
      <span class="highlight">
        ${loginMember.name} (${loginMember.username})
      </span>
      님은
      <span class="highlight">${careerType}</span>
      직렬에서
      <span class="highlight">${myRank}위</span>,
      점수 <span class="highlight">${myScore}점</span> 입니다.
      (총 ${fn:length(rankingList)}명)
    </div>
  </div>

  <section class="card">
    <table>
      <thead>
      <tr>
        <th style="width:90px;">순위</th>
        <th style="width:160px;">이름</th>
        <th>아이디</th>
        <th style="width:120px;">점수</th>
      </tr>
      </thead>
      <tbody>
      <c:forEach var="row" items="${rankingList}">
        <c:set var="isMe" value="${row.USERNAME == loginMember.username}" />
        <tr class="${isMe ? 'me' : ''}">
          <td>
            <span class="rank-badge ${row.RANK_IN_TYPE <= 3 ? 'rank-top3' : ''}">
              ${row.RANK_IN_TYPE}
            </span>
            <c:if test="${isMe}">
              <span class="me-label">ME</span>
            </c:if>
          </td>
          <td>${row.USER_NAME}</td>
          <td>${row.USERNAME}</td>
          <td class="score">${row.TOTAL_SCORE}</td>
        </tr>
      </c:forEach>
      </tbody>
    </table>
  </section>
</main>
</body>
</html>
