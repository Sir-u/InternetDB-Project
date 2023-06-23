<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.web_project.member.MemberBean" %>
<%@ page import="com.web_project.member.MemberDAO" %>
<%@ page import="com.web_project.member.ManagerMemberDAO" %>
<%@ page import="java.util.List" %>
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
      <h2 class="link-offset-2" style="color: #555;">회원 상세정보</h2>
      <div class="table-container">
         <div class="table-responsive m-2">
            <table class="table table-secondary">
               <tr>
                  <td>
                     <table class="table table-bordered">
                        <tr style="text-align:center;">
                           <td class="table-primary">회원 개인정보</td>
                        </tr>
                     </table>
                     <%
                        String stdnumParam = request.getParameter("stdnum");
                        if (stdnumParam != null) {
                           int stdnum = Integer.parseInt(stdnumParam);
                           MemberDAO memberDAO = new MemberDAO();
                           MemberBean member = memberDAO.getMemberByStdnum(stdnum);
                           if (member != null) {
                     %>
                           <table class="table table-bordered">
                              <tr>
                                 <td class="table-info" align="center" width="50">학번</td>
                                 <td width="35">
                                    <%= member.getStdnum() %>
                                 </td>
                              </tr>
                              <tr>
                                 <td class="table-info" align="center" width="50">이름</td>
                                 <td width="35">
                                    <%= member.getUsrname() %>
                                 </td>
                              </tr>
                              <tr>
                                 <td class="table-info" align="center" width="50">성별</td>
                                 <td width="35">
                                    <%= member.getGender() %>
                                 </td>
                              </tr>
                              <tr>
                                 <td class="table-info" align="center" width="50">생일</td>
                                 <td width="35">
                                    <%= member.getBirthday() %>
                                 </td>
                              </tr>
                              <tr>
                                 <td class="table-info" align="center" width="50">나이</td>
                                 <td width="35">
                                    <%= member.getAge() %>
                                 </td>
                              </tr>
                              <tr>
                                 <td class="table-info" align="center" width="50">가입일</td>
                                 <td width="35">
                                    <%= member.getReg_date() %>
                                 </td>
                              </tr>
                             <tr>
							   <td class="table-info" align="center" width="50">권한 등급</td>
							   <td width="35">
							      <% 
							         switch (member.getAuthority_level()) {
							            case 1:
							               out.println("관리자");
							               break;
							            case 0:
							               out.println("일반사용자");
							               break;
							            default:
							               out.println("알 수 없음");
							               break;
							         }
							      %>
							   </td>
							</tr>
                              
                              <!-- Add more member details if needed -->
                           </table>
                     <%
                           } else {
                     %>
                           <p>해당 학번의 회원 정보를 찾을 수 없습니다.</p>
                     <%
                           }
                        } else {
                     %>
                           <p>학번 파라미터를 전달받지 못했습니다.</p>
                     <%
                        }
                     %>
                     
                     <% 
					      ManagerMemberDAO managermemberDAO = new ManagerMemberDAO();
                     	  int stdnum = Integer.parseInt(stdnumParam);
                     	  System.out.println(stdnum);
					      List<AnnounceBean> boardList = managermemberDAO.getBoardsByStdnum(stdnum);
					      int total = boardList.size();
					      
					      out.print("<p class='m-2' style='justify-content: left;'>총 게시물 : " + total + "개</p>");
					
					      if (total == 0) {
					      %>
					        <table width="100%" cellpadding="0" cellspacing="0" border="0">
					          <tr align="center" bgcolor="#FFFFFF" height="30">
					            <td colspan="5">등록된 글이 없습니다.</td>
					          </tr>
					        </table>
					      <% 
					      } else { 
					      %>
					        <table class="table table-hover">
					          <thead class="table-primary">
					            <tr style="text-align: center;">
					              <th scope="col">번호</th>
					              <th scope="col">제목</th>
					              <th scope="col">작성자</th>
					              <th scope="col">작성일</th>
					              <th scope="col">조회수</th>
					            </tr>
					          </thead>
					          <tbody>
					          <% 
					          for (AnnounceBean board : boardList) {
					            int idx = board.getNum();
					            String name = board.getUsrname();
					            String title = board.getTitle();
					            String time = board.getTime().toString();
					            int hit = board.getHit();
					          %>
					            <tr style="cursor: pointer; text-align: center;" onclick="window.location.href='announcedetail.jsp?idx=<%=idx%>';">
					              <th scope="row"><%=idx%></th>
					              <td><%=title%></td>
					              <td><%=name%></td>
					              <td><%=time%></td>
					              <td><%=hit%></td>
					            </tr>
					          <% 
					          		} 
					          	} 
					          %>
					          </tbody>
					      </table>
                  </td>
               </tr>
            </table>
         </div>
      </div>
   </main>
<footer>
      <p>&copy; 2023 동아리명. All rights reserved.</p>
</footer>
<!-- 비밀번호 입력 모달 -->
   <div class="modal" id="passwordModal" tabindex="-1" aria-labelledby="passwordModalLabel" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
         <div class="modal-content">
            <div class="modal-header">
               <h5 class="modal-title" id="passwordModalLabel">비밀번호 입력</h5>
               <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
               <!-- 폼 추가 -->
               <!-- <form name="deleteform" method="post" action="delete_ok.jsp"> -->
               <div class="mb-3">
                  <label for="passwordInput" class="form-label">비밀번호:</label>
                  <input type="password" class="form-control" id="passwordInput" name="password">
               </div>
               <!-- 기타 입력 필드 추가 -->
               <!-- </form> -->
            </div>
            <div class="modal-footer">
               <button type="button" class="btn btn-primary" id="submitButton">확인</button>
            </div>
         </div>
      </div>
   </div>


   <!-- Bootstrap JS -->
   <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
   <!-- Custom JS -->
   <script src="/InternetDB-Project/javascript/password.js"></script>
   <script src="/InternetDB-Project/javascript/reply.js"></script>
   <script src="/InternetDB-Project/javascript/inputCheck.js"></script>
</body>
</html>
