<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>마이페이지</title>
    <link rel="stylesheet" href="/project/resources/style/reset.css">
    <link rel="stylesheet" href="/project/resources/style/mypage.css">
<script src="/project/resources/js/httpRequest.js"></script>
</head>
<body>
    <!-- 전화번호 script -->
    
    <header>
        <div class="gnb">
            <div class="btn_content">
                <!-- 로그인 버튼 -->
                <button class="btn" type="button" onclick="logout();">로그아웃</button>
                <!-- 회원가입 버튼 -->
                <button class="btn" type="button" onclick="location.href='afterLogin.do'">메인으로</button>
            </div>
        </div>
        
    </header>
    <div class="mypage_container">
    <form>
        <div class="tab_box">
            <ul class="tabs">
                <li>
                    <input type="radio" checked name="tabmenu" id="tabmenu1">
                    <label for="tabmenu1">비밀번호 변경</label>
                    <div class="tab_content" >
                        <h2 class="pwLabel">비밀번호 변경</h2>
                        <div class="input_box">
                            <label>비밀번호</label>
                            <!-- 비밀번호 입력창 -->
                            <div class="box">
                                <input class="input" type="password"  placeholder="비밀번호 입력" name="pw" required>
                            </div>
                        </div>
                        <div class="input_box">
                            <label>비밀번호 확인</label>
                            <!-- 비밀번호확인 입력창 -->
                            <div class="box">
                                <input class="input" type="password" placeholder="비밀번호 확인" name="c_pw" required>
                            </div>
                        </div>
                        <button class="btn" onclick="upDatePwd(this.form);">변경</button>
                    </div>
                </li>
                <li>
                    <input type="radio" checked name="tabmenu" id="tabmenu2">
                    <label for="tabmenu2">닉네임 변경</label>
                    <div class="tab_content" >
                        <h2>닉네임 변경</h2>
                        <div class="input_box">
                            <label>닉네임</label>
                            <!-- 닉네임 입력창 -->
                            <div class="box ol_box">
                                <input class="input" type="text" name="name" placeholder="닉네임 입력" required>
                            </div>
                            <!-- 중복체크 버튼 -->
                            <button class="overlab_btn btn" type="button" onclick="equalsNickName(this.form);">중복확인</button>
                        </div>
                        <button class="btn"onclick="upDateNickName(this.form);">변경</button>
                    </div>
                </li>
                <li><input type="radio" checked name="tabmenu" id="tabmenu3">
                    <label for="tabmenu3">찜 목록</label>
                    <div class="tab_content" >
                        <h2>찜 목록</h2>
                        <!-- 찜목록 -->
                        <table class="wish_list">
                            <tr>
                                <th>제목</th>
                                <th>찜취소</th>
                            </tr>
                            <c:forEach var="selectVo" items="${ list }" >
                            	<form>
									<tr>
										<td>
											${ selectVo.movieName }
											<input type="hidden" name="selectMovieName" value="${ selectVo.movieName }">
											<input type="hidden" name="selectUserIdx" value="${ selectVo.userIdx }">
										</td>	
										<td><button type="button" class="btn" onclick="selectDel(this.form);">찜취소</button></td>
									</tr>
								</form>
							</c:forEach>
                        </table>
                    </div></li>
                <li><input type="radio" checked name="tabmenu" id="tabmenu4">
                    <label for="tabmenu4">이메일 변경</label>
                    <div class="tab_content" >
                        <h2>이메일 변경</h2>
                        <div class="input_box">
                            <label>이메일 주소</label>
                            <div class="email_box">
                                <!-- 이메일 입력창 -->
                                <input class="input" id="emailId" type="email" name="eMail"
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
                            <button class="overlab_btn btn" type="button" onclick="equalsEmail(this.form);">중복확인</button>
                        </div>
                        <button class="btn" onclick="upDateEmail(this.form);">변경</button>
                    </div></li>
                <li><input type="radio" checked name="tabmenu" id="tabmenu5">
                    <label for="tabmenu5">전화 번호 변경</label>
                    <div class="tab_content" >
                        <h2>전화 번호 변경</h2>
                        <div class="input_box">
                            <label>전화번호</label>
                            <div class="box">
                                <!-- 전화번호 입력창 -->
                                <input class="input" type="tel" name="phoneNum"
                                onkeyup="telHyphen(this)" maxlength="13"
                                placeholder="전화번호 입력" required>
                            </div>
                            <!-- 중복체크 버튼 -->
                            <button class="overlab_btn btn" type="button" onclick="equalsNum(this.form);">중복확인</button>
                        </div>
                        <button class="btn" onclick="upDatePhoneNum(this.form);">변경</button>
                    </div></li>
            </ul>
        </div>
    </div>
    </form>
</body>
<script>
    function telHyphen(str) {
        var num = str.value.replace(/[^0-9]/g,"");
        var phone = "";

        if(num.length<4){
            return num;
        }else if(num.length < 7){
            phone += num.substr(0, 3);
            phone +="-";
            phone += num.substr(3);
        }else if(num.length<11){
            phone += num.substr(0,3);
            phone += "-";
            phone += num.substr(3,3);
            phone += "-";
            phone += num.substr(6);
        }else{
            phone += num.substr(0,3);
            phone += "-";
            phone += num.substr(3,4);
            phone += "-";
            phone += num.substr(7);
        }

        str.value = phone;
      }
