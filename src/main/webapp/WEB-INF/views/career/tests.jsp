<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>진로 심리검사 목록</title>

    <style>
        :root {
            --bg1:#0ea5e9; --bg2:#6366f1;
            --card-bg:rgba(255,255,255,0.07);
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

        /* ────────────────────────── HEADER ────────────────────────── */

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
        .menu a:hover, .menu a.active { color:#22d3ee; }

        .user-info {
            display:flex; gap:16px;
            font-size:14px; color:#e6eefc;
            align-items:center;
        }

        .logout-btn {
            background:#ef4444; color:white; border:none;
            padding:6px 12px; border-radius:8px; cursor:pointer;
        }

        /* ────────────────────────── MAIN ────────────────────────── */

        main {
            flex:1;
            display:flex;
            flex-direction:column;
            align-items:center;
            padding:60px 20px;
        }

        h1 {
            margin-top:40px;
            font-size:28px;
            font-weight:700;
            text-align:center;
            color:white;
            text-shadow:0 0 10px rgba(0,0,0,0.3);
        }

/* 검사 목록 카드 – 더 진하게 수정 */
.test-card {
    width: min(90%, 900px);
    background: rgba(10, 20, 40, 0.55);            /* 🔥 더 어둡고 선명한 네이비 */
    border: 1px solid rgba(255, 255, 255, 0.12);
    border-radius: 18px;
    padding: 28px;
    margin-top: 35px;
    backdrop-filter: blur(14px);
    box-shadow: 0 10px 32px rgba(0,0,0,0.5);
    transition: 0.25s;
}

.test-card:hover {
    transform: translateY(-4px);
    box-shadow: 0 14px 36px rgba(0,0,0,0.65);
}

/* 검사 제목 */
.title {
    font-size: 22px;
    font-weight: 700;
    color: #ffffff;
    margin-bottom: 12px;
}

/* 설명 */
.desc {
    font-size: 15px;
    color: #dbeafe;                 /* 🔥 밝은 파스텔톤 = 가독성 최고 */
    margin-bottom: 18px;
    line-height: 1.55;
}

/* 예상 시간 */
.info {
    font-size: 14px;
    color: #e2e8f0;                 /* 🔥 밝은 회색으로 통일 */
    display: flex;
    align-items: center;
    gap: 6px;
    margin-bottom: 25px;
}

/* 시작 버튼 */
.start-btn {
    background: #3b82f6;
    color: white;
    padding: 12px 20px;
    border: none;
    border-radius: 12px;
    cursor: pointer;
    font-size: 15px;
    font-weight: 600;
    transition: 0.25s;
}

.start-btn:hover {
    background: #1d4ed8;
    box-shadow: 0 0 12px rgba(59,130,246,0.6);
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
<!-- =========================================================== -->

<main>
    <h1>🧭 진로 심리검사 목록</h1>

<c:forEach var="t" items="${tests}">
    <div class="test-card">

        <div class="title">${t.title}</div>
        <div class="desc">${t.desc}</div>

        <div class="info">
            ⏱ 예상 소요시간: <b>10분</b>
        </div>

        <button class="start-btn"
                onclick="location.href='${pageContext.request.contextPath}/controller/career/tests/${t.id}'">
            검사 시작하기 →
        </button>

    </div>
</c:forEach>


</main>

</body>
</html>
