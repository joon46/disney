<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="/project/resources/style/reset.css">
<link rel="stylesheet" href="/project/resources/style/signup.css">
<script src="/project/resources/js/httpRequest.js"></script>
</head>
<body>
    <div class="signup_container">
        <header>
            <div class="gnb">
                <div class="btn_content">
                    
                    <!-- 뒤로가기 버튼 -->
                    <button class="btn" type="button" onclick="location.href='beforeLogin.do'">뒤로가기</button>
                </div>
            </div>
            
        </header>
        <h1>회원가입</h1>
        <div class="input_container">
            <form >
                <div class="input_box">
                    <label>이름</label>
                    <!-- 이름 입력창 -->
                    <div class="box">
                        <input class="input" type="text" name="userName" placeholder="이름 입력" required>
                    </div>
                </div>
                <div class="input_box">
                    <label>아이디</label>
                    <!-- 아이디 입력창 -->
                    <div class="box ol_box">
                        <input class="input" type="text" name="userId"
                        placeholder="아이디 입력" required>
                    </div>
                    <!-- 중복체크 버튼 -->
                    <button class="overlab_btn btn" type="button" onclick="idCheck(this.form);">중복확인</button>
                </div>
                <div class="input_box">
                    <label>비밀번호</label>
                    <!-- 비밀번호 입력창 -->
                    <div class="box">
                        <input class="input pw_input" type="password" name="userPw"
                        placeholder="비밀번호 입력" required>
                    </div>
                </div>
                <div class="input_box">
                    <label>비밀번호 확인</label>
                    <!-- 비밀번호확인 입력창 -->
                    <div class="box">
                        <input class="input" type="password" name="c_pwd"
                        placeholder="비밀번호 확인" required>
                    </div>
                </div>
                <div class="input_box">
                    <label>전화번호</label>
                    <!-- 전화번호 입력창 -->
                    <div class="box">
                        <input class="input" type="tel" name="userPhoneNum"
                        onkeyup="telHyphen(this)" maxlength="13"
                        placeholder="전화번호 입력" required>
                    </div>
                </div>
                <div class="input_box">
                    <label>생년월일</label>
                    <div class="box">
                        <input type="date" class="input" name="userBirthDate">
                    </div>
                  </div>
                <div class="input_box">
                    <label>이메일 주소</label>
                    <input type="hidden" name="userEmail">
                    <!-- 이메일 입력창 -->
                    <div class="box ol_box">
                        <input class="input" id="emailId" type="email" name="usrEmail"
                        placeholder="이메일 입력">
                        <span>@</span>
                        <select class="select_box" name="b_email">
                            <option value="naver.com">naver.com</option>
                            <option value="gmail.com">gmail.com</option>
                            <option value="hanmail.net">hanmail.net</option>
                            <option value="nate.com">nate.com</option>
                            <option value="kakao.com">kakao.com</option>
                        </select>
                    </div>
                    <!-- 중복체크 버튼 -->
                    <button class="overlab_btn btn" type="button" onclick="emailCheck(this.form);">중복확인</button>
                </div>
                <div class="input_box">
                    <label>닉네임</label>
                    <!-- 이름 입력창 -->
                    <div class="box ol_box">
                        <input class="input" type="text" name="userNickName" placeholder="닉네임 입력" required>
                    </div>
                    <!-- 중복체크 버튼 -->
                    <button class="overlab_btn btn" type="button" onclick="nickNameCheck(this.form);">중복확인</button>
                </div>
                    <!-- 회원가입 버튼 -->
                    <button class="signup_btn btn" type="button" onclick="signUp(this.form);">회원가입</button>
            </form>
        </div>
        
    </div>
    
   
