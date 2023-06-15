<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>답글 작성</title>
</head>
<body>
    <h2>답글 작성</h2>
    <form method="post" action="reply_ok.jsp">
        <input type="hidden" name="replyNum" value="<%= request.getParameter("idx") %>">
        <table>
            <tr>
                <td>작성자명:</td>
                <td><input type="text" name="replyUsername"></td>
            </tr>
            <tr>
                <td>내용:</td>
                <td><textarea name="replyContent" rows="5" cols="40"></textarea></td>
            </tr>
            <tr>
                <td colspan="2"><input type="submit" value="작성"></td>
            </tr>
        </table>
    </form>
</body>
</html>
