<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>JobMate 대시보드</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">

  <style>
    :root {
      --bg1:#0ea5e9; --bg2:#6366f1;
      --card:#0b1220aa; --line:#2a3250;
      --text:#e6eefc; --muted:#b6c4e9; --accent:#22d3ee;
    }

    body {
      margin:0;
      min-height:100vh;
      color:var(--text);
      background:linear-gradient(135deg, var(--bg1), var(--bg2));
      font-family:"Noto Sans KR", sans-serif;
      display:flex; flex-direction:column;
    }

    /* ───── Header ───── */
    header {
      display:flex; align-items:center; justify-content:space-between;
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

    /* ───── Main Layout ───── */
    main {
      flex:1; display:flex; flex-direction:column;
      align-items:center; padding:50px 20px;
      gap:30px;
    }

    h1 {
      font-size:26px; font-weight:700; color:white;
      text-shadow:0 0 10px #22d3ee55;
    }

    .dashboard-grid {
      display:grid;
      grid-template-columns:2fr 1fr;
      gap:30px;
      width:min(100%,1300px);
    }

    .left-panel, .right-panel {
      display:flex; flex-direction:column; gap:20px;
    }

    .card {
      background:var(--card);
      border:1px solid var(--line);
      border-radius:18px;
      padding:24px;
      backdrop-filter:blur(10px);
      transition:.25s;
      box-shadow:0 8px 25px rgba(0,0,0,0.35);
    }

    .card:hover { transform:translateY(-3px); }
    .card h3 { margin-bottom:8px; font-size:17px; color:#fff; }
    .card p { color:var(--muted); font-size:14px; margin:0; }

    /* 점수 카드 */
    .stats {
      display:grid; grid-template-columns:repeat(3,1fr);
      gap:15px; text-align:center;
    }
    .stat-box { background:rgba(255,255,255,0.07); border-radius:12px; padding:18px 10px; }
    .stat-title { font-size:13px; color:#b6c4e9; }
    .stat-value { font-size:26px; font-weight:700; color:#22d3ee; }

    /* 공채 리스트 */
    table {
      width:100%; border-collapse:collapse; font-size:14px;
      color:#dbeafe;
    }
    th, td { padding:10px; border-bottom:1px solid rgba(255,255,255,0.1); }
    th { color:#a5b4fc; text-align:left; font-weight:600; }
    tr:hover { background:rgba(255,255,255,0.05); cursor:pointer; }

    /* 버튼 */
    .quick-actions {
      display:flex; justify-content:space-between;
      width:min(100%,1100px);
      gap:10px; margin-top:10px;
    }

    .quick-btn {
      flex:1; background:rgba(255,255,255,0.08);
      color:white; border:none; border-radius:12px;
      padding:12px 0; cursor:pointer;
      font-weight:500; font-size:14px;
      transition:.25s;
    }
    .quick-btn:hover { background:#2563eb; }

    footer {
      text-align:center; padding:20px; color:#94a3b8; font-size:13px;
    }
.gongchae-table {
  max-height: 360px;
  overflow-y: auto;
  display: block;
}

.gongchae-table td, .gongchae-table th {
  white-space: nowrap; /* 🔹 텍스트 줄바꿈 방지 */
  overflow: hidden;
  text-overflow: ellipsis; /* 🔹 넘칠 경우 … 처리 */
}

.gongchae-table th {
  color:#a5b4fc;
  font-size:13px;
  font-weight:600;
}
.gongchae-table td:nth-child(2) {
  width: 45%;  /* 🔹 공고명 비율 확대 */
}

.gongchae-table tr:hover {
  background:rgba(255,255,255,0.05);
  cursor:pointer;
  transition:0.2s;
}
    .pagination {
  display:flex;
  justify-content:center;
  gap:8px;
  margin-top:15px;
}

.pagination button {
  background:rgba(255,255,255,0.1);
  color:#cbd5e1;
  border:none;
  border-radius:6px;
  padding:6px 10px;
  cursor:pointer;
  font-weight:500;
  transition:0.2s;
}

.pagination button.active {
  background:#2563eb;
  color:white;
}

.pagination button:hover {
  background:rgba(255,255,255,0.25);
}
.table-card {
  background:rgba(11,18,32,0.85);
  border-radius:18px;
  padding:22px;
  border:1px solid rgba(255,255,255,0.08);
  box-shadow:0 8px 25px rgba(0,0,0,0.4);
  backdrop-filter:blur(12px);
}
   /* ✅ 탭 버튼 */
.job-tabs {
  display:flex;
  justify-content:space-between;
  gap:12px;  /* 🔹 버튼 간격 살짝 늘리기 */
}

.tab-btn {
  flex:1;
  background:rgba(255,255,255,0.07);
  color:#b6c4e9;
  border:none;
  border-radius:8px;
  padding:8px 0;
  font-weight:600;
  cursor:pointer;
  transition:0.2s;
}
.tab-btn:hover { background:rgba(255,255,255,0.15); }
.tab-btn.active {
  background:#2563eb;
  color:white;
  box-shadow:0 0 10px rgba(37,99,235,0.4);
}

.job-tabs {
  display:flex;
  gap:10px;
  margin-bottom:12px;
}
.tab-btn {
  flex:1;
  background:rgba(255,255,255,0.07);
  color:#b6c4e9;
  border:none;
  border-radius:8px;
  padding:8px 0;
  font-weight:600;
  cursor:pointer;
  transition:0.2s;
}
.tab-btn:hover { background:rgba(255,255,255,0.15); }
.tab-btn.active {
  background:#2563eb;
  color:white;
  box-shadow:0 0 10px rgba(37,99,235,0.4);
}
.job-tab-content { display:none; }


/* 오른쪽 패널 전체 구조 */
.right-panel {
    display: grid;
    grid-template-columns: 180px 180px;
    gap: 10px;
    justify-content: center;
}

/* ================================
   🔥 카드 1,2 — 전용 스타일 (완전 독립)
================================ */

.r-card-full {
    grid-column: 1 / 3;
    display: flex;
    flex-direction: row;
    align-items: center;
    gap: 12px;
    height: 82px;
    padding: 10px 18px;
}

/* 아이콘 전용 */
.r-icon-full {
    font-size: 44px;
    width: 48px;
    height: 48px;
    display: flex;
    align-items: center;
    justify-content: center;
}

/* 텍스트 묶음 */
.r-txt-full {
    display: flex;
    flex-direction: column;
    justify-content: center;
    gap: 4px;
}

/* 제목 */
.r-title-full {
    font-size: 18px;
    font-weight: 700;
    margin: 0;
}

/* 부제목 */
.r-sub-full {
    font-size: 13px;
    opacity: 0.65;
    margin: 0;
}


/* ================================
   🔥 카드 3,4 (아이콘 위 + 텍스트 아래)
================================ */
.r-box {
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    height: 120px;
    text-align: center;
    gap: 8px;
    padding: 10px 10px;
}

/* 중앙 아이콘 */
.r-box .r-icon-sm {
    font-size: 40px !important;
    margin: 0;
}

/* 제목 */
.r-title-sm {
    font-size: 16px;
    font-weight: 700;
    margin: 0 0 4px 0;
}

/* 부제목 */
.r-sub-sm {
    font-size: 13px;
    opacity: 0.65;
    margin: 0;
}

/* 카드 내 텍스트 전체적으로 위로 */
.r-title, .r-sub {
    margin-top: -2px !important;
}


/* 📌 카드 5 전체 컨테이너 */
.r-wide-small {
    grid-column: 1 / 3;
    height: 80px;
    display: flex;
    justify-content: space-evenly;   /* 🔥 두 항목을 균등 정렬 */
    align-items: center;
    padding: 0 20px;
    gap: 20px;
}

/* 📌 내부 메뉴 — 아이콘 + 텍스트 가로 나란히 */
.r-menu-box {
    display: flex;
    flex-direction: row !important; 
    align-items: center !important;   /* 🔥 아이콘 + 글씨 수직 정렬 */
    justify-content: center;
    gap: 6px;                          /* 🔥 여백 최소화 */
    cursor: pointer;
    padding: 4px 6px;                  /* 🔥 최소 패딩 */
}

/* 📌 아이콘 (조금 작게 + 정중앙) */
.r-small-icon {
    font-size: 18px !important;
    display: flex;
    align-items: center;
}

/* 📌 글씨 — 아이콘 옆에 딱 붙게 */
.r-small-text {
    font-size: 14px;
    font-weight: 500;
    color: #e6eefc;
    white-space: nowrap;              /* 🔥 줄바꿈 금지 */
}




  </style>
</head>

<body>
<header>
  <div class="left-nav">
    <div class="logo" onclick="location.href='${pageContext.request.contextPath}/member/dashboard'">
      <div class="mark"></div> JobMate
    </div>
    <nav class="menu">
      <a href="${pageContext.request.contextPath}/member/dashboard" class="active">대시보드</a>
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

<main>
  <h1><c:out value="${loginMember.name}"/> 님, 오늘도 취업 준비 화이팅 💪</h1>

  <div class="dashboard-grid">
    <!-- ✅ 왼쪽 패널 -->
    <div class="left-panel">
      
      <!-- JobMate 점수 카드 -->
      <div class="card">
        <div class="stats">
          <div class="stat-box">
          <div class="stat-title">JobMate 점수</div>
          <div class="stat-value">
          ${empty jobmateScore ? 0 : jobmateScore}
          </div>
          </div>
          <div class="stat-box">
          <div class="stat-title">오늘의 일정</div>
          <div class="stat-value">0</div>
          </div>
			<div class="stat-box" onclick="location.href='${pageContext.request.contextPath}/favorite/list'" style="cursor:pointer;">
			  <div class="stat-title">찜한 공고</div>
			  <div class="stat-value">${favoriteCount}</div>
			</div>
        </div>
      </div>

      <!-- 📢 공채속보 카드 -->
      <div class="card">

        <!-- ✅ 탭 버튼 -->
        <div class="job-tabs">
          <button class="tab-btn active" onclick="showTab('gongchae')">공채속보</button>

        </div>

        <!-- ✅ 공채속보 탭 -->
        <div id="gongchae" class="job-tab-content" style="display:block;">
          <table class="gongchae-table">
            <thead>
              <tr>
                <th>기업명</th>
                <th>공고명</th>
                <th>기업구분</th>
                <th>고용형태</th>
                <th>마감일</th>
              </tr>
            </thead>
            <tbody>
              <c:if test="${empty employmentList}">
                <tr><td colspan="5" style="text-align:center; padding:20px;">불러올 공채 정보가 없습니다.</td></tr>
              </c:if>

              <c:forEach var="job" items="${employmentList}">
                <tr onclick="location.href='${pageContext.request.contextPath}/member/employment/detail/${job.empSeqno}'">
                  <td>${job.empBusiNm}</td>
                  <td>${job.empWantedTitle}</td>
                  <td>${job.coClcdNm}</td>
                  <td>${job.empWantedTypeNm}</td>
                  <td>${job.empWantedEndt}</td>
                </tr>
              </c:forEach>
            </tbody>
          </table>

          <div class="pagination">
            <c:if test="${currentPage > 1}">
              <button onclick="location.href='${pageContext.request.contextPath}/member/dashboard?page=${currentPage - 1}'">◀ 이전</button>
            </c:if>

            <c:forEach begin="1" end="${currentPage + 2}" var="i">
              <button 
                onclick="location.href='${pageContext.request.contextPath}/member/dashboard?page=${i}'"
                class="<c:out value='${i == currentPage ? "active" : ""}'/>">${i}</button>
            </c:forEach>

            <button onclick="location.href='${pageContext.request.contextPath}/member/dashboard?page=${currentPage + 1}'">다음 ▶</button>
          </div>
        </div>

        <!-- ✅ 사람인 탭 -->
        <div id="saramin" class="job-tab-content" style="display:none; text-align:center; padding:25px;">
          <p style="color:#b6c4e9; font-size:15px;">💡 사람인 API 연동 개발 준비 중입니다.</p>
        </div>

        <!-- ✅ 잡코리아 탭 -->
        <div id="jobkorea" class="job-tab-content" style="display:none; text-align:center; padding:25px;">
          <p style="color:#b6c4e9; font-size:15px;">💡 잡코리아 API 연동 개발 준비 중입니다.</p>
        </div>
      </div>
    </div> <!-- ✅ left-panel 닫음 -->

<div class="right-panel">

    <!-- 카드 1 (전체폭 1행) -->
    <div class="card r-card-full" onclick="location.href='${pageContext.request.contextPath}/controller/career/tests'">
    <div class="r-icon-full">🧭</div>
    <div class="r-txt-full">
        <div class="r-title-full">직업심리검사</div>
        <div class="r-sub-full">검사 시작하기</div>
    </div>
</div>

<!-- 카드 2 (전체폭 2행) -->
<div class="card r-card-full" 
     onclick="location.href='${pageContext.request.contextPath}/member/community/select'">
    <div class="r-icon-full">📣</div>
    <div class="r-txt-full">
        <div class="r-title-full">취업 커뮤니티</div>
        <div class="r-sub-full">인기 게시글 확인하기</div>
    </div>
</div>


    <!-- 카드 3 (왼쪽) -->
<div class="card r-box" onclick="location.href='${pageContext.request.contextPath}/member/todo'">
    <div class="r-icon-sm">📅</div>
    <div class="r-txt-wrap">
        <div class="r-title">To-Do</div>
        <div class="r-sub-sm">할 일 목록</div>
    </div>
</div>


    <!-- 카드 4 (오른쪽) -->
<div class="card r-box" onclick="location.href='${pageContext.request.contextPath}/member/profile'">
    <div class="r-icon-sm">⭐</div>
    <div class="r-txt-wrap">
        <div class="r-title">JobMate 점수</div>
        <div class="r-sub-sm">상위 25%</div>
    </div>
</div>


    <!-- 카드 5 — 전체폭 + 내부 두 버튼 -->
<div class="card r-wide-small">
    <div class="r-menu-box" onclick="location.href='${pageContext.request.contextPath}/member/profile'">
        <div class="r-small-icon">👤</div>
        <div class="r-small-text">My Profile</div>
    </div>

    <div class="r-menu-box" onclick="location.href='https://www.mokpo.ac.kr/www/312/subview.do'">
        <div class="r-small-icon">🏫</div>
        <div class="r-small-text">학교 채용 정보</div>
    </div>
</div>

</div>




  <!-- ✅ 하단 빠른 액션 -->
  <div class="quick-actions">
    <button class="quick-btn">내 지원현황</button>
<button class="quick-btn" 
        onclick="location.href='${pageContext.request.contextPath}/member/recent/list'">
  최근 본 공고
</button>
    <button class="quick-btn">AI 면접 바로가기</button>
    <button class="quick-btn">직렬별 랭킹</button>
  </div>
</main>

<script>
function showTab(tabId) {
  // 모든 탭 콘텐츠 숨기기
  document.querySelectorAll('.job-tab-content').forEach(el => el.style.display = 'none');
  // 버튼 초기화
  document.querySelectorAll('.tab-btn').forEach(btn => btn.classList.remove('active'));
  // 선택된 탭 표시
  document.getElementById(tabId).style.display = 'block';
  // 클릭한 버튼 활성화
  event.currentTarget.classList.add('active');
}
</script>


<footer>
  © 2025 JobMate. All rights reserved.
</footer>
</body>
</html>
