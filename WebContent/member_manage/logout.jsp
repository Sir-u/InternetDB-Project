<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
    // 세션 만료
    session.invalidate();

    // 홈페이지로 이동
    response.sendRedirect("/InternetDB-Project/home.jsp");
%>
</body>
</html>