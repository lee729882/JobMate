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
</style>
</head>

<body>

<main>
  <h1>My Profile</h1>

  <!-- 기본 프로필 이미지 -->
  <c:set var="defaultProfile" value="${pageContext.request.contextPath}/resources/img/default_profile.png" />

  <!-- 실제 사용할 프로필 URL 계산 -->
  <c:set var="profileUrl"
         value="${empty member.profileImage
                 ? defaultProfile
                 : pageContext.request.contextPath.concat(member.profileImage)}" />

  <!-- 프로필 수정 폼 -->
  <form action="${pageContext.request.contextPath}/member/profile/update"
        method="post"
        enctype="multipart/form-data">

    <input type="hidden" name="id" value="${member.id}" />

    <!-- 프로필 이미지 업로드 영역 -->
    <div class="profile-upload-container">
      <div class="profile-img-wrapper">
        <c:choose>
          <c:when test="${empty member.profileImage}">
            <!-- 프로필 이미지가 없을 때: 이니셜 또는 아이콘 표시 -->
            <div class="default-avatar" id="defaultAvatar">
              <span class="default-avatar-icon">👤</span>
            </div>
            <img src="${profileUrl}" alt="profile" class="profile-img" id="profilePreview" style="display:none;" />
          </c:when>
          <c:otherwise>
            <!-- 프로필 이미지가 있을 때 -->
            <div class="default-avatar" id="defaultAvatar" style="display:none;">
              <span class="default-avatar-icon">👤</span>
            </div>
            <img src="${profileUrl}" alt="profile" class="profile-img" id="profilePreview" />
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
</main>

<!-- 이미지 미리보기 스크립트11 -->
<script>
function previewImage(event) {
  const file = event.target.files[0];
  if (file) {
    const reader = new FileReader();
    reader.onload = function(e) {
      // 기본 아바타 숨기고 이미지 표시
      document.getElementById('defaultAvatar').style.display = 'none';
      const profileImg = document.getElementById('profilePreview');
      profileImg.style.display = 'block';
      profileImg.src = e.target.result;
    };
    reader.readAsDataURL(file);
  }
}
</script>

</body>
</html>
