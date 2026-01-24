<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Document</title>
<style>
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

table {
	border-collapse: collapse;
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
	width: 100%;
}

table {
	width: 80%;
	margin: auto;
}

th {
	background-color: aliceblue;
}

th, td {
	border: 1px solid black;
	text-align: center;
}
</style>
</head>
<body>
	<div class="btn_box">
		<button type="button" onclick="location.href='managerPage.do'">메인으로</button>
	</div>
	<div class="container">
		<table>
			<tr>
				<th>idx</th>
				<th>id</th>
				<th>이름</th>
				<th>닉네임</th>
				<th>핸드폰</th>
				<th>가입날짜</th>
				<th>생년월일</th>
				<th>이메일</th>
				<th>멤버십</th>
			</tr>
			<!-- 내용 foreach문으로 넣기 -->
			<c:forEach var="vo" items="${ list }">
				<tr>
					<td>${ vo.userIdx }</td>
					<td>${ vo.userId }</td>
					<td>${ vo.userName }</td>
					<td>${ vo.userNickName }</td>
					<td>${ vo.userPhoneNum }</td>
					<td>${ vo.userRegDate }</td>
					<td>${ vo.userBirthDate }</td>
					<td>${ vo.userEmail }</td>
					<td>${ vo.userMemberShip }</td>
				</tr>
			</c:forEach>
			
		</table>
	</div>
</body>
</html>