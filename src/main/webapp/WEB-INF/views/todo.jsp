<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!doctype html>
<html>
<head>
  <meta charset="UTF-8"/>
  <title>To-Do | JobMate</title>
  <style>
    :root{
      --bg1:#24a1ff; --bg2:#1a2e63;
      --card1:#182a4d; --card2:#1b2f57;
      --header:#0e1d3b;
      --text:#e9f2ff; --muted:#9fb3d8;
      --primary:#35b4ff; --accent:#66e1ff;
      --shadow:0 12px 24px rgba(0,0,0,.25), 0 6px 12px rgba(0,0,0,.18);
      --radius:18px;
    }
    html,body{height:100%}
    body{
      margin:0; color:var(--text);
      font-family:"Pretendard",system-ui,-apple-system,Segoe UI,Roboto,sans-serif;
      background: radial-gradient(1200px 600px at 20% 0%, rgba(255,255,255,.06) 0%, transparent 60%),
                  linear-gradient(160deg, var(--bg1), var(--bg2));
      -webkit-font-smoothing:antialiased;
      padding-top:82px; /* 고정 헤더 높이만큼 */
    }

    /* ===== 상단 고정 헤더 ===== */
    .header{
      position:fixed; inset:0 0 auto 0; z-index:1000;
      background: linear-gradient(180deg, #122549, #0d1e3f);
      border-bottom:1px solid rgba(255,255,255,.08);
      box-shadow:0 8px 20px rgba(0,0,0,.25);
    }
    .nav{
      max-width:1180px; margin:0 auto; padding:16px 20px;
      display:flex; align-items:center; justify-content:space-between; gap:18px;
    }
    .brand{display:flex; align-items:center; gap:10px; font-weight:900;}
    .logo{width:36px;height:36px;border-radius:10px;
      background:linear-gradient(135deg, var(--primary), var(--accent));
      box-shadow:0 6px 10px rgba(0,0,0,.25);}
    .menu{display:flex; gap:28px; align-items:center; font-weight:800;}
    .menu a{color:var(--text); text-decoration:none; opacity:.85; padding:8px 10px; border-radius:10px;}
    .menu a:hover{ background:rgba(255,255,255,.06); opacity:1 }
    .menu .active{ background:rgba(255,255,255,.10); opacity:1; border:1px solid rgba(255,255,255,.12) }
    .right{display:flex; gap:12px; align-items:center;}
    .btn-xs{padding:10px 12px;border-radius:10px;border:1px solid rgba(255,255,255,.16);
      background:transparent;color:var(--text);font-weight:700;cursor:pointer;}
    .btn-xs.primary{ background:linear-gradient(180deg,#2fb8ff,#249cff); color:#0a2741; border:none; }

    /* ===== 레이아웃/카드 ===== */
    .container{ max-width:1180px; margin:28px auto 80px; padding:0 18px; }
    .grid{ display:grid; grid-template-columns:1fr; gap:18px; }
    @media(min-width:1000px){ .grid{ grid-template-columns:1.1fr .9fr; } }
    .card{
      background:linear-gradient(180deg, var(--card1), var(--card2));
      border-radius:var(--radius);
      border:1px solid rgba(255,255,255,.06);
      box-shadow:var(--shadow);
    }
    .card-hd{ padding:22px 24px; border-bottom:1px solid rgba(255,255,255,.06); }
    .title{ font-size:28px; font-weight:900; letter-spacing:.2px; display:flex; gap:10px; align-items:center;}
    .chip{ font-size:13px; color:#58b8ff; background:#0d203f; border:1px solid rgba(255,255,255,.08);
      padding:4px 8px; border-radius:999px }

    /* ===== 리스트 ===== */
    table{ width:100%; border-collapse:collapse; }
    th,td{ padding:16px 18px; text-align:left; }
    thead th{ color:var(--muted); font-weight:700; font-size:13px; letter-spacing:.4px; text-transform:uppercase; }
    tbody tr{ border-top:1px solid rgba(255,255,255,.06); }
    .done{ color:#a8b9dc; text-decoration:line-through; }
    .empty{ padding:24px; border-radius:12px; background:rgba(255,255,255,.04);
      border:1px dashed rgba(255,255,255,.14); color:var(--muted); }

    /* ===== 입력/버튼 ===== */
    .form{ padding:22px 24px; }
    .row{ display:flex; gap:12px; flex-wrap:wrap; }
    .input{
      appearance:none; outline:none; border:none; color:var(--text);
      background:rgba(255,255,255,.06); border:1px solid rgba(255,255,255,.1);
      border-radius:12px; padding:14px 16px; min-width:260px; flex:1 1 260px; transition:.2s;
    }
    .input::placeholder{ color:rgba(233,242,255,.6); }
    .input:focus{ box-shadow:0 0 0 3px rgba(53,180,255,.25); }
    .btn{
      display:inline-flex; align-items:center; gap:8px; cursor:pointer;
      padding:12px 18px; border-radius:12px; border:1px solid rgba(255,255,255,.12);
      background:linear-gradient(180deg,#2fb8ff,#249cff); color:#04243f; font-weight:900;
    }
    .btn.secondary{ background:transparent; color:var(--text); border-color:rgba(255,255,255,.18); }
    .btn.danger{ background:linear-gradient(180deg,#ff8898,#ff6b81); color:#2f0b11; }
    .icon-btn{ background:transparent; border:1px solid rgba(255,255,255,.18);
      border-radius:10px; padding:8px 10px; color:var(--text); cursor:pointer; }
  </style>
</head>
<body>

 <!-- ✅ 상단 네비게이션 추가 -->
  <nav style="margin-bottom:30px;">
  <a href="${pageContext.request.contextPath}/member/challenge"
     style="margin-right:15px; color:#7fc8ff; font-weight:600; text-decoration:none;">
    공용 미션
  </a>

  <c:if test="${sessionScope.loginMember != null 
               && sessionScope.loginMember.username == 'minwoo0821'}">
    <a href="${pageContext.request.contextPath}/admin/public-todo"
       style="color:#ffd07f; font-weight:600; text-decoration:none;">
      공용 미션 관리
    </a>
  </c:if>
</nav>



  <!-- ===== 상단 고정 헤더 ===== -->
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
          <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
          <button class="btn-xs">로그아웃</button>
        </form>
        <button class="btn-xs primary">JobMate 점수</button>
      </div>
    </nav>
  </header>
  
  
  <!-- Flash Message -->
  <c:if test="${not empty msg}">
    <div class="toast ok">${msg}</div>
  </c:if>
  <c:if test="${not empty err}">
    <div class="toast err">${err}</div>
  </c:if>

  <!-- ===== 본문 ===== -->
  <div class="container">
    <div class="grid">

      <!-- 좌측: 리스트 카드 -->
      <section class="card">
        <div class="card-hd">
          <div class="title">To-Do 목록 <span class="chip">JobMate 스타일</span></div>
        </div>
        <div style="padding: 8px 10px 4px;"></div>
        <div style="padding: 0 12px 22px;">
          <c:choose>
            <c:when test="${empty todos}">
              <div class="empty">아직 등록된 할 일이 없어요. 우측 카드에서 새 할 일을 추가해 보세요!</div>
            </c:when>
            <c:otherwise>
              <table>
                <thead>
                  <tr>
                    <th style="width:90px;">상태</th>
                    <th>제목</th>
                    <th>내용</th>
                    <th style="width:140px;">작업</th>
                  </tr>
                </thead>
                <tbody>
                <c:forEach var="t" items="${todos}">
                  <tr>
                    <td>
                     <!-- ✅ 완료는 한 방향(0→1)만: 최초 1회만 +1점 -->
                      <form action="${pageContext.request.contextPath}/member/todo/complete" method="post" style="display:inline;">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                        <input type="hidden" name="id" value="${t.id}"/>
                        <button class="icon-btn" type="submit" ${t.completed ? "disabled" : ""}>
                          ${t.completed ? '✅ 완료' : '⬜ 완료하기'}
                        </button>
                      </form>
                    </td>
                    <td class="${t.completed ? 'done' : ''}">${t.title}</td>
                    <td class="${t.completed ? 'done' : ''}">
                      <span>${t.content}</span>
                    </td>
                    <td>
                      <form action="${pageContext.request.contextPath}/member/todo/delete" method="post" style="display:inline;">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
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

      <!-- 우측: 새 할 일 추가 카드 -->
      <aside class="card">
        <div class="card-hd">
          <div class="title" style="font-size:30px;">새 할 일 추가</div>
        </div>
        <div class="form">
        
         <!-- ✅ 하루 10개 제한: remainToday/todayCount가 있으면 안내 -->
         <c:if test="${not empty todayCount}">
            <div style="color:#b6c4e9; margin-bottom:10px;">
              오늘 추가한 개수: <b>${todayCount}</b>개
              <c:if test="${not empty remainToday}">
                &nbsp;|&nbsp; 남은 가능: <b>${remainToday}</b>개
              </c:if>
            </div>
          </c:if>
         
          <form class="row" action="${pageContext.request.contextPath}/member/todo/add" method="post" style="row-gap:14px;">
            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

            <input class="input" type="text"   name="title"   placeholder="할 일 제목" required />
            <input class="input" type="text"   name="content" placeholder="세부 내용(선택)" />

            <!-- ✅ 생성은 항상 미완료로 -->
             <button class="btn" type="submit" ${remainToday!=null && remainToday<=0 ? "disabled" : ""}>+ 추가</button>
          </form>
        </div>
      </aside>

    </div>
  </div>
</body>
</html>
