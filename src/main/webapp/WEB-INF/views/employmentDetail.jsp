<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>${job.empWantedTitle} | JobMate</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">

  <style>
    :root {
      --bg1:#0ea5e9; --bg2:#6366f1;
      --card:#0b1220aa; --line:#2a3250;
      --text:#e6eefc; --muted:#b6c4e9; --accent:#22d3ee;
      --btn:#2563eb; --error:#ef4444;
    }

    body {
      margin:0; min-height:100vh; color:var(--text);
      background: radial-gradient(1200px 800px at 20% 10%, #1b2a4a 0%, #0d1426 60%),
                  linear-gradient(135deg, var(--bg1), var(--bg2));
      background-blend-mode: screen, normal;
      font-family:"Noto Sans KR", system-ui, Segoe UI, sans-serif;
      display:flex; flex-direction:column;
    }

    header {
      display:flex; align-items:center; justify-content:space-between;
      padding:18px 36px;
      background:rgba(15,25,45,.6);
      backdrop-filter:blur(8px);
      border-bottom:1px solid rgba(255,255,255,.1);
    }

    .logo { font-size:22px; font-weight:800; color:#fff; display:flex; align-items:center; gap:10px; }
    .logo .mark { width:30px; height:30px; border-radius:8px;
      background:conic-gradient(from 180deg at 50% 50%, #22d3ee, #60a5fa, #a78bfa, #22d3ee);
      box-shadow:0 0 25px #22d3ee55;
    }

    .user-info { display:flex; align-items:center; gap:20px; color:#e6eefc; font-size:14px; }
    .logout-btn { background:#ef4444; color:white; border:none; padding:8px 14px; border-radius:10px; cursor:pointer; }

    main {
      flex:1; display:flex; justify-content:center; align-items:flex-start;
      padding:60px 20px;
    }

    .detail-card {
      width:min(100%, 900px);
      background:var(--card);
      border:1px solid var(--line);
      border-radius:18px;
      padding:40px 50px;
      box-shadow:0 8px 30px rgba(0,0,0,.35);
      backdrop-filter:blur(10px);
    }

    h1 {
      font-size:26px; font-weight:700; color:#fff;
      margin-bottom:25px;
      text-shadow:0 0 12px #22d3ee55;
    }

    .info {
      margin-bottom:10px; line-height:1.6; font-size:15px; color:#cbd5e1;
    }

    .info b { color:#a5b4fc; }

    a { color:#22d3ee; text-decoration:none; }
    a:hover { text-decoration:underline; }

    .back-btn {
      display:inline-block;
      margin-top:30px;
      background:#2563eb;
      color:white;
      padding:10px 20px;
      border-radius:10px;
      text-decoration:none;
      transition:0.25s;
    }

    .back-btn:hover {
      background:#1d4ed8;
      transform:translateY(-2px);
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
  <div class="detail-card">
    <h1>${job.empWantedTitle}</h1>
    <div class="info"><b>기업명:</b> ${job.empBusiNm} (${job.coClcdNm})</div>
    <div class="info"><b>고용형태:</b> ${job.empWantedTypeNm}</div>
    <div class="info"><b>근무지역:</b> ${job.workRegionNm}</div>
    <div class="info"><b>경력:</b> ${job.empWantedCareerNm}</div>
    <div class="info"><b>학력:</b> ${job.empWantedEduNm}</div>
    <div class="info"><b>모집기간:</b> ${job.empWantedStdt} ~ ${job.empWantedEndt}</div>
    <div class="info"><b>제출서류:</b> ${job.empSubmitDocCont}</div>
    <div class="info"><b>접수방법:</b> ${job.empRcptMthdCont}</div>
    <div class="info"><b>합격자 발표:</b> ${job.empAcptPsnAnncCont}</div>
    <div class="info"><b>채용 홈페이지:</b> 
      <a href="${job.empWantedHomepgDetail}" target="_blank">${job.empWantedHomepgDetail}</a>
    </div>
    <a href="${pageContext.request.contextPath}/member/employment/list" class="back-btn">← 목록으로 돌아가기</a>
  </div>
</main>

<footer>
  © 2025 JobMate. All rights reserved.
</footer>
</body>
</html>