</script>
<script>
function upDatePwd(f) {
	var userPw = f.pw.value;
	var c_pw = f.c_pw.value;
	if (userPw == '') {
		alert('비밀번호를 입력해 주세요.');
		return;
	}
	if (userPw != c_pw) {
		alert('입력한 비밀번호가 서로 다릅니다.');
		return;
	}
	var url = "pwdupdate.do";
	var param = "userPw=" + userPw;
	sendRequest(url, param, pwdupdateResult, 'post');
}
function pwdupdateResult() {
	if (xhr.readyState == 4 && xhr.status == 200) {
		var data = xhr.responseText;
		if (data == "no") {
			alert('비밀번호 변경 실패');
			return;
		} else {
			alert('비밀번호 변경 성공');
		}
	}
}
//중복 비교 변수
var nickNameCheck = false;
function equalsNickName(f) {
	var userNickName = f.name.value;
	if (userNickName == '') {
		alert('닉네임을 입력해주세요.');
		return;
	}
	var url = "userNickNameCheck.do";
	var param = "userNickName=" + userNickName;
	sendRequest(url, param, userNickNameCheckResult, 'post');
}
function userNickNameCheckResult() {
	if (xhr.readyState == 4 && xhr.status == 200) {
		var data = xhr.responseText;
		if (data == "no") {
			alert('닉네임이 이미 사용중입니다.');
			return;
		} else {
			alert('닉네임 사용가능.');
			nickNameCheck = true;
			return;
		}
	}
}
function upDateNickName(f) {
	var userNickName = f.name.value;
	if (userNickName == '') {
		alert('닉네임을 입력해주세요.');
		return;
	}
	if (nickNameCheck == false) {
		alert('닉네임 중복체크를 해주세요');
		return;
	}
	var url = "userNickNameUpDate.do";
	var param = "userNickName=" + userNickName;
	sendRequest(url, param, userNickNameUpDateResult, 'post');
}
function userNickNameUpDateResult() {
	if (xhr.readyState == 4 && xhr.status == 200) {
		var data = xhr.responseText;
		if (data == "no") {
			alert('닉네임 변경실패');
			return;
		} else {
			alert('닉네임 변경성공');
		}
	}
}
//이메일 체크
var emailCheck = false;
function equalsEmail(f) {
	var Email = f.eMail.value;
	var b_email = f.b_email.value;
	if (Email == '') {
		alert('이메일을 입력해주세요.');
		return;
	}
	var userEmail = Email + "@" + b_email;
	var url = "userEmailCheck.do";
	var param = "userEmail=" + userEmail;
	sendRequest(url, param, userEmailCheckResult, "post")
}
function userEmailCheckResult() {
	if (xhr.readyState == 4 && xhr.status == 200) {
		var data = xhr.responseText;
		if (data == "no") {
			alert("이메일 중복");
			return;
		} else {
			alert("사용가능한 이메일 입니다.");
			emailCheck = true;
		}
	}
}

function upDateEmail(f) {
	var email = f.eMail.value;
	var b_email = f.b_email.value;
	if (email == '') {
		alert("이메일을 입력해주세요.");
		return;
	}
	if (emailCheck == false) {
		alert("이메일 중복체크를 해주세요");
		return;
	}
	var userEmail = email + "@" + b_email;
	var url = "userEmailUpDate.do";
	var param = "userEmail=" + userEmail;
	sendRequest(url, param, userEmailUpDateResult, "post");
}
function userEmailUpDateResult() {
	if (xhr.readyState == 4 && xhr.status == 200) {
		var data = xhr.responseText;
		if (data == "no") {
			alert('이메일 변경실패');
			return;
		} else {
			alert('이메일 변경성공');
		}
	}
}
//핸드폰번호
var phoneNumCheck = false;
function equalsNum(f) {
	var phoneNum = f.phoneNum.value;
	if (phoneNum == '') {
		alert('핸드폰번호를 입력해주세요.');
		return;
	}
	var url = "userPhoneNumCheck.do";
	var param = "userPhoneNum=" + phoneNum;
	sendRequest(url, param, userPhoneNumCheckResult, "post")
}
function userPhoneNumCheckResult() {
	if (xhr.readyState == 4 && xhr.status == 200) {
		var data = xhr.responseText;
		if (data == "no") {
			alert("핸드폰번호 중복");
			return;
		} else {
			alert("사용가능한 번호 입니다.");
			phoneNumCheck = true;
		}
	}
}
function upDatePhoneNum(f) {
var userPhoneNum = f.phoneNum.value;
	if (userPhoneNum == '') {
		alert('전화번호 입력을 해주세요');
		return;
	}
	if (phoneNumCheck == false) {
		alert("전화번호 중복체크를 해주세요");
		return;
	}
	var url = "userPhoneNumUpDate.do";
	var param = "userPhoneNum=" + userPhoneNum;
	sendRequest(url, param, userPhoneNumUpDateResult, "post");
}
function userPhoneNumUpDateResult() {
	if (xhr.readyState == 4 && xhr.status == 200) {
		var data = xhr.responseText;
		if (data == "no") {
			alert('전화번호 변경실패');
			return;
		} else {
			alert('전화번호 변경성공');
		}
	}
}
    
//찜 삭제
function selectDel(f){
	var movieName = f.selectMovieName.value;
	var userIdx = f.selectUserIdx.value;
	var url = "userSelectDelete.do";
	var param = "movieName=" + movieName + "&userIdx=" + userIdx;;
	sendRequest(url, param, userSelectDeleteResult, "post");
}
function userSelectDeleteResult(){
	if (xhr.readyState == 4 && xhr.status == 200) {
		var data = xhr.responseText;
		if (data == "no") {
			alert('찜목록 삭제실패');
			return;
		} else {
			alert('찜목록 삭제성공');
			location.reload();
		}
	}
}
    
//로그아웃
function logout() {
	var url = "sessionDrop.do";
	var param = "";
	sendRequest(url, param, result, "post");
}
function result(){
	if (xhr.readyState == 4 && xhr.status == 200) {
		var data = xhr.responseText;
		if(data == "no"){
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