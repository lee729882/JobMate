<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<html>
<head>
  <meta charset="UTF-8"/>
  <title>To-Do | JobMate</title>
  <style>
    :root{
      --bg-grad-1:#24a1ff; --bg-grad-2:#1a2e63;
      --card:#182a4d; --card-2:#1b2f57;
      --text:#e9f2ff; --muted:#9fb3d8;
      --primary:#35b4ff; --accent:#66e1ff;
      --danger:#ff6b81; --ok:#29d17f;
      --shadow:0 12px 24px rgba(0,0,0,.25), 0 6px 12px rgba(0,0,0,.18);
      --radius:16px;
      --header:#0e1d3b;
    }

    html,body{height:100%}
    body{
      margin:0; color:var(--text);
      font-family:"Pretendard",system-ui,-apple-system,Segoe UI,Roboto,sans-serif;
      background: radial-gradient(1200px 600px at 20% 0%, rgba(255,255,255,.06) 0%, transparent 60%),
                  linear-gradient(160deg, var(--bg-grad-1), var(--bg-grad-2));
      -webkit-font-smoothing:antialiased;
      padding-top:76px; /* 고정 헤더 높이 보정 */
    }

    /* ===== 헤더(고정) ===== */
    .header{
      position:fixed; top:0; left:0; right:0; z-index:1000;
      background: linear-gradient(180deg, #112347, #0d1e3f);
      border-bottom:1px solid rgba(255,255,255,.08);
      box-shadow:0 8px 20px rgba(0,0,0,.25);
    }
    .nav{
      max-width:1180px; margin:0 auto; padding:14px 20px;
      display:flex; align-items:center; justify-content:space-between; gap:16px;
    }
    .brand{display:flex; align-items:center; gap:10px; font-weight:900; letter-spacing:.2px;}
    .logo{
      width:34px; height:34px; border-radius:9px;
      background:linear-gradient(135deg, var(--primary), var(--accent));
      box-shadow:0 6px 10px rgba(0,0,0,.25);
    }
    .menu{display:flex; gap:22px; align-items:center; font-weight:700;}
    .menu a{
      color:var(--text); text-decoration:none; opacity:.85; padding:8px 10px; border-radius:10px;
    }
    .menu a:hover{ background:rgba(255,255,255,.06); opacity:1 }
    .menu .active{ background:rgba(255,255,255,.10); opacity:1; border:1px solid rgba(255,255,255,.12) }
    .right{display:flex; gap:12px; align-items:center; color:var(--muted); font-weight:700;}
    .btn-xs{ padding:8px 12px; border-radius:10px; border:1px solid rgba(255,255,255,.14); background:transparent; color:var(--text); cursor:pointer;}
    .btn-xs.primary{ background:linear-gradient(180deg,#2fb8ff,#249cff); color:#04243f; border:none; }

    /* ===== 공통 카드 ===== */
    .container{ max-width:1100px; margin:32px auto 80px; padding:0 20px; }
    .grid{ display:grid; grid-template-columns:1fr; gap:18px; }
    @media(min-width:900px){ .grid{ grid-template-columns: 1.1fr .9fr; } }
    .card{
      background:linear-gradient(180deg, var(--card), var(--card-2));
      border-radius:var(--radius);
      box-shadow:var(--shadow);
      border:1px solid rgba(255,255,255,.06);
    }
    .card-header{ padding:22px 24px; border-bottom:1px solid rgba(255,255,255,.06); }
    .title{ font-size:22px; font-weight:800; letter-spacing:.2px; display:flex; gap:10px; align-items:center;}
    .chip{ font-size:13px; color:var(--bg-grad-1); background:#0d203f; border:1px solid rgba(255,255,255,.06);
      padding:4px 8px; border-radius:999px }

    /* 입력/버튼 */
    .form-card .row{ display:flex; gap:12px; flex-wrap:wrap; }
    .input{
      appearance:none; outline:none; border:none; color:var(--text);
      background:rgba(255,255,255,.06); border:1px solid rgba(255,255,255,.08);
      border-radius:12px; padding:12px 14px; min-width:260px; flex:1 1 260px; transition:.2s;
    }
    .input::placeholder{ color:rgba(233,242,255,.6); }
    .input:focus{ box-shadow:0 0 0 3px rgba(53,180,255,.25); }
    .btn{
      display:inline-flex; align-items:center; gap:8px; cursor:pointer;
      padding:12px 16px; border-radius:12px; border:1px solid rgba(255,255,255,.12);
      background:linear-gradient(180deg,#2fb8ff,#249cff);
      color:#04243f; font-weight:800; letter-spacing:.2px;
    }
    .btn.secondary{ background:transparent; color:var(--text); border-color:rgba(255,255,255,.18); }
    .btn.danger{ background:linear-gradient(180deg,#ff8898,#ff6b81); color:#3a0b14; }

    /* 테이블 */
    table{ width:100%; border-collapse:collapse; }
    th,td{ padding:16px 18px; text-align:left; }
    thead th{ color:var(--muted); font-weight:700; font-size:13px; letter-spacing:.4px; text-transform:uppercase; }
    tbody tr{ border-top:1px solid rgba(255,255,255,.06); }
    .done{ color:#a8b9dc; text-decoration:line-through; }
    .badge{ font-size:12px; padding:4px 8px; border-radius:999px; background:rgba(255,255,255,.08); }
    .empty{ padding:28px; border-radius:12px; background:rgba(255,255,255,.04);
      border:1px dashed rgba(255,255,255,.14); color:var(--muted); }

    .icon-btn{ background:transparent; border:1px solid rgba(255,255,255,.18);
      border-radius:10px; padding:8px 10px; color:var(--text); cursor:pointer; }
    .icon-ok{ color:var(--ok); }
  </style>
</head>
<body>

  <!-- ===== 고정 헤더 ===== -->
  <header class="header">
    <nav class="nav">
      <div class="brand">
        <div class="logo"></div>
        <div>JobMate</div>
      </div>
      <div class="menu">
        <a href="${pageContext.request.contextPath}/member/dashboard">대시보드</a>
        <a class="active" href="${pageContext.request.contextPath}/member/todo">To-Do</a>
        <a href="${pageContext.request.contextPath}/member/employment/list">면접 AI</a>
        <a href="#">취업 커뮤니티</a>
        <a href="${pageContext.request.contextPath}/member/member/profile">My Profile</a>
      </div>
      <div class="right">
        <form action="${pageContext.request.contextPath}/member/logout" method="post" style="margin:0">
          <button class="btn-xs">로그아웃</button>
        </form>
        <button class="btn-xs primary">JobMate 점수</button>
      </div>
    </nav>
  </header>

  <!-- ===== 본문 ===== -->
  <div class="container">
    <div class="grid">
      <!-- 좌: 리스트 -->
      <section class="card">
        <div class="card-header">
          <div class="title">To-Do 목록 <span class="chip">JobMate 스타일</span></div>
        </div>
        <div style="padding: 6px 6px 4px;"></div>
        <div style="padding: 0 6px 18px;">
          <c:choose>
            <c:when test="${empty todos}">
              <div class="empty">아직 등록된 할 일이 없어요. 우측 카드에서 새 할 일을 추가해 보세요!</div>
            </c:when>
            <c:otherwise>
              <table>
                <thead>
                  <tr>
                    <th style="width:90px;">완료</th>
                    <th>제목</th>
                    <th>내용</th>
                    <th style="width:140px;">작업</th>
                  </tr>
                </thead>
                <tbody>
                <c:forEach var="t" items="${todos}">
                  <tr>
                    <td>
                      <form action="${pageContext.request.contextPath}/member/todo/toggle" method="post" style="display:inline;">
                        <input type="hidden" name="id" value="${t.id}"/>
                        <button class="icon-btn" title="완료 전환">
                          <span class="${t.completed ? 'icon-ok' : ''}">${t.completed ? '✅ 완료' : '⬜ 미완'}</span>
                        </button>
                      </form>
                    </td>
                    <td class="${t.completed ? 'done' : ''}">${t.title}</td>
                    <td class="${t.completed ? 'done' : ''}"><span class="badge">${t.content}</span></td>
                    <td>
                      <form action="${pageContext.request.contextPath}/member/todo/delete" method="post" style="display:inline;">
                        <input type="hidden" name="id" value="${t.id}"/>
                        <button class="btn danger" type="submit">삭제</button>
                      </form>
                    </td>
                  </tr>
                </c:forEach>
                </tbody>
              </table>
            </c:otherwise>
          </c:choose>
        </div>
      </section>

      <!-- 우: 추가 카드 -->
      <aside class="card form-card">
        <div class="card-header">
          <div class="title">새 할 일 추가</div>
        </div>
        <div style="padding:22px 24px;">
          <form class="row" action="${pageContext.request.contextPath}/member/todo/add" method="post">
            <input class="input" type="text"   name="title"   placeholder="할 일 제목" required />
            <input class="input" type="text"   name="content" placeholder="세부 내용(선택)" />
            <label class="btn secondary" style="gap:10px;">
              <input type="checkbox" name="completed" style="accent-color: var(--primary); transform:scale(1.2)"/> 완료로 추가
            </label>
            <button class="btn" type="submit">+ 추가</button>
          </form>
        </div>
      </aside>
    </div>
  </div>
</body>
</html>
