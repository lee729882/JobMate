<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>내 대시보드 | JobMate</title>
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
    .logo {
      font-size:22px; font-weight:800; color:#fff;
      display:flex; align-items:center; gap:10px;
    }
    .logo .mark {
      width:30px; height:30px; border-radius:8px;
      background:conic-gradient(from 180deg at 50% 50%, #22d3ee, #60a5fa, #a78bfa, #22d3ee);
      box-shadow:0 0 25px #22d3ee55;
    }
    .user-info {
      display:flex; align-items:center; gap:20px;
      color:#e6eefc; font-size:14px;
    }
    .logout-btn {
      background:#ef4444; color:white; border:none;
      padding:8px 14px; border-radius:10px; cursor:pointer;
    }

    main {
      flex:1;
      display:flex; justify-content:center; align-items:flex-start;
      padding:60px 20px;
    }
    .card-grid {
      display:grid;
      grid-template-columns:repeat(auto-fit,minmax(260px,1fr));
      gap:30px;
      width:min(100%,1000px);
    }

    .card {
      background:var(--card); border:1px solid var(--line);
      padding:30px; border-radius:18px;
      text-align:center;
      transition:all .25s ease;
      cursor:pointer;
      backdrop-filter: blur(8px);
    }
    .card:hover {
      transform:translateY(-6px);
      box-shadow:0 12px 40px rgba(0,0,0,.35);
    }
    .card h3 {
      margin:0 0 10px; color:#fff; font-size:20px;
    }
    .card p { color:var(--muted); font-size:14px; }

    footer {
      text-align:center;
      padding:20px;
      color:#94a3b8;
      font-size:13px;
    }

    /* API 영역 */
    #apiSection {
      margin-top:40px;
      width:100%;
      max-width:1000px;
      background:rgba(11,18,32,.6);
      border:1px solid var(--line);
      border-radius:18px;
      padding:24px;
      color:#dbeafe;
      display:none;
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
      <strong>${loginMember.username}</strong> 님 |
      <c:out value="${loginMember.careerType == 'EXP' ? '경력직' : '신입'}"/> |
      <c:out value="${loginMember.phone}"/>
    </div>
    <form action="${pageContext.request.contextPath}/member/logout" method="post">
      <button type="submit" class="logout-btn">로그아웃</button>
    </form>
  </div>
</header>

<main>
  <div>
    <div class="card-grid">
      <div class="card" onclick="loadApi('공채')">
        <h3>공채 정보</h3>
        <p>최신 채용 행사 및 공채 일정 확인</p>
      </div>
      <div class="card" onclick="loadApi('사람인')">
        <h3>사람인 채용 API</h3>
        <p>사람인 데이터를 기반으로 채용 정보 확인</p>
      </div>
      <div class="card" onclick="loadApi('잡코리아')">
        <h3>잡코리아 API</h3>
        <p>잡코리아 연동 채용 데이터 보기</p>
      </div>
    </div>

    <
