<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>${job.empWantedTitle} | JobMate</title>
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

    .logo { font-size:22px; font-weight:800; color:#fff; display:flex; align-items:center; gap:10px; }
    .logo .mark { width:30px; height:30px; border-radius:8px;
      background:conic-gradient(from 180deg at 50% 50%, #22d3ee, #60a5fa, #a78bfa, #22d3ee);
      box-shadow:0 0 25px #22d3ee55;
    }

    .user-info { display:flex; align-items:center; gap:20px; color:#e6eefc; font-size:14px; }
    .logout-btn { background:#ef4444; color:white; border:none; padding:8px 14px; border-radius:10px; cursor:pointer; }

    main {
      flex:1; display:flex; justify-content:center; align-items:flex-start;
      padding:60px 20px;
    }

    .detail-card {
      width:min(100%, 950px);
      background:var(--card);
      border:1px solid var(--line);
      border-radius:18px;
      padding:40px 50px;
      box-shadow:0 8px 30px rgba(0,0,0,.35);
      backdrop-filter:blur(10px);
    }

    h1 {
      font-size:26px; font-weight:700; color:#fff;
      margin-bottom:25px;
      text-shadow:0 0 12px #22d3ee55;
    }

    h3 {
      margin-top:25px; color:#a5b4fc; font-size:18px;
      border-left:4px solid var(--accent); padding-left:10px;
    }

    .info {
      margin-bottom:10px; line-height:1.6; font-size:15px; color:#cbd5e1;
    }

    .info b { color:#a5b4fc; }

    a { color:#22d3ee; text-decoration:none; }
    a:hover { text-decoration:underline; }

    hr {
      border:0; border-top:1px solid #334155; margin:25px 0;
    }

    ul {
      list-style:disc; margin:10px 0 20px 30px; color:#cbd5e1;
    }

    .back-btn {
      display:inline-block;
      margin-top:30px;
      background:#2563eb;
      color:white;
      padding:10px 20px;
      border-radius:10px;
      text-decoration:none;
      transition:0.25s;
    }

    .back-btn:hover {
      background:#1d4ed8;
      transform:translateY(-2px);
    }

    footer {
      text-align:center;
      padding:20px;
      color:#94a3b8;
      font-size:13px;
    }
  </style>
  <style>
  h3 {
    font-size: 18px;
    font-weight: 600;
    color: #a5b4fc;
    margin-top: 40px;
    margin-bottom: 15px;
    display: flex;
    align-items: center;
    gap: 6px;
  }

  .selection-steps {
    display: flex;
    flex-wrap: wrap;
    gap: 12px;
    margin-top: 10px;
  }

  .step-card {
    background: rgba(255,255,255,0.08);
    border: 1px solid rgba(255,255,255,0.15);
    border-radius: 10px;
    padding: 12px 18px;
    min-width: 130px;
    color: #e2e8f0;
    font-size: 14px;
    text-align: center;
    transition: 0.3s;
  }

  .step-card:hover {
    background: rgba(59,130,246,0.25);
    transform: translateY(-3px);
  }

  .step-name {
    font-weight: 600;
    color: #93c5fd;
  }

  .step-date {
    margin-top: 5px;
    font-size: 13px;
    color: #cbd5e1;
  }
  .logo {
  font-size:22px;
  font-weight:800;
  color:#fff;
  display:flex;
  align-items:center;
  gap:10px;
  text-decoration:none;
}

.logo:hover {
  opacity:0.8;
  transition:0.2s;
}
  
</style>
  
</head>

<body>
<header>
  <a href="${pageContext.request.contextPath}/member/dashboard" class="logo">
    <div class="mark"></div>
    JobMate
  </a>
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
  <div class="detail-card">
    <h1>${job.empWantedTitle}</h1>

    <c:if test="${not empty job.regLogImgNm}">
      <img src="${job.regLogImgNm}" alt="기업 로고" style="max-height:70px; margin-bottom:20px;">
    </c:if>

    <!-- 기본정보 -->
    <div class="info"><b>기업명:</b> ${job.empBusiNm} (${job.coClcdNm})</div>
    <div class="info"><b>고용형태:</b> ${job.empWantedTypeNm}</div>
    <div class="info"><b>근무지역:</b> ${job.workRegionNm}</div>
    <div class="info"><b>경력:</b> ${empty job.empWantedCareerNm ? '별도 명시 없음' : job.empWantedCareerNm}</div>
    <div class="info"><b>학력:</b> ${empty job.empWantedEduNm ? '별도 명시 없음' : job.empWantedEduNm}</div>
    <div class="info"><b>모집기간:</b> ${job.empWantedStdt} ~ ${job.empWantedEndt}</div>

    <hr>

    <!-- 모집분야 -->
    <h3>📋 모집분야</h3>
    <div class="info"><b>모집직무:</b> ${job.empRecrNm}</div>
    <div class="info"><b>직무내용:</b> ${job.jobCont}</div>
    <div class="info"><b>필요자격/우대:</b> ${job.sptCertEtc}</div>
    <div class="info"><b>모집인원:</b> ${job.recrPsncnt}</div>

    <hr>

<!-- 전형절차 -->
<h3>🕐 채용 절차</h3>
<c:if test="${not empty job.selectionList}">
  <div class="selection-steps">
    <c:forEach var="s" items="${job.selectionList}">
      <c:if test="${not empty s.selsNm}">
        <div class="step-card">
          <div class="step-name">${s.selsNm}</div>
          <c:if test="${not empty s.selsSchdCont}">
            <div class="step-date">${s.selsSchdCont}</div>
          </c:if>
        </div>
      </c:if>
    </c:forEach>
  </div>
</c:if>
<c:if test="${empty job.selectionList}">
  <p>전형 절차 정보가 등록되어 있지 않습니다.</p>
</c:if>



    <hr>

    <!-- 제출서류 / 접수방법 -->
    <h3>📎 제출서류</h3>
    <p>${empty job.empSubmitDocCont ? '공고문 참고' : job.empSubmitDocCont}</p>

    <h3>📝 접수방법</h3>
    <p>${empty job.empRcptMthdCont ? '공고문 참고' : job.empRcptMthdCont}</p>

    <h3>📅 합격자 발표</h3>
    <p>${empty job.empAcptPsnAnncCont ? '별도 공지 예정' : job.empAcptPsnAnncCont}</p>

    <hr>

    <!-- 기타 / 공통사항 -->
    <h3>💬 공통사항</h3>
    <p>${job.recrCommCont}</p>

    <h3>📞 문의사항</h3>
    <p>${job.inqryCont}</p>

    <h3>📦 기타사항</h3>
    <p>${job.empnEtcCont}</p>

    <h3>🔗 채용 홈페이지</h3>
    <a href="${job.empWantedHomepgDetail}" target="_blank">${job.empWantedHomepgDetail}</a>

    <a href="${pageContext.request.contextPath}/member/employment/list" class="back-btn">← 목록으로 돌아가기</a>
  </div>
</main>

<footer>
  © 2025 JobMate. All rights reserved.
</footer>
</body>
</html>
