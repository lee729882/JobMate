<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <title>회원가입 | JobMate</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">

  <style>
    :root{
      --bg1:#0ea5e9; --bg2:#6366f1;
      --card:#0b1220aa; --line:#2a3250;
      --text:#e6eefc; --muted:#b6c4e9; --accent:#22d3ee;
      --btn:#16a34a; --error:#ef4444;
    }

    body{
      margin:0; min-height:100vh; color:var(--text);
      background: radial-gradient(1200px 800px at 20% 10%, #1b2a4a 0%, #0d1426 60%),
                  linear-gradient(135deg, var(--bg1), var(--bg2));
      background-blend-mode: screen, normal;
      display:flex; align-items:center; justify-content:center;
      font-family:"Noto Sans KR", system-ui, -apple-system, Segoe UI, Roboto, sans-serif;
    }

    .wrap{ width:min(100%, 980px); padding:24px; box-sizing:border-box; }
    .brand{ display:flex; align-items:center; gap:10px; margin:0 0 14px; opacity:.95; }
    .brand .logo{ width:36px; height:36px; border-radius:10px;
      background: conic-gradient(from 180deg at 50% 50%, #22d3ee, #60a5fa, #a78bfa, #22d3ee);
      box-shadow:0 0 40px #22d3ee33, inset 0 0 12px #ffffff55; }
    .brand h1{ font-size:20px; margin:0; }

    .card{
      background:var(--card); border:1px solid var(--line);
      box-shadow:0 12px 40px rgba(0,0,0,.35), inset 0 1px 0 rgba(255,255,255,.06);
      backdrop-filter: blur(10px);
      border-radius:18px; padding:26px; position:relative; overflow:hidden;
    }
    .card::before{ content:""; position:absolute; inset:-1px; border-radius:18px;
      background:linear-gradient(135deg, #ffffff22, transparent 40%); pointer-events:none; }

    .title{ display:flex; align-items:flex-end; justify-content:space-between; gap:12px; margin:0 0 18px; }
    .title h2{ margin:0; font-size:22px; font-weight:800; }
    .subtitle{ color:var(--muted); font-size:13px; }

    .grid{ display:grid; gap:16px; grid-template-columns: repeat(12, 1fr); }
    .col-6{ grid-column: span 6; } .col-12{ grid-column: span 12; }
    @media (max-width: 900px){ .col-6{ grid-column: span 12; }}

    label{ display:block; margin:2px 0 8px; font-size:13px; color:#fff; }
    input, select{
      width:100%; box-sizing:border-box; padding:12px 14px; color:#fff;
      background:#0e172a; border:1px solid #1f2946; border-radius:12px; outline:none;
    }
    input::placeholder{ color:#8da1d6; }
    input:focus, select:focus{
      border-color:var(--accent);
      box-shadow:0 0 0 3px rgba(34,211,238,.15), 0 10px 30px rgba(34,211,238,.05);
    }

    .actions{ margin-top:18px; display:flex; gap:10px; justify-content:flex-end; }
    .btn{ border:none; cursor:pointer; padding:12px 18px; border-radius:12px; font-weight:800; color:white;
      background:linear-gradient(135deg, var(--btn), #19b354); box-shadow:0 10px 24px rgba(22,163,74,.25); }
    .btn-secondary{ background:linear-gradient(135deg, #334155, #1f2937); }

    /* 카스케이딩 선택 박스 */
    .cascader{
      display:grid; grid-template-columns: 240px 1fr; gap:12px;
      background:#0c1429; border:1px solid #1f2a49; border-radius:12px; padding:12px;
    }
    .pane{
      background:#0b1220; border:1px solid #1b2442; border-radius:10px; overflow:auto; max-height:280px;
    }

    .pane .item {
      padding:10px 12px;
      border-bottom:1px solid #111a33;
      cursor:pointer;
      font-size:13px;
      display:flex;
      align-items:center;
      justify-content:space-between;
      color:#ffffff !important;
    }
    .pane .item:hover { background:#0f1a34; }
    .pane .item.active {
      background:#112046;
      border-left:3px solid #59d6ff;
    }

    .selected-bar {
      display: flex;
      flex-wrap: wrap;
      gap: 6px;
      margin-top: 8px;
      min-height: 32px;
    }

    .tag {
      display: inline-flex;
      align-items: center;
      gap: 6px;
      padding: 6px 10px;
      margin: 4px;
      background: #1e293b;
      border-radius: 8px;
      font-size: 13px;
      color: #ffffff;
    }
    .tag span { color: #ffffff; }
    .tag button {
      all: unset;
      cursor: pointer;
      opacity: .75;
      color: #ffffff;
      font-weight: bold;
    }
    
    .error{ color:var(--error); font-size:12px; margin-top:6px; }
    
    
  </style>
</head>
<body>
  <div class="wrap">
    <div class="brand">
      <div class="logo"></div><h1>JobMate</h1>
    </div>

    <div class="card">
      <div class="title">
        <h2>회원가입</h2>
        <div class="subtitle">몇 가지 정보만 입력하면 맞춤 채용을 추천해드려요.</div>
      </div>

      <c:if test="${not empty error}">
        <div class="error">${error}</div>
      </c:if>

<form:form modelAttribute="member" action="${pageContext.request.contextPath}/member/signup" method="post" autocomplete="off">
  <div class="grid">
    <!-- 기본 정보 -->
    <div class="col-6">
      <label for="username">아이디 *</label>
      <form:input path="username" id="username"/>
      <form:errors path="username" cssClass="error"/>
    </div>

    <div class="col-6">
      <label for="password">비밀번호 *</label>
      <form:password path="password" id="password"/>
      <form:errors path="password" cssClass="error"/>
    </div>

    <div class="col-6">
      <label for="email">이메일 *</label>
      <form:input path="email" id="email" type="email"/>
      <form:errors path="email" cssClass="error"/>
    </div>

    <div class="col-6">
      <label for="name">이름</label>
      <form:input path="name" id="name"/>
      <form:errors path="name" cssClass="error"/>
    </div>

    <!-- 경력/학력 -->
    <div class="col-6">
      <label for="careerType">경력 여부 *</label>
      <form:select path="careerType" id="careerType">
        <form:option value="" label="선택"/>
        <form:option value="NEW" label="신입"/>
        <form:option value="EXP" label="경력"/>
        <form:option value="ANY" label="무관"/>
      </form:select>
      <form:errors path="careerType" cssClass="error"/>
    </div>

    <div class="col-6">
      <label for="eduCode">학력 *</label>
      <form:select path="eduCode" id="eduCode">
        <form:option value=""   label="선택"/>
        <form:option value="ANY" label="무관"/>
        <form:option value="HS"  label="고졸"/>
        <form:option value="AD"  label="초대졸"/>
        <form:option value="BA"  label="학사"/>
        <form:option value="MA"  label="석사"/>
        <form:option value="PHD" label="박사"/>
      </form:select>
      <form:errors path="eduCode" cssClass="error"/>
    </div>

    <!-- 희망 직종 -->
    <div class="col-12">
      <label>희망 직종(다중 선택) *</label>
      <div class="cascader" id="jobCategory">
        <div class="pane" data-pane="macro"></div>
        <div class="pane" data-pane="micro"></div>
      </div>
      <div class="selected-bar" id="jobCategorySelected"></div>
      <form:errors path="jobCodes" cssClass="error"/>
    </div>

    <!-- 근무지역 -->
    <div class="col-12">
      <label>근무지역(다중 선택) *</label>
      <div class="cascader" id="workRegion">
        <div class="pane" data-pane="macro"></div>
        <div class="pane" data-pane="micro"></div>
      </div>
      <div class="selected-bar" id="workRegionSelected"></div>
      <form:errors path="workRegionCodes" cssClass="error"/>
    </div>

    <!-- 희망 연봉 -->
    <div class="col-6">
      <label for="minSalary">희망 연봉 하한(만원)</label>
      <form:input path="minSalary" id="minSalary" type="number" min="0" step="100" placeholder="예) 3000"/>
      <form:errors path="minSalary" cssClass="error"/>
    </div>
  </div>

  <!-- 글로벌 에러 (예: signupFailed) -->
  <form:errors path="" cssClass="error"/>

  <div class="actions">
    <button type="button" class="btn btn-secondary" onclick="history.back()">돌아가기</button>
    <button class="btn" type="submit">회원가입 완료</button>
  </div>
</form:form>

    </div>
  </div>

<script>
  // 공통 카스케이더 함수 (동일)
  function createCascader(rootId, dataMap, multiple = true, fieldName = "codes") {
    const root = document.getElementById(rootId);
    const macroPane = root.querySelector('[data-pane="macro"]');
    const microPane = root.querySelector('[data-pane="micro"]');
    const selectedBar = document.getElementById(rootId + "Selected");
    const selected = new Map();

    const keys = Object.keys(dataMap);

    function renderMacro(activeKey) {
      macroPane.innerHTML = '';
      keys.forEach(k => {
        const div = document.createElement('div');
        div.className = 'item' + (k === activeKey ? ' active' : '');
        div.textContent = k;
        div.addEventListener('click', () => {
          renderMacro(k);
          renderMicro(k);
        });
        macroPane.appendChild(div);
      });
    }

    function renderMicro(mKey) {
      microPane.innerHTML = '';
      dataMap[mKey].forEach(item => {
        const div = document.createElement('div');
        div.className = 'item';
        div.textContent = item.name;
        div.addEventListener('click', () => {
          if (multiple) {
            if (selected.has(item.code)) {
              selected.delete(item.code);
            } else {
              selected.set(item.code, item.name);
            }
          } else {
            selected.clear();
            selected.set(item.code, item.name);
          }
          syncSelected();
        });
        microPane.appendChild(div);
      });
    }

    function syncSelected() {
      selectedBar.innerHTML = '';
      [...selectedBar.parentElement.querySelectorAll('input[type="hidden"]')].forEach(h => h.remove());
      selected.forEach((name, code) => {
        const tag = document.createElement('div');
        tag.className = 'tag';
        const span = document.createElement('span');
        span.textContent = name;
        const btn = document.createElement('button');
        btn.textContent = '✕';
        btn.addEventListener('click', () => {
          selected.delete(code);
          syncSelected();
        });
        tag.appendChild(span);
        tag.appendChild(btn);
        selectedBar.appendChild(tag);

        const hidden = document.createElement('input');
        hidden.type = 'hidden';
        hidden.name = fieldName;
        hidden.value = code;
        selectedBar.parentElement.appendChild(hidden);
      });
    }

    renderMacro(keys[0]);
    renderMicro(keys[0]);
    syncSelected();
  }

  // 직종 데이터는 하드코딩
  const JOB_CATEGORY = {
    "기획·전략": [
      {code:"JOB101", name:"경영·비즈니스 기획"},
      {code:"JOB102", name:"전략·사업기획"},
      {code:"JOB103", name:"마케팅기획"},
      {code:"JOB104", name:"PM/PO"},
      {code:"JOB105", name:"컨설턴트"}
    ],
    "개발·데이터": [
      {code:"JOB501", name:"백엔드 개발자"},
      {code:"JOB502", name:"프론트엔드 개발자"},
      {code:"JOB503", name:"풀스택 개발자"},
      {code:"JOB504", name:"모바일(iOS/Android)"},
      {code:"JOB505", name:"AI/ML 엔지니어"},
      {code:"JOB506", name:"데이터 엔지니어"},
      {code:"JOB507", name:"데이터 사이언티스트"},
      {code:"JOB508", name:"DevOps/인프라"},
      {code:"JOB509", name:"보안"},
      {code:"JOB510", name:"QA/테스트"}
    ]
  };
  createCascader('jobCategory', JOB_CATEGORY, true, 'jobCodes');

// 근무지역은 외부 JSON 불러오기
fetch('<c:url value="/static/data/region.json"/>')
  .then(res => res.json())
  .then(data => {
    createCascader('workRegion', data, true, 'workRegionCodes');
  })
  .catch(err => console.error("지역 데이터 로딩 실패:", err));

</script>

</body>
</html>
