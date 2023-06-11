<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.web_project.member.MemberBean" %>
<%@ page import="com.web_project.member.MemberDAO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Member Information</title>
</head>
<body>
<% 
    Integer stdnum = (Integer) session.getAttribute("id");
    if (stdnum != null) {
        // 로그인된 상태
%>
    <table border="1">
        <thead>
            <tr>
                <th>학번</th>
                <th>이름</th>
                <th>성별</th>
                <th>생일</th>
                <th>나이</th>
                <th>가입일</th>
            </tr>
        </thead>
        <tbody>
            <%  
                MemberDAO memberDAO = new MemberDAO();
                MemberBean member = memberDAO.getMemberByStdnum(stdnum);
				
                //해당 멤버에 대한 정보가 DB에 있을 때
                if (member != null) {
            %>
            <tr>
                <td><%= member.getStdnum() %></td>
                <td><%= member.getUsrname() %></td>
                <td><%= member.getGender() %></td>
                <td><%= member.getBirthday() %></td>
                <td><%= member.getAge() %></td>
                <td><%= member.getReg_date() %></td>
            </tr>
            <%  //해당 멤버에 대한 정보가 DB에 없을 때(session인증을 하고 들어오는 것이기 때문에 앵간하면 있을 것이지만 예외처리로 넣었습니다.) 
                } else {
            %>
            <tr>
                <td colspan="7">No member found.</td>
            </tr>
            <%  
                }
            %>
<%
    } else {
        // 로그인되지 않은 상태
%>
        <script>
            alert("로그인이 필요합니다.");
            location.href = "/InternetDB-Project/home.jsp"; // 홈 페이지로 이동
        </script>
<%
    }
%>
        </tbody>
    </table>
    
    <a href="/InternetDB-Project/member_manage/updateMemberform.jsp">회원 정보 수정</a>
</body>
</html>
