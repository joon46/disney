<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>영화추가 페이지</title>
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
            width: 800px;
            margin: auto;
            background-color: aliceblue;
            display: flex;
            justify-content: center;
        }
        table{
            width:100%;

        }
        td{
            border: 1px solid black;
            text-align: center;

        }
        input{
            width: 300px;
            margin: 10px;
            padding: 5px;
        }
        textarea{
            width: 300px;
            padding: 5px;
        }
        button{
            width: 150px;
            height: 40px;
        }
</style>
<script src="/project/resources/js/httpRequest.js"></script>
</head>
<body>
	<div class="btn_box">
		<button type="button" onclick="location.href='managerPage.do'">메인으로</button>
	</div>
	<form method="post" enctype="multipart/form-data">
		<div class="container">
			<table>
				<tr>
					<td>영화제목</td>
					<td><input type="text" name="movieName"></td>
				</tr>
				<tr>
					<td>영화주소</td>
					<td><input type="text" name="movieUrl"></td>
				</tr>
				<tr>
					<td>영화 심의 등급</td>
					<td><input type="text" name="movieClass"></td>
				</tr>
				<tr>
					<td>영화 줄거리</td>
					<td><textarea name="movieStory" id="" cols="30" rows="10"></textarea></td>
				</tr>
				<tr>
					<td>영화 개봉 날짜</td>
					<td><input type="date" name="movieLaunchDate"></td>
				</tr>
				<tr>
					<td>영화 장르</td>
					<td><input type="text" name="movieGenre"></td>
				</tr>
				<tr>
					<td>영화 배우</td>
					<td><textarea name="actors" id="" cols="30" rows="10"></textarea></td>
				</tr>
				<tr>
	                <td>영화 포스터</td>
	                <td><input type="file" name="photo"></td>
            	</tr>
				<tr>
					<td colspan="2"><button type="button" onclick="movieInsert(this.form);">추가</button></td>
				</tr>
			</table>
		</div>
	</form>
	<script>
	function movieInsert(f){
		var movieName = f.movieName.value;
		var movieUrl = f.movieUrl.value;
		var movieClass = f.movieClass.value;
		var movieStory = f.movieStory.value;
		var movieLaunchDate = f.movieLaunchDate.value;
		var movieGenre = f.movieGenre.value;
		
		var url = "movieInsert.do";
		var param = "movieName=" + movieName +
					"&movieUrl=" + movieUrl +
					"&movieClass=" + movieClass +
					"&movieStory=" + movieStory +
					"&movieLaunchDate=" + movieLaunchDate +
					"&movieGenre=" + movieGenre;
		sendRequest(url, param, resultFn, "post");
		
		//영화배우 넘겨주는 파라미터
		var actors = f.actors.value;
		//액터 배열로 넘김
		var actor = actors.split(',');
		actorNum = actor.length;
		
		var urll = "actorInsert.do";
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
				alert("영화 추가 실패");
				return;
			}
			alert("영화 추가 성공");
		}
	}
	
	function result(){
		if (xhr.readyState == 4 && xhr.status == 200) {
			var data = xhr.responseText;
			if(data == 'no'){
				alert("배우 추가 실패");
				return;
			}
		}
	}
	
	function resultSet(){
		alert("배우 추가 성공");
		location.href = "managerPage.do";	
	}
	
	</script>
</body>
</html>