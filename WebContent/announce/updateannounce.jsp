<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>    
<%@ page import="com.web_project.announce.AnnounceDAO" %>
<%@ page import="com.web_project.announce.AnnounceBean" %>
<%@ page import="com.web_project.db_env.PasswdGenerator"%>
<!DOCTYPE html>
<%
    request.setCharacterEncoding("utf-8");

    String password = "";

    try {
        int idx = Integer.parseInt(request.getParameter("idx"));
        String title = request.getParameter("title");
        String memo = request.getParameter("memo");
        String input_passw = request.getParameter("password");
        String passw = PasswdGenerator.hashPassword(input_passw);

        AnnounceDAO announceDAO = new AnnounceDAO();
        AnnounceBean announce = announceDAO.getAnnouncementByNum(idx);

        if (announce != null) {
            password = announce.getPassword();
        }

        if (password.equals(passw)) {
            announce.setTitle(title);
            announce.setMemo(memo);
            announceDAO.updateAnnouncement(announce);
%>
            <script language="javascript">
                self.window.alert("글이 수정되었습니다.");
                location.href="announcedetail.jsp?idx=<%=idx%>";
            </script>
<%
        } else {
%>
            <script language="javascript">
                self.window.alert("비밀번호를 틀렸습니다.");
                location.href="javascript:history.back()";
            </script>
<%
        }

    } catch (Exception e) {
        out.println(e.toString());
    }
%>