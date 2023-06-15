<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Delete Page</title>
</head>
<body>
	<table>
		<form name="deleteform" method="post" action="delete_ok.jsp">
			<tr>
				<td>
					<table width="100%" cellpadding="0" cellspacing="0" border="0">
						<tr style="text-align:center;">
							<td>삭제</td>
						</tr>
					</table>
					<table>
						<tr>
							<td>&nbsp;</td>
							<td align="center">비밀번호</td>
							<td><input name="password" type="password" size="50" maxlength="100"></td>
							<td>&nbsp;</td>
						</tr>
						<tr height="1" bgcolor="#dddddd">
							<td colspan="4"></td>
						</tr>
						<tr height="1" bgcolor="#82B5DF">
							<td colspan="4"></td>
						</tr>
						<tr align="center">
							<td>&nbsp;</td>
							<td colspan="2">
								<input type="hidden" name="idx" value="<%= request.getParameter("idx") %>">
								<input type="button" value="삭제" onclick="deleteCheck();">
								<input type="button" value="취소" onclick="javascript:history.back(-1)">
							</td>
							<td>&nbsp;</td>
						</tr>
					</table>
				</td>
			</tr>
		</form>
	</table>

	<script language="javascript">
		function deleteCheck() {
			var form = document.deleteform;

			if (!form.password.value) {
				alert("비밀번호를 입력해주세요.");
				form.password.focus();
				return;
			}

			form.submit();
		}
	</script>
</body>
</html>
