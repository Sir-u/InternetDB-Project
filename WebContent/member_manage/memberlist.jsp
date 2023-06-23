<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<!DOCTYPE html>
<html>

<head>
   <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
   <title>동아리명 - 게시판</title>
   <link rel="stylesheet" href="/InternetDB-Project/style/style.css" type="text/css" />
   <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
   <link href="https://getbootstrap.com/docs/5.3/assets/css/docs.css" rel="stylesheet">
   <style>
    @media (max-width: 768px) {
      .table-container {
        margin-left: 10px;
        margin-right: 10px;
      }
    }

    @media (min-width: 769px) and (max-width: 1200px) {
      .table-container {
        margin-left: 100px;
        margin-right: 100px;
      }
    }

    @media (min-width: 1201px) {
      .table-container {
        margin-left: 300px;
        margin-right: 300px;
      }
    }
  </style>
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
            <li><a href="/InternetDB-Project/introduce.jsp">소개</a></li>
            <li><a href="/InternetDB-Project/board/list.jsp">게시판</a></li>
            <li><a href="/InternetDB-Project/announce/announcelist.jsp">공지사항</a></li>
            <li><a href="/InternetDB-Project/mypage.jsp">마이페이지</a></li>
            <%  if (session.getAttribute("authority_level") != null) {
	                int authorityLevel = (int) session.getAttribute("authority_level");
	                if (authorityLevel >= 1) {
            %>
            <li>
                <a href="/InternetDB-Project/member_manage/memberlist.jsp" style="font-weight: bold;">회원관리</a>
            </li>
            <%
                	}
            	}
            %>
        </ul>
    </nav>
   <main>
      <h2 class="link-offset-2" style="color: #555;">회원 목록</h2>
      <div class="table-container">
      <div class="container">
         <table class="table table-hover">
          <thead class="table-primary">
            <tr style="text-align: center;">
              <th scope="col">학번</th>
              <th scope="col">이름</th>
              <th scope="col">성별</th>
              <th scope="col">생일</th>
              <th scope="col">나이</th>
            </tr>
          </thead>
            <tbody>
               <% 
               com.web_project.member.ManagerMemberDAO memberDAO = new com.web_project.member.ManagerMemberDAO();
               List<com.web_project.member.MemberListBean> members = memberDAO.getAllMembers();
               for (com.web_project.member.MemberListBean member : members) { %>
                  <tr style="cursor: pointer; text-align: center;" onclick="window.location.href='memberDetail.jsp?stdnum=<%= member.getStdnum() %>';">
                     <th scope="row"><%= member.getStdnum() %></td>
                     <td><%= member.getUsrname() %></td>
                     <td><%= member.getGender() %></td>
                     <td><%= member.getBirthday() %></td>
                     <td><%= member.getAge() %></td>
                  </tr>
               <% } %>
            </tbody>
         </table>
      </div>
      </div>
   </main>
   <footer>
      <p>&copy; 2023 동아리명. All rights reserved.</p>
   </footer>
</body>

</html>