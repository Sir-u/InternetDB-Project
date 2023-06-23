<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.web_project.announce.AnnounceDAO" %>
<%@ page import="com.web_project.announce.AnnounceBean" %>
<!DOCTYPE html>
<html>
<head>
   <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
   <title>동아리명 - 게시판</title>
   <link rel="stylesheet" href="/InternetDB-Project/style/style.css" type="text/css" />
   <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
   <link href="https://getbootstrap.com/docs/5.3/assets/css/docs.css" rel="stylesheet">
   <style>
      textarea {
         width: 100%;
         max-width: 800px;
         box-sizing: border-box;
      }

      @media (max-width: 768px) {
         .table-container {
            margin-left: 10px;
            margin-right: 10px;
         }

         input[name="title"],
         input[name="name"],
         input[type="password"],
         input[name="memo"] {
            width: 100%;
            max-width: 200px;
         }
      }

      @media (min-width: 769px) and (max-width: 1200px) {
         .table-container {
            margin-left: 100px;
            margin-right: 100px;
         }

         input[name="title"],
         input[name="name"],
         input[type="password"],
         input[name="memo"] {
            width: 100%;
            max-width: 300px;
         }
      }

      @media (min-width: 1201px) {
         .table-container {
            margin-left: 300px;
            margin-right: 300px;
         }

         input[name="title"],
         input[name="name"],
         input[type="password"],
         input[name="memo"] {
            width: 100%;
            max-width: 400px;
         }

      }
   </style>
   <script src="/InternetDB-Project/javascript/inputCheck.js"></script>
</head>


<body>
<script>
   // textarea 크기 조정 함수
   function adjustTextarea() {
      const textarea = document.getElementById('memo');
      textarea.style.height = 'auto';
      textarea.style.height = textarea.scrollHeight + 'px';
   }

   // 초기 호출 및 창 크기 변경 시 호출
   adjustTextarea();
   window.addEventListener('resize', adjustTextarea);
</script>
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
            <li><a href="/InternetDB-Project/announce/announcelist.jsp" style="font-weight: bold;">공지사항</a></li>
            <li><a href="/InternetDB-Project/mypage.jsp">마이페이지</a></li>
            <%  if (session.getAttribute("authority_level") != null) {
	                int authorityLevel = (int) session.getAttribute("authority_level");
	                if (authorityLevel >= 1) {
            %>
            <li>
                <a href="/InternetDB-Project/member_manage/memberlist.jsp">회원관리</a>
            </li>
            <%
                	}
            	}
            %>
        </ul>
    </nav>

<%
   request.setCharacterEncoding("utf-8");

   String name = "";
   String password = "";
   String title = "";
   String memo = "";
   int idx = Integer.parseInt(request.getParameter("idx"));

   try {
      AnnounceDAO announceDAO = new AnnounceDAO();
      AnnounceBean announce = announceDAO.getAnnouncementByNum(idx);

      if (announce != null) {
         name = announce.getUsrname();
         password = announce.getPassword();
         title = announce.getTitle();
         memo = announce.getMemo();
      }
   } catch (Exception e) {
      out.println(e.toString());
   }
%>

<main>
   <h2 class="link-offset-2" style="color: #555;">공지사항 글 수정하기</h2>
   <div class="table-container">
      <div class="table-responsive m-2">
         <table class="table table-secondary">
            <form method="post" action="updateannounce.jsp?idx=<%=idx%>">
               <tr>
                  <td>
                     <table class="table table-bordered">
                        <tr style="text-align:center;">
                           <td class="table-primary">글 수정하기</td>
                        </tr>
                     </table>
                     <table class="table table-bordered">
                        <tr>
                           <td class="table-info" align="center" width="76">제목</td>
                           <td width="319">
                              <input class="form-control" name="title" size="40" maxlength="50" id="title"  value="<%=title%>" required>
                              <div class="invalid-feedback" id="invalidFeedback1">제목을 적어주세요</div>
                           </td>
                        </tr>
                        <tr>
                           <td class="table-info" align="center" width="76">이름</td>
                           <td width="319">
                              <%=name%>
                              <input class="form-control" type="hidden" name="name" size="40" maxlength="50" id="studentName" value="<%=name%>" required>
                              <div class="invalid-feedback" id="invalidFeedback2">이름을 적어주세요.</div>
                           </td>
                        </tr>
                        <tr>
                           <td class="table-info" align="center" width="76">비밀번호</td>
                           <td width="319">
                              <input class="form-control" type="password" placeholder="수정하시려면 비밀번호를 입력해주세요" name="password" size="40" maxlength="50" id="studentPassward" required>
                              <div class="invalid-feedback" id="invalidFeedback3">비밀번호를 적어주세요.</div>
                           </td>
                        </tr>
                        <tr>
                           <td class="table-info" align="center" width="76">내용</td>
                           <td width="319">
                              <textarea class="form-control" name="memo" id="memo" rows="13"><%=memo %></textarea>
                              <div class="invalid-feedback" id="invalidFeedback4">내용을 적어주세요.</div>
                           </td>
                        </tr>

                        <tr align="center">
                           <td colspan="2" width="399">
                              <input type="submit" value="수정" class="btn btn-outline-success" onclick="writeCheck();">
                              <input type="button" value="취소" class="btn btn-outline-danger" onclick="history.back(-1)">
                           </td>

                        </tr>
                     </table>
                  </td>
               </tr>
            </form>
         </table>

      </div>
   </div>
</main>
<footer>
   <p>&copy; 2023 동아리명. All rights reserved.</p>
</footer>
</body>

</html>
