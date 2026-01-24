<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>관리자 메인 페이지</title>
    <style>
        *{ 
            margin:0; padding:0; 
            box-sizing: border-box;
        }
        table{
                border-collapse: collapse;
        }
        a:link,
        a:active,
        a:visited { text-decoration: none; color:inherit;  }
        a:hover{ color:inherit; text-decoration: underline;}

        li{ list-style-type:none; }

        body{ color:#666; }

        .clearFix::after{ 
        content:''; display:block; clear:both;
        }

        .flex{
            display: flex; 
            justify-content: center;
            align-items: center;
        }

        .span{ display: block;
            width:100%; height: 100%;
            background-color: skyblue;
        }

        .btn_box{
            height: 100px;
            display: flex;
            justify-content: flex-end;
        }
        .btn_box>button{
            width: 100px;
            height: 40px;
            margin: 10px;
        }

        .container{
            background-color: aliceblue;
            width: 800px;
            height: 600px;
            margin:auto;
            display: flex;
            flex-wrap: wrap;
        }
        .container>div{
            width: 400px;
            height: 300px;
            border: 1px solid black;
        }
        .container>div>button{
            width:100%;
            height: 100%;
        }
    </style>
<script src="/project/resources/js/httpRequest.js"></script>
</head>
<body>
    <div class="btn_box">
        <button type="button" >메인으로</button>
    </div>
    <div class="container">
        <div class="insert_movie">
            <button type="button" value="a" onclick="result(value);">영화 추가</button>
        </div>
        <div class="update_movie">
            <button type="button" value="b" onclick="result(value);">영화 편집</button>
        </div>
        <div class="select_users">
            <button type="button" value="c" onclick="result(value);">사용자 정보보기</button>
        </div>
        <div class="logout">
            <button type="button" value="d" onclick="result(value);">로그아웃</button>
        </div>
    </div>
    
</body>
<script>
function result(v){
    switch(v){
    case 'a' :
    	location.href = "movieInsertForm.do";
    	break;
    case 'b' :
    	location.href = "movieUpDateForm.do";
    	break;
    case 'c' :
    	location.href = "userAboutForm.do";
    	break;
    case 'd' :
    	logout();
    	break;
    }
}
//로그아웃
function logout() {
    var url = "sessionDrop.do";
    var param = "";
    sendRequest(url, null, res, "post");
    //location.href="sessionDrop.do";
}
function res(){
	if (xhr.readyState == 4 && xhr.status == 200) {
    	var data = xhr.responseText;
    	if(data == "no"){
    		alert("세션 삭제 실패");
       		return;
       	}
       	else {
       		alert("세션 삭제 성공");
       		location.href = 'beforeLogin.do';
       	}
    }
}
</script>
</html>