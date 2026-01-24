<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
</style>
<link rel="stylesheet" href="/project/resources/style/reset.css">
<link rel="stylesheet" href="/project/resources/style/after_login.css">
<link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css'rel='stylesheet'>
<script src="/project/resources/js/httpRequest.js"></script>
<style>
	a>img{
    width: 220px;
    height: 350px;
    transition: all 0.1s linear;
}
a:hover img{
    transform: scale(1.05); 
}
	
</style>
</head>
<body>
	<div class="container">

		<header>
			<div class="gnb">
				<div class="btn_content">
					<!-- 로그인 버튼 -->
					<button class="btn" type="button" onclick="logout();">로그아웃</button>
					<!-- 회원가입 버튼 -->
					<button class="btn" type="button"
						onclick="location.href='myPage.do'">마이페이지</button>
				</div>
			</div>

		</header>
		<section>
			<div class="section_container">

				<div class="title">
					<h1>조회수 랭킹</h1>
				</div>

				<div class="views_ranking">
					<div class="slides_container" id="vr_slide">
						
						<div class="movie_content slide2" id="vr_slide_list1">
							<c:forEach var="vo" items="${ movieHit }" begin="0" end="5">
								<form>
									<input type="hidden" name="${ vo.movieIdx }"
										value="${ vo.movieName }">
									<div class="movie_list">
										<!-- 영화 화면 뜨는지 확인 -->
										<a href="movie.do?movieIdx=${ vo.movieIdx }"> <img
											src="/project/resources/image/${ vo.movieName }.jpg" alt="">
										</a>
									</div>
								</form>
							</c:forEach>
						</div>
						<div class="movie_content slide2" id="vr_slide_list2">
							<c:forEach var="vo" items="${ movieHit }" begin="6" end="11">
								<form>
									<input type="hidden" name="${ vo.movieIdx }"
										value="${ vo.movieName }">
									<div class="movie_list">
										<!-- 영화 화면 뜨는지 확인 -->
										<a href="movie.do?movieIdx=${ vo.movieIdx }"> <img
											src="/project/resources/image/${ vo.movieName }.jpg" alt="">
										</a>
									</div>
								</form>
							</c:forEach>
						</div>
						<div class="movie_content slide3" id="vr_slide_list3">
							<c:forEach var="vo" items="${ movieHit }" begin="12" end="17">
								<form>
									<input type="hidden" name="${ vo.movieIdx }"
										value="${ vo.movieName }">
									<div class="movie_list">
										<!-- 영화 화면 뜨는지 확인 -->
										<a href="movie.do?movieIdx=${ vo.movieIdx }"> <img
											src="/project/resources/image/${ vo.movieName }.jpg" alt="">
										</a>
									</div>
								</form>
							</c:forEach>
						</div>
					</div>

					<div class="slide_btn_box">
						<!-- hsl(0deg 0% 8% / 50%) -->
						<button type="button" class="prev" id="vr_prevBtn">
							<!-- 이클립스 이미지 경로 변경 -->
							prev <img
								src="/project/resources/image/chevron-left-solid-72.png" alt="">
						</button>
						<button type="button" class="next" id="vr_nextBtn">
							<!-- 이클립스 이미지 경로 변경 -->
							next <img
								src="/project/resources/image/chevron-right-solid-72.png" alt="">
						</button>
					</div>
				</div>
				<div class="title">
					<h1>찜 목록</h1>
				</div>

				<div class="star_ranking">
					<div class="slides_container" id="sr_slide">
						<div class="movie_content slide1" id="sr_slide_list">
							<c:forEach var="select" items="${ movieSelect }" begin="0"
								end="5">
								<form>
									<input type="hidden" name="${ select.movieIdx }"
										value="${ select.movieName }">
									<div class="movie_list">
										<!-- 영화 화면 뜨는지 확인 -->
										<a href="movie.do?movieIdx=${ select.movieIdx }"> <img
											src="/project/resources/image/${ select.movieName }.jpg"
											alt="">
										</a>
									</div>
								</form>
							</c:forEach>
						</div>
						<div class="movie_content slide2" id="sr_slide_list">
							<c:forEach var="select" items="${ movieSelect }" begin="6"
								end="12">
								<form>
									<input type="hidden" name="${ select.movieIdx }"
										value="${ select.movieName }">
									<div class="movie_list">
										<!-- 영화 화면 뜨는지 확인 -->
										<a href="movie.do?movieIdx=${ select.movieIdx }"> <img
											src="/project/resources/image/${ select.movieName }.jpg"
											alt="">
										</a>
									</div>
								</form>
							</c:forEach>

						</div>
						<div class="movie_content slide3" id="sr_slide_list">
							<c:forEach var="select" items="${ movieSelect }" begin="13"
								end="18">
								<form>
									<input type="hidden" name="${ select.movieIdx }"
										value="${ select.movieName }">
									<div class="movie_list">
										<!-- 영화 화면 뜨는지 확인 -->
										<a href="movie.do?movieIdx=${ select.movieIdx }"> <img
											src="/project/resources/image/${ select.movieName }.jpg"
											alt="">
										</a>
									</div>
								</form>
							</c:forEach>
						</div>
					</div>

					<div class="slide_btn_box">
						<!-- hsl(0deg 0% 8% / 50%) -->
						<button type="button" class="prev" id="sr_prevBtn">
							prev
							<!-- 이클립스 이미지 경로 변경-->
							<img src="/project/resources/image/chevron-left-solid-72.png"
								alt="">
						</button>
						<button type="button" class="next" id="sr_nextBtn">
							<!-- 이클립스 이미지 경로 변경-->
							next <img
								src="/project/resources/image/chevron-right-solid-72.png" alt="">
						</button>
					</div>
				</div>
			</div>
		</section>
	</div>
