<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>welcome</title>
<link rel="stylesheet" href="/project/resources/style/reset.css">
<link rel="stylesheet" href="/project/resources/style/welcome.css">
</head>
<body>
	<div class="welcome_container">
		<div class="welcome_box">
			<div class="text_box">
				<!-- 님 앞에 이름넣기 -->
				<p>${ vo.userNickName }님 가입이 완료되었습니다.</p>
			</div>
			<div class="btn_box">
				<button type="button" onclick="location.href='beforeLogin.do'">메인 페이지로 이동</button>
				<button type="button" onclick="location.href='loginForm.do'">로그인 페이지로 이동</button>
			</div>
		</div>
	
	</div>
</body>
</html>