<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.web_project.member.MemberBean" %>
<%@ page import="com.web_project.member.MemberDAO" %>
<%@ page import="com.web_project.announce.AnnounceBean" %>
<%@ page import="com.web_project.announce.AnnounceDAO" %>

<%
    request.setCharacterEncoding("utf-8");
    MemberDAO memberDAO = new MemberDAO();
    
    int stdnum = (Integer) session.getAttribute("id");
    String name = (String) session.getAttribute("usrname");
    MemberBean member = memberDAO.getMemberByStdnum(stdnum);
    String password = member.getPasswd();
    String title = request.getParameter("title");
    String memo = request.getParameter("memo");

    AnnounceBean announce = new AnnounceBean();
    announce.setStdnum(stdnum);
    announce.setUsrname(name);
    announce.setPassword(password);
    announce.setTitle(title);
    announce.setMemo(memo);

    AnnounceDAO announceDAO = new AnnounceDAO();
    announceDAO.createAnnouncement(announce);
%>
<script language="javascript">
    self.window.alert("입력한 글을 저장하였습니다.");
    location.href="announcelist.jsp"; 
</script>
