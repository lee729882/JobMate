<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Profile | JobMate</title>

<style>
body {
  margin:0; 
  min-height:100vh;
  background: radial-gradient(1200px 800px at 20% 10%, #1b2a4a 0%, #0d1426 60%);
  font-family:"Noto Sans KR", sans-serif;
  color:#e6eefc;
}

main {
  max-width:900px;
  margin:120px auto;
  background:rgba(15,25,45,.6);
  border:1px solid rgba(255,255,255,.1);
  padding:40px 50px;
  border-radius:18px;
  box-shadow:0 10px 30px rgba(0,0,0,.4);
  backdrop-filter:blur(10px);
}

h1 {
  font-size:32px;
  margin-bottom:30px;
  text-align:center;
  font-weight:700;
  color:#34d399;
}

label { display:block; font-size:14px; margin-bottom:6px; }
input, select {
  width:100%; padding:12px 15px; margin-bottom:20px;
  background:#0e172a; border:1px solid #1f2937;
  border-radius:10px; color:white;
}

.btn {
  width:100%; padding:12px; border:none; cursor:pointer;
  background:linear-gradient(135deg,#34d399,#10b981);
  border-radius:12px; font-size:16px; font-weight:700;
}

.profile-img {
  width:120px;
  height:120px;
  border-radius:50%;
  object-fit:cover;
  display:block;
  margin:0 auto 20px auto;
  border:2px solid #34d399;
}

/* 프로필 이미지 업로드 영역 디자인 개선 */
.profile-upload-container {
  position: relative;
  margin-bottom: 30px;
}

.profile-img-wrapper {
  position: relative;
  width: 140px;
  height: 140px;
  margin: 0 auto 20px;
}

.profile-img-wrapper .profile-img {
  width: 140px;
  height: 140px;
  border: 3px solid #34d399;
  box-shadow: 0 0 20px rgba(52, 211, 153, 0.3),
              0 0 40px rgba(52, 211, 153, 0.1);
  transition: all 0.3s ease;
}

.profile-img-wrapper:hover .profile-img {
  transform: scale(1.05);
  box-shadow: 0 0 30px rgba(52, 211, 153, 0.5),
              0 0 60px rgba(52, 211, 153, 0.2);
}

/* 프로필 이미지가 없을 때 표시할 기본 아바타 */
.default-avatar {
  width: 140px;
  height: 140px;
  border-radius: 50%;
  border: 3px solid #34d399;
  box-shadow: 0 0 20px rgba(52, 211, 153, 0.3),
              0 0 40px rgba(52, 211, 153, 0.1);
  display: flex;
  align-items: center;
  justify-content: center;
  background: linear-gradient(135deg, #1e3a8a, #3b82f6, #34d399);
  font-size: 48px;
  font-weight: 700;
  color: white;
  text-transform: uppercase;
  position: relative;
  overflow: hidden;
  transition: all 0.3s ease;
  margin: 0 auto 20px;
}

.default-avatar::before {
  content: '';
  position: absolute;
  top: -50%;
  left: -50%;
  width: 200%;
  height: 200%;
  background: linear-gradient(
    45deg,
    transparent,
    rgba(255, 255, 255, 0.1),
    transparent
  );
  transform: rotate(45deg);
  animation: shine 3s infinite;
}

@keyframes shine {
  0% { transform: translateX(-100%) translateY(-100%) rotate(45deg); }
  100% { transform: translateX(100%) translateY(100%) rotate(45deg); }
}

.default-avatar:hover {
  transform: scale(1.05);
  box-shadow: 0 0 30px rgba(52, 211, 153, 0.5),
              0 0 60px rgba(52, 211, 153, 0.2);
}

.default-avatar-icon {
  font-size: 60px;
  filter: drop-shadow(0 2px 4px rgba(0, 0, 0, 0.3));
  position: relative;
  z-index: 1;
}

.camera-icon-overlay {
  position: absolute;
  bottom: 5px;
  right: 5px;
  width: 40px;
  height: 40px;
  background: linear-gradient(135deg, #34d399, #10b981);
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  box-shadow: 0 4px 10px rgba(0, 0, 0, 0.3);
  transition: all 0.3s ease;
}

.camera-icon-overlay:hover {
  transform: scale(1.1);
  box-shadow: 0 0 20px rgba(52, 211, 153, 0.6);
}

.camera-icon-overlay::before {
  content: "📷";
  font-size: 18px;
}

.file-upload-wrapper {
  position: relative;
  margin-top: 15px;
}

.file-upload-label {
  display: block;
  padding: 20px;
  background: linear-gradient(135deg, rgba(52, 211, 153, 0.1), rgba(16, 185, 129, 0.05));
  border: 2px dashed #34d399;
  border-radius: 12px;
  text-align: center;
  cursor: pointer;
  transition: all 0.3s ease;
  position: relative;
  overflow: hidden;
}

.file-upload-label::before {
  content: '';
  position: absolute;
  top: 0;
  left: -100%;
  width: 100%;
  height: 100%;
  background: linear-gradient(90deg, transparent, rgba(52, 211, 153, 0.2), transparent);
  transition: left 0.5s ease;
}

.file-upload-label:hover::before {
  left: 100%;
}

.file-upload-label:hover {
  border-color: #10b981;
  background: linear-gradient(135deg, rgba(52, 211, 153, 0.2), rgba(16, 185, 129, 0.1));
  box-shadow: 0 0 20px rgba(52, 211, 153, 0.2);
}

.file-upload-input {
  display: none;
}

.upload-icon {
  font-size: 32px;
  margin-bottom: 10px;
  display: block;
}

.upload-text {
  color: #34d399;
  font-weight: 600;
  font-size: 14px;
  margin-bottom: 5px;
}

.upload-hint {
  color: #94a3b8;
  font-size: 12px;
}

/* Styles for liked posts section */
.liked-posts-grid {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
  gap: 20px;
  margin-top: 20px;
}

.liked-post-card {
  background: linear-gradient(135deg, rgba(52, 211, 153, 0.08), rgba(16, 185, 129, 0.05));
  border: 1px solid rgba(52, 211, 153, 0.2);
  border-radius: 16px;
  padding: 20px;
  transition: all 0.3s ease;
  position: relative;
  overflow: hidden;
}

.liked-post-card::before {
  content: '';
  position: absolute;
  top: -50%;
  left: -50%;
  width: 200%;
  height: 200%;
  background: linear-gradient(45deg, transparent, rgba(52, 211, 153, 0.1), transparent);
  transform: rotate(45deg);
  transition: all 0.6s ease;
  opacity: 0;
}

.liked-post-card:hover::before {
  opacity: 1;
  animation: shimmer 1.5s infinite;
}

@keyframes shimmer {
  0% { transform: translateX(-100%) translateY(-100%) rotate(45deg); }
  100% { transform: translateX(100%) translateY(100%) rotate(45deg); }
}

.liked-post-card:hover {
  transform: translateY(-5px);
  box-shadow: 0 10px 30px rgba(52, 211, 153, 0.3),
              0 0 40px rgba(52, 211, 153, 0.1);
  border-color: #34d399;
}

.liked-post-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 12px;
}

.liked-post-category {
  background: linear-gradient(135deg, #34d399, #10b981);
  color: white;
  padding: 4px 12px;
  border-radius: 20px;
  font-size: 12px;
  font-weight: 700;
  text-transform: uppercase;
  letter-spacing: 0.5px;
}

.liked-post-date {
  color: #64748b;
  font-size: 12px;
}

.liked-post-title {
  font-size: 18px;
  font-weight: 700;
  color: #e6eefc;
  margin-bottom: 10px;
  line-height: 1.4;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
}

.liked-post-content {
  color: #94a3b8;
  font-size: 14px;
  line-height: 1.6;
  margin-bottom: 15px;
  display: -webkit-box;
  -webkit-line-clamp: 3;
  -webkit-box-orient: vertical;
  overflow: hidden;
}

.liked-post-image {
  width: 100%;
  height: 180px;
  object-fit: cover;
  border-radius: 12px;
  margin-bottom: 15px;
  border: 2px solid rgba(52, 211, 153, 0.2);
  box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
}

.liked-post-footer {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding-top: 12px;
  border-top: 1px solid rgba(52, 211, 153, 0.1);
  margin-bottom: 12px;
}

.liked-post-author {
  color: #64748b;
  font-size: 13px;
}

.liked-post-likes {
  color: #f87171;
  font-size: 14px;
  font-weight: 600;
}

.view-post-btn {
  display: inline-block;
  width: 100%;
  text-align: center;
  padding: 10px;
  background: linear-gradient(135deg, #34d399, #10b981);
  color: white;
  text-decoration: none;
  border-radius: 10px;
  font-weight: 600;
  font-size: 14px;
  transition: all 0.3s ease;
  position: relative;
  z-index: 1;
}

.view-post-btn:hover {
  transform: translateY(-2px);
  box-shadow: 0 5px 20px rgba(52, 211, 153, 0.4);
}

/* Updated styles for title-only liked posts list */
.liked-title-item {
  background: linear-gradient(135deg, rgba(30, 58, 138, 0.4), rgba(15, 23, 42, 0.6));
  border: 1px solid rgba(59, 130, 246, 0.3);
  border-radius: 12px;
  padding: 16px 20px;
  margin-bottom: 12px;
  cursor: pointer;
  transition: all 0.3s ease;
  position: relative;
  overflow: hidden;
}

.liked-title-item::before {
  content: '';
  position: absolute;
  top: 0;
  left: -100%;
  width: 100%;
  height: 100%;
  background: linear-gradient(90deg, transparent, rgba(59, 130, 246, 0.2), transparent);
  transition: left 0.5s ease;
}

.liked-title-item:hover::before {
  left: 100%;
}

.liked-title-item:hover {
  transform: translateX(5px);
  border-color: #3b82f6;
  box-shadow: 0 5px 20px rgba(59, 130, 246, 0.3);
  background: linear-gradient(135deg, rgba(30, 58, 138, 0.6), rgba(15, 23, 42, 0.8));
}

.liked-title-text {
  color: #e6eefc;
  font-size: 16px;
  font-weight: 600;
  margin: 0;
  position: relative;
  z-index: 1;
}

/* Modal styles for post detail view */
.post-modal {
  display: none;
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: rgba(0, 0, 0, 0.8);
  backdrop-filter: blur(5px);
  z-index: 9999;
  justify-content: center;
  align-items: center;
  padding: 20px;
  animation: fadeIn 0.3s ease;
}

.post-modal.active {
  display: flex;
}

@keyframes fadeIn {
  from { opacity: 0; }
  to { opacity: 1; }
}

.modal-content {
  background: linear-gradient(135deg, rgba(15, 23, 42, 0.95), rgba(30, 58, 138, 0.9));
  border: 2px solid rgba(59, 130, 246, 0.4);
  border-radius: 20px;
  max-width: 700px;
  width: 100%;
  max-height: 85vh;
  overflow-y: auto;
  padding: 30px;
  position: relative;
  box-shadow: 0 20px 60px rgba(0, 0, 0, 0.5),
              0 0 40px rgba(59, 130, 246, 0.2);
  animation: slideUp 0.4s ease;
}

@keyframes slideUp {
  from {
    transform: translateY(50px);
    opacity: 0;
  }
  to {
    transform: translateY(0);
    opacity: 1;
  }
}

.modal-close {
  position: absolute;
  top: 20px;
  right: 20px;
  width: 40px;
  height: 40px;
  background: rgba(239, 68, 68, 0.2);
  border: 2px solid rgba(239, 68, 68, 0.5);
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  transition: all 0.3s ease;
  font-size: 24px;
  color: #ef4444;
  z-index: 1;
}

.modal-close:hover {
  background: rgba(239, 68, 68, 0.4);
  transform: rotate(90deg);
  box-shadow: 0 0 20px rgba(239, 68, 68, 0.5);
}

.modal-category {
  display: inline-block;
  background: linear-gradient(135deg, #3b82f6, #2563eb);
  color: white;
  padding: 6px 16px;
  border-radius: 20px;
  font-size: 13px;
  font-weight: 700;
  text-transform: uppercase;
  letter-spacing: 0.5px;
  margin-bottom: 20px;
}

.modal-title {
  font-size: 28px;
  font-weight: 700;
  color: #e6eefc;
  margin-bottom: 20px;
  line-height: 1.3;
}

.modal-content-text {
  color: #cbd5e1;
  font-size: 16px;
  line-height: 1.8;
  margin-bottom: 25px;
  white-space: pre-wrap;
}

.modal-image {
  width: 100%;
  border-radius: 16px;
  margin-bottom: 25px;
  border: 2px solid rgba(59, 130, 246, 0.3);
  box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
}

.modal-footer {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding-top: 20px;
  border-top: 2px solid rgba(59, 130, 246, 0.2);
}

.modal-author {
  color: #94a3b8;
  font-size: 14px;
  font-weight: 600;
}

.modal-likes {
  color: #f87171;
  font-size: 16px;
  font-weight: 700;
}

/* Scrollbar styling for modal */
.modal-content::-webkit-scrollbar {
  width: 8px;
}

.modal-content::-webkit-scrollbar-track {
  background: rgba(15, 23, 42, 0.5);
  border-radius: 10px;
}

.modal-content::-webkit-scrollbar-thumb {
  background: linear-gradient(135deg, #3b82f6, #2563eb);
  border-radius: 10px;
}

.modal-content::-webkit-scrollbar-thumb:hover {
  background: linear-gradient(135deg, #2563eb, #1d4ed8);
}

/* Added tab navigation styles */
.tab-container {
  display: flex;
  justify-content: center;
  gap: 20px;
  margin-bottom: 40px;
  border-bottom: 2px solid rgba(59, 130, 246, 0.2);
}

.tab-button {
  background: none;
  border: none;
  padding: 15px 30px;
  font-size: 16px;
  font-weight: 600;
  color: #94a3b8;
  cursor: pointer;
  position: relative;
  transition: all 0.3s ease;
}

.tab-button:hover {
  color: #3b82f6;
}

.tab-button.active {
  color: #3b82f6;
}

.tab-button.active::after {
  content: '';
  position: absolute;
  bottom: -2px;
  left: 0;
  right: 0;
  height: 2px;
  background: linear-gradient(90deg, #3b82f6, #2563eb);
  animation: slideIn 0.3s ease;
}

@keyframes slideIn {
  from {
    transform: scaleX(0);
  }
  to {
    transform: scaleX(1);
  }
}

.tab-content {
  display: none;
}

.tab-content.active {
  display: block;
  animation: fadeInContent 0.4s ease;
}

@keyframes fadeInContent {
  from {
    opacity: 0;
    transform: translateY(10px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}

@media (max-width: 768px) {
  .liked-posts-grid {
    grid-template-columns: 1fr;
  }
}
</style>
</head>

<body>

<main>
  <h1>My Profile</h1>

  <!-- Added tab navigation -->
  <div class="tab-container">
    <button class="tab-button active" onclick="switchTab('profile')">
      👤 개인 정보 수정
    </button>
    <button class="tab-button" onclick="switchTab('liked')">
      ❤️ 좋아요한 게시물
    </button>
  </div>

  <!-- Wrapped profile form in tab content -->
  <div id="profileTab" class="tab-content active">
    <form action="${pageContext.request.contextPath}/member/profile/update"
          method="post"
          enctype="multipart/form-data">

      <input type="hidden" name="id" value="${member.id}" />

      <!-- 프로필 이미지 영역 -->
      <div class="profile-upload-container">
        <div class="profile-img-wrapper">

          <!-- 🔥 Base64 출력 방식 -->
          <c:choose>
              <c:when test="${not empty profileBase64}">
                  <img id="profilePreview"
                       class="profile-img"
                       src="data:image/png;base64,${profileBase64}">
              </c:when>
              <c:otherwise>
                  <!-- 기본 이미지 (Base64 없는 경우 로컬 기본이미지) -->
                  <img id="profilePreview"
                       class="profile-img"
                       src="${pageContext.request.contextPath}/resources/img/default_profile.png">
              </c:otherwise>
          </c:choose>

          <label for="profileImageFile" class="camera-icon-overlay"></label>
        </div>

        <div class="file-upload-wrapper">
          <label for="profileImageFile" class="file-upload-label">
            <span class="upload-icon">📸</span>
            <div class="upload-text">프로필 사진 변경</div>
            <div class="upload-hint">클릭하거나 이미지를 드래그하세요</div>
          </label>

          <input type="file"
                 id="profileImageFile"
                 name="profileImageFile"
                 accept="image/*"
                 class="file-upload-input"
                 onchange="previewImage(event)" />
        </div>
      </div>

      <!-- 아래 기본 정보 폼들은 동일 -->
      <label>이름</label>
      <input type="text" name="name" value="${member.name}" required />

      <label>아이디</label>
      <input type="text" value="${member.username}" disabled />

      <label>이메일</label>
      <input type="email" name="email" value="${member.email}" required />

      <label>전화번호</label>
      <input type="text" name="phone" value="${member.phone}" />

      <label>경력 여부</label>
      <select name="careerType">
        <option value="NEW" ${member.careerType == 'NEW' ? 'selected' : ''}>신입</option>
        <option value="EXP" ${member.careerType == 'EXP' ? 'selected' : ''}>경력</option>
      </select>

      <label>지역</label>
      <input type="text" name="region" value="${member.region}" />

      <label>자격증</label>
      <input type="text" name="certifications" value="${member.certifications}" />

      <button class="btn" type="submit">프로필 저장</button>

      <a href="${pageContext.request.contextPath}/member/dashboard"
         style="display:block; text-align:center; margin-top:15px;
                padding:12px; border-radius:12px;
                background:#1f2937; color:white; font-weight:700;
                text-decoration:none;">
          메인화면으로
      </a>

    </form>
  </div>

  <!-- Wrapped liked posts section in tab content -->
  <div id="likedTab" class="tab-content">
    <h2 style="color: #3b82f6; font-size: 24px; margin-bottom: 25px; text-align: center;">
      ❤️ 내가 좋아요한 게시물
    </h2>

    <c:choose>
      <c:when test="${not empty likedPosts}">
        <div style="max-width: 600px; margin: 0 auto;">
          <c:forEach var="post" items="${likedPosts}" varStatus="status">
            <div class="liked-title-item" onclick="openPostModal(${status.index})">
              <p class="liked-title-text">${post.title}</p>
            </div>
          </c:forEach>
        </div>
      </c:when>
      <c:otherwise>
        <div style="text-align: center; padding: 60px 20px; 
                    background: linear-gradient(135deg, rgba(59, 130, 246, 0.05), rgba(30, 58, 138, 0.02));
                    border-radius: 16px; border: 2px dashed rgba(59, 130, 246, 0.2);">
          <div style="font-size: 48px; margin-bottom: 15px;">💔</div>
          <p style="color: #94a3b8; font-size: 16px;">아직 좋아요한 게시물이 없습니다.</p>
          <p style="color: #64748b; font-size: 14px; margin-top: 8px;">
            커뮤니티에서 마음에 드는 게시물에 좋아요를 눌러보세요!
          </p>
        </div>
      </c:otherwise>
    </c:choose>
  </div>

</main>

<!-- Added modal for post details -->
<div id="postModal" class="post-modal" onclick="closePostModal(event)">
  <div class="modal-content" onclick="event.stopPropagation()">
    <div class="modal-close" onclick="closePostModal()">×</div>
    <span id="modalCategory" class="modal-category"></span>
    <h2 id="modalTitle" class="modal-title"></h2>
    <p id="modalContent" class="modal-content-text"></p>
    <img id="modalImage" class="modal-image" style="display: none;" />
    <div class="modal-footer">
      <span id="modalAuthor" class="modal-author"></span>
      <span id="modalLikes" class="modal-likes"></span>
    </div>
  </div>
</div>

<script>
function previewImage(event) {
    const file = event.target.files[0];
    if (!file) return;

    const reader = new FileReader();
    reader.onload = e => {
        document.getElementById("profilePreview").src = e.target.result;
    };
    reader.readAsDataURL(file);
}

const likedPostsData = [
  <c:forEach var="post" items="${likedPosts}" varStatus="status">
    {
      title: "${post.title}",
      content: "${post.content}",
      category: "${post.category}",
      writer: "${post.writer}",
      likeCount: ${post.likeCount},
      imageBase64: "${post.postImageBase64}"
    }<c:if test="${!status.last}">,</c:if>
  </c:forEach>
];

function openPostModal(index) {
  const post = likedPostsData[index];
  if (!post) return;

  document.getElementById('modalCategory').textContent = post.category;
  document.getElementById('modalTitle').textContent = post.title;
  document.getElementById('modalContent').textContent = post.content;
  document.getElementById('modalAuthor').textContent = '작성자: ' + post.writer;
  document.getElementById('modalLikes').textContent = '♥ ' + post.likeCount;

  const modalImage = document.getElementById('modalImage');
  if (post.imageBase64 && post.imageBase64.trim() !== '') {
    modalImage.src = post.imageBase64;
    modalImage.style.display = 'block';
  } else {
    modalImage.style.display = 'none';
  }

  document.getElementById('postModal').classList.add('active');
  document.body.style.overflow = 'hidden';
}

function closePostModal(event) {
  if (event && event.target !== event.currentTarget) return;
  
  document.getElementById('postModal').classList.remove('active');
  document.body.style.overflow = 'auto';
}

// Close modal on Escape key
document.addEventListener('keydown', function(e) {
  if (e.key === 'Escape') {
    closePostModal();
  }
});

function switchTab(tabName) {
  // Hide all tab contents
  const tabContents = document.querySelectorAll('.tab-content');
  tabContents.forEach(content => content.classList.remove('active'));

  // Remove active class from all tab buttons
  const tabButtons = document.querySelectorAll('.tab-button');
  tabButtons.forEach(button => button.classList.remove('active'));

  // Show selected tab content
  if (tabName === 'profile') {
    document.getElementById('profileTab').classList.add('active');
    tabButtons[0].classList.add('active');
  } else if (tabName === 'liked') {
    document.getElementById('likedTab').classList.add('active');
    tabButtons[1].classList.add('active');
  }
}
</script>

</body>
</html>
