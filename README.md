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

2. 기능별 통합 가이드 (Java & JSP Mapping)

면접관님, 특정 기능을 구현하기 위해 사용된 파일 간의 연관 관계입니다. DB 대신 자바 객체 내에 보관된 데이터를 처리하는 로직을 확인할 수 있습니다.

주요 기능

View (JSP / webapp)

Logic (Java / src)

핵심 로직 설명

메인 대시보드

main.jsp

MovieController, MovieDAO

ArrayList에 담긴 영화 객체들을 루프를 통해 JSTL로 출력

상세 정보 & 댓글

movieDetail.jsp

ReplyController, ScoreVO

사용자의 입력값을 자바 객체 리스트에 실시간 추가 및 관리

사용자 인증

login.jsp, join.jsp

UserController, UserVO

UserList 내 객체 비교를 통한 회원가입/로그인 유효성 검증

마이페이지

myPage.jsp

UserSelectDAO

선택된 유저의 인덱스를 기준으로 리스트 필터링 수행

인물 정보

actor.jsp

ActorVO, ActorDAO

배우 정보를 담은 컬렉션을 영화 정보와 매칭하여 노출

관리자 모드

admin.jsp

AdminController

add(), remove() 등 컬렉션 메서드를 활용한 콘텐츠 CRUD

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
