<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>

<!DOCTYPE html>
<html>
<head>

<title>게시판</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>동아리명 - 게시판</title>
<link rel="stylesheet" href="style.css" type="text/css" />
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link href="https://getbootstrap.com/docs/5.3/assets/css/docs.css"
	rel="stylesheet">
<style>
.search-bar {
	display: flex;
}

.search-bar input, .search-btn, .search-btn:before, .search-btn:after {
	transition: all 0.25s ease-out;
}

.search-bar input, .search-btn {
	width: 3em;
	height: 3em;
}

.search-bar input:invalid:not(:focus), .search-btn {
	cursor: pointer;
}

.search-bar, .search-bar input:focus, .search-bar input:valid {
	width: 100%;
}

.search-bar input:focus, .search-bar input:not(:focus)+.search-btn:focus
	{
	outline: transparent;
}

.search-bar {
	margin: auto;
	padding: 1.5em;
	justify-content: center;
	max-width: 30em;
}

.search-bar input {
	background: transparent;
	border-radius: 1.5em;
	box-shadow: 0 0 0 0.4em #171717 inset;
	padding: 0.75em;
	transform: translate(0.5em, 0.5em) scale(0.5);
	transform-origin: 100% 0;
	-webkit-appearance: none;
	-moz-appearance: none;
	appearance: none;
}

.search-bar input::-webkit-search-decoration {
	-webkit-appearance: none;
}

.search-bar input:focus, .search-bar input:valid {
	background: #fff;
	border-radius: 0.375em 0 0 0.375em;
	box-shadow: 0 0 0 0.1em #d9d9d9 inset;
	transform: scale(1);
}

.search-btn {
	background: #171717;
	border-radius: 0 0.75em 0.75em 0/0 1.5em 1.5em 0;
	padding: 0.75em;
	position: relative;
	transform: translate(0.25em, 0.25em) rotate(45deg) scale(0.25, 0.125);
	transform-origin: 0 50%;
}

.search-btn:before, .search-btn:after {
	content: "";
	display: block;
	opacity: 0;
	position: absolute;
}

.search-btn:before {
	border-radius: 50%;
	box-shadow: 0 0 0 0.2em #f1f1f1 inset;
	top: 0.75em;
	left: 0.75em;
	width: 1.2em;
	height: 1.2em;
}

.search-btn:after {
	background: #f1f1f1;
	border-radius: 0 0.25em 0.25em 0;
	top: 51%;
	left: 51%;
	width: 0.75em;
	height: 0.25em;
	transform: translate(0.2em, 0) rotate(45deg);
	transform-origin: 0 50%;
}

.search-btn span {
	display: inline-block;
	overflow: hidden;
	width: 1px;
	height: 1px;
}

/* Active state */
.search-bar input:focus+.search-btn, .search-bar input:valid+.search-btn
	{
	background: #555;
	border-radius: 0 0.375em 0.375em 0;
	transform: scale(1);
}

.search-bar input:focus+.search-btn:before, .search-bar input:focus+.search-btn:after,
	.search-bar input:valid+.search-btn:before, .search-bar input:valid+.search-btn:after
	{
	opacity: 1;
}

.search-bar input:focus+.search-btn:hover, .search-bar input:valid+.search-btn:hover,
	.search-bar input:valid:not(:focus)+.search-btn:focus {
	background: #777;
}

.search-bar input:focus+.search-btn:active, .search-bar input:valid+.search-btn:active
	{
	transform: translateY(1px);
}

@media ( max-width : 768px) {
	.table-container {
		margin-left: 10px;
		margin-right: 10px;
	}
}

@media ( min-width : 769px) and (max-width: 1200px) {
	.table-container {
		margin-left: 100px;
		margin-right: 100px;
	}
}

