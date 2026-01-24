<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="/project/resources/style/reset.css">
<link rel="stylesheet" href="/project/resources/style/login.css">
<script src="/project/resources/js/httpRequest.js"></script>
<!-- 1. 카카오SDK로드 -->
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.2.js" charset="utf-8"></script>

</head>
<body>
    <div class="login_container">
        <div class="input_container">
            <form>
                <div class="input_box">
                    <label >아이디</label>
                    <!-- 아이디 입력창 -->
                    <input class="input" type="text" name="userId"
                    placeholder="아이디 입력">
                </div>
                <div class="input_box">
                    <label >비밀번호</label>
                    <!-- 비밀번호 입력창 -->
                    <input class="input" type="text" name="userPw"
                    placeholder="비밀번호 입력">
                </div>
                
                <div class="input_box">
                    <!-- 카카오 로그인 버튼 -->
                    <button class="signin_btn btn" id="kakao" type="button" onclick="loginWithKakao();">
                        <img src="//k.kakaocdn.net/14/dn/btqCn0WEmI3/nijroPfbpCa4at5EIsjyf0/o.jpg" width="223" />
                    </button>
                </div>
                <div class="input_box" id="naverIdLogin">
                    <!-- 네이버 로그인 버튼 -->
                    <button class="signin_btn btn" id="naver" type="button" onclick="">
                        <img width="223" src="https://developers.naver.com/doc/review_201802/CK_bEFnWMeEBjXpQ5o8N_20180202_7aot50.png"/>
                    </button>
                </div>
                
                <div class="input_box">
                    <!-- 아이디 비번찾기 버튼 -->
                    <button class="login_btn btn" type="button" onclick="login(this.form);">로그인</button>
                    <button class="cancel_btn btn" type="button" onclick="location.href='beforeLogin.do'">취소</button>
                </div>
            </form>
        </div>
    </div>
</body>
<script>
function login(f) {
    var userId = f.userId.value;
    var userPw = f.userPw.value;
    if (userId == '') {
        alert("ID는 필수입니다.");
        return;
    }
    if (userPw == '') {
        alert("비밀번호는 필수입니다.");
        return;
    }

    var url = "login.do";
    var param = "userId=" + userId + "&userPw=" + userPw;
    sendRequest(url, param, loginResult, "post");
}
function loginResult() {
    if (xhr.readyState == 4 && xhr.status == 200) {
        var data = xhr.responseText;
        if (data == 'no') {
            alert('id가 일치하지 않습니다');
            return;
        } else if (data == 'idOk') {
            alert('비밀번호가 일치하지 않습니다');
            return;
        } else if(data == 'manager'){
            alert("관리자");
            location.href = "managerPage.do";
        } else {
            alert('로그인 성공');
            location.href = "afterLogin.do";
        }
    }
}    
    
//카카오
// 2. 카카오 초기화
Kakao.init('0942662a60138d6b23579d0eb15a2657');
//console.log( Kakao.isInitialized() ); // 초기화 판단여부
// 3. 데모버전으로 들어가서 카카오로그인 코드를 확인.
function loginWithKakao() {
    Kakao.Auth.login({
        success: function (authObj) {
            //console.log(authObj); // access토큰 값
            Kakao.Auth.setAccessToken(authObj.access_token); // access토큰값 저장
            getInfo();
        }, fail: function (err) {
            console.log(err);
        }
    });
}

//카카오 이메일
var emial;

// 4. 엑세스 토큰을 발급받고, 아래 함수를 호출시켜서 사용자 정보를 받아옴.
function getInfo() {
    Kakao.API.request({
    	url: '/v2/user/me',
    	success: function (res) {
        //console.log(res);
        // 이메일, 성별, 닉네임, 프로필이미지
	        email = res.kakao_account.email;
	        var gender = res.kakao_account.gender;
	        var nickname = res.kakao_account.profile.nickname;
	        var profile_image = res.kakao_account.profile.thumbnail_image_url;
	        var birthday = res.kakao_account.birthday;
	        var phone_number = res.kakao_account.phone_number;
	        kakaoLogin();        
		}, fail: function (error) {
	            alert('카카오 로그인에 실패했습니다. 관리자에게 문의하세요.' + JSON.stringify(error));
	    }
    });
}
//카카오 로그인
function kakaoLogin(){
   var url = "kakaoLogin.do";
   var param = "userEmail=" + email;
   sendRequest(url, param, kakaoLoginResult, "post");
}
function kakaoLoginResult(){
    if(xhr.readyState == 4 && xhr.status == 200){
    	var data = xhr.responseText;
        if(data == "no"){
        	alert("카카오 로그인 실패");
            return;
        }
        else {
        	alert("카카오 로그인 성공");
            location.href = 'afterLogin.do';
        }
    }
}

//네이버 로그인
const naverLogin = new naver.LoginWithNaverId(
	{
    clientId: "Yn0lLOYBMyxzLqiDaCYF",
    callbackUrl: "http://localhost:9090/project/loginForm.do",
    loginButton: {color: "green", type: 3, height: 48}
    }
);
naverLogin.init();
naverLogin.getLoginStatus(function (status) {
	if (status) {
		const nickName=naverLogin.user.getNickName();
		var birthYear = naverLogin.user.getBirthyear();
		const birthday=naverLogin.user.getBirthday();
		var userBirthDate = birthYear + '-' + birthday;
		var userEmail = naverLogin.user.getEmail();     
		var mobile = naverLogin.user.getMobile();
		if(nickName===null||nickName===undefined ){
			alert("별명이 필요합니다. 정보제공을 동의해주세요.");
			naverLogin.reprompt();
            return ;  
       	} else {
			var url = "naverLogin.do";
			var param = "userBirthYear=" + userBirthDate + 
						"&userEmail=" + userEmail + 
						"&userPhoenNum=" + mobile;
			sendRequest(url, param, naverLoginResult, "post");
        }
    }
    naverLogin.logout();
});
//console.log(naverLogin);
function naverLoginResult(){
	if (xhr.readyState == 4 && xhr.status == 200) {
		var data = xhr.responseText;
		if(data == "no"){
			alert("네이버 로그인 실패");
			return;
		} else {
			alert("네이버 로그인 성공");
			location.href = 'afterLogin.do';
		}
	}
}
    
</script>
</html>