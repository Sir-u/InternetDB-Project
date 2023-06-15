<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 창</title>
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>
    <script>
        $(function() {
            $("#datepicker").datepicker({
                dateFormat: "yy-mm-dd", // 월과 일 형식 설정 (예: 05-31)
                showMonth: true, // 월 선택기 숨김
                showYear: true, // 년 선택기 숨김
                changeMonth: false, // 월 선택기 숨김
                changeYear: true,
                yearRange: "1950:2030"
            });
        });
        
        window.onload = function() {
            var now = new Date();
            var year = now.getFullYear();
            var month = ('0' + (now.getMonth() + 1)).slice(-2);
            var day = ('0' + now.getDate()).slice(-2);
            var currentTime = year + '-' + month + '-' + day;
            document.getElementById("reg_date").value = currentTime;
        }
    </script>
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
      <section>
         <h2 style="color: #555;">회원가입</h2>
         <div class="p-3 m-0 border-0 bd-example m-0 border-0" ; justify-content="center" ;>
            <div class="col-sm-4" style="margin: auto;">
               <div class="card p-3">
                  <div class="card-body h-100">
                     <form action="addMember.jsp" method = "post">
                        <h1 class="h3 mb-3 fw-normal">정보를 입력해주세요</h1>

                        <div class="form-floating">
                           <input type="number" class="form-control" name = "stdnum" id="studentNumber" placeholder="123456789">
                           <label for="studentNumber">학번</label>
                        </div>
                        <div class="form-floating">
                           <input type="password" class="form-control" name = "passwd" id="studentPassword" placeholder="비밀번호">
                           <label for="studentPassword">비밀번호</label>
                        </div>
                        <div class="form-floating">
                           <input type="text" class="form-control" name = "usrname" id="studentName" placeholder="이름">
                           <label for="studentName">이름</label>
                        </div>
                        <div class="form-floating">
                        	<select class = "form-control" name="gender">
					            <option value="male">남성</option>
					            <option value="female">여성</option>
				        	</select>
				        	<label for = "gender">성별</label>
                        </div>
                        <div class="form-floating">
                        	<input type="text" class="form-control" id="datepicker" name="birthday" placeholder="생일">
							<label for="datepicker">생일</label>
                        </div>
                        <div class="form-floating">
                           <input type="number" class="form-control" id="studentAge" name = "age" placeholder="나이">
                           <label for="studentAge">나이</label>
                        </div>
                        <div class="form-floating">
                           <input type="text" class="form-control" id="reg_date" name = "reg_date" placeholder="등록일" readonly>
                           <label for="reg_date">등록일</label>
                        </div>
                        <div class="form-check text-start my-3">
                        </div>
                        <input type="hidden" name="authority_level" value="0">
	
                        <button class="btn bd-cyan-400 w-100 py-2" type="submit">가입하기</button>
                        </form>
                  </div>
               </div>
            </div>

         </div>
      </section>
   
   <footer>
      <p>&copy; 2023 동아리명. All rights reserved.</p>
   </footer>
</body>

</html>