@media ( min-width : 1201px) {
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
		<a href="loginandsignup.html" class="btn btn-warning">로그인/회원가입</a>
	</header>
	<nav>
		<ul>
			<li><a href="homepage.html">홈</a></li>
			<li><a href="#">소개</a></li>
			<li><a href="billboard.html" style="font-weight: bold;">게시판</a></li>
			<li><a href="#">자료실</a></li>
			<li><a href="#">마이페이지</a></li>
		</ul>
	</nav>
<main>
<!-- 	<div class="container">
		<div class="row">
			<form method="post" name="search" action="search.jsp">
				<table class="pull-right">
					<tr>
						<td><select class="form-control" name="searchField">
								<option value="0">선택</option>
								<option value="TITLE">제목</option>
								<option value="USERNAME">작성자</option>
						</select></td>
						<td><input type="text" class="form-control"
							placeholder="검색어 입력" name="searchText" maxlength="100"></td>
						<td><button type="submit" class="btn btn-success">검색</button></td>
					</tr>
				</table>
			</form>
		</div>
	</div> -->
	
	
	
	
	
	      <h2 class="link-offset-2" ; style="color: #555;">게시판</h2>
	
	<%
    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;
    
    try {
        // 드라이버 로드
        Class.forName("oracle.jdbc.driver.OracleDriver");
        
        // 데이터베이스 연결
        String url = "jdbc:oracle:thin:@localhost:1521:XE?useUnicode=true&characterEncoding=UTF-8";
        String id = "scott";
        String pass = "tiger";
        conn = DriverManager.getConnection(url, id, pass);
        stmt = conn.createStatement();
        
        // 총 게시물 수 조회
        String sqlCount = "SELECT COUNT(*) FROM board";
        rs = stmt.executeQuery(sqlCount);
        
        int total = 0;
        if (rs.next()) {
            total = rs.getInt(1);
        }
        rs.close();
        out.print("<p class='m-2' style='justify-content: left;'>총 게시물 : " + total + "개</p>");
        
        // 게시물 목록 조회
        String sqlList = "SELECT NUM, USERNAME, TITLE, TIME, HIT FROM board ORDER BY NUM DESC";
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
	<table width="100%" cellpadding="0" cellspacing="0" border="0">
		<tr style="text-align: center;">
			<td width="73">번호</td>
			<td width="379">제목</td>
			<td width="73">작성자</td>
			<td width="164">작성일</td>
			<td width="58">조회수</td>
		</tr>
		<%
            while (rs.next()) {
                int idx = rs.getInt("NUM");
                String name = rs.getString("USERNAME");
                String title = rs.getString("TITLE");
                String time = rs.getString("TIME");
                int hit = rs.getInt("HIT");
%>
		<tr align="center">
			<td><%=idx %></td>
			<td align="left"><a href="view.jsp?idx=<%=idx%>"><%=title %></a></td>
			<td align="center"><%=name %></td>
			<td align="center"><%=time %></td>
			<td align="center"><%=hit %></td>
		</tr>
		<%
            }
        }
    } catch (ClassNotFoundException | SQLException e) {
        e.printStackTrace();
    } finally {
        // 연결 및 리소스 해제
        if (rs != null) {
            try {
                rs.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if (stmt != null) {
            try {
                stmt.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
%>
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
			<tr height="1" bgcolor="#82B5DF">
				<td colspan="5" width="752"></td>
			</tr>
		</table>
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
			<tr>
				<td colspan="4" height="5"></td>
			</tr>
			<tr align="center">
				<td><input type="button" value="글쓰기"
					onclick="window.location='write.jsp'"></td>
			</tr>
		</table>
		
		 <div class="container">
         <form action="" class="search-bar">
            <input type="search" name="search" pattern=".*\S.*" required>
            <button class="search-btn" type="submit">
               <span>Search</span>
            </button>

         </form>

      </div>
		</main>
		<footer>
      <p>&copy; 2023 동아리명. All rights reserved.</p>
   </footer>
</body>
</html>