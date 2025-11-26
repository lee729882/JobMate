<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>JobMate 면접 AI</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <style>
    main {
      max-width: 900px;
      margin: 40px auto;
      color: #e5e7eb;
      font-family: "Noto Sans KR", sans-serif;
    }
    h1 { font-size: 26px; margin-bottom: 20px; }

    .qa-box {
      display:flex;
      flex-direction:column;
      gap:16px;
      background:rgba(15,23,42,0.85);
      border-radius:16px;
      padding:20px;
      border:1px solid rgba(148,163,184,0.4);
    }

    label { font-size:14px; color:#cbd5e1; }

    textarea {
      width:100%;
      min-height:90px;
      resize: vertical;
      border-radius:8px;
      border:1px solid rgba(148,163,184,0.4);
      padding:10px;
      font-family:inherit;
      font-size:14px;
      background:#020617;
      color:#e5e7eb;
    }

    .btn-row {
      display:flex;
      justify-content:flex-end;
      margin-top:10px;
      gap:8px;
    }

    .btn-primary {
      background:#2563eb;
      color:white;
      border:none;
      border-radius:10px;
      padding:8px 16px;
      font-size:14px;
      font-weight:600;
      cursor:pointer;
    }

    .btn-primary:disabled {
      opacity:0.6;
      cursor:not-allowed;
    }

    .feedback-box {
      margin-top:24px;
      padding:16px;
      border-radius:12px;
      background:rgba(15,23,42,0.9);
      border:1px solid rgba(34,197,94,0.4);
      display:none;
    }

    .feedback-title {
      font-size:15px;
      font-weight:700;
      margin-bottom:8px;
      color:#4ade80;
    }

    .feedback-content {
      font-size:14px;
      white-space:pre-line;
    }

    .error-msg {
      margin-top:10px;
      font-size:13px;
      color:#f97373;
      display:none;
    }

    /* 🔥 기록 보기 버튼 스타일 */
    .top-bar {
      display:flex;
      justify-content:space-between;
      align-items:center;
      margin-bottom:16px;
    }

    .btn-history {
      display:inline-block;
      padding:6px 14px;
      border-radius:999px;
      border:1px solid rgba(148,163,184,0.7);
      font-size:13px;
      color:#e5e7eb;
      text-decoration:none;
      background:rgba(15,23,42,0.9);
    }

    .btn-history:hover {
      background:rgba(30,64,175,0.8);
      border-color:#60a5fa;
    }

  </style>
</head>
<body>

<header>
  <%-- 공통 헤더가 있으면 include --%>
  <%-- <jsp:include page="/WEB-INF/views/common/header.jsp"/> --%>
</header>

<main>

  <!-- 🔥 제목 + 내 기록 보기 버튼 -->
  <div class="top-bar">
    <h1>면접 AI 연습</h1>

    <a href="${pageContext.request.contextPath}/member/interview/history"
       class="btn-history">
      내 면접 기록 보기
    </a>
  </div>

  <p style="font-size:14px; color:#cbd5e1; margin-bottom:20px;">
    예상 면접 질문과 나의 답변을 입력하면, ChatGPT가 기본 피드백을 제공합니다.
  </p>

  <div class="qa-box">
    <div>
      <label for="question">예상 면접 질문</label>
      <textarea id="question" placeholder="예: 본인의 강점과 약점에 대해 말씀해 주세요."></textarea>
    </div>

    <div>
      <label for="answer">나의 답변</label>
      <textarea id="answer" placeholder="예: 저의 강점은 책임감이고, 약점은 일을 너무 완벽하게 하려고 하는 점입니다..."></textarea>
    </div>

    <div class="btn-row">
      <button id="btn-feedback" class="btn-primary">
        피드백 받기
      </button>
    </div>

    <div id="error-msg" class="error-msg"></div>
  </div>

  <div id="feedback-box" class="feedback-box">
    <div class="feedback-title">AI 피드백</div>
    <div id="feedback-content" class="feedback-content"></div>
  </div>
</main>

<!-- 🔥 contextPath 사용해서 JS 경로 안정적으로 -->
<script src="${pageContext.request.contextPath}/static/js/interview.js"></script>

</body>
</html>
