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

<h2>회원가입 성공.</h2>
<script>
    alert("회원 가입이 성공적으로 이루어졌습니다.");
    location.href = "/InternetDB-Project/home.jsp"; // 홈으로 이동
</script>

</body>
</html>