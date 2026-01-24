<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
table {
	border-collapse: collapse;
}
				
.list {
	width: 100%;
}	
					
table {
	width: 80%;
	margin: auto;
}	

th, td {
	border: 1px solid black;
	text-align: center;
}
</style>
<body>
	<table border="1" align="center">
		<tr>
			<th>movieIdx</th>
			<th>영화제목</th>
			<th>개봉일자</th>
			<th>장르</th>
			<th>영화 연령대</th>
			<th>정보 수정</th>
		</tr>
		<c:forEach var="list" items="${ movieList }">
			<form>
				<tr>
					<td >
						${ list.movieIdx }
						<input type="hidden" name="movieIdx" value="${ list.movieIdx }">
					</td>
					<td>
						${ list.movieName }
						<input type="hidden" name="movieName" value="${ list.movieName }">
					</td>
					<td>
						${ list.movieLaunchDate }
						<input type="hidden" name="movieLaunchDate" value="${ list.movieLaunchDate }">
					</td>
					<td>
						${ list.movieGenre }
						<input type="hidden" name="movieGenre" value="${ list.movieGenre }">
					</td>
					<td>
						${ list.movieClass }
						<input type="hidden" name="movieClass" value="${ list.movieClass }">
						<input type="hidden" name="movieUrl" value="${ list.movieUrl }">
						<input type="hidden" name="movieStory" value="${ list.movieStory }">
					</td>
					<td><input type="button" value="수정" onclick="movieUpDate(this.form)"></td>
				</tr>
			</form>
		</c:forEach>
	</table>
	
	
	
	
	
	
	
	
	
</body>
<script>
	function movieUpDate(f){
		var movieIdx = f.movieIdx.value;
		var movieName = f.movieName.value;
		var movieLaunchDate = f.movieLaunchDate.value;
		var movieGenre = f.movieGenre.value;
		var movieClass = f.movieClass.value;
		var movieUrl = f.movieUrl.value;
		var movieStory = f.movieStory.value;
		
		f.action = "movieUpDate.do";
		f.method = "post";
		f.submit();
		
	}
</script>
</html>