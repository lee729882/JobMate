<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>면접 기록 상세 - JobMate</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <style>
    main {
      max-width: 900px;
      margin: 40px auto;
      color: #e5e7eb;
      font-family: "Noto Sans KR", sans-serif;
    }
    h1 { font-size: 24px; margin-bottom: 20px; }

    .top-bar {
      display:flex;
      justify-content:space-between;
      align-items:center;
      margin-bottom:16px;
    }

    .btn-small {
      display:inline-block;
      padding:6px 12px;
      border-radius:999px;
      border:1px solid rgba(148,163,184,0.7);
      font-size:13px;
      color:#e5e7eb;
      text-decoration:none;
      background:rgba(15,23,42,0.9);
    }

    .btn-small:hover {
      background:rgba(30,64,175,0.8);
      border-color:#60a5fa;
    }

    .field-box {
      margin-bottom:18px;
    }

    .field-label {
      font-size:14px;
      color:#cbd5e1;
      margin-bottom:6px;
    }

    textarea {
      width:100%;
      min-height:80px;
      resize:vertical;
      border-radius:8px;
      border:1px solid rgba(148,163,184,0.4);
      padding:10px;
      font-family:inherit;
      font-size:14px;
      background:#020617;
      color:#e5e7eb;
    }

    .meta {
      font-size:13px;
      color:#9ca3af;
      margin-bottom:16px;
    }
  </style>
</head>
<body>

<main>

  <div class="top-bar">
    <h1>면접 기록 상세</h1>

    <div>
      <a href="${pageContext.request.contextPath}/member/interview/history" class="btn-small">
        ← 목록으로
      </a>
      &nbsp;
      <a href="${pageContext.request.contextPath}/member/interview" class="btn-small">
        면접 연습으로
      </a>
    </div>
  </div>

  <c:if test="${empty history}">
    <p style="color:#f87171;">해당 기록을 찾을 수 없습니다.</p>
  </c:if>

  <c:if test="${not empty history}">
    <div class="meta">
      기록 ID: ${history.id} /
      작성일시: ${history.createdAt} /
      회원: ${history.memberId}
    </div>

    <div class="field-box">
      <div class="field-label">질문</div>
      <textarea readonly="readonly">${history.question}</textarea>
    </div>

    <div class="field-box">
      <div class="field-label">나의 답변</div>
      <textarea readonly="readonly">${history.answer}</textarea>
    </div>

    <div class="field-box">
      <div class="field-label">AI 피드백</div>
      <textarea readonly="readonly">${history.feedback}</textarea>
    </div>
  </c:if>

</main>

</body>
</html>
