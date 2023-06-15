<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.web_project.member.MemberBean" %>
<%@ page import="com.web_project.member.MemberDAO" %>
<%
	request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Update Member</title>
</head>
<body>
    <% 
        // Retrieve the form data
        int stdnum = Integer.parseInt(request.getParameter("stdnum"));
        String passwd = request.getParameter("passwd");
        String usrname = request.getParameter("usrname");
        String gender = request.getParameter("gender");
        String birthday = request.getParameter("birthday");
        int age = Integer.parseInt(request.getParameter("age"));
        String reg_date = request.getParameter("reg_date");
        int authority_level = Integer.parseInt(request.getParameter("authority_level"));

        // Create a new MemberBean object
        MemberBean member = new MemberBean();
        member.setStdnum(stdnum);
        member.setPasswd(passwd);
        member.setUsrname(usrname);
        member.setGender(gender);
        member.setBirthday(birthday);
        member.setAge(age);
        member.setReg_date(reg_date);
        member.setAuthority_level(authority_level);

        // Update the member in the database
        MemberDAO memberDAO = new MemberDAO();
        boolean updated = memberDAO.updateMember(member);

        if (updated) {
    %>
            <script>
                alert("회원정보가 수정되었습니다.");
                location.href = "/InternetDB-Project/mypage.jsp"; // Redirect to the member's page
            </script>
    <%
        } else {
    %>
            <script>
                alert("회원정보 수정에 실패했습니다.");
                history.back(); // Go back to the previous page
            </script>
    <%
        }
    %>
</body>
</html>
