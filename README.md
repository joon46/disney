## 🚀 Key Features
- **사용자 인증 시스템 (User Auth):** 카카오/네이버 OAuth API 연동을 통한 간편 로그인 지원.
- **데이터 무결성 검증:** AJAX를 이용한 ID, 닉네임, 이메일 실시간 3중 중복 체크로 시스템 무결성 확보.
- **운영 자동화 프로세스:** 사용자 조회수(MovieHit) 데이터를 실시간 수집하여 인기 콘텐츠 자동 노출 로직 구현.
- **고객 선호도 데이터 확보:** 찜하기(UserSelect), 별점(Score), 댓글(Reply) 기능을 통한 트랜잭션 데이터 관리.
- **관리자 전용 대시보드:** 콘텐츠 생애주기 관리(CRUD) 및 사용자 현황 실시간 모니터링 관리자 페이지 구축.

## 🛠 Tech Stack
- **Language:** Java, JavaScript
- **Framework/Library:** Spring (MyBatis), JSP, AJAX
- **Database:** Oracle / MySQL (Relational Modeling)
- **API:** Kakao Login API, Naver Login API
- **ETC:** HTML5/CSS3, GitHub

🏗️ 1. System Architecture
면접관님을 위한 시스템 구조도입니다. 클라이언트의 요청이 어떻게 서버를 거쳐 DB에 도달하고, 다시 UI로 렌더링되는지를 보여줍니다.
graph TD
    subgraph Client_Layer
        Web[Web Browser]
        UI[JSP / HTML5 / CSS3]
    end

    subgraph Logic_Layer
        Controller[Controller: Servlet/Spring]
        Service[Service Logic: Java Beans]
        Auth[OAuth API: Kakao/Naver]
    end

    subgraph Data_Layer
        MyBatis[Persistence: MyBatis]
        DB[(Oracle / MySQL)]
    end

    Web --> UI
    UI -- AJAX/Request --> Controller
    Controller --> Auth
    Controller --> Service
    Service --> MyBatis
    MyBatis --> DB
    DB --> MyBatis
    MyBatis --> Service
    Service --> Controller
    Controller -- Response --> UI
