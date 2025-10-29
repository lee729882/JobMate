<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<html>
<head>
  <title>맞춤 채용공고 추천</title>
  <style>
    body { font-family: 'Noto Sans KR', sans-serif; margin: 40px; background: #f5f7fa; }
    h1 { font-size: 26px; color: #333; }
    .job-card { background: #fff; padding: 20px; margin-bottom: 15px; border-radius: 12px; box-shadow: 0 2px 5px rgba(0,0,0,0.1); }
    .job-card h3 { margin-top: 0; color: #2c3e50; }
    .job-card p { margin: 6px 0; color: #555; }
    .job-card a { text-decoration: none; color: #007bff; font-weight: bold; }
  </style>
</head>
<body>

  <h1>${memberName} 님을 위한 맞춤 채용공고 🔍</h1>
  <p>선호 지역: ${pref.regionCodesCsv} / 선호 직종: ${pref.occCodesCsv} / 키워드: ${pref.keyword}</p>
  <hr>

  <c:if test="${empty jobs}">
    <p>현재 조건에 맞는 채용공고가 없습니다.</p>
  </c:if>

  <c:forEach var="job" items="${jobs}">
    <div class="job-card">
      <h3>${job.title}</h3>
      <p><strong>${job.company}</strong></p>
      <p>지역: ${job.regionName} | 경력: ${job.careerLevel}</p>
      <p>급여: ${job.salaryText} (${job.employmentType})</p>
      <p>등록일: ${job.postedAt} ~ 마감일: ${job.deadlineAt}</p>
      <a href="${job.detailUrl}" target="_blank">상세보기 →</a>
    </div>
  </c:forEach>

</body>
</html>