</body>
<!-- 조회수 랭킹 슬라이드 -->
<script>
	const slides1 = document.querySelector('#vr_slide'); //전체 슬라이드 컨테이너
	const slide1 = document.querySelectorAll('#vr_slide_list'); //모든 슬라이드들
	let vr_currentIdx = 0; //현재 슬라이드 index
	const vr_slideCount = slide1.length; // 슬라이드 개수
	const vr_prev = document.querySelector('#vr_prevBtn'); //이전 버튼
	const vr_next = document.querySelector('#vr_nextBtn'); //다음 버튼
	const slideWidth1 = 1380; //한개의 슬라이드 넓이
	const slideMargin1 = 0; //슬라이드간의 margin 값

	//전체 슬라이드 컨테이너 넓이 설정
	slides1.style.width = (slideWidth1 + slideMargin1) * vr_slideCount + 'px';

	function moveSlide1(num) {
		slides1.style.left = -num * 1380 + 'px';
		vr_currentIdx = num;
	}

	vr_prev.addEventListener('click', function() {
		/*첫 번째 슬라이드로 표시 됐을때는 
		이전 버튼 눌러도 아무런 반응 없게 하기 위해 
		currentIdx !==0일때만 moveSlide 함수 불러옴 */

		if (vr_currentIdx !== 0)
			moveSlide1(vr_currentIdx - 1);
	});

	vr_next.addEventListener('click', function() {
		/* 마지막 슬라이드로 표시 됐을때는 
		다음 버튼 눌러도 아무런 반응 없게 하기 위해
		currentIdx !==slideCount - 1 일때만 
		moveSlide 함수 불러옴 */
		if (vr_currentIdx !== vr_slideCount - 1) {
			moveSlide1(vr_currentIdx + 1);
		}
	});
</script>

<!-- 별점수 랭킹 슬라이드 -->
<script>
	const slides2 = document.querySelector('#sr_slide'); //전체 슬라이드 컨테이너
	const slide2 = document.querySelectorAll('#sr_slide_list'); //모든 슬라이드들
	let sr_currentIdx = 0; //현재 슬라이드 index
	const sr_slideCount = slide2.length; // 슬라이드 개수
	const sr_prev = document.querySelector('#sr_prevBtn'); //이전 버튼
	const sr_next = document.querySelector('#sr_nextBtn'); //다음 버튼
	const slideWidth2 = 1380; //한개의 슬라이드 넓이
	const slideMargin2 = 0; //슬라이드간의 margin 값

	//전체 슬라이드 컨테이너 넓이 설정
	slides1.style.width = (slideWidth2 + slideMargin2) * sr_slideCount + 'px';

	function moveSlide2(num) {
		slides2.style.left = -num * 1380 + 'px';
		sr_currentIdx = num;
	}

	sr_prev.addEventListener('click', function() {
		/*첫 번째 슬라이드로 표시 됐을때는 
		이전 버튼 눌러도 아무런 반응 없게 하기 위해 
		currentIdx !==0일때만 moveSlide 함수 불러옴 */

		if (sr_currentIdx !== 0)
			moveSlide2(sr_currentIdx - 1);
	});

	sr_next.addEventListener('click', function() {
		/* 마지막 슬라이드로 표시 됐을때는 
		다음 버튼 눌러도 아무런 반응 없게 하기 위해
		currentIdx !==slideCount - 1 일때만 
		moveSlide 함수 불러옴 */
		if (sr_currentIdx !== sr_slideCount - 1) {
			moveSlide2(sr_currentIdx + 1);
		}
	});
	
	
//로그아웃
function logout() {
	var url = "sessionDrop.do";
	var param = "";
	sendRequest(url, param, logoutResult, "post");
}
function logoutResult() {
	if (xhr.readyState == 4 && xhr.status == 200) {
		var data = xhr.responseText;
		if (data == "no") {
			alert("세션 삭제 실패");
			return;
		} else {
			alert("세션 삭제 성공");
			location.href = 'beforeLogin.do';
		}
	}
}
</script>
</html>