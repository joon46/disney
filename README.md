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

## Security
- SQL Injection 방지: MyBatis 사용 시 모든 파라미터 바인딩을 ${}(Literal) 대신 #{}(PreparedStatement) 방식을 적용하여 SQL 인젝션 공격에 대비한 안정적인 데이터 조작 로직을 구현하였습니다.

## 각 파일 설명
# Java (Back-end: MVC Pattern)
com.disney.controller: 사용자 요청(.do)을 받아 적절한 서비스로 연결

- MovieController.java: 영화 리스트 출력, 상세 정보, 랭킹 및 조회수 로직 처리.

- UserController.java: 일반/소셜 로그인, 회원가입, 중복 체크(AJAX) 관리.

- UserSelectController.java: 찜하기 추가 및 삭제 요청 처리.

com.disney.dao: DB에 직접 접근하여 SQL 쿼리 실행

- MovieDAO.java: 영화 CRUD 및 랭킹(MovieHit) 업데이트 로직.

- UserDAO.java: 유저 정보 관리 및 중복 데이터 확인 쿼리.

com.disney.vo: DB 테이블과 매핑되는 Value Object (데이터 바구니).

# Web Content (Front-end: JSP)
WEB-INF/views/main.jsp: 메인 페이지. 영화 슬라이더 및 실시간 랭킹 순위 노출.

WEB-INF/views/movie/: 영화 관련 화면

- movie_detail.jsp: 영화 상세 정보, 별점 부여 및 댓글 작성 UI.

WEB-INF/views/user/: 회원 관련 화면

- login.jsp / register.jsp: 로그인 및 회원가입(유효성 검사 포함).

- mypage.jsp: 개인정보 수정 및 찜 목록(UserSelect) 관리.

WEB-INF/views/admin/: 관리자 전용 영화 등록 및 회원 관리 페이지.

## 영화 인기 랭킹 & 조회수 관리 프로세스 흐름도


graph LR

    subgraph View_JSP
        A[beforeLogin.jsp / afterLogin.jsp] -- "1. 영화 클릭 (movie.do?movieIdx=X)" --> B[movie.jsp] (영화정보)
        F[afterLogin.jsp / beforeLogin.jsp] -- "4. 데이터 갱신된 메인 출력" --> G((사용자 확인))
    end

    subgraph Controller_Java
        C[MovieController] -- "2. @RequestMapping('movie.do')" --> D[movieAbout 메서드]
        D -- "조회수 증가 호출" --> E[movieHitUpDate 실행]
    end

    subgraph Model_MyBatis
        E -- "UPDATE MovieTable SET MovieHit++" --> DB[(Oracle DB)]
        D -- "SELECT * FROM MovieTable" --> DB
    end

    B -- "3. 페이지 로드 시 최신 랭킹 리스트 요청" --> C
    C -- "movieList 데이터 반환" --> F

- **사용자 요청 처리**: `@RequestMapping`을 통해 `.do` 기반의 가상 경로를 설정, 비즈니스 로직과 뷰(JSP)를 완전히 분리했습니다.
- **조회수 자동 집계**: 사용자가 영화 상세 정보를 조회할 때마다 `MovieDAO.movieHitUpDate`가 실행되어 실시간 트래픽을 데이터화합니다.
- **동적 화면 구성**: 
  - `beforeLogin.jsp`: 비로그인 사용자용 메인 (로그인 유도)
  - `afterLogin.jsp`: 로그인 사용자 전용 메인 (개인화된 메뉴 및 서비스 노출)
- **Persistence**: MyBatis의 `sqlSession`을 활용하여 SQL 쿼리를 DAO 외부(XML)에서 관리, 유지보수성을 극대화했습니다.


## 회원가입 및 데이터 무결성 검증 프로세스

sequenceDiagram

    participant JSP as signUp.jsp (View)
    participant AJAX as jQuery/AJAX
    participant Controller as UserController
    participant DAO as UserDAO
    participant DB as Database
    participant WC as Welcome.jsp (View)

    JSP->>AJAX: ID/닉네임 입력 이벤트
    AJAX->>Controller: 중복 체크 요청 (.do)
    Controller->>DAO: findUserById() / findUserByNick()
    DAO->>DB: SELECT COUNT(*)
    DB-->>Controller: 결과 반환
    Controller-->>AJAX: JSON 응답 (사용가능 여부)
    - AJAX->>WC: 사용 가능 시 회원가입 성공 페이지로 이동  
    - 화면에 실시간 메시지 출력
    
    Note over JSP, DB: 모든 검증 완료 후
    JSP->>Controller: 회원가입 요청 (POST)
    Controller->>DAO: userInsert(vo)
    DAO->>DB: INSERT INTO UserTable


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
