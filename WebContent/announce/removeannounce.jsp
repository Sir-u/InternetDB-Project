<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.web_project.announce.AnnounceDAO" %>
<%@ page import="com.web_project.announce.AnnounceBean" %>
<%@ page import="com.web_project.db_env.PasswdGenerator" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Delete Result</title>
</head>
<body>
<%
    request.setCharacterEncoding("utf-8");
    int idx = Integer.parseInt(request.getParameter("idx"));
    String inputPassw = request.getParameter("password");
    String hashedPassw = PasswdGenerator.hashPassword(inputPassw);

    AnnounceDAO announceDAO = new AnnounceDAO();
    AnnounceBean announce = announceDAO.getAnnouncementByNum(idx);

    if (announce != null) {
        String password = announce.getPassword();

        if (password.equals(hashedPassw)) {
            // 글 삭제
            announceDAO.deleteAnnouncement(idx);
            announceDAO.updateAnnouncementNumbers(idx);

            response.sendRedirect("announcelist.jsp");
        } else {
%>
            <script language="javascript">
                self.window.alert("비밀번호가 틀렸습니다.");
                location.href="javascript:history.back()";
            </script>
<%
        }
    } else {
%>
        <script language="javascript">
            self.window.alert("해당하는 글을 찾을 수 없습니다.");
            location.href="javascript:history.back()";
        </script>
<%
    }
%>
</body>
</html>
