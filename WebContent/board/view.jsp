<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.web_project.db.DBConnection"%>
<%@ page import="com.web_project.member.MemberBean" %>
<%@ page import="com.web_project.member.MemberDAO" %>
<%

int idx = Integer.parseInt(request.getParameter("idx"));

try {
	Connection conn = DBConnection.getConnection();
    Statement stmt = conn.createStatement();

    // 원문 글 정보 가져오기
    String sql = "SELECT stdnum, USRNAME, TITLE, MEMO, TIME, HIT, PASSWORD FROM board WHERE NUM=" + idx;
    ResultSet rs = stmt.executeQuery(sql);
    if (rs.next()) {
    	int stdnum = rs.getInt(1);
        String name = rs.getString(2);
        String title = rs.getString(3);
        String memo = rs.getString(4);
        String time = rs.getString(5);
        int hit = rs.getInt(6);
        String password=rs.getString(7);
        hit++;

        // 조회수 증가
        String updateSql = "UPDATE board SET HIT=" + hit + " WHERE NUM=" + idx;
        stmt.executeUpdate(updateSql);

        // 답글 정보 가져오기
        sql = "SELECT REPLY_USERNAME, REPLY_CONTENT, REPLY_TIME FROM REPLY WHERE REPLY_NUM=" + idx;
        ResultSet replyRs = stmt.executeQuery(sql);
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
            <li><a href="/InternetDB-Project/board/list.jsp" style="font-weight: bold;">게시판</a></li>
            <li><a href="/InternetDB-Project/announce/announcelist.jsp">공지사항</a></li>
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
      <h2 class="link-offset-2" style="color: #555;">게시판</h2>
      <div class="table-container">
         <div class="table-responsive m-2">
            <form name="deleteform" method="post" action="delete_ok.jsp">
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
                                 <input type="button" value="목록" class="btn btn-outline-secondary" OnClick="window.location='list.jsp'">
                                 <%
                                 	if(session.getAttribute("id") != null){
                                 		
                                 %>
                                 <input id="replyButton" type="button" value="답글" class="btn btn-outline-success" OnClick="window.location='reply.jsp?idx=<%=idx%>'">
                                 <% 
	                                 	int stdnum_session = (int) session.getAttribute("id");
	                                 	int authorityLevel = (int) session.getAttribute("authority_level");
	                                 	if(stdnum == stdnum_session){
                                 %>
                                 
                                 <input type="button" value="수정" class="btn btn-outline-warning" onclick="window.location='modify.jsp?idx=<%=idx%>'">
                                 <input id="passwordButton" type="submit" value="삭제" class="btn btn-outline-danger">
                                 <input class="form-control" id="passwordInput" name="password" type="password" placeholder="삭제하시려면 비밀번호를 입력후 삭제버튼을 눌러주세요">
                                 <div class="invalid-feedback" id="passwordInputFeedback">내용을 적어주세요.</div>
                                 <%
	                                 	}else if(authorityLevel >= 1){
	                                 		
	                             %>
	                             
                                 <input type="button" value="수정" class="btn btn-outline-warning" onclick="window.location='modify.jsp?idx=<%=idx%>'">
                                 <input id="passwordButton" type="submit" value="삭제" class="btn btn-outline-danger">
                                 <input class="form-control" id="passwordInput" name="password" type="password" value="<%= password %>" readonly>
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
                  <tr>
                     <td>
                        <table class="table table-bordered">
                           <tr style="text-align:center;">
                              <td class="table-primary">답 글</td>
                           </tr>
                        </table>
                        <% while (replyRs.next()) {
					        String replyUsername = replyRs.getString(1);
					        String replyContent = replyRs.getString(2);
					        String replyTime = replyRs.getString(3);
					    %>
                        <table class="table table-bordered">
                           <tr>
                              <td class="table-info" align="center" width="150">작성자</td>
                              <td style="text-align: center;">
                                 <%=replyUsername%>
                              </td>
                              <td class="table-info" align="center" width="150">작성일</td>
                              <td style="text-align: center;">
                                 <%=replyTime%>
                              </td>
                           </tr>
                           <tr>
                              <td class="table-info" align="center" width="76">내용</td>
                              <td colspan="3" width="319">
                                 <%=replyContent%>
                              </td>
                           </tr>
                        </table>
                        <% }
    replyRs.close();
    rs.close();
    stmt.close();
} 
} catch (SQLException e) {
    e.printStackTrace();
}
%>
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
</html>
