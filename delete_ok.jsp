<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Delete Result</title>
</head>
<body>
<%
	request.setCharacterEncoding("utf-8");
	String url = "jdbc:oracle:thin:@localhost:1521:XE";
	String id = "scott";
	String pass = "tiger";
	String password = null;
	int idx = Integer.parseInt(request.getParameter("idx"));
	String passw = request.getParameter("password");
	
	try {
		Class.forName("oracle.jdbc.driver.OracleDriver");
		Connection conn = DriverManager.getConnection(url, id, pass);
		Statement stmt = conn.createStatement();
		
		String sql = "SELECT PASSWORD FROM board WHERE NUM=" + idx;
		ResultSet rs = stmt.executeQuery(sql);
		
		if (rs.next()) {
			password = rs.getString(1);
		}
		 
		if (password.equals(passw)) {
			// 삭제할 글의 답글 먼저 삭제
			sql = "DELETE FROM reply WHERE reply_num IN (SELECT NUM FROM board WHERE NUM=" + idx + ")";
			stmt.executeUpdate(sql);
			
			// 글 삭제
			sql = "DELETE FROM board WHERE NUM=" + idx;
			int rowCount = stmt.executeUpdate(sql);
			
			if (rowCount > 0) {
				sql = "UPDATE board SET NUM = NUM - 1 WHERE NUM > " + idx;
				stmt.executeUpdate(sql);
				response.sendRedirect("list.jsp");
			} else {
%>
				<script language="javascript">
					self.window.alert("글 삭제에 실패했습니다.");
					location.href="javascript:history.back()";
				</script>
<%
			}
		} else {
%>
			<script language="javascript">
				self.window.alert("비밀번호가 틀렸습니다.");
				location.href="javascript:history.back()";
			</script>
<%
		}
		
		rs.close();
		stmt.close();
		conn.close();
	} catch (ClassNotFoundException | SQLException e) {
		e.printStackTrace();
	}
%>
</body>
</html>

