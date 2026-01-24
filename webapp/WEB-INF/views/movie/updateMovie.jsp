<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>영화편집 페이지</title>
<style>
@charset "utf-8";

* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

a:link, a:active, a:visited {
	text-decoration: none;
	color: inherit;
}

a:hover {
	color: inherit;
	text-decoration: underline;
}

li {
	list-style-type: none;
}

body {
	color: #666;
}

.clearFix::after {
	content: '';
	display: block;
	clear: both;
}

.flex {
	display: flex;
	justify-content: center;
	align-items: center;
}

.span {
	display: block;
	width: 100%;
	height: 100%;
	background-color: skyblue;
}
</style>
<style>
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

table {
	border-collapse: collapse;
}

a:link, a:active, a:visited {
	text-decoration: none;
	color: inherit;
}

a:hover {
	color: inherit;
	text-decoration: underline;
}

li {
	list-style-type: none;
}

body {
	color: #666;
}

.clearFix::after {
	content: '';
	display: block;
	clear: both;
}

.flex {
	display: flex;
	justify-content: center;
	align-items: center;
}

.span {
	display: block;
	width: 100%;
	height: 100%;
	background-color: skyblue;
}

.btn_box {
	height: 100px;
	display: flex;
	justify-content: flex-end;
}

.btn_box>button {
	width: 100px;
	height: 40px;
	margin: 10px;
}

.container {
	width: 800px;
	height: 600px;
	margin: auto;
	background-color: aliceblue;
	display: flex;
	justify-content: center;
}

td {
	border: 1px solid black;
	text-align: center;
}

.ftd, .ltd {
	border: none;
}

button {
	width: 150px;
	height: 40px;
}
</style>
</head>
<script src="/project/resources/js/httpRequest.js"></script>
<body>
	<div class="btn_box">
		<button type="button" onclick="location.href='managerPage.do'">메인으로</button>
	</div>
	<div class="container">
	<form>
		<table>
			<tr>
				<td class="ftd" colspan="2"><button type="button" onclick="movieDelete(this.form);">삭제</button></td>
			</tr>
			<tr>
				<td>영화제목</td>
				<td><input type="text" name="movieName" value="${ movie.movieName }"></td>
				<input type="hidden" name="movieIdx" value="${ movie.movieIdx }">
			</tr>
			<tr>
				<td>영화주소</td>
				<td><input type="text" name="movieUrl" value="${ movie.movieUrl }"></td>
			</tr>
			<tr>
				<td>영화 심의 등급</td>
				<td><input type="text" name="movieClass" value="${ movie.movieClass }"></td>
			</tr>
			<tr>
				<td>영화 줄거리</td>
				<td><textarea name="movieStory" id="" cols="30" rows="10">${ movie.movieStory }</textarea></td>
			</tr>
			<tr>
				<td>영화 개봉 날짜</td>
				<td><input type="date" name="movieLaunchDate" value="${ movie.movieLaunchDate }"></td>
			</tr>
			<tr>
				<td>영화 장르</td>
				<td><input type="text" name="movieGenre" value="${ movie.movieGenre }"></td>
			</tr>
			<tr>
				<td>영화 배우</td>
				<td>
					<textarea name="actors" id="" cols="30" rows="10"><c:forEach var="list" items="${ actorList }">${ list.actorName },</c:forEach></textarea>
				</td>
			</tr>
			<tr>
				<td class="ltd" colspan="2"><button type="button" onclick="movieUpDate(this.form);">변경</button></td>
			</tr>
		</table>
	</form>
	</div>
</body>
<script>
function movieUpDate(f){
	var movieIdx = f.movieIdx.value;
	var movieName = f.movieName.value;
	var movieUrl = f.movieUrl.value;
	var movieClass = f.movieClass.value;
	var movieStory = f.movieStory.value;
	var movieLaunchDate = f.movieLaunchDate.value;
	var movieGenre = f.movieGenre.value;
	
	var url = "movieUpDateMethod.do";
	var param = "movieIdx=" + movieIdx +
				"&movieName=" + movieName +
				"&movieUrl=" + movieUrl +
				"&movieClass=" + movieClass +
				"&movieStory=" + movieStory +
				"&movieLaunchDate=" + movieLaunchDate +
				"&movieGenre=" + movieGenre;
	sendRequest(url, param, resultFn, "post");
	
	var urlll = "actorDelete.do";
	var pa = "movieName=" + movieName;
	sendRequest(urlll, pa, actorDeleteResult, "post");
	//영화배우 넘겨주는 파라미터
	var actors = f.actors.value;
	//액터 배열로 넘김
	var actor = actors.split(',');
	actorNum = actor.length;
	
	var urll = "actorUpDate.do";
	for(var i = 0; i < actor.length; i++){
		var par = "movieName=" + movieName +
				  "&actorName=" + actor[i];
		sendRequest(urll, par, result, "post");
	}
	resultSet();
}

function resultFn() {
	if (xhr.readyState == 4 && xhr.status == 200) {
		var data = xhr.responseText;
		if(data == 'no'){
			alert("영화 수정 실패");
			return;
		}
		alert("영화 수정 성공");
	}
}

function actorDeleteResult(){
	if (xhr.readyState == 4 && xhr.status == 200) {
		var data = xhr.responseText;
		if(data == 'no'){
			alert("배우 삭제 실패");
			return;
		}
	}
}

function result(){
	if (xhr.readyState == 4 && xhr.status == 200) {
		var data = xhr.responseText;
		if(data == 'no'){
			alert("배우 수정 실패");
			return;
		}
	}
}

function resultSet(){
	alert("배우 수정 성공");
	location.href = "managerPage.do";	
}

function movieDelete(f){
	var movieName = f.movieName.value;
	var movieUrl = f.movieUrl.value;
	var movieClass = f.movieClass.value;
	var movieStory = f.movieStory.value;
	var movieLaunchDate = f.movieLaunchDate.value;
	var movieGenre = f.movieGenre.value;
	
	var url = "movieDelete.do";
	var param = "movieName=" + movieName +
				"&movieUrl=" + movieUrl +
				"&movieClass=" + movieClass +
				"&movieStory=" + movieStory +
				"&movieLaunchDate=" + movieLaunchDate +
				"&movieGenre=" + movieGenre;
	sendRequest(url, param, movieDeleteResult, "post");
}

function movieDeleteResult(){
	if (xhr.readyState == 4 && xhr.status == 200) {
		var data = xhr.responseText;
		if(data == 'no'){
			alert("영화 삭제 실패");
			return;
		}
		alert("영화 삭제 성공");
	}
}

</script>
</html>