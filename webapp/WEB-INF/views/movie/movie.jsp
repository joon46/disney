<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>영화 재생 페이지</title>
<link rel="stylesheet" href="/project/resources/style/reset.css">
<link rel="stylesheet" href="/project/resources/style/movie.css">
<script src="/project/resources/js/httpRequest.js"></script>
</head>
<body>
	<div class="conatiner">
		<div class="movie_container">
			<div class="movie_view">
				<div class="view_content">
					<iframe width="866" height="487" src="${ movieOne.movieUrl }"
						frameborder="0"
						allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
						allowfullscreen></iframe>
				</div>
				<!-- 뒤로가기 버튼 -->
				<button type="button" class="back_btn btn"
					onclick="location.href='afterLogin.do'">뒤로가기</button>
				<!-- 찜하기 버튼 -->
				<form>
					<input type="hidden" name="userIdx" value="${ user.userIdx }">
					<input type="hidden" name="movieName" value="${ movieOne.movieName }">
					<button type="button" class="wish_btn btn"
						onclick="userSelectInsert(this.form);">찜하기</button>
				</form>
			</div>
			<div class="content">
				<div class="content_box">
					<div class="box">
						<div class="movie_title text">
							<!-- 영화제목,  -->${ movieOne.movieName }</div>
						<div class="age_limit text">
							<!-- 연령제한,  -->${ movieOne.movieClass }</div>
					</div>
					<div class="staff text">
						<!-- 배우&제작자 -->
						<c:forEach var="actor" items="${ actors }">
                    		${ actor.actorName },
                    	</c:forEach>
					</div>
					<div class="star_box">
						<div class="star text">${ avgScore }</div>
						<div class="star text">
							<form>
								<input type="hidden" name="userIdx" value="${ user.userIdx }">
								<input type="hidden" name="movieName" value="${ movieOne.movieName }">
								<input type="number" name="starScore" min="1" max="5" style="width:30">
								<input type="button" onclick="scoreInsert(this.form);" value="별점주기">
							</form>
						</div>
					</div>
				</div>
				<div class="summary text">
					<!-- 줄거리,  -->${ movieOne.movieStory }</div>
			</div>
			<div class="comment_box">
				<div class="write_comment">
					<h2>댓글 쓰기</h2>
					<p>아이디 : ${ user.userIdx }</p>
					<textarea name="replyComment" id="replyComment" cols="80" rows="10"></textarea>
					<button class="comment_btn" onclick="replyInsert()">등록</button>
				</div>
				<c:forEach var="vo" items="${ list }">
					<form>
						<div class="comment" id="comment1">
							<p>${ vo.userIdx }</p>
							<p>${ vo.replyComment }</p>
							<input type="hidden" value="${ vo.replyComment }"
								name="replyComment"> <input class="comment_del"
								type="button" value="평점 삭제" onclick="replyDelete(this.form)">
						</div>
					</form>
				</c:forEach>
			</div>
		</div>
	</div>
</body>
<script>
//영화 찜목록에 저장(중복 안되게)
function userSelectInsert(f) {
	var userIdx = f.userIdx.value;
	var movieName = f.movieName.value;
	var url = "userSelectInsert.do";
	var param = "userIdx=" + userIdx + "&movieName=" + movieName;
	sendRequest(url, param, userSelectInsertResult, "post");
}
function userSelectInsertResult() {
	if (xhr.readyState == 4 && xhr.status == 200) {
		var data = xhr.responseText;
		if (data == 'a') {
			alert("이미 찜목록에 담겼습니다.");
			return;
		}
		if (data == 'no') {
			alert("찜하기 실패");
			return;
		}
		alert("찜하기 성공");
	}
}

function replyInsert() {
	var userIdx = ${ user.userIdx };
	var replyComment = document.getElementById("replyComment").value;
	var movieName = "${movieOne.movieName}";
	var url = "replyInsert.do";
	var param = "userIdx=" + userIdx +
				"&movieName=" + movieName + 
				"&replyComment=" + replyComment;
	sendRequest(url, param, replyInsertResult, "post")
}

function replyInsertResult() {
	if (xhr.readyState == 4 && xhr.status == 200) {
		var data = xhr.responseText;
		if (data == 'no') {
			alert("평점 저장 실패");
			return;
		}
		alert("평점 저장 성공");
		location.reload();
	}
}

function replyDelete(f) {
	var userIdx = ${ user.userIdx };
	var movieName = "${movieOne.movieName}";
	var replyComment = f.replyComment.value;
	var url = "replyDelete.do";
	var param = "userIdx=" + userIdx + 
				"&movieName=" + movieName + 
				"&replyComment=" + replyComment;
	sendRequest(url, param, replyDeleteResult, "post");
}

function replyDeleteResult() {
	if (xhr.readyState == 4 && xhr.status == 200) {
		var data = xhr.responseText;
		if (data == 'no') {
			alert("평점 삭제 실패");
			return;
		}
		alert("평점 삭제 성공");
		location.reload();
	}
}
	
function scoreInsert(f){
	var userIdx = f.userIdx.value;
	var movieName = f.movieName.value;
	var starScore = f.starScore.value;
	var url = "scoreInsert.do";
	var param = "userIdx=" + userIdx +
				"&movieName=" + movieName +
				"&starScore=" + starScore;
	sendRequest(url, param, scoreInsertResult, "post");
}
function scoreInsertResult(){
	if (xhr.readyState == 4 && xhr.status == 200) {
		var data = xhr.responseText;
		if(data == 'exist'){
			alert("이미 별점을 추가했습니다.");
			return;
		}
		if (data == 'no') {
			alert("별점추가 실패");
			return;
		}
		alert("별점추가 성공");
		location.reload();
	}
}
	
</script>
</html>