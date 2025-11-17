<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${category} 커뮤니티</title>

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
            background: linear-gradient(135deg, #0a1628 0%, #142850 50%, #0c1e3a 100%);
            min-height: 100vh;
            padding: 20px;
            position: relative;
            overflow-x: hidden;
        }

        body::before {
            content: "";
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-image: 
                radial-gradient(2px 2px at 20px 30px, white, transparent),
                radial-gradient(2px 2px at 60px 70px, white, transparent),
                radial-gradient(1px 1px at 50px 50px, white, transparent),
                radial-gradient(1px 1px at 130px 80px, white, transparent),
                radial-gradient(2px 2px at 90px 10px, white, transparent),
                radial-gradient(1px 1px at 10px 100px, white, transparent),
                radial-gradient(2px 2px at 150px 150px, white, transparent),
                radial-gradient(1px 1px at 180px 20px, white, transparent);
            background-size: 200px 200px;
            background-repeat: repeat;
            opacity: 0.8;
            animation: twinkle 3s infinite alternate;
            pointer-events: none;
            z-index: 0;
        }

        @keyframes twinkle {
            0%, 100% { opacity: 0.6; }
            50% { opacity: 0.9; }
        }

        .container {
            max-width: 800px;
            margin: 0 auto;
            position: relative;
            z-index: 1;
        }

        .back-btn {
            display: inline-block;
            color: white;
            text-decoration: none;
            background: rgba(59, 130, 246, 0.15);
            padding: 10px 20px;
            border-radius: 8px;
            margin-bottom: 20px;
            backdrop-filter: blur(10px);
            border: 1px solid rgba(59, 130, 246, 0.3);
            transition: all 0.3s ease;
        }

        .back-btn:hover {
            background: rgba(37, 99, 235, 0.3);
            transform: translateX(-5px);
            box-shadow: 0 5px 20px rgba(59, 130, 246, 0.5);
        }

        h1 {
            color: white;
            font-size: 32px;
            font-weight: 700;
            margin-bottom: 30px;
            text-shadow: 0 0 30px rgba(59, 130, 246, 0.9), 0 2px 10px rgba(0, 0, 0, 0.8);
        }

        .search-container {
            margin-bottom: 30px;
            position: relative;
        }

        .search-input {
            width: 100%;
            padding: 14px 50px 14px 20px;
            background: rgba(20, 40, 80, 0.7);
            color: #dbeafe;
            border: 2px solid rgba(59, 130, 246, 0.3);
            border-radius: 12px;
            font-size: 16px;
            font-family: inherit;
            transition: all 0.3s ease;
            backdrop-filter: blur(10px);
        }

        .search-input:focus {
            outline: none;
            border-color: #60a5fa;
            background: rgba(20, 40, 80, 0.9);
            box-shadow: 0 0 25px rgba(59, 130, 246, 0.4);
        }

        .search-input::placeholder {
            color: #93c5fd;
        }

        .search-icon {
            position: absolute;
            right: 18px;
            top: 50%;
            transform: translateY(-50%);
            color: #93c5fd;
            font-size: 20px;
            pointer-events: none;
        }

        .user-info-box {
            background: rgba(20, 40, 80, 0.6);
            padding: 20px;
            border-radius: 16px;
            display: flex;
            align-items: center;
            gap: 15px;
            margin-bottom: 30px;
            backdrop-filter: blur(10px);
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.7), 0 0 40px rgba(59, 130, 246, 0.2);
            border: 1px solid rgba(59, 130, 246, 0.3);
        }

        .user-info-box img {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            object-fit: cover;
            border: 3px solid #3b82f6;
            box-shadow: 0 0 15px rgba(59, 130, 246, 0.6);
        }

        .user-info-box b {
            font-size: 18px;
            color: #dbeafe;
        }

        .user-info-box small {
            color: #93c5fd;
        }

        .write-btn {
            position: fixed;
            bottom: 30px;
            right: 30px;
            width: 60px;
            height: 60px;
            border-radius: 50%;
            background: linear-gradient(135deg, #3b82f6 0%, #2563eb 100%);
            color: white;
            border: none;
            font-size: 28px;
            cursor: pointer;
            box-shadow: 0 5px 25px rgba(59, 130, 246, 0.6);
            transition: all 0.3s ease;
            z-index: 100;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .write-btn:hover {
            transform: scale(1.1) rotate(90deg);
            box-shadow: 0 8px 35px rgba(59, 130, 246, 0.8);
        }

        .post-card {
            background: rgba(20, 40, 80, 0.7);
            border-radius: 16px;
            padding: 24px;
            margin-bottom: 20px;
            backdrop-filter: blur(10px);
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.8), 0 0 40px rgba(59, 130, 246, 0.15);
            position: relative;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            border: 1px solid rgba(59, 130, 246, 0.3);
        }

        .post-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 40px rgba(0, 0, 0, 0.9), 0 0 60px rgba(59, 130, 246, 0.4);
        }

        .post-card.edit-mode {
            background: rgba(30, 50, 90, 0.8);
        }

        .post-header {
            display: flex;
            align-items: center;
            gap: 12px;
            margin-bottom: 16px;
        }

        .post-header img {
            width: 45px;
            height: 45px;
            border-radius: 50%;
            object-fit: cover;
            border: 2px solid rgba(59, 130, 246, 0.5);
        }

        .post-writer {
            font-weight: 600;
            color: #dbeafe;
            font-size: 15px;
        }

        .post-title {
            font-size: 22px;
            font-weight: 700;
            color: #f0f9ff;
            margin-bottom: 12px;
            line-height: 1.4;
        }

        .post-content {
            color: #bfdbfe;
            line-height: 1.7;
            margin-bottom: 16px;
            font-size: 15px;
        }

        .post-image {
            width: 100%;
            border-radius: 12px;
            margin-top: 16px;
            object-fit: cover;
            max-height: 400px;
        }

        .like-btn {
            cursor: pointer;
            font-size: 24px;
            transition: transform 0.2s ease, filter 0.2s ease;
            display: inline-block;
        }

        .like-btn:hover {
            transform: scale(1.2);
            filter: drop-shadow(0 0 8px currentColor);
        }

        .like-btn:active {
            transform: scale(0.95);
        }

        .edit-btn, .delete-btn {
            background: linear-gradient(135deg, #3b82f6 0%, #2563eb 100%);
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 8px;
            cursor: pointer;
            font-size: 14px;
            font-weight: 600;
            text-decoration: none;
            display: inline-block;
            margin-top: 12px;
            transition: all 0.3s ease;
            box-shadow: 0 0 15px rgba(59, 130, 246, 0.5);
        }

        .edit-btn:hover, .delete-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(37, 99, 235, 0.7), 0 0 25px rgba(59, 130, 246, 0.8);
        }

        .edit-btn:active, .delete-btn:active {
            transform: translateY(0);
        }

        .edit-overlay {
            display: none;
            background: rgba(20, 40, 80, 0.95);
            padding: 20px;
            border-radius: 12px;
            border: 2px solid #3b82f6;
        }

        .edit-overlay.active {
            display: block;
        }

        .edit-title, .edit-content {
            width: 100%;
            padding: 12px;
            background: rgba(10, 22, 40, 0.8);
            color: #dbeafe;
            border: 2px solid rgba(59, 130, 246, 0.3);
            border-radius: 8px;
            font-size: 15px;
            margin-bottom: 12px;
            font-family: inherit;
            transition: border-color 0.3s ease;
        }

        .edit-title:focus, .edit-content:focus {
            outline: none;
            border-color: #60a5fa;
            background: rgba(10, 22, 40, 0.95);
            box-shadow: 0 0 20px rgba(59, 130, 246, 0.3);
        }

        .edit-overlay label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #dbeafe;
        }

        .edit-image {
            width: 100%;
            padding: 10px;
            border: 2px dashed rgba(59, 130, 246, 0.4);
            border-radius: 8px;
            margin-bottom: 16px;
            background: rgba(10, 22, 40, 0.5);
            color: #93c5fd;
        }

        .save-btn, .cancel-btn {
            padding: 10px 20px;
            border: none;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-right: 10px;
        }

        .save-btn {
            background: #3b82f6;
            color: white;
            box-shadow: 0 0 15px rgba(59, 130, 246, 0.5);
        }

        .save-btn:hover {
            background: #2563eb;
            transform: translateY(-2px);
            box-shadow: 0 5px 20px rgba(59, 130, 246, 0.7);
        }

        .cancel-btn {
            background: rgba(51, 65, 85, 0.5);
            color: #93c5fd;
        }

        .cancel-btn:hover {
            background: rgba(71, 85, 105, 0.7);
        }

        .write-form-overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.8);
            backdrop-filter: blur(10px);
            z-index: 1000;
            align-items: center;
            justify-content: center;
            animation: fadeIn 0.3s ease;
        }

        .write-form-overlay.active {
            display: flex;
        }

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        .write-form {
            background: rgba(20, 40, 80, 0.95);
            padding: 30px;
            border-radius: 16px;
            backdrop-filter: blur(10px);
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.9), 0 0 80px rgba(59, 130, 246, 0.3);
            border: 2px solid rgba(59, 130, 246, 0.5);
            max-width: 600px;
            width: 90%;
            max-height: 90vh;
            overflow-y: auto;
            position: relative;
            animation: slideUp 0.3s ease;
        }

        @keyframes slideUp {
            from { 
                opacity: 0;
                transform: translateY(50px);
            }
            to { 
                opacity: 1;
                transform: translateY(0);
            }
        }

        .write-form h2 {
            color: #f0f9ff;
            margin-bottom: 25px;
            font-size: 24px;
            padding-right: 40px;
        }

        .write-form input[type="text"],
        .write-form textarea {
            width: 100%;
            padding: 12px 16px;
            background: rgba(10, 22, 40, 0.8);
            color: #dbeafe;
            border: 2px solid rgba(59, 130, 246, 0.3);
            border-radius: 10px;
            font-size: 15px;
            margin-bottom: 16px;
            font-family: inherit;
            transition: all 0.3s ease;
        }

        .write-form input[type="text"]:focus,
        .write-form textarea:focus {
            outline: none;
            border-color: #60a5fa;
            background: rgba(10, 22, 40, 0.95);
            box-shadow: 0 0 20px rgba(59, 130, 246, 0.3);
        }

        .write-form label {
            display: block;
            color: #93c5fd;
            font-size: 14px;
            margin-bottom: 8px;
            font-weight: 600;
        }

        .write-form input[type="file"] {
            width: 100%;
            padding: 12px;
            background: rgba(10, 22, 40, 0.6);
            border: 2px dashed rgba(59, 130, 246, 0.4);
            border-radius: 10px;
            color: #93c5fd;
            margin-bottom: 20px;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .write-form input[type="file"]:hover {
            border-color: #60a5fa;
            background: rgba(10, 22, 40, 0.8);
        }

        .writer-box {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 12px;
            background: rgba(10, 22, 40, 0.5);
            border-radius: 10px;
            margin-bottom: 20px;
            border: 1px solid rgba(59, 130, 246, 0.2);
        }

        .writer-box img {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            object-fit: cover;
            border: 2px solid rgba(59, 130, 246, 0.4);
        }

        .writer-box span {
            color: #dbeafe;
            font-weight: 600;
        }

        .write-form button[type="submit"] {
            width: 100%;
            padding: 14px;
            background: linear-gradient(135deg, #3b82f6 0%, #2563eb 100%);
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 16px;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 5px 20px rgba(59, 130, 246, 0.4);
        }

        .write-form button[type="submit"]:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 30px rgba(59, 130, 246, 0.6);
        }

        .write-form button[type="submit"]:active {
            transform: translateY(0);
        }

        .close-modal {
            position: absolute;
            top: 15px;
            right: 15px;
            background: none;
            border: none;
            color: #93c5fd;
            font-size: 28px;
            cursor: pointer;
            transition: all 0.3s ease;
            width: 35px;
            height: 35px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 50%;
        }

        .close-modal:hover {
            background: rgba(59, 130, 246, 0.2);
            color: #dbeafe;
            transform: rotate(90deg);
        }
    </style>
</head>
<body>
    <div class="container"
         id="community-root"
         data-category="${category}"
         data-ctx="${pageContext.request.contextPath}">

        <a href="${pageContext.request.contextPath}/member/community/select" class="back-btn">← 커뮤니티 선택</a>

        <h1>${category} 커뮤니티</h1>

        <div class="search-container">
            <input type="text" id="searchInput" class="search-input" placeholder="게시물 검색 (제목, 내용, 작성자)">
            <span class="search-icon">🔍</span>
        </div>

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

            <div class="post-card" data-post-id="${post.id}">

                <!-- 수정창 -->
                <div class="edit-overlay">
                    <input type="text" class="edit-title" value="${post.title}">
                    <textarea class="edit-content" rows="5">${post.content}</textarea>

                    <label>이미지 변경:</label>
                    <input type="file" class="edit-image" accept="image/*">

                    <button type="button" class="save-btn" onclick="saveEdit(this)">저장</button>
                    <button type="button" class="cancel-btn" onclick="closeEdit(this)">취소</button>
                </div>

                <!-- 일반 화면 -->
                <div class="post-header">
                    <img src="${empty post.writerProfileBase64 ? '/img/default.png' : post.writerProfileBase64}">
                    <div class="post-writer">${post.writer}</div>
                </div>

                <div class="post-title">${post.title}</div>

                <div class="post-content">${post.content}</div>

                <c:if test="${not empty post.postImageBase64}">
                    <img class="post-image" src="${post.postImageBase64}">
                </c:if>

                <!-- 좋아요 -->
                <div style="margin-top:10px;">
                    <span class="like-btn"
                          data-post-id="${post.id}"
                          data-like-url="${pageContext.request.contextPath}/community/${category}/${post.id}/like"
                          style="cursor:pointer; font-size:22px; color:${post.likedByMe ? '#f87171' : '#94a3b8'};">
                        ♥
                    </span>
                    <span id="like-count-${post.id}" style="margin-left:6px; color: white; font-weight: 600;">
                        ${post.likeCount}
                    </span>
                </div>

                <c:if test="${loginUser.username == post.writer}">
                    
                    <a href="${pageContext.request.contextPath}/community/${category}/${post.id}/delete"
                       onclick="return confirm('정말 삭제하시겠습니까?')"
                       class="delete-btn">삭제</a>
                </c:if>

            </div>
        </c:forEach>

        <!-- 글쓰기 폼 -->
        <button class="write-btn" onclick="openWriteModal()">+</button>

        <div class="write-form-overlay" id="writeModal">
            <div class="write-form">
                <button class="close-modal" onclick="closeWriteModal()">&times;</button>
                <h2>글 작성</h2>

                <form method="post" enctype="multipart/form-data"
                      action="${pageContext.request.contextPath}/community/${category}/write">

                    <input type="text" name="title" placeholder="제목을 입력하세요" required>
                    <textarea name="content" rows="6" placeholder="내용을 입력하세요" required></textarea>

                    <label>이미지 업로드 (선택사항)</label>
                    <input type="file" name="postImageFile" accept="image/*">

                    <div class="writer-box">
                        <img src="data:image/png;base64,${profileBase64}" alt="프로필">
                        <span>${loginUser.username}</span>
                    </div>

                    <button type="submit">작성하기</button>
                </form>
            </div>
        </div>

    </div>

    <script>
        function openWriteModal() {
            document.getElementById('writeModal').classList.add('active');
            document.body.style.overflow = 'hidden';
        }

        function closeWriteModal() {
            document.getElementById('writeModal').classList.remove('active');
            document.body.style.overflow = 'auto';
        }

        document.getElementById('writeModal').addEventListener('click', function(e) {
            if (e.target === this) {
                closeWriteModal();
            }
        });

        function highlightText(element, searchTerm) {
            const text = element.textContent;
            if (!searchTerm) {
                element.textContent = text;
                return;
            }
            
            const regex = new RegExp(`(${searchTerm})`, 'gi');
            const highlightedHTML = text.replace(regex, '<span style="background-color: #fbbf24; color: #0a1628; padding: 2px 0; border-radius: 2px;">$1</span>');
            element.innerHTML = highlightedHTML;
        }

        document.getElementById('searchInput').addEventListener('input', function(e) {
            const searchTerm = e.target.value.toLowerCase().trim();
            const posts = document.querySelectorAll('.post-card');

            posts.forEach(post => {
                const titleEl = post.querySelector('.post-title');
                const contentEl = post.querySelector('.post-content');
                const writerEl = post.querySelector('.post-writer');

                // 원본 텍스트를 가져오기 위해 데이터 속성에 저장
                if (!titleEl.dataset.originalText) {
                    titleEl.dataset.originalText = titleEl.textContent;
                    contentEl.dataset.originalText = contentEl.textContent;
                    writerEl.dataset.originalText = writerEl.textContent;
                }

                const title = titleEl.dataset.originalText.toLowerCase();
                const content = contentEl.dataset.originalText.toLowerCase();
                const writer = writerEl.dataset.originalText.toLowerCase();

                if (title.includes(searchTerm) || content.includes(searchTerm) || writer.includes(searchTerm)) {
                    post.style.display = 'block';
                    
                    // 검색어가 포함된 부분만 하이라이트
                    if (title.includes(searchTerm)) {
                        highlightText(titleEl, searchTerm);
                    } else {
                        titleEl.textContent = titleEl.dataset.originalText;
                    }
                    
                    if (content.includes(searchTerm)) {
                        highlightText(contentEl, searchTerm);
                    } else {
                        contentEl.textContent = contentEl.dataset.originalText;
                    }
                    
                    if (writer.includes(searchTerm)) {
                        highlightText(writerEl, searchTerm);
                    } else {
                        writerEl.textContent = writerEl.dataset.originalText;
                    }
                } else {
                    post.style.display = 'none';
                }
            });

            // 검색어가 비어있으면 모든 하이라이트 제거
            if (!searchTerm) {
                posts.forEach(post => {
                    const titleEl = post.querySelector('.post-title');
                    const contentEl = post.querySelector('.post-content');
                    const writerEl = post.querySelector('.post-writer');
                    
                    if (titleEl.dataset.originalText) {
                        titleEl.textContent = titleEl.dataset.originalText;
                        contentEl.textContent = contentEl.dataset.originalText;
                        writerEl.textContent = writerEl.dataset.originalText;
                    }
                });
            }
        });

        /* 수정창 열기 */
        document.addEventListener("click", function(e) {
            if (e.target.classList.contains("edit-btn")) {
                const card = e.target.closest(".post-card");
                card.querySelector(".edit-overlay").classList.add("active");
                card.classList.add("edit-mode");
            }
        });

        /* 수정 취소 */
        function closeEdit(btn) {
            const card = btn.closest(".post-card");
            card.classList.remove("edit-mode");
            card.querySelector(".edit-overlay").classList.remove("active");
        }

        /* 수정 저장 */
        function saveEdit(btn) {

            const card = btn.closest(".post-card");
            const id = card.dataset.postId;

            const root = document.getElementById("community-root");
            const category = root.dataset.category;
            const ctx = root.dataset.ctx;

            const overlay = card.querySelector(".edit-overlay");
            const title = overlay.querySelector(".edit-title").value;
            const content = overlay.querySelector(".edit-content").value;
            const img = overlay.querySelector(".edit-image").files[0];

            const formData = new FormData();
            formData.append("title", title);
            formData.append("content", content);
            if (img) formData.append("postImageFile", img);

            const url = `${ctx}/community/${category}/${id}/edit?ts=${Date.now()}`;
            console.log("🔥 FETCH URL =", url);

            fetch(url, { method:"POST", body: formData })
            .then(res => res.json())
            .then(data => {

                if (data.status !== "OK") {
                    alert("수정 실패: " + data.status);
                    return;
                }

                card.querySelector(".post-title").innerText = data.title;
                card.querySelector(".post-content").innerText = data.content;

                if (data.imageBase64) {
                    const imgTag = card.querySelector(".post-image");
                    if (imgTag) imgTag.src = data.imageBase64;
                }

                closeEdit(btn);
            });
        }

        /* 좋아요 */
        document.addEventListener("DOMContentLoaded", () => {
            document.querySelectorAll(".like-btn").forEach(btn => {
                btn.addEventListener("click", () => {
                    const url = btn.dataset.likeUrl;
                    const postId = btn.dataset.postId;

                    fetch(url, { method:"POST" })
                        .then(res => res.json())
                        .then(data => {
                            btn.style.color = data.status === "LIKED" ? "#f87171" : "#94a3b8";
                            document.getElementById(`like-count-${postId}`).innerText = data.likeCount;
                        });
                });
            });
        });
    </script>
</body>
</html>
