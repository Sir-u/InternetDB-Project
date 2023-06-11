<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
   <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
   <title>동아리명 - 게시판</title>
   <link rel="stylesheet" href="/InternetDB-Project/style/style.css" type="text/css" />
   <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
   <link href="https://getbootstrap.com/docs/5.3/assets/css/docs.css" rel="stylesheet">
</head>

<body>
   <header>
    <h1 style="font-size: 36px;">동아리명</h1>
    <div>
        <% if (session.getAttribute("isLoggedIn") != null) {
            Integer id = (Integer) session.getAttribute("id");
        %>
            <%= id %> 님, 안녕하세요!
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
         <li><a href="/InternetDB-Project/board/boardlist.jsp" style="font-weight: bold;">게시판</a></li>
         <li><a href="#">자료실</a></li>
         <li><a href="#">마이페이지</a></li>
      </ul>
   </nav>
   <main>
      <h2 class="link-offset-2"; style="color: #555;">게시판</h2>
      <div class="container">
      
               <table class="table">
                  <thead>
                     <tr>
                        <th scope="col">번호</th>
                        <th scope="col">제목</th>
                        <th scope="col">작성자</th>
                        <th scope="col">작성일</th>
                     </tr>
                  </thead>
                  <tbody>
                     <tr>
                        <th scope="row">1</th>
                        <td>게시글 제목 1</td>
                        <td>작성자 1</td>
                        <td>2023-05-19</td>
                     </tr>
                     <tr>
                        <th scope="row">2</th>
                        <td>게시글 제목 2</td>
                        <td>작성자 2</td>
                        <td>2023-05-20</td>
                     </tr>
                     <tr>
                        <th scope="row">3</th>
                        <td>게시글 제목 3</td>
                        <td>작성자 3</td>
                        <td>2023-05-21</td>
                     </tr>
                  </tbody>
               </table>
            </div>
         </div>
      </div>
      
   </main>
   <footer>
      <p>&copy; 2023 동아리명. All rights reserved.</p>
   </footer>
</body>

</html>