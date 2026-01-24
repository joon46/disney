<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/project/resources/style/reset.css">
<link rel="stylesheet" href="/project/resources/style/before_login.css">
<link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet'>
</head>
<body>
    <div class="container">

        <header>
            <div class="gnb">
                <div class="btn_content">
                    <!-- 로그인 버튼 -->
                    <button class="btn" type="button" onclick="location.href='loginForm.do'">로그인</button>
                    <!-- 회원가입 버튼 -->
                    <button class="btn" type="button" onclick="location.href='signUpForm.do'">회원가입</button>
                </div>
            </div>
            
        </header>
        <section>
            <div class="section_container">
                <div class="content">
                    <h1>LOGO</h1>
                    <h1>영화를 시청하려면 지금가입하기버튼을 눌러주세요</h1>
                    <button class="sign_up" type="button" onclick="location.href='signUpForm.do'">지금가입하기</button>
                </div>

                
                <div class="title">
                    <h1>logo에서 볼수 있는 영화</h1>
                </div>
                <div class="views_ranking">
                    <div class="slides_container" id="vr_slide">
                    </div>
                    
                    <div class="slide_btn_box">
                        <!-- hsl(0deg 0% 8% / 50%) -->
                    </div>
                </div>
            </div>
        </section>
    </div>
</body>
		<!-- data list만큼 slide list 생성 -->
        <script>
            var list  = [1,2,3,4,5,6,7,8,9,10,11,12,13,14]; //[1,2,3,4,5,6,7,8,9,10,11,12,13,14] --> ${vo.list}
            const vr_slide = document.querySelector("#vr_slide");
            const vr_slide_list = document.createElement('div');
            vr_slide_list.setAttribute('class','movie_content');
            vr_slide_list.classList.add('slide');
            vr_slide_list.setAttribute('id','vr_slide_list');
            vr_slide.appendChild(vr_slide_list);
            var slide_idx = 0;
            var child_idx = 0;
            for(var i = 0 ; i<list.length; i++){
                const slide_list = document.querySelector(".slide");
                const movie_list = document.createElement('div');
                movie_list.setAttribute('class','movie_list');
                const a = document.createElement('a');
                const img = document.createElement('img');
                img.setAttribute('src','/project/resources/image/movie_poster'+(i+1)+'.jpg'); // './img/movie_poster'+(i+1)+'.jpg' --> /Project/resources/upload/${vo.filename}
                slide_list.append(movie_list);
                slide_list.childNodes[child_idx].append(a);
                slide_list.childNodes[child_idx].childNodes[0].append(img);
                child_idx++;
            }

        </script>

        <!-- 조회수 랭킹 슬라이드 -->
        <script>
            const slides1 = document.querySelector('#vr_slide'); //전체 슬라이드 컨테이너
            const slide1 = document.querySelector('#vr_slide_list'); //모든 슬라이드들
            const movie_list = document.querySelectorAll('.movie_list')
            console.log(movie_list.length);
            const vr_slideCount = slide1.length; // 슬라이드 개수
            const vr_prev = document.querySelector('#vr_prevBtn'); //이전 버튼
            const vr_next = document.querySelector('#vr_nextBtn'); //다음 버튼
            const slideWidth1 = 1380; //한개의 슬라이드 넓이
            const slideMargin1 = 0; //슬라이드간의 margin 값
            const moviewidth = 230;
            const movewidth = (( -230 * (movie_list.length - 6))) + 'px';
            //전체 슬라이드 컨테이너 넓이 설정
            slides1.style.width = moviewidth * movie_list.length + 'px';
            // slides1.style.transform = `translateX(${movewidth})`
            document.documentElement.style.setProperty("--mytranslateX", movewidth);
            console.log(document.documentElement.style.getPropertyValue("--mytranslateX"));
        </script>
</html>