<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*"%>
<%
Class.forName("oracle.jdbc.driver.OracleDriver");
String url = "jdbc:oracle:thin:@localhost:1521:XE";
String id = "scott";
String pass = "tiger";
int idx = Integer.parseInt(request.getParameter("idx"));

try {
    Connection conn = DriverManager.getConnection(url, id, pass);
    Statement stmt = conn.createStatement();

    // 원문 글 정보 가져오기
    String sql = "SELECT USERNAME, TITLE, MEMO, TIME, HIT FROM board WHERE NUM=" + idx;
    ResultSet rs = stmt.executeQuery(sql);
    if (rs.next()) {
        String name = rs.getString(1);
        String title = rs.getString(2);
        String memo = rs.getString(3);
        String time = rs.getString(4);
        int hit = rs.getInt(5);
        hit++;

        // 답글 정보 가져오기
        sql = "SELECT REPLY_USERNAME, REPLY_CONTENT, REPLY_TIME FROM REPLY WHERE REPLY_NUM=" + idx;
        ResultSet replyRs = stmt.executeQuery(sql);

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>게시판</title>
</head>
<body>
<table>
    <tr>
        <td>
            <table width="100%" cellpadding="0" cellspacing="0" border="0">
                <tr style="text-align:center;">
                    <td width="5"></td>
                    <td>내 용</td>
                    <td width="5"></td>
                </tr>
            </table>
            <table width="413">
                <tr>
                    <td width="0">&nbsp;</td>
                    <td align="center" width="76">글번호</td>
                    <td width="319"><%=idx%></td>
                    <td width="0">&nbsp;</td>
                </tr>
                <tr height="1" bgcolor="#dddddd">
                    <td colspan="4" width="407"></td>
                </tr>
                <tr>
                    <td width="0">&nbsp;</td>
                    <td align="center" width="76">조회수</td>
                    <td width="319"><%=hit%></td>
                    <td width="0">&nbsp;</td>
                </tr>
                <tr height="1" bgcolor="#dddddd">
                    <td colspan="4" width="407"></td>
                </tr>
                <tr>
                    <td width="0">&nbsp;</td>
                    <td align="center" width="76">이름</td>
                    <td width="319"><%=name%></td>
                    <td width="0">&nbsp;</td>
                </tr>
                <tr height="1" bgcolor="#dddddd">
                    <td colspan="4" width="407"></td>
                </tr>
                <tr>
                    <td width="0">&nbsp;</td>
                    <td align="center" width="76">작성일</td>
                    <td width="319"><%=time%></td>
                    <td width="0">&nbsp;</td>
                </tr>
                <tr height="1" bgcolor="#dddddd">
                    <td colspan="4" width="407"></td>
                </tr>
                <tr>
                    <td width="0">&nbsp;</td>
                    <td align="center" width="76">제목</td>
                    <td width="319"><%=title%></td>
                    <td width="0">&nbsp;</td>
                </tr>
                <tr height="1" bgcolor="#dddddd">
                    <td colspan="4" width="407"></td>
                </tr>
                <tr>
                    <td width="0"></td>
                    <td width="399" colspan="2" height="200"><%=memo %>
                </tr>
                <tr height="1" bgcolor="#dddddd">
                    <td colspan="4" width="407"></td>
                </tr>
                <tr height="1" bgcolor="#82B5DF">
                    <td colspan="4" width="407"></td>
                </tr>
                <tr align="center">
                    <td width="0">&nbsp;</td>
                    <td colspan="2" width="399">
                        <input type="button" value="글쓰기" OnClick="window.location='write.jsp'">
                        <input type="button" value="목록" OnClick="window.location='list.jsp'">
                        <input type="button" value="답글" OnClick="window.location='reply.jsp?idx=<%=idx%>'">
                        <input type="button" value="수정" OnClick="window.location='modify.jsp?idx=<%=idx%>'">
                        <input type="button" value="삭제" OnClick="window.location='delete.jsp?idx=<%=idx%>'">
                    </td>
                    <td width="0">&nbsp;</td>
                </tr>
            </table>
        </td>
    </tr>
    <% while (replyRs.next()) {
        String replyUsername = replyRs.getString(1);
        String replyContent = replyRs.getString(2);
        String replyTime = replyRs.getString(3);
    %>
    <tr>
        <td>
            <table width="100%" cellpadding="0" cellspacing="0" border="0">
                <tr style="text-align:center;">
                    <td width="5"></td>
                    <td>답 글</td>
                    <td width="5"></td>
                </tr>
            </table>
            <table width="413">
                <tr>
                    <td width="0">&nbsp;</td>
                    <td align="center" width="76">작성자</td>
                    <td width="319"><%=replyUsername%></td>
                    <td width="0">&nbsp;</td>
                </tr>
                <tr height="1" bgcolor="#dddddd">
                    <td colspan="4" width="407"></td>
                </tr>
                <tr>
                    <td width="0">&nbsp;</td>
                    <td align="center" width="76">내용</td>
                    <td width="319"><%=replyContent%></td>
                    <td width="0">&nbsp;</td>
                </tr>
                <tr height="1" bgcolor="#dddddd">
                    <td colspan="4" width="407"></td>
                </tr>
                <tr>
                    <td width="0">&nbsp;</td>
                    <td align="center" width="76">작성일</td>
                    <td width="319"><%=replyTime%></td>
                    <td width="0">&nbsp;</td>
                </tr>
                <tr height="1" bgcolor="#dddddd">
                    <td colspan="4" width="407"></td>
                </tr>
            </table>
        </td>
    </tr>
    <% }
    replyRs.close();
    rs.close();
    stmt.close();
    conn.close();
} 
} catch (SQLException e) {
    e.printStackTrace();
}
%>
</table>
</body>
</html>
