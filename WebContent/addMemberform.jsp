<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 창</title>
    <link rel="stylesheet" href="https://code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>
    <script>
        $(function() {
            $("#datepicker").datepicker({
                dateFormat: "yy-mm-dd", // 월과 일 형식 설정 (예: 05-31)
                showMonth: true, // 월 선택기 숨김
                showYear: true, // 년 선택기 숨김
                changeMonth: false, // 월 선택기 숨김
                changeYear: true,
                yearRange: "1950:2030"
            });
        });
        
        window.onload = function() {
            var now = new Date();
            var year = now.getFullYear();
            var month = ('0' + (now.getMonth() + 1)).slice(-2);
            var day = ('0' + now.getDate()).slice(-2);
            var currentTime = year + '-' + month + '-' + day;
            document.getElementById("reg_date").value = currentTime;
        }
    </script>

</head>
<body>
<h2>회원의 정보 입력 폼</h2>
	<form action="addMember.jsp" method = "post">
	<table>
		<tr>
		<td> 학번 </td>
		<td> <input type = "number" name = "stdnum" size = "20"> </td>
		</tr>
		
		<tr>
		<td> 비밀번호 </td>
		<td> <input type = "password" name = "passwd" size = "20"> </td>
		</tr>
		
		<tr>
		<td> 이름 </td>
		<td> <input type = "text" name = "usrname" size = "20"> </td>
		</tr>
		
		<tr>
		<td> 성별 </td>
		<td> 
			<select name="gender">
	            <option value="male">남성</option>
	            <option value="female">여성</option>
        	</select>
        </td>
		</tr>
		
		<tr>
        <td> 생일 </td>
        <td> <input type="text" id="datepicker" name="birthday"> </td>
        </tr>
		
		<tr>
		<td> 나이 </td>
		<td> <input type = "number" name = "age" size = "20"> </td>
		</tr>
		
		<tr>
		<td> 등록일 </td>
		<td> <input type = "text" id="reg_date" name = "reg_date" size = "20" readonly> </td>
		</tr>
		
		
		<tr>
		<td> <input type = "submit" value = "전송"> </td>
		<td> <input type = "reset" value = "취소"> </td>
		</tr>
		
	</table>
	
	</form>
	
<a href="home.jsp">홈으로</a>

</body>
</html>