<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>커뮤니티 선택</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            min-height: 100vh;
            background: linear-gradient(135deg, #0f2e1e 0%, #1a2634 50%, #0a1520 100%);
            color: white;
            font-family: "Noto Sans KR", -apple-system, BlinkMacSystemFont, sans-serif;
            overflow-x: hidden;
        }

        /* 별 떨어지는 애니메이션 */
        @keyframes fall {
            to {
                transform: translateY(100vh) rotate(360deg);
                opacity: 0;
            }
        }

        @keyframes twinkle {
            0%, 100% { opacity: 0.3; }
            50% { opacity: 1; }
        }

        @keyframes shimmer {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.2); }
        }

        .star {
            position: fixed;
            width: 2px;
            height: 2px;
            background: white;
            border-radius: 50%;
            animation: fall linear forwards, twinkle 3s infinite;
            pointer-events: none;
        }

        /* 메인 컨텐츠 */
        main {
            max-width: 1400px;
            margin: 80px auto;
            padding: 0 40px;
        }

        /* 페이지 헤더 디자인 개선 */
        .page-header {
            text-align: center;
            margin-bottom: 80px;
            position: relative;
        }

        .page-header h1 {
            font-size: 64px;
            margin-bottom: 25px;
            background: linear-gradient(135deg, #34d399 0%, #10b981 50%, #059669 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            filter: drop-shadow(0 0 30px rgba(52, 211, 153, 0.5));
            font-weight: 800;
            letter-spacing: -1px;
            line-height: 1.1;
            animation: titleGlow 3s ease-in-out infinite;
        }

        @keyframes titleGlow {
            0%, 100% {
                filter: drop-shadow(0 0 30px rgba(52, 211, 153, 0.5));
            }
            50% {
                filter: drop-shadow(0 0 50px rgba(52, 211, 153, 0.7));
            }
        }

        .page-header p {
            font-size: 20px;
            color: rgba(255, 255, 255, 0.8);
            font-weight: 400;
            line-height: 1.8;
            max-width: 700px;
            margin: 0 auto;
            letter-spacing: 0.5px;
            position: relative;
            padding: 0 20px;
        }

        .page-header p::before {
            content: '';
            position: absolute;
            left: 50%;
            top: -20px;
            transform: translateX(-50%);
            width: 60px;
            height: 3px;
            background: linear-gradient(90deg, transparent, #34d399, transparent);
            border-radius: 2px;
        }

        /* 필터 섹션 */
        .filter-section {
            display: flex;
            gap: 15px;
            margin-bottom: 50px;
            flex-wrap: wrap;
            align-items: center;
        }

        .filter-btn {
            padding: 12px 24px;
            border: 1.5px solid rgba(52, 211, 153, 0.4);
            background: rgba(52, 211, 153, 0.05);
            color: rgba(255, 255, 255, 0.8);
            border-radius: 8px;
            cursor: pointer;
            font-size: 14px;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .filter-btn:hover,
        .filter-btn.active {
            background: rgba(52, 211, 153, 0.2);
            border-color: #34d399;
            color: #34d399;
            box-shadow: 0 0 15px rgba(52, 211, 153, 0.2);
        }

        /* 그리드 레이아웃 */
        .community-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 30px;
            margin-bottom: 80px;
        }

        .community-card {
            position: relative;
            background: linear-gradient(135deg, rgba(52, 211, 153, 0.1), rgba(16, 185, 129, 0.05));
            border: 1.5px solid rgba(52, 211, 153, 0.3);
            border-radius: 16px;
            padding: 30px;
            cursor: pointer;
            transition: all 0.3s ease;
            backdrop-filter: blur(10px);
            overflow: hidden;
            display: flex;
            flex-direction: column;
            gap: 20px;
            min-height: 320px;
        }

        .community-card::before {
            content: '';
            position: absolute;
            inset: 0;
            background: linear-gradient(135deg, rgba(52, 211, 153, 0.1), transparent);
            opacity: 0;
            transition: opacity 0.3s ease;
        }

        .community-card:hover::before {
            opacity: 1;
        }

        .community-card:hover {
            border-color: #34d399;
            background: linear-gradient(135deg, rgba(52, 211, 153, 0.15), rgba(16, 185, 129, 0.1));
            transform: translateY(-8px);
            box-shadow: 0 15px 40px rgba(52, 211, 153, 0.2);
        }

        .card-icon {
            width: 60px;
            height: 60px;
            background: linear-gradient(135deg, #34d399, #10b981);
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 32px;
            position: relative;
            z-index: 1;
        }

        .card-content {
            position: relative;
            z-index: 1;
            flex-grow: 1;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }

        .card-title {
            font-size: 22px;
            font-weight: 700;
            margin-bottom: 10px;
            letter-spacing: 0.5px;
        }

        .card-description {
            font-size: 14px;
            color: rgba(255, 255, 255, 0.7);
            line-height: 1.6;
        }
        
        .card-button {
            padding: 12px 20px;
            background: linear-gradient(135deg, rgba(52, 211, 153, 0.2), rgba(16, 185, 129, 0.1));
            border: 1.5px solid rgba(52, 211, 153, 0.5);
            color: #34d399;
            border-radius: 8px;
            cursor: pointer;
            font-size: 14px;
            font-weight: 600;
            transition: all 0.3s ease;
            position: relative;
            z-index: 2;
            align-self: flex-start;
        }

        .card-button:hover {
            background: rgba(52, 211, 153, 0.3);
            border-color: #34d399;
            box-shadow: 0 0 20px rgba(52, 211, 153, 0.3);
            transform: translateX(5px);
        }

        /* 모달 */
        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.7);
            z-index: 999;
            align-items: center;
            justify-content: center;
            backdrop-filter: blur(5px);
        }

        .modal.active {
            display: flex;
            animation: fadeIn 0.3s ease;
        }

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        .modal-content {
            background: linear-gradient(135deg, rgba(15, 31, 46, 0.98), rgba(10, 21, 32, 0.98));
            border: 1.5px solid rgba(52, 211, 153, 0.4);
            border-radius: 16px;
            padding: 40px;
            max-width: 500px;
            width: 90%;
            position: relative;
            backdrop-filter: blur(15px);
            animation: slideIn 0.3s ease;
        }

        @keyframes slideIn {
            from {
                opacity: 0;
                transform: scale(0.9);
            }
            to {
                opacity: 1;
                transform: scale(1);
            }
        }

        .modal-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 20px;
        }

        .modal-title {
            font-size: 28px;
            font-weight: 700;
            background: linear-gradient(135deg, #34d399, #10b981);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .modal-close {
            background: none;
            border: none;
            color: rgba(255, 255, 255, 0.6);
            font-size: 28px;
            cursor: pointer;
            transition: all 0.2s ease;
        }

        .modal-close:hover {
            color: #34d399;
            transform: rotate(90deg);
        }

        .modal-body {
            margin-bottom: 30px;
        }

        .modal-body p {
            font-size: 15px;
            color: rgba(255, 255, 255, 0.7);
            line-height: 1.8;
            margin-bottom: 15px;
        }

        .modal-footer {
            display: flex;
            gap: 15px;
        }

        .modal-btn {
            flex: 1;
            padding: 12px 20px;
            border: 1.5px solid rgba(52, 211, 153, 0.5);
            background: rgba(52, 211, 153, 0.1);
            color: #34d399;
            border-radius: 8px;
            cursor: pointer;
            font-size: 14px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .modal-btn.primary {
            background: linear-gradient(135deg, #34d399, #10b981);
            color: #0a1520;
            border-color: #34d399;
        }

        .modal-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(52, 211, 153, 0.3);
        }

        /* 반응형 */
        @media (max-width: 1024px) {
            main {
                padding: 0 20px;
                margin: 60px auto;
            }

            .community-grid {
                grid-template-columns: repeat(auto-fill, minmax(240px, 1fr));
                gap: 20px;
            }

            .page-header h1 {
                font-size: 48px;
            }

            .page-header p {
                font-size: 18px;
            }
        }

        @media (max-width: 768px) {
            main {
                margin: 40px auto;
            }

            .page-header {
                margin-bottom: 60px;
            }

            .page-header h1 {
                font-size: 36px;
            }

            .page-header p {
                font-size: 16px;
            }

            .community-grid {
                grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
                gap: 15px;
            }

            .community-card {
                padding: 20px;
                min-height: 280px;
            }

            .card-title {
                font-size: 18px;
            }

            .filter-section {
                justify-content: center;
            }

            .modal-content {
                padding: 30px 20px;
            }
        }

        @media (max-width: 480px) {
            .community-grid {
                grid-template-columns: 1fr;
            }

            .page-header h1 {
                font-size: 28px;
            }

            .page-header p {
                font-size: 14px;
            }
        }
    </style>
</head>
<body>
    <main>
        <!-- 페이지 헤더 디자인 개선 -->
        <div class="page-header">
            <h1>커뮤니티 선택</h1>
            <p>당신의 전문 분야와 관심사에 맞는 커뮤니티를 찾아보세요</p>
        </div>

        <!-- 필터 버튼 -->
        <div class="filter-section">
            <button class="filter-btn active" onclick="filterCards('all', this)">전체</button>
            <button class="filter-btn" onclick="filterCards('professional', this)">전문가</button>
            <button class="filter-btn" onclick="filterCards('tech', this)">기술</button>
            <button class="filter-btn" onclick="filterCards('business', this)">비즈니스</button>
        </div>

        <!-- 그리드 카드 레이아웃 -->
        <div class="community-grid">
            <div class="community-card" data-category="professional" data-community="medical">
                <div class="card-icon">💼</div>
                <div class="card-content">
                    <div>
                        <div class="card-title">의료</div>
                        <div class="card-description">의료 전문가들을 위한 네트워킹과 지식 공유 커뮤니티</div>
                    </div>
                </div>
                <button class="card-button" onclick="goToCommunity('medical')">참여하기</button>
            </div>

            <div class="community-card" data-category="professional" data-community="finance">
                <div class="card-icon">💰</div>
                <div class="card-content">
                    <div>
                        <div class="card-title">금융</div>
                        <div class="card-description">금융업 종사자들의 정보 교환 및 경력 발전 플랫폼</div>
                    </div>
                </div>
                <button class="card-button" onclick="goToCommunity('finance')">참여하기</button>
            </div>

            <div class="community-card" data-category="tech" data-community="developer">
                <div class="card-icon">💻</div>
                <div class="card-content">
                    <div>
                        <div class="card-title">개발자</div>
                        <div class="card-description">프로그래머와 개발자들의 기술 공유 및 협업 공간</div>
                    </div>
                </div>
                <button class="card-button" onclick="goToCommunity('developer')">참여하기</button>
            </div>

            <div class="community-card" data-category="business" data-community="public">
                <div class="card-icon">🏛️</div>
                <div class="card-content">
                    <div>
                        <div class="card-title">공기업</div>
                        <div class="card-description">공무원과 공기업 종사자들의 경력 및 정보 공유</div>
                    </div>
                </div>
                <button class="card-button" onclick="goToCommunity('public')">참여하기</button>
            </div>

            <div class="community-card" data-category="professional" data-community="law">
                <div class="card-icon">⚖️</div>
                <div class="card-content">
                    <div>
                        <div class="card-title">법률</div>
                        <div class="card-description">법조인들의 판례 공유 및 법률 상담 커뮤니티</div>
                    </div>
                </div>
                <button class="card-button" onclick="goToCommunity('law')">참여하기</button>
            </div>

            <div class="community-card" data-category="tech" data-community="engineering">
                <div class="card-icon">🔧</div>
                <div class="card-content">
                    <div>
                        <div class="card-title">엔지니어링</div>
                        <div class="card-description">엔지니어 및 기술자들의 프로젝트 협력 플랫폼</div>
                    </div>
                </div>
                <button class="card-button" onclick="goToCommunity('engineering')">참여하기</button>
            </div>

            <div class="community-card" data-category="business" data-community="marketing">
                <div class="card-icon">📊</div>
                <div class="card-content">
                    <div>
                        <div class="card-title">마케팅</div>
                        <div class="card-description">마케터들의 전략 공유 및 트렌드 분석 커뮤니티</div>
                    </div>
                </div>
                <button class="card-button" onclick="goToCommunity('marketing')">참여하기</button>
            </div>

            <div class="community-card" data-category="tech" data-community="startup">
                <div class="card-icon">🚀</div>
                <div class="card-content">
                    <div>
                        <div class="card-title">스타트업</div>
                        <div class="card-description">창업자와 스타트업 팀들의 네트워킹 허브</div>
                    </div>
                </div>
                <button class="card-button" onclick="goToCommunity('startup')">참여하기</button>
            </div>
        </div>
    </main>

    <!-- 모달 추가 -->
    <div id="communityModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <div class="modal-title" id="modalTitle"></div>
                <button class="modal-close" onclick="closeCommunity()">×</button>
            </div>
            <div class="modal-body">
                <p id="modalDesc"></p>
            </div>
            <div class="modal-footer">
                <button class="modal-btn" onclick="closeCommunity()">취소</button>
                <button class="modal-btn primary" onclick="joinCommunity()">커뮤니티 참여</button>
            </div>
        </div>
    </div>

    <script>
        // 별 떨어지는 애니메이션
        function createFallingStars() {
            setInterval(() => {
                const star = document.createElement('div');
                star.className = 'star';
                const x = Math.random() * window.innerWidth;
                const duration = Math.random() * 3 + 2;
                star.style.left = x + 'px';
                star.style.top = '-10px';
                star.style.animationDuration = duration + 's';
                document.body.appendChild(star);

                setTimeout(() => star.remove(), duration * 1000);
            }, 300);
        }

        window.addEventListener('load', createFallingStars);

        // 필터 기능
        function filterCards(category, button) {
            const cards = document.querySelectorAll('.community-card');
            const buttons = document.querySelectorAll('.filter-btn');

            buttons.forEach(btn => btn.classList.remove('active'));
            button.classList.add('active');

            cards.forEach(card => {
                if (category === 'all' || card.dataset.category === category) {
                    card.style.display = '';
                    setTimeout(() => card.style.opacity = '1', 10);
                } else {
                    card.style.opacity = '0';
                    setTimeout(() => card.style.display = 'none', 300);
                }
            });
        }

        const communities = {
            '의료': '의료 커뮤니티에 오신 것을 환영합니다. 의료 전문가들과 함께 최신 의료 정보와 경험을 공유하세요.',
            '금융': '금융 커뮤니티에 오신 것을 환영합니다. 금융 전문가들과 투자 전략을 논의하세요.',
            '개발자': '개발자 커뮤니티에 오신 것을 환영합니다. 최신 기술과 프로젝트를 함께 진행하세요.',
            '공기업': '공기업 커뮤니티에 오신 것을 환영합니다. 공무원들과 경력 정보를 공유하세요.',
            '법률': '법률 커뮤니티에 오신 것을 환영합니다. 법조인들과 판례를 논의하세요.',
            '엔지니어링': '엔지니어링 커뮤니티에 오신 것을 환영합니다. 기술 프로젝트에 협력하세요.',
            '마케팅': '마케팅 커뮤니티에 오신 것을 환영합니다. 마케팅 전략과 트렌드를 공유하세요.',
            '스타트업': '스타트업 커뮤니티에 오신 것을 환영합니다. 창업자들과 네트워킹하세요.'
        };

        function showCommunity(name) {
            document.getElementById('modalTitle').textContent = name;
            document.getElementById('modalDesc').textContent = communities[name];
            document.getElementById('communityModal').classList.add('active');
        }

        function closeCommunity() {
            document.getElementById('communityModal').classList.remove('active');
        }

        function joinCommunity() {
            alert('커뮤니티 참여 완료!');
            closeCommunity();
        }

        function goToCommunity(category) {
            window.location.href = "/controller/community/" + category;
        }



        document.addEventListener('keydown', (e) => {
            if (e.key === 'Escape') {
                closeCommunity();
            }
        });

        document.getElementById('communityModal').addEventListener('click', (e) => {
            if (e.target.id === 'communityModal') {
                closeCommunity();
            }
        });
    </script>
</body>
</html>
