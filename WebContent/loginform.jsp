<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>login</title>
</head>
<body>
<form action="login.jsp" method = "post">
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
		<td> <input type = "submit" value = "로그인"> </td>
		<td> <input type = "reset" value = "취소"> </td>
		</tr>
	</table>
	
</form>
<a href="home.jsp">홈으로</a>

</body>
</html>