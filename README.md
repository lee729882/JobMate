## 🎯 Catcher: 취업 기회 포착 및 일정 관리 시스템

![Java](https://img.shields.io/badge/Java-ED8B00?style=for-the-badge&logo=openjdk&logoColor=white)
![Spring](https://img.shields.io/badge/Spring-6DB33F?style=for-the-badge&logo=spring&logoColor=white)
![Oracle](https://img.shields.io/badge/Oracle-F80000?style=for-the-badge&logo=oracle&logoColor=white)
![FullCalendar](https://img.shields.io/badge/FullCalendar-4285F4?style=for-the-badge&logo=googlecalendar&logoColor=white)
![OpenAI](https://img.shields.io/badge/OpenAI-412991?style=for-the-badge&logo=openai&logoColor=white)

> **"흩어진 취업 정보, Catcher가 한 곳에 모았습니다."**
> <br/>고용24 API 기반의 채용 정보와 FullCalendar 일정을 연동하여, 공고 검색부터 AI 면접 대비까지 한 곳에서 끝내는 **올인원 취업 비서 플랫폼**
<img width="1919" height="955" alt="1" src="https://github.com/user-attachments/assets/05db3fad-54f8-4854-9e42-ed49536f00cd" />

<br/>

## 📸 프로젝트 시연 (Screenshots)
<img width="603" height="880" alt="clipboard-202512041955-hf4w2" src="https://github.com/user-attachments/assets/05eb1762-2eb9-439d-a239-ade4207fe726" />
<img width="1877" height="809" alt="clipboard-202511182032-umvwc" src="https://github.com/user-attachments/assets/ba7feda2-5258-40fb-92d4-4acf226adf88" />
<img width="876" height="678" alt="그림 (1)" src="https://github.com/user-attachments/assets/d7068d82-c919-4e5f-9ce7-2a00f57380b0" />
<img width="506" height="682" alt="그림" src="https://github.com/user-attachments/assets/07432afe-0ff6-4211-bcb1-7ad8fc589bad" />

<br/>

## 📌 주요 기능 (Key Features)

* **📅 채용 공고 & 캘린더 자동 연동**
    * **고용24 API**를 통해 실시간 채용 정보를 조회하고, 관심 기업 '찜(Scrap)' 시 **FullCalendar**에 마감일정이 자동 등록됨
* **🤖 AI 면접 트레이닝 (ChatGPT)**
    * 희망 직무를 입력하면 **ChatGPT**가 예상 질문을 생성하고, 사용자의 답변에 대해 피드백을 제공하는 모의 면접 시스템
* **🔎 직업 가치관 검사 및 추천 (CareerNet)**
    * **커리어넷 API**를 활용하여 사용자 성향을 분석하고, 적합한 직업군을 추천해주는 진로 탐색 알고리즘 구현
* **🏆 게이미피케이션 (Gamification)**
    * 자격증, 어학 등 To-Do 미션 달성 시 경험치를 부여하고 유저 랭킹을 산정하여 동기 부여 제공

<br/>

## 🛠 시스템 구조 (System Architecture)

Spring MVC 패턴을 기반으로 3가지 외부 API(고용24, 커리어넷, OpenAI)와 유기적으로 통신하도록 설계했습니다.
<img width="3678" height="729" alt="clipboard-202512161128-ej3kd" src="https://github.com/user-attachments/assets/c0235599-7b26-4a68-9f04-4112110a0678" />
<img width="386" height="647" alt="clipboard-202512131534-jlmoy" src="https://github.com/user-attachments/assets/1d8468cb-755a-438e-9d5d-d00e2ad6d805" />

<br/>

## ⚡ 기술적 도전 및 해결 (Troubleshooting)

### 1. 외부 API 대용량 데이터 처리 속도 개선
* **Issue:** 고용24 API의 채용 정보(XML) 호출 시 데이터 양이 많아 페이지 로딩이 3초 이상 지연됨
* **Solution:**
    * **페이징(Paging) 적용:** 한 번에 모든 데이터를 파싱하지 않고, 페이지네이션 처리를 통해 필요한 데이터만 호출
    * **캐싱(Caching) 전략:** 자주 조회되는 인기 공고는 DB에 임시 저장하여 API 호출 횟수를 줄이고 응답 속도를 개선

### 2. FullCalendar와 DB 간 실시간 동기화
* **Issue:** 캘린더 UI에서 드래그 앤 드롭으로 일정을 변경해도 DB에 반영되지 않아 새로고침 시 데이터가 원상 복구됨
* **Solution:**
    * `FullCalendar`의 `eventDrop` 콜백 함수 내에 **AJAX 비동기 통신** 로직을 구현
    * 변경된 날짜(`start`, `end`) 정보를 즉시 서버로 전송하여 `UPDATE` 쿼리를 실행함으로써 데이터 일관성 확보

### 3. 커리어넷 검사 결과 기반 추천 알고리즘 구현
* **Issue:** 커리어넷 API는 단순 검사 결과(JSON)만 반환하므로, 이를 우리 서비스의 직업 데이터와 매칭할 로직이 필요
* **Solution:**
    * 검사 결과의 상위 2개 가치관 코드를 추출하여, 내부 DB의 직업군 테이블과 조인(Join)하는 매칭 알고리즘을 Java단에서 구현

<br/>

## ⚙️ 기술 스택 (Tech Stack)

| Category | Technology |
|---|---|
| **Language** | Java 11, SQL, JavaScript(ES6) |
| **Framework** | Spring Framework (Legacy), MyBatis |
| **Database** | Oracle Database 19c |
| **Frontend** | JSP, jQuery, AJAX, Bootstrap |
| **Libraries** | FullCalendar, Chart.js, Lombok |
| **APIs** | **고용24**, **커리어넷**, **OpenAI (ChatGPT)** |
| **Tools** | STS, SQL Developer, Redmine |
