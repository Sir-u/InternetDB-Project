<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.web_project.db.DBConnection"%>

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
      <!-- <div class="table-responsive m-2">
        
          <div class="row justify-content-end">
            <div class="col-auto">
              <input type="button" value="글쓰기" onclick="window.location='write.jsp'" class="btn btn-primary">
            </div>
          
        </div>
      </div> -->
      <%
      Statement stmt=null; 
      ResultSet rs=null; 
      try { 
        Connection conn=DBConnection.getConnection(); 
        stmt=conn.createStatement(); 
        
        String sqlCount="SELECT COUNT(*) FROM board" ;
        rs=stmt.executeQuery(sqlCount);
        int total=0; 
        if(rs.next()) { 
          total=rs.getInt(1); 
        } 
        rs.close();
        %>
      <div class="table-container m-2">
					<div class="table-responsive">
						<div class="row justify-content-between m-2">
							<div class="col-auto">
								<p class="m-0" style="justify-content: left;">총 게시물: <%=total%>개</p>
							</div>
							<% 
							    Integer stdnum = (Integer) session.getAttribute("id");
							    if (stdnum != null) {
							        // 로그인된 상태
							%>
							<div class="col-auto">
								<input type="button" value="글쓰기" onclick="window.location='write.jsp'" class="btn btn-primary">
							</div>
						</div>
					</div>
				</div>
	<%
	    }
	%>

      <%  

        String sqlList = "SELECT num, usrname, TITLE, TIME, HIT FROM board ORDER BY NUM DESC";
        rs = stmt.executeQuery(sqlList);

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
          <% 
          while (rs.next()) { 
            int idx=rs.getInt("NUM"); 
            String name=rs.getString("USRNAME");
            String title=rs.getString("TITLE"); 
            String time=rs.getString("TIME"); 
            int hit=rs.getInt("HIT"); 
          %>
            <tbody>
              <tr style="cursor: pointer; text-align: center;" onclick="window.location.href='view.jsp?idx=<%=idx%>';">
                <th scope="row"><%=idx%></th>
                <td><%=title%></td>
                <td><%=name%></td>
                <td><%=time%></td>
                <td><%=hit%></td>
              </tr>
          <% 
          } 
          } 
          } catch (SQLException e) { 
            e.printStackTrace(); 
          } finally { 
            if (rs !=null) { 
              try { 
                rs.close(); 
              } catch(SQLException e) { 
                e.printStackTrace(); 
              } 
            } 
            if (stmt !=null) { 
              try { 
                stmt.close(); 
              } catch (SQLException e) { 
                e.printStackTrace(); 
              } 
            } 
          } 
          %>
        </tbody>
      </table>
      
      
      <div class="container">
        <div class="row">
          <form method="post" name="search" action="search.jsp">
            <table class="pull-right">
              <tr>
                <td>
                  <select class="form-control" name="searchField">
                    <option value="0">선택</option>
                    <option value="TITLE">제목</option>
                    <option value="USERNAME">작성자</option>
                  </select>
                </td>
                <td>
                  <input type="text" class="form-control" placeholder="검색어 입력" name="searchText" maxlength="100">
                </td>
                <td>
                  <button type="submit" class="btn btn-success">검색</button>
                </td>
              </tr>
            </table>
          </form>
        </div>
      </div>
    </div>
  </main>

  <footer>
    <p>&copy; 2023 동아리명. All rights reserved.</p>
  </footer>
</body>

</html>