<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title>동아리명 - 회원가입</title>
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
            <li><a href="/InternetDB-Project/board/boardlist.jsp">게시판</a></li>
            <li><a href="#">자료실</a></li>
            <li><a href="/InternetDB-Project/mypage.jsp">마이페이지</a></li>
        </ul>
    </nav>
    <main>
        <section>
            <h2 style="color: #555;">로그인</h2>
            <div class="p-3 m-0 border-0 bd-example m-0 border-0" ; justify-content="center" ;>
                <div class="col-sm-4" style="margin: auto;">
                    <div class="card p-3">
                        <div class="card-body h-100">
                            	<form action="login.jsp" method = "post">
                                <h1 class="h3 mb-3 fw-normal">정보를 입력해주세요</h1>

                                <div class="form-floating">
                                    <input type="number" class="form-control" name = "stdnum" id="studentNumber" placeholder="123456789">
                                    <label for="floatingInput">학번</label>
                                </div>
                                <div class="form-floating">
                                    <input type="password" class="form-control" name = "passwd" id="studentPassword" placeholder="비밀번호">
                                    <label for="floatingPassword">비밀번호</label>
                                </div>
                                <div class="form-check text-start my-3">
                                </div>

                                <button class="btn bd-cyan-400 w-100 py-2" type="submit">로그인</button>
                                </form>
                        </div>
                    </div>
                </div>

            </div>
        </section>
    </main>
    <footer>
        <p>&copy; 2023 동아리명. All rights reserved.</p>
    </footer>
</body>

</html>
    
