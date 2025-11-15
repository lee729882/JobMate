<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${category} 커뮤니티</title>

    <style>
        body { background: #0A1520; color: white; font-family: 'Noto Sans KR'; }
        .container { width: 900px; margin: 50px auto; }
        h1 { margin-bottom: 20px; color: #34d399; }

        .user-info-box {
            display: flex; align-items: center;
            gap: 12px; margin-bottom: 20px;
            padding: 10px; border: 1px solid #34d399; border-radius: 10px;
            background: rgba(20, 30, 40, 0.6);
        }

        .user-info-box img {
            width: 50px; height: 50px; border-radius: 50%;
            border: 2px solid #34d399; object-fit: cover;
        }

        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        table, th, td { border: 1px solid #34d399; }
        th, td { padding: 12px; text-align: left; }
        a { color: #34d399; text-decoration: none; }

        .write-form { margin-top: 40px; }
        input, textarea {
            width: 100%; padding: 12px; margin-top: 10px;
            background: #0f1f2e; border: 1px solid #34d399; color: white; border-radius: 6px;
        }

        button {
            margin-top: 10px; padding: 12px 20px;
            background: #34d399; border: none; cursor: pointer;
            font-weight: bold; color: black; border-radius: 6px;
        }

        .back-btn {
            display: inline-block; margin-bottom: 20px;
            padding: 8px 14px; border: 1px solid #34d399; border-radius: 6px;
        }

        .post-profile-img {
            width: 35px; height: 35px; border-radius: 50%;
            margin-right: 8px; object-fit: cover;
            border: 1px solid #34d399;
        }

        .writer-box {
            display: flex; align-items: center; gap: 10px; margin-top: 10px;
            padding: 10px; border: 1px solid #34d399; border-radius: 8px;
            background: rgba(20, 30, 40, 0.5);
        }

        .writer-box img {
            width: 45px; height: 45px; border-radius: 50%;
            border: 2px solid #34d399;
        }
    </style>
</head>

<body>

<div class="container">

    <!-- 🔙 카테고리 선택으로 돌아가기 -->
    <a href="${pageContext.request.contextPath}/member/community/select" class="back-btn">← 커뮤니티 선택</a>

    <!-- 페이지 타이틀 -->
    <h1>${category} 커뮤니티</h1>

    <!-- 🔥 로그인 사용자 정보 표시 -->
    <c:if test="${not empty loginUser}">
        <div class="user-info-box">
            <img src="${pageContext.request.contextPath}${loginUser.profileImage}" alt="profile">
            <div>
                <div><b>${loginUser.name}</b> (${loginUser.username})</div>
                <small>${loginUser.email}</small>
            </div>
        </div>
    </c:if>

    <!-- 📌 게시글 목록 -->
    <table>
        <tr>
            <th>ID</th>
            <th style="width: 50%;">제목</th>
            <th>작성자</th>
            <th>삭제</th>
        </tr>

        <c:forEach var="post" items="${posts}">
            <tr>
                <td>${post.id}</td>
                <td>${post.title}</td>

                <td>
                    <img src="${pageContext.request.contextPath}${post.writerProfile}" class="post-profile-img">
                    ${post.writer}
                </td>

                <td>
                    <a href="${pageContext.request.contextPath}/community/${category}/${post.id}/delete"
                       onclick="return confirm('정말 삭제하시겠습니까?')">
                        삭제
                    </a>
                </td>
            </tr>
        </c:forEach>

    </table>

    <!-- ✏️ 글쓰기 영역 -->
    <div class="write-form">
        <h2>글 작성</h2>

        <form method="post" action="${pageContext.request.contextPath}/community/${category}/write">

            <input type="text" name="title" placeholder="제목" required>
            <textarea name="content" rows="5" placeholder="내용" required></textarea>

            <div class="writer-box">
                <img src="${pageContext.request.contextPath}${loginUser.profileImage}">
                <span>${loginUser.username}</span>
            </div>

            <button type="submit">작성하기</button>
        </form>
    </div>

</div>

</body>
</html>
