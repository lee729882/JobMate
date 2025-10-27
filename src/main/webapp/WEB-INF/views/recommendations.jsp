<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head><title>맞춤 채용 추천</title></head>
<body>
<h2>맞춤 채용 추천</h2>

<c:if test="${empty jobs}">
  <p>조건에 맞는 공고가 없습니다.</p>
</c:if>

<c:forEach var="job" items="${jobs}">
  <div style="border:1px solid #ddd; padding:10px; margin:8px 0;">
    <div><small>[${job.source}]</small></div>
    <h3 style="margin:6px 0;"><a href="${job.detailUrl}" target="_blank">${job.title}</a></h3>
    <div>${job.company} · ${job.regionName} · ${job.employmentType} · ${job.careerLevel}</div>
    <div>${job.salaryText} · 게재 ${job.postedAt} · 마감 ${job.deadlineAt}</div>
  </div>
</c:forEach>

</body>
</html>
