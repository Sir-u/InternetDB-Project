<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.web_project.member.MemberBean" %>
<%@ page import="com.web_project.member.MemberDAO" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Member Information</title>
	<link rel="stylesheet" href="/InternetDB-Project/style/style.css" type="text/css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://getbootstrap.com/docs/5.3/assets/css/docs.css" rel="stylesheet">
</head>
<body>
	<header>
    <h1 style="font-size: 36px;">동아리명</h1>
    <div>
        <% if (session.getAttribute("isLoggedIn") != null) {
            String usrname = (String) session.getAttribute("usrname");
        %>
            <%= usrname %> 님, 안녕하세요!
            <a href="/InternetDB-Project/member_manage/logout.jsp" class="btn btn-warning">로그아웃</a>
            
            <a href="/InternetDB-Project/member_manage/removeMemberform.jsp" class="btn btn-warning">회원탈퇴</a>
        <% } else { %>
            <a href="/InternetDB-Project/member_manage/loginform.jsp" class="btn btn-warning">로그인</a>
            
            <a href="/InternetDB-Project/member_manage/addMemberform.jsp" class="btn btn-warning">회원가입</a>
        <% } %>
    </div>
	</header>
	<nav>
        <ul>
            <li><a href="/InternetDB-Project/home.jsp">홈</a></li>
            <li><a href="#">소개</a></li>
            <li><a href="/InternetDB-Project/board/boardlist.jsp">게시판</a></li>
            <li><a href="#">자료실</a></li>
            <li><a href="/InternetDB-Project/mypage.jsp" style="font-weight: bold;">마이페이지</a></li>
        </ul>
    </nav>
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
