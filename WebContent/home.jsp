<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.web_project.announce.AnnounceBean" %>
<%@ page import="com.web_project.announce.AnnounceDAO" %>
<%@ page import="com.web_project.member.ManagerMemberDAO" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title>동아리명</title>
    <link rel="stylesheet" href="/InternetDB-Project/style/style.css" type="text/css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://getbootstrap.com/docs/5.3/assets/css/docs.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
    $(document).ready(function() {
        $('.carousel').carousel();
    });
	</script>
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
            <li><a href="/InternetDB-Project/home.jsp" style="font-weight: bold;">홈</a></li>
            <li><a href="/InternetDB-Project/introduce.jsp">소개</a></li>
            <li><a href="/InternetDB-Project/board/list.jsp">게시판</a></li>
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
    <!--- 그림 슬라이드 --->
    <div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="true">
        <div class="carousel-indicators">
            <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active" aria-label="Slide 1" aria-current="true" style="filter: invert(100%);"></button>
            <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1" aria-label="Slide 2" class="" style="filter: invert(100%);"></button>
            <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2" aria-label="Slide 3" class="" style="filter: invert(100%);"></button>
        </div>

        <div class="carousel-inner">
            <div class="carousel-item active">
                <img src="/InternetDB-Project/img/sample1.png" class="img-fluid mx-auto d-block" alt="pic1.png로 img파일 안에 저장해주세요" style="width: 60%;">
            </div>

            <div class="carousel-item">
                <img src="/InternetDB-Project/img/sample2.png" class="img-fluid mx-auto d-block" alt="pic2.png로 img파일 안에 저장해주세요" style="width: 60%;">
            </div>

            <div class="carousel-item">
                <img src="/InternetDB-Project/img/sample3.png" class="img-fluid mx-auto d-block" alt="pic3.png로 img파일 안에 저장해주세요" style="width: 60%;">
            </div>
        </div>

        <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true" style="filter: invert(100%);"></span>
            <span class="visually-hidden">Previous</span>
        </button>

        <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
            <span class="carousel-control-next-icon" aria-hidden="true" style="filter: invert(100%);"></span>
            <span class="visually-hidden">Next</span>
        </button>
    </div>
<!--- --->

    <main>
        <div class="row">

            <div class="col-12 col-lg-6">
                <div class="card card-table m-2">
                    <h2 class="card-header" style="color: #555;">공지사항</h2>
                    <div class="card-body">
                        <table class="table table-hover">
                            <tbody>
                              
                                <%
                                	AnnounceDAO announceDAO = new AnnounceDAO();
                                	List<AnnounceBean> topAnnouncements = announceDAO.getTopThreeAnnouncements();
                                	
                                	if(topAnnouncements.isEmpty()){
                                		
                                %>
                                	<table width="100%" cellpadding="0" cellspacing="0" border="0">
							          <tr align="center" bgcolor="#FFFFFF" height="30">
							            <td colspan="5">등록된 글이 없습니다.</td>
							          </tr>
							        </table>
                                <%
                                	}else{
                                		for(AnnounceBean announcement : topAnnouncements){
                                			int idx = announcement.getNum();
                                            String name = announcement.getUsrname();
                                            String title = announcement.getTitle();
                                            String time = announcement.getTime().toString();
                                            int hit = announcement.getHit();
                                %>

                                <tr style="cursor: pointer; text-align: center;"
                                    onclick="window.location.href='/InternetDB-Project/announce/announcedetail.jsp?idx=<%=idx%>';">
                                    <th scope="row" hidden>
                                        <%=idx%>
                                    </th>
                                    <td>
                                        <%=title%>
                                    </td>
                                    <td>
                                        <%=name%>
                                    </td>
                                    
                                    <td>
                                        <%=hit%>
                                    </td>
                                </tr>
                                <%
                                		}
                                	}
                                %>
                            </tbody>
                    </table>
                    </div>
                </div>
            </div>

            <div class="col-12 col-lg-6">
                <div class="card card-table m-2">
                    <h2 class="card-header" style="color: #555;">게시판</h2>
                    <div class="card-body">
                            <table class="table table-hover">
                                    <tbody>
                                    	<%
		                                	ManagerMemberDAO boardDAO = new ManagerMemberDAO();
		                                	List<AnnounceBean> topBoards = boardDAO.getTopThreeBoards();
		                                	
		                                	if(topBoards.isEmpty()){
		                                		
		                                %>
		                                	<table width="100%" cellpadding="0" cellspacing="0" border="0">
									          <tr align="center" bgcolor="#FFFFFF" height="30">
									            <td colspan="5">등록된 글이 없습니다.</td>
									          </tr>
									        </table>
		                                <%
		                                	}else{
		                                		for(AnnounceBean board : topBoards){
		                                			int idx = board.getNum();
		                                            String name = board.getUsrname();
		                                            String title = board.getTitle();
		                                            String time = board.getTime().toString();
		                                            int hit = board.getHit();
		                                %>
                                    
                                        <tr style="cursor: pointer; text-align: center;"
                                            onclick="window.location.href='/InternetDB-Project/board/view.jsp?idx=<%=idx%>';">
                                            <th scope="row" hidden>
                                                <%=idx%>
                                            </th>
                                            <td>
                                                <%=title%>
                                            </td>
                                            <td>
                                                <%=name%>
                                            </td>
                                           
                                            <td>
                                                <%=hit%>
                                            </td>
                                        </tr>
                                        <%
		                                		}
		                                	}
                                        %>
                                    </tbody>
                            </table>
                    </div>
                </div>
            </div>


        </div>
    </main>

    <footer>
        <p>&copy; 2023 동아리명. All rights reserved.</p>
    </footer>
</body>

</html>

