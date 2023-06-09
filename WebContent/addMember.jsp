<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("utf-8");
%>
<%@ page import="com.web_project.member.MemberBean" %>
<%@ page import="com.web_project.member.MemberDAO" %>

<jsp:useBean id = "member" class = "com.web_project.member.MemberBean" scope = "page"> </jsp:useBean>
<jsp:setProperty name = "member" property = "*"/>

<%
	MemberDAO memberDAO = new MemberDAO();
	memberDAO.insertMember(member);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 페이지</title>
</head>
<body>

<h2>회원가입이 성공.</h2>
<table>

	<tr>
		<td> 학번 </td>
		<td> <%= member.getStdnum() %> </td>
	</tr>

	<tr>
		<td> 비밀번호 </td>
		<td> <%= member.getPasswd() %> </td>
	</tr>

	<tr>
		<td> 이름 </td>
		<td> <%= member.getUsrname() %> </td>
	</tr>

	<tr>
		<td> 성별 </td>
		<td> <%= member.getGender() %> </td>
	</tr>

	<tr>
		<td> 생일 </td>
		<td> <%= member.getBirthday() %> </td>
	</tr>

	<tr>
		<td> 나이 </td>
		<td> <%= member.getAge() %> </td>
	</tr>

	<tr>
		<td> 등록일 </td>
		<td> <%= member.getReg_date() %> </td>
	</tr>
</table>
db 입력 완료
</body>
</html>