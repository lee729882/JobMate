// ✅ JS 파일 로드 확인
console.log("[interview.js] loaded");

// ------------------------------------------------------------------
//  페이지 초기화 (DOMContentLoaded 안 씀 - 스크립트가 body 맨 아래라서 바로 실행)
// ------------------------------------------------------------------
initInterviewPage();

function initInterviewPage() {
  var btnFeedback     = document.getElementById("btn-feedback");
  var btnRandom       = document.getElementById("btn-random");
  var qInput          = document.getElementById("question");
  var aInput          = document.getElementById("answer");
  var feedbackBox     = document.getElementById("feedback-box");
  var feedbackContent = document.getElementById("feedback-content");
  var errorMsg        = document.getElementById("error-msg");

  console.log("[interview.js] element check", {
    btnFeedback: !!btnFeedback,
    btnRandom: !!btnRandom,
    qInput: !!qInput,
    aInput: !!aInput
  });

  if (!btnFeedback) {
    console.error("❌ btn-feedback 버튼을 찾을 수 없습니다.");
    return;
  }

  // 🔹 랜덤 질문 버튼 클릭
  if (btnRandom) {
    btnRandom.addEventListener("click", function () {
      console.log("[interview.js] 랜덤 질문 클릭");
      fetchRandomQuestion(qInput, errorMsg, btnRandom);
    });
  }

  // 🔹 피드백 버튼 클릭
  btnFeedback.addEventListener("click", function () {
    console.log("[interview.js] 피드백 받기 클릭");
    sendFeedback(qInput, aInput, feedbackBox, feedbackContent, errorMsg, btnFeedback);
  });
}


// ------------------------------------------------------------------
//  피드백 요청
// ------------------------------------------------------------------
function sendFeedback(qInput, aInput, feedbackBox, feedbackContent, errorMsg, btn) {
  var question = qInput.value.trim();
  var answer   = aInput.value.trim();

  if (!question || !answer) {
    errorMsg.style.display = "block";
    errorMsg.textContent = "질문과 답변을 모두 입력해 주세요.";
    return;
  } else {
    errorMsg.style.display = "none";
  }

  btn.disabled = true;
  btn.textContent = "피드백 생성 중...";

  var url = getContextPath() + "/member/interview/feedback";
  console.log("➡ [피드백] 요청 URL:", url);

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
      var msg = (data && data.feedback) ? data.feedback : "피드백을 불러오지 못했습니다.";

      if (msg.indexOf("로그인 후 이용 가능합니다") !== -1) {
        // 로그인 안 된 경우
        errorMsg.style.display = "block";
        errorMsg.textContent = msg;
        feedbackBox.style.display = "none";
      } else {
        feedbackContent.textContent = msg;
        feedbackBox.style.display = "block";
        errorMsg.style.display = "none";
      }
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


// ------------------------------------------------------------------
//  랜덤 질문 요청
// ------------------------------------------------------------------
function fetchRandomQuestion(qInput, errorMsg, btn) {
  btn.disabled = true;

  var url = getContextPath() + "/member/interview/question";
  console.log("➡ [랜덤 질문] 요청 URL:", url);

  fetch(url, {
    method: "POST"
  })
    .then(function (resp) {
      if (!resp.ok) {
        throw new Error("서버 오류 : " + resp.status);
      }
      return resp.json();
    })
    .then(function (data) {
      console.log("[랜덤 질문 응답]", data);
      if (data && data.question) {
        qInput.value = data.question;
        errorMsg.style.display = "none";
      } else {
        throw new Error("질문 데이터가 비어 있습니다.");
      }
    })
    .catch(function (e) {
      console.error(e);
      errorMsg.style.display = "block";
      errorMsg.textContent =
        "질문을 불러오는 중 오류가 발생했습니다. 잠시 후 다시 시도해 주세요.";
    })
    .finally(function () {
      btn.disabled = false;
    });
}


// ------------------------------------------------------------------
//  contextPath 계산 (/controller)
// ------------------------------------------------------------------
function getContextPath() {
  var path = window.location.pathname.split("/"); // ["", "controller", "member", "interview"]
  return "/" + path[1]; // "/controller"
}
