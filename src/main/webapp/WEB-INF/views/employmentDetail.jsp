<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>${job.empWantedTitle} | JobMate</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

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

    /* ✅ Header */
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
      color:white; text-decoration:none;
    }
    .logo .mark {
      width:30px; height:30px; border-radius:8px;
      background:conic-gradient(from 180deg at 50% 50%, #22d3ee, #60a5fa, #a78bfa, #22d3ee);
      box-shadow:0 0 20px #22d3ee77;
    }
    .logo:hover { opacity:0.8; transition:0.2s; }

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

    /* ✅ Main Card */
    main { flex:1; display:flex; justify-content:center; padding:60px 20px; }
    .detail-card {
      width:min(100%,950px);
      background:var(--card);
      border:1px solid var(--line);
      border-radius:18px;
      padding:40px 50px;
      box-shadow:0 8px 30px rgba(0,0,0,.35);
      backdrop-filter:blur(10px);
    }

    .employment-header {
      display:flex;
      justify-content:space-between;
      align-items:center;
      margin-bottom:10px;
    }

    h1 {
      font-size:24px; font-weight:700;
      color:#fff; margin:0;
      text-shadow:0 0 12px #22d3ee55;
    }

    /* ✅ Favorite Button */
    .favorite-btn {
      background:#e6eefc;
      border:none;
      color:#2e4372;
      font-size:14px;
      padding:6px 12px;
      border-radius:8px;
      cursor:pointer;
      display:flex;
      align-items:center;
      gap:6px;
      transition:0.2s;
    }
    .favorite-btn i { color:#aaa; transition:0.2s; }
    .favorite-btn:hover { transform:scale(1.05); }

    .favorite-btn.active {
      background:#e3d1f4;
      color:#7a1ab0;
    }
    .favorite-btn.active i { color:#b15ff0; }

    h3 {
      margin-top:30px; margin-bottom:10px;
      color:#a5b4fc; font-size:18px;
      border-left:4px solid var(--accent);
      padding-left:10px;
    }

    .info { margin-bottom:8px; line-height:1.6; font-size:15px; color:#cbd5e1; }
    .info b { color:#a5b4fc; }

    hr { border:0; border-top:1px solid #334155; margin:25px 0; }

    a { color:#22d3ee; text-decoration:none; }
    a:hover { text-decoration:underline; }

    /* ✅ Selection Steps */
    .selection-steps {
      display:flex; flex-wrap:wrap; gap:12px; margin-top:10px;
    }
    .step-card {
      background:rgba(255,255,255,0.08);
      border:1px solid rgba(255,255,255,0.15);
      border-radius:10px;
      padding:12px 18px;
      min-width:130px;
      color:#e2e8f0;
      font-size:14px;
      text-align:center;
      transition:0.3s;
    }
    .step-card:hover { background:rgba(59,130,246,0.25); transform:translateY(-3px); }
    .step-name { font-weight:600; color:#93c5fd; }
    .step-date { margin-top:5px; font-size:13px; color:#cbd5e1; }

    footer { text-align:center; padding:20px; color:#94a3b8; font-size:13px; }
  </style>
</head>

<body>
<header>
  <div class="left-nav">
    <a href="${pageContext.request.contextPath}/member/dashboard" class="logo">
      <div class="mark"></div> JobMate
    </a>
    <nav class="menu">
      <a href="${pageContext.request.contextPath}/member/dashboard" class="active">대시보드</a>
      <a href="${pageContext.request.contextPath}/member/todo">To-Do</a>
      <a href="${pageContext.request.contextPath}/member/interview">면접 AI</a>
      <a href="${pageContext.request.contextPath}/member/profile">My Profile</a>
      <a href="${pageContext.request.contextPath}/member/community">취업 커뮤니티</a>
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
  <div class="detail-card">

    <!-- ✅ 제목 + 찜 버튼 -->
    <div class="employment-header">
      <h1>${job.empWantedTitle}</h1>
<button id="favoriteBtn"
        class="favorite-btn ${isFavorite ? 'active' : ''}"
        data-emp-source="${empSource}"
        data-emp-seqno="${job.empSeqno}"
        data-emp-title="${job.empWantedTitle}"
        data-emp-company="${job.empBusiNm}"
        data-emp-deadline="${job.empWantedEndt}">
  <i class="fa fa-heart"></i>
  <span>${isFavorite ? '찜됨' : '찜하기'}</span>
</button>

    </div>

    <!-- ✅ 기업 로고 -->
    <c:if test="${not empty job.regLogImgNm}">
      <img src="${job.regLogImgNm}" alt="기업 로고" style="max-height:70px; margin:10px 0 20px 0;">
    </c:if>

    <!-- ✅ 기본 정보 -->
    <div class="info"><b>기업명:</b> ${job.empBusiNm} (${job.coClcdNm})</div>
    <div class="info"><b>고용형태:</b> ${job.empWantedTypeNm}</div>
    <div class="info"><b>근무지역:</b> ${job.workRegionNm}</div>
    <div class="info"><b>경력:</b> ${empty job.empWantedCareerNm ? '별도 명시 없음' : job.empWantedCareerNm}</div>
    <div class="info"><b>학력:</b> ${empty job.empWantedEduNm ? '별도 명시 없음' : job.empWantedEduNm}</div>
    <div class="info"><b>모집기간:</b> ${job.empWantedStdt} ~ ${job.empWantedEndt}</div>

    <hr>

    <!-- ✅ 모집분야 -->
    <h3>📋 모집분야</h3>
    <div class="info"><b>모집직무:</b> ${job.empRecrNm}</div>
    <div class="info"><b>직무내용:</b> ${job.jobCont}</div>
    <div class="info"><b>필요자격/우대:</b> ${job.sptCertEtc}</div>
    <div class="info"><b>모집인원:</b> ${job.recrPsncnt}</div>

    <hr>

    <!-- ✅ 전형절차 -->
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

    <!-- ✅ 제출서류 및 기타 -->
    <h3>📎 제출서류</h3>
    <p>${empty job.empSubmitDocCont ? '공고문 참고' : job.empSubmitDocCont}</p>

    <h3>📝 접수방법</h3>
    <p>${empty job.empRcptMthdCont ? '공고문 참고' : job.empRcptMthdCont}</p>

    <h3>📅 합격자 발표</h3>
    <p>${empty job.empAcptPsnAnncCont ? '별도 공지 예정' : job.empAcptPsnAnncCont}</p>

    <h3>💬 공통사항</h3>
    <p>${job.recrCommCont}</p>

    <h3>📞 문의사항</h3>
    <p>${job.inqryCont}</p>

    <h3>📦 기타사항</h3>
    <p>${job.empnEtcCont}</p>

    <h3>🔗 채용 홈페이지</h3>
    <a href="${job.empWantedHomepgDetail}" target="_blank">${job.empWantedHomepgDetail}</a>
  </div>
</main>

<!-- ✅ Ajax for 찜 토글 + 실시간 대시보드 반영 -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
$('#favoriteBtn').click(function(){
  const btn = $(this);
  $.post('${pageContext.request.contextPath}/favorite/toggle', {
      empSource: btn.data('emp-source'),
      empSeqno: btn.data('emp-seqno'),
      empTitle: btn.data('emp-title'),
      empCompany: btn.data('emp-company'),
      empDeadline: btn.data('emp-deadline')
  }, function(res){
      if(res === 'added'){
          btn.addClass('active');
          btn.find('span').text('찜됨');
          $('#favoriteCount').text(parseInt($('#favoriteCount').text()) + 1);
      } else if(res === 'removed'){
          btn.removeClass('active');
          btn.find('span').text('찜하기');
          $('#favoriteCount').text(parseInt($('#favoriteCount').text()) - 1);
      } else if(res === 'unauthorized'){
          alert('로그인 후 이용해주세요.');
      }
  });
});
</script>

<footer>
  © 2025 JobMate. All rights reserved.
</footer>
</body>
</html>
