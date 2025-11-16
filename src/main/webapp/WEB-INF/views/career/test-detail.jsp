<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>${test.qnm} - 검사 진행</title>

    <style>
        :root {
            --bg1:#0ea5e9; --bg2:#6366f1;
            --card-bg:rgba(255,255,255,0.10);
            --line:rgba(255,255,255,0.25);
            --text:#ffffff;
            --text-sub:#dbeafe;
            --accent:#3b82f6;
        }

        body {
            margin:0;
            min-height:100vh;
            background:linear-gradient(135deg, var(--bg1), var(--bg2));
            font-family:"Noto Sans KR", sans-serif;
            color:white;
            display:flex;
            flex-direction:column;
        }

        /* HEADER */
        header {
            display:flex; align-items:center; justify-content:space-between;
            padding:16px 40px;
            background:rgba(10,20,40,.55);
            backdrop-filter:blur(10px);
            border-bottom:1px solid rgba(255,255,255,.1);
        }

        .left-nav { display:flex; align-items:center; gap:40px; }
        .logo { font-size:22px; font-weight:800; display:flex; align-items:center; gap:10px; cursor:pointer; }
        .logo .mark {
            width:30px; height:30px; border-radius:8px;
            background:conic-gradient(from 180deg at 50% 50%, #22d3ee, #60a5fa, #a78bfa, #22d3ee);
            box-shadow:0 0 20px #22d3ee77;
        }
        nav.menu { display:flex; gap:30px; }

        .menu a { color:#cbd5e1; text-decoration:none; font-size:15px; }
        .menu a:hover, .menu a.active { color:#22d3ee; }

        .user-info { display:flex; gap:16px; font-size:14px; color:#e6eefc; align-items:center; }

        .logout-btn {
            background:#ef4444; color:white; border:none;
            padding:6px 12px; border-radius:8px; cursor:pointer;
        }

        /* MAIN */
        main {
            flex:1; display:flex; flex-direction:column;
            align-items:center; padding:60px 20px;
        }

        h1 {
            font-size:28px; font-weight:700;
            margin-bottom:10px; text-shadow:0 0 10px rgba(0,0,0,0.3);
        }

        .summary {
            font-size:16px;
            color:#e2e8f0;
            margin-bottom:40px;
            text-align:center;
            max-width:800px;
            line-height:1.6;
        }

        /* QUESTION CARD */
        .question-card {
            width:min(90%, 900px);
            background:rgba(10,20,40,0.55);
            border:1px solid rgba(255,255,255,0.12);
            border-radius:18px;
            padding:28px;
            margin-bottom:28px;
            backdrop-filter:blur(12px);
            box-shadow:0 10px 32px rgba(0,0,0,0.5);
            transition:0.25s;
        }

        .question-card:hover {
            transform:translateY(-4px);
            box-shadow:0 14px 36px rgba(0,0,0,0.6);
        }

        .question-title {
            font-size:20px;
            font-weight:700;
            margin-bottom:20px;
        }

        .choice-box {
            background:rgba(255,255,255,0.05);
            border:1px solid rgba(255,255,255,0.18);
            padding:14px 16px;
            border-radius:12px;
            margin-bottom:12px;
            cursor:pointer;
            display:flex;
            align-items:center;
            gap:10px;
            transition:0.2s;
        }

        .choice-box:hover { background:rgba(255,255,255,0.15); }

        .choice-text { font-size:15px; color:#e2e8f0; }

        .choice-box input[type=radio] {
            accent-color:#3b82f6;
            transform:scale(1.35);
        }

        .page-nav {
            display:flex;
            gap:12px;
            margin-top:25px;
        }

        .page-btn {
            background:rgba(255,255,255,0.15);
            border:1px solid rgba(255,255,255,0.3);
            padding:10px 18px;
            border-radius:10px;
            cursor:pointer;
            color:white;
            font-size:15px;
            font-weight:600;
            transition:.2s;
        }

        .submit-btn {
            background:var(--accent);
            color:white;
            padding:14px 26px;
            border:none;
            border-radius:12px;
            cursor:pointer;
            font-size:17px;
            font-weight:600;
            margin-top:30px;
        }

        footer {
            text-align:center;
            padding:20px;
            font-size:13px;
            color:#e2e8f0;
            opacity:0.8;
        }
        select {
    background: rgba(255,255,255,0.1);
    color: white;
    border: 1px solid rgba(255,255,255,0.25);
    border-radius: 10px;
    padding: 10px 14px;
}

/* 옵션 펼쳤을 때 배경/글자 색 지정 */
select option {
    background: #1e293b !important;   /* 네이비 */
    color: #f8fafc !important;        /* 하얀색 */
}
        
    </style>
</head>

<body>

<!-- HEADER -->
<header>
    <div class="left-nav">
        <div class="logo" onclick="location.href='${pageContext.request.contextPath}/member/dashboard'">
            <div class="mark"></div> JobMate
        </div>

        <nav class="menu">
            <a href="${pageContext.request.contextPath}/member/dashboard">대시보드</a>
            <a href="${pageContext.request.contextPath}/member/todo">To-Do</a>
            <a href="${pageContext.request.contextPath}/member/interview">면접 AI</a>
            <a href="${pageContext.request.contextPath}/member/community">취업 커뮤니티</a>
            <a href="${pageContext.request.contextPath}/member/profile">My Profile</a>
        </nav>
    </div>

    <div class="user-info">
        <div>
            <strong>${loginMember.name}</strong>
            (${loginMember.username}) 님 |
            <c:out value="${loginMember.careerType == 'EXP' ? '경력직' : '신입'}"/> |
            ${loginMember.phone}
        </div>

        <form action="${pageContext.request.contextPath}/member/logout" method="post">
            <button type="submit" class="logout-btn">로그아웃</button>
        </form>
    </div>
</header>

<!-- MAIN -->
<main>




<h1>🧭 ${test.qnm}</h1>
<p class="summary">${test.summary}</p>

<!-- 저장 폼 -->
<form action="${pageContext.request.contextPath}/controller/career/tests/${test.qno}/save" method="post">

    <input type="hidden" name="page" value="${page}" />

    <c:forEach var="q" items="${questions}">

        <div class="question-card">

            <div class="question-title">
                ${q.no}. ${q.text}
            </div>

            <c:set var="prefix" value="answer_" />

            <c:forEach var="c" items="${q.choices}">
                <c:set var="key" value="${prefix}${q.no}" />

                <label class="choice-box">
                    <input type="radio"
                           name="answer_${q.no}"
                           value="${c.val}"
                           <c:if test="${answers[key] eq c.val}">checked</c:if>
                    />
                    <div class="choice-text">${c.text}</div>
                </label>
            </c:forEach>

        </div>

    </c:forEach>

    <div class="page-nav">
        <c:if test="${page > 1}">
            <button class="page-btn"
                    formaction="${pageContext.request.contextPath}/controller/career/tests/${test.qno}/save?page=${page - 1}">
                ◀ 이전
            </button>
        </c:if>

        <c:if test="${page < maxPage}">
            <button class="page-btn"
                    formaction="${pageContext.request.contextPath}/controller/career/tests/${test.qno}/save?page=${page + 1}">
                다음 ▶
            </button>
        </c:if>
    </div>

</form>
<!-- 마지막 페이지에서만 나타남 -->
<c:if test="${page == maxPage}">
<div class="question-card" style="margin-top:20px;">

    <div class="question-title" style="font-size:18px; margin-bottom:15px;">
        📌 검사 정보 입력
    </div>

    <div style="display:flex; justify-content:center; gap:30px;">

        <!-- 성별 -->
        <div>
            <label style="font-size:16px; font-weight:600;">성별</label><br>
            <select name="gender" id="gender"
                    style="margin-top:8px; padding:10px 14px; width:150px;
                           border-radius:10px; border:1px solid rgba(255,255,255,0.25);
                           background:rgba(255,255,255,0.1); color:white;">
                <option value="100323">남자</option>
                <option value="100324">여자</option>
            </select>
        </div>

        <!-- 학년 -->
        <div>
            <label style="font-size:16px; font-weight:600;">학년</label><br>
            <select name="grade" id="grade"
                    style="margin-top:8px; padding:10px 14px; width:150px;
                           border-radius:10px; border:1px solid rgba(255,255,255,0.25);
                           background:rgba(255,255,255,0.1); color:white;">
                <option value="1">1학년</option>
                <option value="2">2학년</option>
                <option value="3">3학년</option>
                <option value="4">4학년</option>
            </select>
        </div>

    </div>
</div>
</c:if>
<!-- 마지막 페이지 제출 버튼 -->
<c:if test="${page == maxPage}">
    <form id="submitForm" action="${pageContext.request.contextPath}/controller/career/tests/submit" method="post">
        <input type="hidden" name="gender" id="genderField">
        <input type="hidden" name="grade" id="gradeField">

        <button type="submit" class="submit-btn" onclick="copyUserInfo()">
            검사 결과 확인 →
        </button>
    </form>
</c:if>

<script>
function copyUserInfo() {
    document.getElementById("genderField").value =
        document.getElementById("gender").value;
    document.getElementById("gradeField").value =
        document.getElementById("grade").value;
}
</script>

</main>

<footer>
    © 2025 JobMate. All rights reserved.
</footer>

</body>
</html>
