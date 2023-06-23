<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.web_project.db.DBConnection"%>
<%
   request.setCharacterEncoding("utf-8");

   // 입력 받은 파라미터 가져오기
   int replyNum = Integer.parseInt(request.getParameter("replyNum"));
   String replyUsername = (String) session.getAttribute("usrname"); // 수정된 부분
   String replyContent = new String(request.getParameter("memo")); // 수정된 부분

   PreparedStatement pstmt = null;

   try {
       // 데이터베이스 연결
       Connection conn = DBConnection.getConnection();

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
   }
%>

