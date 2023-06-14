<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>
<%
    // 데이터베이스 연결 정보
    String url = "jdbc:oracle:thin:@localhost:1521:XE?useUnicode=true&characterEncoding=UTF-8";
    String id = "scott";
    String pass = "tiger";

    // 입력 받은 파라미터 가져오기
    int replyNum = Integer.parseInt(request.getParameter("replyNum"));
    String replyUsername = request.getParameter("replyUsername");
    String replyContent = new String(request.getParameter("replyContent").getBytes("ISO-8859-1"), "UTF-8");

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        // 데이터베이스 연결
        Class.forName("oracle.jdbc.driver.OracleDriver");
        conn = DriverManager.getConnection(url, id, pass);

        // 답글 저장을 위한 SQL 쿼리 작성
        String sql = "INSERT INTO REPLY (REPLY_NUM, REPLY_USERNAME, REPLY_CONTENT, REPLY_TIME) VALUES (?, ?, ?, CURRENT_TIMESTAMP)";
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, replyNum);
        pstmt.setString(2, replyUsername);
        pstmt.setString(3, replyContent);

        // 답글 저장
        int rowsAffected = pstmt.executeUpdate();
        if (rowsAffected > 0) {
            response.sendRedirect("view.jsp?idx=" + replyNum); // 답글 저장 후 원래 글로 돌아가기
        } else {
            throw new Exception("답글 저장에 실패했습니다."); // 답글 저장 실패 시 예외 발생
        }
    } catch (ClassNotFoundException e) {
        e.printStackTrace();
    } catch (SQLException e) {
        e.printStackTrace();
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        // 리소스 해제
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
