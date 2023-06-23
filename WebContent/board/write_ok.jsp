<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<!DOCTYPE html>
<%@ page import="java.sql.*"%>
<%@ page import="com.web_project.db.DBConnection"%>
<%@ page import="com.web_project.member.MemberBean" %>
<%@ page import="com.web_project.member.MemberDAO" %>

<%
    request.setCharacterEncoding("utf-8");
	MemberDAO memberDAO = new MemberDAO();
    
    int stdnum = (Integer) session.getAttribute("id");
    String name = (String) session.getAttribute("usrname");
    MemberBean member = memberDAO.getMemberByStdnum(stdnum);
    String password = member.getPasswd();
    String title = request.getParameter("title");
    String memo = request.getParameter("memo");

    try {    
        Connection conn = DBConnection.getConnection();

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

        String sql = "INSERT INTO BOARD(NUM, stdnum, usrname, PASSWORD, TITLE, MEMO, TIME) VALUES (?, ?, ?, ?, ?, ?, SYSDATE)";
        PreparedStatement pstmt = conn.prepareStatement(sql);

        pstmt.setInt(1, num);
        pstmt.setInt(2, stdnum);
        pstmt.setString(3, name);
        pstmt.setString(4, password);
        pstmt.setString(5, title);
        pstmt.setString(6, memo);

        pstmt.executeUpdate();
        pstmt.close();

    } catch(SQLException e) {
        out.println(e.toString());
    }
%>
<script language="javascript">
    self.window.alert("입력한 글을 저장하였습니다.");
    location.href="list.jsp"; 
</script>