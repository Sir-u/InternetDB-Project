<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%> 
<!DOCTYPE html>
<html>
<head>
    <title>게시판</title>
</head>
<body>
    <%-- 주석: modifyCheck() 함수 위치를 수정 --%>
    <script language="javascript">
        function modifyCheck() {
            var form = document.modifyform;

            if (!form.password.value) {
                alert("비밀번호를 입력해주세요.");
                form.password.focus();
                return;
            }

            if (!form.title.value) {
                alert("제목을 입력해주세요.");
                form.title.focus();
                return;
            }

            if (!form.memo.value) {
                alert("내용을 입력해주세요.");
                form.memo.focus();
                return;
            }

            form.submit();
        }
    </script>
    <%
        request.setCharacterEncoding("utf-8");
        Class.forName("oracle.jdbc.driver.OracleDriver");

        String url = "jdbc:oracle:thin:@localhost:1521:XE";
        String id = "scott";
        String pass = "tiger";

        String name = "";
        String password = "";
        String title = "";
        String memo = "";
        int idx = Integer.parseInt(request.getParameter("idx"));

        try {
            Connection conn = DriverManager.getConnection(url, id, pass);
            Statement stmt = conn.createStatement();

            String sql = "SELECT USERNAME, PASSWORD, TITLE, MEMO FROM board WHERE NUM=" + idx;
            ResultSet rs = stmt.executeQuery(sql);

            if (rs.next()) {
                name = rs.getString(1);
                password = rs.getString(2);
                title = rs.getString(3);
                memo = rs.getString(4);
            }

            rs.close();
            stmt.close();
            conn.close();

        } catch (SQLException e) {
            out.println(e.toString());
        }
    %>
    <form name="modifyform" method="post" action="modify_ok.jsp?idx=<%=idx%>">
        <table>
            <tr>
                <td>
                    <table width="100%" cellpadding="0" cellspacing="0" border="0">
                        <tr style="text-align:center;">
                            <td>수정</td>
                        </tr>
                    </table>
                    <table>
                        <tr>
                            <td>&nbsp;</td>
                            <td align="center">제목</td>
                            <td><input name="title" size="50" maxlength="100" value="<%=title%>"></td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr height="1" bgcolor="#dddddd">
                            <td colspan="4"></td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                            <td align="center">이름</td>
												<td><%=name%><input type=hidden name=name size=50  maxlength=50 value="<%=name%>"></td>                            <td>&nbsp;</td>
                        </tr>
                        <tr height="1" bgcolor="#dddddd">
                            <td colspan="4"></td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                            <td align="center">비밀번호</td>
                            <%-- 수정: password 필드 name 속성 값 수정 --%>
                            <td><input type="password" name="password" size="50" maxlength="50"></td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr height="1" bgcolor="#dddddd">
                            <td colspan="4"></td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                            <td align="center">내용</td>
                            <td><textarea name="memo" cols="50" rows="13"><%=memo%></textarea></td>
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
                                <%-- 수정: 수정 버튼의 type 속성 값을 "submit"으로 변경 --%>
                                <input type="submit" value="수정">
                                <input type="button" value="취소">
                            </td>
                            <td>&nbsp;</td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </form>
</body>
</html>