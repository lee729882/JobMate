<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <title>로그인 | JobMate</title>
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

    .wrap{ width:min(100%, 980px); padding:24px; box-sizing:border-box; }
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

    .title{ display:flex; align-items:flex-end; justify-content:space-between; gap:12px; margin:0 0 18px; }
    .title h2{ margin:0; font-size:22px; font-weight:800; }
    .subtitle{ color:var(--muted); font-size:13px; }

    .grid{ display:grid; gap:16px; grid-template-columns: repeat(12, 1fr); }
    .col-6{ grid-column: span 6; } .col-12{ grid-column: span 12; }
    @media (max-width: 900px){ .col-6{ grid-column: span 12; }}

    label{ display:block; margin:2px 0 8px; font-size:13px; color:#fff; }
    input{
      width:100%; box-sizing:border-box; padding:12px 14px; color:#fff;
      background:#0e172a; border:1px solid #1f2946; border-radius:12px; outline:none;
    }
    input::placeholder{ color:#8da1d6; }
    input:focus{
      border-color:var(--accent);
      box-shadow:0 0 0 3px rgba(34,211,238,.15), 0 10px 30px rgba(34,211,238,.05);
    }

    .actions{ margin-top:18px; display:flex; gap:10px; justify-content:flex-end; }
    .btn{ border:none; cursor:pointer; padding:12px 18px; border-radius:12px; font-weight:800; color:white;
      background:linear-gradient(135deg, var(--btn), #19b354); box-shadow:0 10px 24px rgba(22,163,74,.25); }
    .btn-secondary{ background:linear-gradient(135deg, #334155, #1f2937); }

    .row-inline{ display:flex; align-items:center; justify-content:space-between; gap:10px; }
    .hint{ color:var(--muted); font-size:12px; }
    .error{ color:#ffb4b4; background:#2b0e12; border:1px solid #7f1d1d; padding:10px 12px; border-radius:10px; margin-bottom:12px; }
    .ok{ color:#b7ffcf; background:#0f2b1a; border:1px solid #14532d; padding:10px 12px; border-radius:10px; margin-bottom:12px; }
  </style>
</head>
<body>
  <div class="wrap">
    <div class="brand">
      <div class="logo"></div><h1>JobMate</h1>
    </div>

    <div class="card" style="max-width:640px;margin:0 auto;">
      <div class="title">
        <h2>로그인</h2>
        <div class="subtitle">아이디와 비밀번호를 입력해 주세요.</div>
      </div>

      <c:if test="${not empty error}">
        <div class="error"><c:out value="${error}"/></div>
      </c:if>
      <c:if test="${not empty loginMsg}">
        <div class="ok"><c:out value="${loginMsg}"/></div>
      </c:if>

      <form action="<c:url value='/member/login'/>" method="post" autocomplete="off" accept-charset="UTF-8">
        <div class="grid">
          <div class="col-12">
            <label for="username">아이디 *</label>
            <input id="username" name="username" type="text" value="${member.username}" placeholder="아이디를 입력하세요" required />
          </div>
          <div class="col-12">
            <label for="password">비밀번호 *</label>
            <input id="password" name="password" type="password" placeholder="비밀번호를 입력하세요" required />
          </div>
          <div class="col-12 row-inline">
            <label style="display:flex;align-items:center;gap:8px;">
              <input type="checkbox" name="remember" value="Y" style="width:auto;"> 로그인 상태 유지
            </label>
			<a href="<c:url value='/member/findPw'/>" class="hint">비밀번호 찾기</a>
          </div>
        </div>

        <div class="actions">
          <a class="btn btn-secondary" href="<c:url value='/member/signup'/>" style="text-decoration:none;display:inline-block;">회원가입</a>
          <button class="btn" type="submit">로그인</button>
        </div>
      </form>

      <c:if test="${not empty sessionScope.loginMember}">
        <hr style="border:0; border-top:1px solid var(--line); margin:18px 0;">
        <div class="row-inline">
          <div class="hint">
            <b><c:out value="${sessionScope.loginMember.username}"/></b> 님으로 로그인됨
          </div>
          <form action="<c:url value='/member/logout'/>" method="post" style="margin:0;">
            <button class="btn btn-secondary" type="submit">로그아웃</button>
          </form>
        </div>
      </c:if>
    </div>
  </div>

  <script>
    // Enter키 UX: 비번 입력 중 Enter 누르면 제출
    document.getElementById('password')?.addEventListener('keydown', function(e){
      if(e.key === 'Enter'){
        e.target.form?.submit();
      }
    });
    // 첫 진입 포커스
    window.addEventListener('DOMContentLoaded', () => {
      const u = document.getElementById('username');
      if(u && !u.value) u.focus();
    });
  </script>
</body>
</html>
