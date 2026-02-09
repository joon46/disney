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

🏗️ 1. Integrated System Architecture

사용자의 요청이 View에서 시작해 Java의 인메모리 데이터 저장소(ArrayList)를 거쳐 다시 화면으로 돌아오는 메커니즘입니다.

sequenceDiagram
    participant User as 👤 User (JSP)
    participant Controller as ⚙️ Controller (Java)
    participant DAO as 🗳️ DAO (Memory)
    participant List as 📦 ArrayList / Vector

    User->>Controller: HTTP Request (예: 영화 상세 조회)
    Controller->>DAO: 데이터 조회 메서드 호출 (getMovieList)
    DAO->>List: 컬렉션 내 객체 탐색 및 필터링
    List-->>DAO: VO 객체 반환
    DAO-->>Controller: ArrayList / VO 전달
    Controller->>User: RequestDispatcher / JSP 데이터 바인딩
    Note over User: JSTL/EL을 이용한 동적 렌더링
