<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${category} 커뮤니티</title>

    <style>
        body {
            background: #0A1520;
            color: white;
            font-family: 'Noto Sans KR';
            margin: 0; padding: 0;
        }

        .container {
            width: 800px;
            margin: 50px auto;
        }

        h1 {
            margin-bottom: 20px;
            color: #34d399;
            font-size: 32px;
            font-weight: bold;
        }

        .back-btn {
            display: inline-block;
            margin-bottom: 20px;
            padding: 8px 14px;
            border: 1px solid #34d399;
            border-radius: 6px;
            color: #34d399;
            text-decoration: none;
        }

        .user-info-box {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 12px;
            border: 1px solid #34d399;
            border-radius: 10px;
            background: rgba(20, 30, 40, 0.6);
            margin-bottom: 30px;
        }

        .user-info-box img {
            width: 55px; height: 55px;
            border-radius: 50%;
            border: 2px solid #34d399;
            object-fit: cover;
        }

        .post-card {
            background: rgba(20, 30, 40, 0.7);
            border: 1px solid #34d399;
            border-radius: 12px;
            padding: 18px 20px;
            margin-bottom: 30px;
            box-shadow: 0px 4px 20px rgba(0,0,0,0.3);
        }

        .post-header {
            display: flex;
            align-items: center;
            gap: 12px;
            margin-bottom: 15px;
        }

        .post-header img {
            width: 45px;
            height: 45px;
            border-radius: 50%;
            border: 2px solid #34d399;
            object-fit: cover;
        }

        .post-title {
            font-size: 20px;
            font-weight: bold;
            margin-bottom: 10px;
            color: #34d399;
        }

        .post-content {
            white-space: pre-line;
            line-height: 1.6;
            font-size: 16px;
            margin-bottom: 15px;
            color: #dbeafe;
        }

        .post-image {
            width: 100%;
            max-height: 400px;
            object-fit: contain;
            border-radius: 10px;
            margin-bottom: 15px;
        }

        .delete-btn {
            color: #f87171;
            text-decoration: none;
            font-size: 14px;
            font-weight: bold;
        }

        .write-form {
            margin-top: 50px;
            padding: 20px;
            border: 1px solid #34d399;
            border-radius: 12px;
            background: rgba(20, 30, 40, 0.6);
        }

        input, textarea {
            width: 100%;
            padding: 12px;
            margin-top: 10px;
            background: #0f1f2e;
            border: 1px solid #34d399;
            color: white;
            border-radius: 6px;
        }

        .writer-box {
            display: flex; align-items: center; gap: 10px; margin-top: 10px;
            padding: 10px; border: 1px solid #34d399; border-radius: 8px;
            background: rgba(20, 30, 40, 0.5);
        }
        .writer-box img {
            width: 45px; height: 45px;
            border-radius: 50%; border: 2px solid #34d399;
        }

    </style>
</head>

<body>

<div class="container">

    <a href="${pageContext.request.contextPath}/member/community/select" class="back-btn">← 커뮤니티 선택</a>

    <h1>${category} 커뮤니티</h1>

    <!-- 로그인 사용자 정보 -->
    <c:if test="${not empty profileBase64}">
        <div class="user-info-box">
            <img src="data:image/png;base64,${profileBase64}">
            <div>
                <b>${loginUser.name}</b> (${loginUser.username})<br>
                <small>${loginUser.email}</small>
            </div>
        </div>
    </c:if>

    <!-- 게시글 목록 -->
    <c:forEach var="post" items="${posts}">

        <div class="post-card">

            <div class="post-header">
                <img src="${post.writerProfileBase64}">
                <div class="post-writer">${post.writer}</div>
            </div>

            <div class="post-title">${post.title}</div>

            <div class="post-content">${post.content}</div>

            <!-- 게시물 이미지 출력 -->
            <c:if test="${not empty post.postImageBase64}">
                <img class="post-image" src="${post.postImageBase64}">
            </c:if>

            <a href="${pageContext.request.contextPath}/community/${category}/${post.id}/delete"
               onclick="return confirm('정말 삭제하시겠습니까?')"
               class="delete-btn">
                삭제
            </a>

        </div>

    </c:forEach>


    <!-- 글쓰기 -->
    <div class="write-form">
        <h2>글 작성</h2>

        <!-- 파일 업로드 가능하도록 enctype 설정 -->
        <form method="post" enctype="multipart/form-data"
              action="${pageContext.request.contextPath}/community/${category}/write">

            <input type="text" name="title" placeholder="제목" required>
            <textarea name="content" rows="5" placeholder="내용" required></textarea>

            <!-- 게시물 이미지 업로드 -->
            <label style="margin-top: 10px;">이미지 업로드:</label>
            <input type="file" name="postImageFile" accept="image/*">

            <div class="writer-box">
                <img src="data:image/png;base64,${profileBase64}">
                <span>${loginUser.username}</span>
            </div>

            <button type="submit">작성하기</button>
        </form>
    </div>

    <a href="${pageContext.request.contextPath}/member/dashboard"
       style="display:block; text-align:center; margin-top:15px;
              padding:12px; border-radius:12px;
              background:#1f2937; color:white; font-weight:700;
              text-decoration:none;">
        메인화면으로
    </a>

</div>

</body>
</html>
