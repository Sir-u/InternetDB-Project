<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title>동아리명</title>
    <link rel="stylesheet" href="/InternetDB-Project/style/style.css" type="text/css">
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
            <li><a href="/InternetDB-Project/home.jsp" style="font-weight: bold;">홈</a></li>
            <li><a href="#">소개</a></li>
            <li><a href="/InternetDB-Project/board/boardlist.jsp">게시판</a></li>
            <li><a href="#">자료실</a></li>
            <li><a href="/InternetDB-Project/mypage.jsp">마이페이지</a></li>
        </ul>
    </nav>

    <main>
        <section>
            <img src="img/sample.png">
        </section>
        <section>
            <h2 style="color: #555;">최신 글</h2>
            <div class="project">
                <h3>글 1</h3>
                <p>글 1에 대한 설명 Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed sed dictum arcu.</p>
            </div>

            <div class="project">
                <h3>글 2</h3>
                <p>글 2에 대한 설명 Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed sed dictum arcu.</p>
            </div>
        </section>
        <div class="container">
            <section class="notice-section">
                <h2 style="color: #555;">공지사항</h2>
                <div class="notice">
                    <ul>
                        <li><a href="#">공지사항 1</a></li>
                        <li><a href="#">공지사항 2</a></li>
                        <li><a href="#">공지사항 3</a></li>
                    </ul>
                </div>
            </section>

            <section class="board-section">
                <h2 style="color: #555;">게시판</h2>
                <div class="board">
                    <ul>
                        <li><a href="#">게시글 1</a></li>
                        <li><a href="#">게시글 2</a></li>
                        <li><a href="#">게시글 3</a></li>
                    </ul>
                </div>
            </section>
        </div>

    </main>

    <footer>
        <p>&copy; 2023 동아리명. All rights reserved.</p>
    </footer>
</body>

</html>






<%-- <!DOCTYPE html>
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
        <a href="member_manage/logout.jsp">로그아웃</a>
        <a href="member_manage/removeMemberform.jsp">회원탈퇴</a>
    <% } else { %>
        <h1>홈 페이지</h1>
        <a href="member_manage/loginform.jsp">로그인</a>
        <a href="member_manage/addMemberform.jsp">회원가입</a>
    <% } %>

</body>
</html> --%>
