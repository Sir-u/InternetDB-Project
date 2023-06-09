<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h2>정말로 회원탈퇴를 바라신다면 id 및 password를 입력해주세요</h2>
<form action="removeMember.jsp" method = "post">
	<table>
		<tr>
		<td> 학번 </td>
		<td> <input type = "number" name = "stdnum" size = "20"> </td>
		</tr>
		
		<tr>
		<td> 비밀번호 </td>
		<td> <input type = "password" name = "passwd" size = "20"> </td>
		</tr>
			
		<tr>
		<td> <input type = "submit" value = "회원탈퇴"> </td>
		<td> <input type = "reset" value = "취소"> </td>
		</tr>
	</table>
	
</form>
<a href="home.jsp">홈으로</a>
</body>
</html>