</body>
<script>
//아이디 중복체크
var isIdCheck = false;
//이메일 중복체크
var isEmailCheck = false;
//닉네임 중복체크
var isNickNameCheck = false;
//아이디 비번 비밀번호 재입력 다 맞아야 다음으로 넘어감
function signUp(f) {
	var userName = f.userName.value.trim();
	var userId = f.userId.value.trim();
	var userPw = f.userPw.value.trim();
	var c_pwd = f.c_pwd.value.trim();
	var userPhoneNum = f.userPhoneNum.value.trim();
	var userBirthDate = f.userBirthDate.value.trim();
	var usrEmail = f.usrEmail.value.trim();
	var b_email = f.b_email.value;
	var userEmail = f.userEmail;
	if(userName == ''){
		alert("이름은 필수입니다.");
		return;
	}
	if (userId == '') {
		alert("ID는 필수입니다.");
		return;
	}
	if (userPw == '') {
		alert("비밀번호는 필수입니다.");
		return;
	}
	if (userPw != c_pwd) {
		alert("입력하신 비밀번호가 일치하지 않습니다.");
		return;
	}
	if (isIdCheck != true) {
		alert("Id 중복비교 안됨");
		return;
	}
	if (isEmailCheck != true) {
		alert("이메일 중복비교 안됨");
		return;
	}
	if (isNickNameCheck != true) {
		alert("닉네임 중복비교 안됨");
		return;
	}
	userEmail.value = usrEmail + "@" + b_email;
	f.action = "signUp.do";
	f.method = "post";
	f.submit();
}

//id 중복체크
function idCheck(f) {
	var userId = f.userId.value.trim();
	if (userId == '') {
		alert("아이디를 입력해주세요");
		return;
	}
	var url = "userIdCheck.do";
	var param = "userId=" + userId;
	sendRequest(url, param, userIdCheckResult, "post");
}

function userIdCheckResult() {
	if (xhr.readyState == 4 && xhr.status == 200) {
		var data = xhr.responseText;
		if (data == "no") {
			alert('아이디 중복');
			return;
		} else {
			alert('사용가능한 아이디');
			isIdCheck = true;
		}
	}
}

//이메일 중복비교
function emailCheck(f) {
	var Email = f.usrEmail.value;
	if (Email == '') {
		alert("이메일을 입력해주세요.");
		return;
	}
	var b_email = f.b_email.value;
	var userEmail = Email + "@" + b_email;
	var url = "userEmailCheck.do";
	var param = "userEmail=" + userEmail;
	sendRequest(url, param, userEmailCheckResult, "post");
}

function userEmailCheckResult() {
	if (xhr.readyState == 4 && xhr.status == 200) {
		var data = xhr.responseText;
		if (data == "no") {
			alert("이메일 중복");
			return;
		} else {
			alert("사용가능한 이메일 입니다.");
			isEmailCheck = true;
		}
	}
}

//닉네임 중복 비교
function nickNameCheck(f) {
	var userNickName = f.userNickName.value;
	var url = "userNickNameCheck.do";
	var param = "userNickName=" + userNickName;
	sendRequest(url, param, userNickNameCheckResult, "post");
}

function userNickNameCheckResult() {
	if (xhr.readyState == 4 && xhr.status == 200) {
		var data = xhr.responseText;
		if (data == "no") {
			alert("닉네임 중복");
			return;
		} else {
			alert("사용가능한 닉네임 입니다.");
			isNickNameCheck = true;
		}
	}
}

//핸드폰 번호 스크립트
function telHyphen(str) {
	var num = str.value.replace(/[^0-9]/g, "");
	var phone = "";
	if (num.length < 4) {
		return num;
	} else if (num.length < 7) {
		phone += num.substr(0, 3);
		phone += "-";
		phone += num.substr(3);
	} else if (num.length < 11) {
		phone += num.substr(0, 3);
		phone += "-";
		phone += num.substr(3, 3);
		phone += "-";
		phone += num.substr(6);
	} else {
		phone += num.substr(0, 3);
		phone += "-";
		phone += num.substr(3, 4);
		phone += "-";
		phone += num.substr(7);
	}
	str.value = phone;
}
</script>
</html>