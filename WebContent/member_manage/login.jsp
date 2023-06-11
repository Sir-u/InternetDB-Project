<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="com.web_project.member.LoginBean" %>
<%@ page import="com.web_project.member.MemberDAO" %>

<jsp:useBean id="login" class="com.web_project.member.LoginBean" scope="page" />
<jsp:setProperty name="login" property="*" />

<%
    MemberDAO memberDAO = new MemberDAO();
    int isAuthenticated = memberDAO.authenticateMember(login);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>
</head>
<body>
<%
    if (isAuthenticated == 1) {
    	session.setAttribute("isLoggedIn", true);
        session.setAttribute("id", login.getStdnum());

        response.sendRedirect("/InternetDB-Project/home.jsp"); // 홈으로 리다이렉트
    } else {
        if (isAuthenticated == 0) {
%>
<script>
    alert("비밀번호가 일치하지 않습니다.");
    history.back(); // 이전 페이지로 이동
</script>
<%
        } else if (isAuthenticated == -1) {
%>
<script>
    alert("아이디가 존재하지 않습니다.");
    history.back(); // 이전 페이지로 이동
</script>
<%
        } else {
%>
<script>
    alert("DB 오류가 발생했습니다.");
    history.back(); // 이전 페이지로 이동
</script>
<%
        }
    }
%>

</body>
</html>
