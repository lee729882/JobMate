<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>검사 결과</title>

    <!-- 자동 이동 완전히 제거됨 -->

    <style>
        :root {
            --bg1:#0ea5e9; --bg2:#6366f1;
            --text:#ffffff;
            --text-sub:#dbeafe;
            --accent:#3b82f6;
        }

        body {
            margin:0;
            background:linear-gradient(135deg, var(--bg1), var(--bg2));
            font-family:"Noto Sans KR", sans-serif;
            color:var(--text);
            display:flex;
            flex-direction:column;
            align-items:center;
            padding-top:120px;
        }

        .card {
            width:min(90%, 700px);
            background:rgba(10,20,40,0.55);
            border:1px solid rgba(255,255,255,0.15);
            border-radius:18px;
            padding:40px;
            text-align:center;
            backdrop-filter:blur(10px);
            box-shadow:0 8px 32px rgba(0,0,0,0.35);
            animation:fadeIn .8s ease;
        }

        h1 {
            font-size:28px;
            margin-bottom:12px;
        }

        .btn {
            display:inline-block;
            background:var(--accent);
            padding:14px 22px;
            border-radius:12px;
            margin-top:25px;
            color:white;
            font-weight:600;
            text-decoration:none;
        }

        .btn:hover { background:#1d4ed8; }

        @keyframes fadeIn {
            from {opacity:0; transform:translateY(20px);}
            to   {opacity:1; transform:translateY(0);}
        }
    </style>
</head>

<body>
<pre>
result: ${result}
result.RESULT: ${result.RESULT}
result.RESULT.inspctSeq: ${result.RESULT.inspctSeq}
</pre>

<div class="card">

    <h1>검사 완료!</h1>
    <p>아래 버튼을 눌러 결과를 확인하세요.</p>

    <!-- 우리 서비스에서 결과 보기 -->
<c:if test="${not empty result['RESULT']}">
<a class="btn"
   href="/controller/controller/career/tests/result-view?seq=${result.RESULT.inspctSeq}">
    우리 서비스에서 결과 보기 →
</a>




</c:if>


</div>

</body>
</html>
