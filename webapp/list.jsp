<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
<title>게시판</title>
</head>
<body>
<%
    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;
    
    try {
        // 드라이버 로드
        Class.forName("oracle.jdbc.driver.OracleDriver");
        
        // 데이터베이스 연결
        String url = "jdbc:oracle:thin:@localhost:1521:XE";
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
        out.print("총 게시물 : " + total + "개");
        
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
        <tr style="text-align:center;">
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