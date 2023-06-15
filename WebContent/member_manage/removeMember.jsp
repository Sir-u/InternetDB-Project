<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="com.web_project.member.LoginBean" %>
<%@ page import="com.web_project.member.MemberDAO" %>

<jsp:useBean id="removeMember" class="com.web_project.member.LoginBean" scope="page" />
<jsp:setProperty name="removeMember" property="*" />

<%
MemberDAO memberDAO = new MemberDAO();
int isRemoved = memberDAO.deleteMember(removeMember);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
    if (isRemoved == 1) {
    	session.invalidate();
%>
<script>
    alert("회원 탈퇴가 성공적으로 이루어졌습니다.");
    location.href = "/InternetDB-Project/home.jsp"; // 홈으로 이동
</script>
<%
    } else {
        if (isRemoved == 0) {
%>
<script>
    alert("비밀번호가 일치하지 않습니다.");
    history.back(); // 이전 페이지로 이동
</script>
<%
        } else if (isRemoved == -2) {
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