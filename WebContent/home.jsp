<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Home</title>
</head>
<body>
    <% if (session.getAttribute("isLoggedIn") != null) {
    	Integer id = (Integer) session.getAttribute("id");
    %>
        <h1><%= id %> 님, 안녕하세요!</h1>
        <a href="logout.jsp">로그아웃</a>
        <a href="removeMemberform.jsp">회원탈퇴</a>
    <% } else { %>
        <h1>홈 페이지</h1>
        <a href="loginform.jsp">로그인</a>
        <a href="addMemberform.jsp">회원가입</a>
    <% } %>

</body>
</html>
