<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <title>회원가입 | JobMate</title>
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

    .wrap{ width:min(100%, 480px); padding:24px; box-sizing:border-box; }
    .brand{ display:flex; align-items:center; gap:10px; margin:0 0 14px; opacity:.95; }
    .brand .logo{ width:36px; height:36px; border-radius:10px;
      background: conic-gradient(from 180deg at 50% 50%, #22d3ee, #60a5fa, #a78bfa, #22d3ee);
      box-shadow:0 0 40px #22d3ee33, inset 0 0 12px #ffffff55; }
    .brand h1{ font-size:20px; margin:0; }

    .card{
      background:var(--card); border:1px solid var(--line);
      box-shadow:0 12px 40px rgba(0,0,0,.35), inset 0 1px 0 rgba(255,255,255,.06);
      backdrop-filter: blur(10px);
      border-radius:18px; padding:26px; position:relative; overflow:hidden;
    }
    .card::before{ content:""; position:absolute; inset:-1px; border-radius:18px;
      background:linear-gradient(135deg, #ffffff22, transparent 40%); pointer-events:none; }

    .title{ margin:0 0 18px; font-size:22px; font-weight:800; }
    label{ display:block; margin:2px 0 8px; font-size:13px; color:#fff; }
    input, select{
      width:100%; box-sizing:border-box; padding:12px 14px; color:#fff;
      background:#0e172a; border:1px solid #1f2946; border-radius:12px; outline:none;
    }
    input::placeholder{ color:#8da1d6; }
    input:focus, select:focus{
      border-color:var(--accent);
      box-shadow:0 0 0 3px rgba(34,211,238,.15), 0 10px 30px rgba(34,211,238,.05);
    }

    .actions{ margin-top:18px; display:flex; gap:10px; justify-content:flex-end; }
    .btn{ border:none; cursor:pointer; padding:12px 18px; border-radius:12px; font-weight:800; color:white;
      background:linear-gradient(135deg, var(--btn), #19b354); box-shadow:0 10px 24px rgba(22,163,74,.25); }
    .btn-secondary{ background:linear-gradient(135deg, #334155, #1f2937); }
    .error{ color:var(--error); font-size:12px; margin-top:6px; }
  </style>
</head>

<body>
<div class="wrap">
  <div class="brand">
    <div class="logo"></div><h1>JobMate</h1>
  </div>

  <div class="card">
    <h2 class="title">회원가입</h2>

    <form:form modelAttribute="member" method="post" action="${pageContext.request.contextPath}/member/signup">
      <label for="username">아이디 *</label>
      <form:input path="username" id="username"/>
      <form:errors path="username" cssClass="error"/>

      <label for="password">비밀번호 *</label>
      <form:password path="password" id="password"/>
      <form:errors path="password" cssClass="error"/>

      <label for="email">이메일 *</label>
      <form:input path="email" id="email" type="email"/>
      <form:errors path="email" cssClass="error"/>

      <label for="phone">전화번호</label>
      <form:input path="phone" id="phone" placeholder="010-1234-5678"/>

      <label for="careerType">경력 여부</label>
      <form:select path="careerType" id="careerType">
        <form:option value="" label="선택"/>
        <form:option value="NEW" label="신입"/>
        <form:option value="EXP" label="경력"/>
      </form:select>

      <label for="region">지역</label>
      <form:input path="region" id="region" placeholder="예: 서울특별시 강남구"/>

      <label for="certifications">자격증</label>
      <form:input path="certifications" id="certifications" placeholder="예: 간호사, 정보처리기사"/>

      <div class="actions">
        <button type="button" class="btn btn-secondary" onclick="history.back()">돌아가기</button>
        <button class="btn" type="submit">회원가입 완료</button>
      </div>
    </form:form>
  </div>
</div>
</body>
</html>
