<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<!DOCTYPE html>
<%@ page import="java.sql.*"%>  
<%
    request.setCharacterEncoding("utf-8");

    Class.forName("oracle.jdbc.driver.OracleDriver");
    String url = "jdbc:oracle:thin:@localhost:1521:XE";
    String id = "scott";
    String pass = "tiger";
    String name = request.getParameter("name");
    String password = request.getParameter("password");
    String title = request.getParameter("title");
    String memo = request.getParameter("memo");

    try {    
        Connection conn = DriverManager.getConnection(url, id, pass);

        // 새로운 글의 NUM 값을 조회
        String numSql = "SELECT MAX(NUM) FROM BOARD";
        Statement numStmt = conn.createStatement();
        ResultSet numRs = numStmt.executeQuery(numSql);
        int num = 1;
        if (numRs.next()) {
            num = numRs.getInt(1) + 1;
        }
        numRs.close();
        numStmt.close();

        String sql = "INSERT INTO BOARD(NUM, USERNAME, PASSWORD, TITLE, MEMO, TIME) VALUES (?, ?, ?, ?, ?, SYSDATE)";
        PreparedStatement pstmt = conn.prepareStatement(sql);

        pstmt.setInt(1, num);
        pstmt.setString(2, name);
        pstmt.setString(3, password);
        pstmt.setString(4, title);
        pstmt.setString(5, memo);

        pstmt.executeUpdate();
        pstmt.close();

        conn.close();
    } catch(SQLException e) {
        out.println(e.toString());
    }
%>
<script language="javascript">
    self.window.alert("입력한 글을 저장하였습니다.");
    location.href="list.jsp"; 
</script>