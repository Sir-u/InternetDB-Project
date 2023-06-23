<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="com.web_project.announce.AnnounceBean"%>
<%@ page import="com.web_project.announce.AnnounceDAO"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>

<%
int idx = Integer.parseInt(request.getParameter("idx"));

AnnounceDAO announceDAO = new AnnounceDAO();
AnnounceBean announce = announceDAO.getAnnouncementByNum(idx);

if (announce != null) {
    String name = announce.getUsrname();
    String title = announce.getTitle();
    String memo = announce.getMemo();
    String time = announce.getTime().toString();
    int hit = announce.getHit();

    // Increase hit count
    announceDAO.increaseHitCount(idx);

    // Retrieve updated hit count
    announce = announceDAO.getAnnouncementByNum(idx);
    hit = announce.getHit();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
   <title>동아리명 - 게시판</title>
   <link rel="stylesheet" href="/InternetDB-Project/style/style.css" type="text/css" />
   <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
   <link href="https://getbootstrap.com/docs/5.3/assets/css/docs.css" rel="stylesheet">
   <style>
      .modal-dialog {
         max-width: 800px;
      }

      .modal-body {
         overflow-y: auto;
      }

      .modal-dialog-centered {
         display: flex;
         align-items: center;
         min-height: calc(100% - (.5rem * 2));
      }

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
<main>
      <h2 class="link-offset-2" style="color: #555;">공지사항</h2>
      <div class="table-container">
         <div class="table-responsive m-2">
            <form name="deleteform" method="post" action="removeannounce.jsp">
               <input type="hidden" name="idx" value="<%=idx%>">
               <table class="table table-secondary">
                  <tr>
                     <td>
                        <table class="table table-bordered">
                           <tr style="text-align:center;">
                              <td class="table-primary">내 용</td>
                           </tr>
                        </table>

                        <table class="table table-bordered">
                           <tr>
                              <td class="table-info" align="center" width="76">글번호</td>
                              <td width="319">
                                 <%=idx%>
                              </td>
                           </tr>
                           <tr>
                              <td class="table-info" align="center" width="76">조회수</td>
                              <td width="319">
                                 <%=hit%>
                              </td>
                           </tr>
                           <tr>
                              <td class="table-info" align="center" width="76">이름</td>
                              <td width="319">
                                 <%=name%>
                              </td>
                           </tr>
                           <tr>
                              <td class="table-info" align="center" width="76">작성일</td>
                              <td width="319">
                                 <%=time%>
                              </td>
                           </tr>
                           <tr>
                              <td class="table-info" align="center" width="76">제목</td>
                              <td width="319">
                                 <%=title%>
                              </td>
                           </tr>
                           <tr>
                              <td width="399" colspan="2" height="200">
                                 <%=memo %>
                              </td>
                           </tr>
                           <tr align="center">
                              <td colspan="2" width="399">
                                 <input type="button" value="목록" class="btn btn-outline-secondary" OnClick="window.location='announcelist.jsp'">
                                 <%  if (session.getAttribute("authority_level") != null) {
									    int authorityLevel = (int) session.getAttribute("authority_level");
									    if (authorityLevel >= 1) {
								 %>
                                 <input type="button" value="수정" class="btn btn-outline-warning" onclick="window.location='updateannounceform.jsp?idx=<%=idx%>'">
                                 <input id="passwordButton" type="submit" value="삭제" class="btn btn-outline-danger">
                                 <input class="form-control" id="passwordInput" name="password" type="password" placeholder="삭제하시려면 비밀번호를 입력후 삭제버튼을 눌러주세요">
                                 <div class="invalid-feedback" id="passwordInputFeedback">내용을 적어주세요.</div>
                                 <%
					                	}
					            	}
					            %>
                              </td>
                           </tr>
                        </table>
                     </td>
                  </tr>
               </table>
            </form>
         </div>
      </div>
   </main>
   <footer>
      <p>&copy; 2023 동아리명. All rights reserved.</p>
   </footer>

   <script src="/InternetDB-Project/javascript/password.js"></script>
   <script src="/InternetDB-Project/javascript/reply.js"></script>
   <script src="/InternetDB-Project/javascript/inputCheck.js"></script>  	
</body>
 <%} %>
</html>
