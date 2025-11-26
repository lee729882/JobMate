// ✅ JS 파일 로드 확인
console.log("[interview.js] loaded");

document.addEventListener("DOMContentLoaded", function () {
  var btn = document.getElementById("btn-feedback");
  var qInput = document.getElementById("question");
  var aInput = document.getElementById("answer");
  var feedbackBox = document.getElementById("feedback-box");
  var feedbackContent = document.getElementById("feedback-content");
  var errorMsg = document.getElementById("error-msg");

  if (!btn) {
    console.error("버튼(#btn-feedback)을 찾을 수 없습니다.");
    return;
  }

  btn.addEventListener("click", function () {
    // 👉 비동기 함수 따로 분리 (async 화살표 함수 때문에 에러났던 것 방지)
    sendFeedback(qInput, aInput, feedbackBox, feedbackContent, errorMsg, btn);
  });
});

function sendFeedback(qInput, aInput, feedbackBox, feedbackContent, errorMsg, btn) {
  var question = qInput.value.trim();
  var answer = aInput.value.trim();

  if (!question || !answer) {
    errorMsg.style.display = "block";
    errorMsg.textContent = "질문과 답변을 모두 입력해 주세요.";
    return;
  } else {
    errorMsg.style.display = "none";
  }

  btn.disabled = true;
  btn.textContent = "피드백 생성 중...";

  // ✅ 실제 요청 URL 확인 로그
  var url = getContextPath() + "/member/interview/feedback";
  console.log("➡ 요청 URL:", url);

  fetch(url, {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({ question: question, answer: answer })
  })
    .then(function (resp) {
      if (!resp.ok) {
        throw new Error("서버 오류 : " + resp.status);
      }
      return resp.json();
    })
    .then(function (data) {
      feedbackContent.textContent =
        (data && data.feedback) || "피드백을 불러오지 못했습니다.";
      feedbackBox.style.display = "block";
    })
    .catch(function (e) {
      console.error(e);
      errorMsg.style.display = "block";
      errorMsg.textContent =
        "피드백 요청 중 오류가 발생했습니다. 잠시 후 다시 시도해 주세요.";
    })
    .finally(function () {
      btn.disabled = false;
      btn.textContent = "피드백 받기";
    });
}

// ✅ contextPath 계산 (/controller)
function getContextPath() {
  var path = window.location.pathname.split("/"); // ["", "controller", "member", "interview"]
  return "/" + path[1]; // "/controller"
}
