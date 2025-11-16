<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>기업 추천</title>
</head>
<body>

<h1>맞춤 기업 추천</h1>
<p>당신의 진로 코드: <strong>${code}</strong></p>

<c:forEach var="c" items="${companies}">
    <div style="border:1px solid #ccc; padding:15px; margin-bottom:20px;">
        <h3>${c.name}</h3>
        <p>추천 직무: ${c.role}</p>
        <a href="${c.link}" target="_blank">채용 공고 보기</a>
    </div>
</c:forEach>

</body>
</html>
