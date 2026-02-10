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

## Java-JSP 파일 연동 다이어그램
사용자의 요청이 들어왔을 때, 어떤 Java 파일을 거쳐 어떤 JSP로 데이터가 전달되는지에 대한 구조도입니다.
graph LR

    subgraph "View Layer (webapp/WEB-INF)"
        JSP_MAIN[main.jsp]
        JSP_DET[movieDetail.jsp]
        JSP_ADM[admin.jsp]
    end

    subgraph "Controller Layer (src/java/controller)"
        CON_MOV[MovieController.java]
        CON_REPLY[ReplyController.java]
        CON_ADM[AdminController.java]
    end

    subgraph "Model Layer (src/java/dao & vo)"
        DAO_MOV[MovieDAO.java]
        DAO_ACT[ActorDAO.java]
        VO_MOV[MovieVO.java]
    end

    %% 관계 설정
    JSP_MAIN -- "Request" --> CON_MOV
    CON_MOV -- "getMovieList()" --> DAO_MOV
    DAO_MOV -- "ArrayList<VO>" --> CON_MOV
    CON_MOV -- "setAttribute & Forward" --> JSP_MAIN

    JSP_DET -- "AJAX Request" --> CON_REPLY
    CON_REPLY -- "insertReply()" --> DAO_MOV
    DAO_MOV -- "Response Data" --> CON_REPLY
    CON_REPLY -- "JSON/Text" --> JSP_DET

    JSP_ADM -- "CRUD Request" --> CON_ADM
    CON_ADM -- "update/delete" --> DAO_MOV


🚀 3. 핵심 기술 포인트 (Deep Dive)

📍 In-Memory Data Management (Collection Framework)

ArrayList & Vector 활용: 실제 DB 테이블 역할을 하는 리스트를 DAO 클래스 내에 정적(static) 혹은 싱글톤 형태로 관리하여, 데이터의 영속성을 흉내 내고 일관된 접근을 보장했습니다.

객체 지향적 설계: 데이터 하나하나를 VO(Value Object) 클래스로 정의하여, 단순한 문자열이 아닌 구조화된 '객체' 단위로 데이터를 처리했습니다.

📍 MVC Model 2 패턴의 구현

Controller (Java): 서블릿이 클라이언트의 요청을 가로채어, 필요한 DAO의 메서드를 호출하고 결과 데이터를 적절한 JSP로 포워딩합니다.

View (JSP): request.getAttribute()를 통해 전달받은 자바 객체들을 JSTL 태그로 풀어서 화면을 구성합니다.

📍 데이터 제어 로직 (Java Logic)

Sorting & Searching: SQL의 ORDER BY나 WHERE 절 대신, 자바의 반복문과 조건문을 활용하여 인메모리 데이터를 직접 정렬하고 검색하는 로직을 구현했습니다.

🛠️ 개선 및 확장 계획 (To-Be)

Database Migration: 현재의 인메모리 저장 방식에서 Oracle / MySQL 연동으로 전환하여 데이터 영속성 확보

Persistence Framework: JDBC 또는 MyBatis를 도입하여 자바 코드와 SQL 쿼리 분리

Framework Upgrade: 순수 Servlet 프로젝트를 Spring Boot로 리팩토링하여 전체적인 생산성 향상
    Controller->>User: RequestDispatcher / JSP 데이터 바인딩
    Note over User: JSTL/EL을 이용한 동적 렌더링
