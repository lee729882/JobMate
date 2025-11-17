<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>검사 결과</title>

    <style>
        :root {
            --bg1:#0ea5e9; 
            --bg2:#6366f1;
            --text:#ffffff;
            --text-sub:#dbeafe;
            --accent:#3b82f6;
        }

        body {
            margin:0;
            min-height:100vh;
            background:linear-gradient(135deg, var(--bg1), var(--bg2));
            font-family:"Noto Sans KR", sans-serif;
            display:flex;
            flex-direction:column;
            color:white;
        }

        /* ---------- HEADER ---------- */
        header {
            display:flex;
            align-items:center;
            justify-content:space-between;
            padding:16px 40px;
            background:rgba(10,20,40,.55);
            backdrop-filter:blur(10px);
            border-bottom:1px solid rgba(255,255,255,.1);
        }

        .left-nav { display:flex; align-items:center; gap:40px; }

        .logo {
            font-size:22px; font-weight:800;
            display:flex; align-items:center; gap:10px;
            color:white; cursor:pointer;
        }
        .logo .mark {
            width:30px; height:30px; border-radius:8px;
            background:conic-gradient(from 180deg at 50% 50%, #22d3ee, #60a5fa, #a78bfa, #22d3ee);
            box-shadow:0 0 20px #22d3ee77;
        }

        nav.menu { display:flex; gap:30px; }
        .menu a {
            color:#cbd5e1; text-decoration:none; font-size:15px;
            transition:.2s;
        }
        .menu a:hover { color:#22d3ee; }

        .user-info {
            display:flex; gap:16px;
            font-size:14px; color:#e6eefc;
            align-items:center;
        }

        .logout-btn {
            background:#ef4444; color:white; border:none;
            padding:6px 12px; border-radius:8px; cursor:pointer;
        }

        /* ---------- MAIN ---------- */
        main {
            flex:1;
            display:flex;
            flex-direction:column;
            align-items:center;
            padding:60px 20px;
        }

        .top-card {
            width:min(90%, 1100px);
            background:rgba(10,20,40,0.55);
            border:1px solid rgba(255,255,255,0.15);
            border-radius:18px;
            padding:40px;
            backdrop-filter:blur(10px);
            box-shadow:0 8px 32px rgba(0,0,0,0.4);
            animation:fadeIn .8s ease;
        }

        h1 { font-size:28px; margin-bottom:20px; }

        .debug-box {
            width:100%;
            background:#0f172a;
            border-radius:14px;
            padding:20px;
            margin-top:18px;
            color:#cbd5e1;
            font-size:14px;
            line-height:1.5;
            box-shadow:0 4px 16px rgba(0,0,0,0.35);
        }

        iframe {
            width:100%;
            height:1800px;
            border:none;
            margin-top:25px;
            border-radius:10px;
            background:white;
        }

        .btn {
            display:inline-block;
            margin-top:25px;
            background:var(--accent);
            padding:12px 20px;
            border-radius:12px;
            color:white;
            font-weight:600;
            text-decoration:none;
            transition:.2s;
        }
        .btn:hover { background:#1d4ed8; }

        @keyframes fadeIn {
            from {opacity:0; transform:translateY(20px);}
            to   {opacity:1; transform:translateY(0);}
        }

        /* ---------- FOOTER ---------- */
        footer {
            margin-top:60px;
            width:100%;
            text-align:center;
            padding:20px;
            color:#dbeafe9a;
            font-size:14px;
        }
    </style>
</head>

<body>

<!-- ========================= HEADER ========================= -->
<header>
    <div class="left-nav">
        <div class="logo" onclick="location.href='${pageContext.request.contextPath}/member/dashboard'">
            <div class="mark"></div> JobMate
        </div>

        <nav class="menu">
            <a href="${pageContext.request.contextPath}/member/dashboard">대시보드</a>
            <a href="${pageContext.request.contextPath}/member/todo">To-Do</a>
            <a href="${pageContext.request.contextPath}/member/interview">면접 AI</a>
      <a href="${pageContext.request.contextPath}/member/community/select">취업 커뮤니티</a>
      <a href="${pageContext.request.contextPath}/member/profile">My Profile</a>
        </nav>
    </div>

    <div class="user-info">
        <div>
            <strong><c:out value="${loginMember.name}" /></strong>
            (<c:out value="${loginMember.username}" />) 님 |
            <c:out value="${loginMember.careerType == 'EXP' ? '경력직' : '신입'}" /> |
            <c:out value="${loginMember.phone}" />
        </div>
        <form action="${pageContext.request.contextPath}/member/logout" method="post">
            <button type="submit" class="logout-btn">로그아웃</button>
        </form>
    </div>
</header>
<!-- ========================================================= -->

<main>

    <div class="top-card">
        <h1>📊 검사 결과</h1>

        <p>아래는 CareerNet 공식 결과 페이지를 임베드한 화면입니다.</p>

        <div class="debug-box">
            <strong>CareerNet API JSON 결과</strong><br><br>
${career}

            <iframe src="${url}"></iframe>
        </div>

        <c:if test="${not empty url}">
            <a class="btn" href="${url}" target="_blank">
                CareerNet 결과 페이지 직접 열기 →
            </a>
        </c:if>
    </div>

</main>

<!-- ========================= FOOTER ========================= -->
<footer>
    © 2025 MOKPO UNIVERSITY · JobMate Career Platform
</footer>

</body>
</html>
