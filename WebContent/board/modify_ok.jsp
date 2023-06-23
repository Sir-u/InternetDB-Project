<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>    
<%@ page import="java.util.*"%>
<%@ page import="com.web_project.db.DBConnection"%>
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
		String passw;
		if(input_passw.length() < 30){
			passw = PasswdGenerator.hashPassword(input_passw);
		}else{
			passw = input_passw;
		}

		Connection conn = DBConnection.getConnection();
		Statement stmt = conn.createStatement();

		String sql = "SELECT PASSWORD FROM board WHERE NUM=" + idx;
		ResultSet rs = stmt.executeQuery(sql);

		if (rs.next()) {
			password = rs.getString(1);
		}

		if (password.equals(passw)) {
			sql = "UPDATE board SET TITLE='" + title + "' ,MEMO='" + memo + "' WHERE NUM=" + idx;
			stmt.executeUpdate(sql);
%>
			<script language="javascript">
				self.window.alert("글이 수정되었습니다.");
				location.href="view.jsp?idx=<%=idx%>";
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

		rs.close();
		stmt.close();
	} catch (SQLException e) {
		out.println(e.toString());
	}
%>
