<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>JobMate 면접 AI</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">

  <style>
    body {
      margin: 0;
      padding: 0;
      min-height: 100vh;
      font-family: "Noto Sans KR", system-ui, -apple-system, BlinkMacSystemFont, sans-serif;
      background: radial-gradient(circle at top, #111827 0, #020617 55%, #000 100%);
      color: #e5e7eb;
    }

    main {
      max-width: 980px;
      margin: 40px auto 60px;
      padding: 0 16px;
    }

    .page-tag {
      display:inline-block;
      padding:4px 10px;
      border-radius:999px;
      border:1px solid rgba(148,163,184,0.5);
      font-size:11px;
      letter-spacing:1px;
      text-transform:uppercase;
      color:#9ca3af;
      margin-bottom:10px;
    }

    h1 {
      font-size: 32px;
      font-weight: 800;
      margin: 0 0 8px;
    }

    .page-subtitle {
      font-size: 14px;
      color: #cbd5e1;
      margin-bottom: 28px;
    }

    /* 상단 버튼들 (홈으로 / 내 면접 기록 보기) */
    .top-actions {
      position:absolute;
      right:24px;
      top:24px;
      display:flex;
      gap:10px;
    }

    .pill-btn {
      display:inline-flex;
      align-items:center;
      justify-content:center;
      padding:7px 18px;
      border-radius:999px;
      border:1px solid rgba(148,163,184,0.6);
      font-size:13px;
      color:#e5e7eb;
      background:rgba(15,23,42,0.9);
      text-decoration:none;
      cursor:pointer;
    }

    .pill-btn:hover {
      background:rgba(30,64,175,0.85);
      border-color:#60a5fa;
    }

    .pill-btn.primary {
      background:linear-gradient(135deg,#2563eb,#1d4ed8);
      border:none;
      box-shadow:0 8px 24px rgba(37,99,235,0.45);
    }

    .pill-btn.primary:hover {
      filter:brightness(1.05);
    }

    .card {
      position: relative;
      margin-top: 36px;
      padding: 26px 26px 30px;
      border-radius: 26px;
      background: radial-gradient(circle at top left, rgba(37,99,235,0.25), transparent 55%),
                  radial-gradient(circle at bottom right, rgba(34,197,94,0.18), transparent 55%),
                  rgba(15,23,42,0.96);
      border: 1px solid rgba(148,163,184,0.4);
      box-shadow:
        0 24px 60px rgba(15,23,42,0.9),
        0 0 0 1px rgba(15,23,42,0.8);
    }

    .card-inner {
      border-radius: 20px;
      padding: 16px 18px 18px;
      background: radial-gradient(circle at top, rgba(15,23,42,0.8), rgba(15,23,42,0.95));
      border: 1px solid rgba(30,64,175,0.5);
    }

    .field-title-row {
      display:flex;
      align-items:center;
      justify-content:space-between;
      margin-bottom:6px;
    }

    .field-label {
      font-size:13px;
      font-weight:600;
      color:#e5e7eb;
    }

    .field-hint {
      font-size:11px;
      padding:3px 10px;
      border-radius:999px;
      border:1px solid rgba(148,163,184,0.55);
      color:#9ca3af;
    }

    textarea {
      width:100%;
      min-height:120px;
      resize:vertical;
      border-radius:14px;
      border:1px solid rgba(148,163,184,0.45);
      padding:12px 13px;
      font-family:inherit;
      font-size:14px;
      background:radial-gradient(circle at top, #020617, #020617);
      color:#e5e7eb;
      box-sizing:border-box;
    }

    textarea::placeholder {
      color:#6b7280;
    }

    textarea:focus {
      outline:none;
      border-color:#60a5fa;
      box-shadow:0 0 0 1px rgba(37,99,235,0.6);
    }

    .field-group {
      margin-bottom:18px;
    }

    .btn-row {
      display:flex;
      justify-content:flex-end;
      gap:10px;
      margin-top:12px;
    }

    .btn-random {
      padding:9px 18px;
      border-radius:999px;
      border:1px solid rgba(148,163,184,0.6);
      background:rgba(15,23,42,0.94);
      color:#e5e7eb;
      font-size:13px;
      cursor:pointer;
    }

    .btn-random:hover {
      background:rgba(30,64,175,0.9);
      border-color:#60a5fa;
    }

    .btn-primary {
      padding:9px 20px;
      border-radius:999px;
      border:none;
      background:linear-gradient(135deg,#2563eb,#1d4ed8);
      color:white;
      font-size:14px;
      font-weight:600;
      cursor:pointer;
      box-shadow:0 12px 30px rgba(37,99,235,0.7);
    }

    .btn-primary:disabled,
    .btn-random:disabled {
      opacity:0.6;
      cursor:not-allowed;
      box-shadow:none;
    }

    .feedback-box {
      margin-top:22px;
      padding:16px 18px;
      border-radius:16px;
      border:1px solid rgba(34,197,94,0.6);
      background:rgba(5,46,22,0.9);
      display:none;
    }

    .feedback-title {
      font-size:14px;
      font-weight:700;
      margin-bottom:6px;
      color:#4ade80;
    }

    .feedback-content {
      font-size:14px;
      white-space:pre-line;
      color:#e5ffe9;
    }

    .error-msg {
      margin-top:12px;
      font-size:13px;
      color:#f97373;
      display:none;
    }

    /* 아래쪽 여백 */
    .page-bottom-space {
      height:30px;
    }
  </style>
</head>
<body>

<header>
  <%-- 필요하면 공통 헤더 include --%>
</header>

<main>
  <div style="position:relative;">
    <span class="page-tag">AI 면접 연습 · Beta</span>

    <!-- 상단 오른쪽 버튼들 -->
    <div class="top-actions">
      <!-- 홈으로 -->
      <a href="${pageContext.request.contextPath}/member/dashboard"
         class="pill-btn">
        홈으로
      </a>

      <!-- 내 면접 기록 보기 -->
      <a href="${pageContext.request.contextPath}/member/interview/history"
         class="pill-btn primary">
        내 면접 기록 보기
      </a>
    </div>

    <h1>면접 AI 연습</h1>
    <p class="page-subtitle">
      랜덤 면접 질문을 뽑고 나의 답변을 입력하면, ChatGPT가 장점·보완점·예시 답변을 정리해 줍니다.
    </p>
  </div>

  <section class="card">
    <div class="card-inner">

      <!-- 예상 면접 질문 -->
      <div class="field-group">
        <div class="field-title-row">
          <div class="field-label">예상 면접 질문</div>
          <div class="field-hint">랜덤 질문 버튼으로 자동 생성 가능</div>
        </div>
        <textarea id="question"
                  placeholder="예: 본인의 강점과 약점에 대해 말씀해 주세요."></textarea>
      </div>

      <!-- 나의 답변 -->
      <div class="field-group">
        <div class="field-title-row">
          <div class="field-label">나의 답변</div>
        </div>
        <textarea id="answer"
                  placeholder="예: 저의 강점은 책임감이고, 약점은 일을 너무 완벽하게 하려고 하는 점입니다..."></textarea>
      </div>

      <!-- 버튼 영역 -->
      <div class="btn-row">
        <button id="btn-random" class="btn-random" type="button">
          랜덤 질문
        </button>
        <button id="btn-feedback" class="btn-primary" type="button">
          피드백 받기
        </button>
      </div>

      <!-- 에러 메시지 -->
      <div id="error-msg" class="error-msg"></div>

      <!-- AI 피드백 박스 -->
      <div id="feedback-box" class="feedback-box">
        <div class="feedback-title">✓ AI 피드백</div>
        <div id="feedback-content" class="feedback-content"></div>
      </div>

    </div>
  </section>

  <div class="page-bottom-space"></div>
</main>

<!-- JS 파일 로드 (contextPath 기반) -->
<script src="${pageContext.request.contextPath}/static/js/interview.js"></script>

</body>
</html>
