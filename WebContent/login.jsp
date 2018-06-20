<%@ page contentType="text/html; charset=utf-8" %>
<link rel="stylesheet" href="topstyle.css" type="text/css">
<HTML>
<head><title>수강신청 시스템 로그인</title></head>
<BODY>
<%@ include file="top.jsp" %>
<br>
	<table width="75%" align="center" >
		<tr><td><div align="center"> 아이디와 패스워드를 입력하세요</table>
<br>
	<table width="75%" align="center" >
		<FORM method="post" action="login_verify.jsp" >
		<tr>
			<td><div align="center">아이디</div></td>
			<td><div align="center"><input type="text" name="userID"></div></td>
		</tr>
		<tr>
			<td><div align="center">패스워드</div></td>
			<td><div align="center"><input type="password" name="userPassword"></div></td>
		</tr>
		<tr>
			<td colspan=2><div align="center">
			<INPUT TYPE="SUBMIT" NAME="Submit" VALUE="로그인">
			<INPUT TYPE="button" VALUE="취소" onclick="location.href='main.jsp'">
			</div></td>
		</tr>
	</table>
	</FORM>
	</BODY> 
</HTML>