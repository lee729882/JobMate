<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <title>가입 완료 | JobMate</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">

  <style>
    :root{
      --bg1:#0ea5e9; --bg2:#6366f1;
      --card:#0b1220aa; --line:#2a3250;
      --text:#e6eefc; --muted:#b6c4e9; --accent:#22d3ee;
      --btn:#16a34a; --error:#ef4444;
    }
    body{
      margin:0; min-height:100vh; color:var(--text);
      background: radial-gradient(1200px 800px at 20% 10%, #1b2a4a 0%, #0d1426 60%),
                  linear-gradient(135deg, var(--bg1), var(--bg2));
      background-blend-mode: screen, normal;
      display:flex; align-items:center; justify-content:center;
      font-family:"Noto Sans KR", system-ui, -apple-system, Segoe UI, Roboto, sans-serif;
    }
    .wrap{ width:min(100%, 680px); padding:24px; box-sizing:border-box; }
    .brand{ display:flex; align-items:center; gap:10px; margin:0 0 14px; opacity:.95; }
    .brand .logo{ width:36px; height:36px; border-radius:10px;
      background: conic-gradient(from 180deg at 50% 50%, #22d3ee, #60a5fa, #a78bfa, #22d3ee);
      box-shadow:0 0 40px #22d3ee33, inset 0 0 12px #ffffff55; }
    .brand h1{ font-size:20px; margin:0; }
    .card{
      background:var(--card); border:1px solid var(--line);
      box-shadow:0 12px 40px rgba(0,0,0,.35), inset 0 1px 0 rgba(255,255,255,.06);
      backdrop-filter: blur(10px);
      border-radius:18px; padding:32px; position:relative; overflow:hidden; text-align:center;
    }
    .card::before{ content:""; position:absolute; inset:-1px; border-radius:18px;
      background:linear-gradient(135deg, #ffffff22, transparent 40%); pointer-events:none; }
    h2{ font-size:24px; margin:0 0 18px; font-weight:800; }
    .info{ color:var(--muted); font-size:14px; margin:6px 0; }
    .actions{ margin-top:24px; display:flex; gap:10px; justify-content:center; }
    .btn{ border:none; cursor:pointer; padding:12px 20px; border-radius:12px; font-weight:800; color:white;
      background:linear-gradient(135deg, var(--btn), #19b354); box-shadow:0 10px 24px rgba(22,163,74,.25); text-decoration:none; display:inline-block; }
    .btn-secondary{ background:linear-gradient(135deg, #334155, #1f2937); }
  </style>
</head>
<body>
  <div class="wrap">
    <div class="brand">
      <div class="logo"></div><h1>JobMate</h1>
    </div>

    <div class="card">
      <h2>가입이 완료되었습니다 🎉</h2>
      <p class="info">아이디: <c:out value="${username}"/></p>

      <div class="actions">
        <a class="btn" href="<c:url value='/member/login'/>">로그인 하러 가기</a>
        <a class="btn btn-secondary" href="<c:url value='/'/>">홈으로</a>
      </div>
    </div>
  </div>
</body>
</html>
