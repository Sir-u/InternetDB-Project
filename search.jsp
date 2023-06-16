 <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
    <title>게시판</title>
</head>
<body>
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

<%
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        // 드라이버 로드
        Class.forName("oracle.jdbc.driver.OracleDriver");

        // 데이터베이스 연결
        String url = "jdbc:oracle:thin:@localhost:1521:XE?useUnicode=true&characterEncoding=UTF-8";
        String id = "scott";
        String pass = "tiger";
        conn = DriverManager.getConnection(url, id, pass);

        String searchField = request.getParameter("searchField");
        String searchText = request.getParameter("searchText");
        String sqlList = "SELECT NUM, USERNAME, TITLE, TIME, HIT FROM board";
        if (searchField != null && searchText != null && !searchField.equals("0") && !searchText.equals("")) {
            sqlList += " WHERE " + searchField + " LIKE '%' || ? || '%'";
        }
        sqlList += " ORDER BY NUM DESC";

        // PreparedStatement를 사용하여 쿼리 실행
        pstmt = conn.prepareStatement(sqlList);
        if (searchField != null && searchText != null && !searchField.equals("0") && !searchText.equals("")) {
            // 인코딩 설정
            searchText = new String(searchText.getBytes("ISO-8859-1"), "UTF-8");
            pstmt.setString(1, searchText);
        }
        rs = pstmt.executeQuery();

        if (!rs.next()) {
%>
    <table width="100%" cellpadding="0" cellspacing="0" border="0">
        <tr align="center" bgcolor="#FFFFFF" height="30">
            <td colspan="5">검색된 글이 없습니다.</td>
        </tr>
    </table>
<%
        } else {
%>
    <table width="100%" cellpadding="0" cellspacing="0" border="0">
        <tr style="text-align:center;">
            <td width="73">번호</td>
            <td width="379">제목</td>
            <td width="73">작성자</td>
            <td width="164">작성일</td>
            <td width="58">조회수</td>
        </tr>
<%
            do {
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
            } while (rs.next());
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
        if (pstmt != null) {
            try {
                pstmt.close();
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
        <tr height="1" bgcolor="#82B5DF"><td colspan="5" width="752"></td></tr>
    </table>
    <table width="100%" cellpadding="0" cellspacing="0" border="0">
        <tr><td colspan="4" height="5"></td></tr>
        <tr align="center">
            <td><input type="button" value="글쓰기" onclick="window.location='write.jsp'"></td>
        </tr>
    </table>
</body>
</html>