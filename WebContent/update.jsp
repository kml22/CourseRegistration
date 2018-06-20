<%@ page contentType="text/html; charset=utf-8"%>
<link rel="stylesheet" href="topstyle.css" type="text/css">
<%@ page import="java.sql.*"%>
<HTML>
<head>
<title>수강신청 시스템 정보수정</title>
<style>
.inputArea {
	border:none;
}
</style>
</head>
<body>
	<%@ include file="top.jsp"%>
	<%
		if(session_id == null){
			%>
			<script>
			alert("로그인 후 사용하세요.");
			location.href("main.jsp");
			</script>
			<% 
		}
		else {
		String dbdriver = "oracle.jdbc.driver.OracleDriver";
		Class.forName(dbdriver);
		String dburl = "jdbc:oracle:thin:@localhost:1521:xe";
		String user = "siss";
		String passwd = "5155";
		Connection myConn = null;
		Statement stmt = null;
		String mySQL = null;

		myConn = DriverManager.getConnection(dburl, user, passwd);
		stmt = myConn.createStatement();

		mySQL = "select * from student where s_id='" + session_id + "'";

		ResultSet rs = stmt.executeQuery(mySQL);
		rs.next();
		String s_pwd = rs.getString("s_pwd");
		String s_name = rs.getString("s_name");
		String s_univ = rs.getString("s_univ");
		String s_major = rs.getString("s_major");
		String s_grade = rs.getString("s_grade");
		String s_tel = rs.getString("s_tel");
		String s_addr = rs.getString("s_addr");
	%>
	<form method="post" action="update_verify.jsp">
		<table width="50%" height="40%" align="center">
			<tr>
				<td><h3>내 정보 수정</h3>
				<font color="gray">
					<h5>(변경 가능 항목 : 비밀번호, 연락처, 주소)</h5> 
					</br>
				</font>
				<b>이름</b> |&nbsp;&nbsp;&nbsp;<input class="inputArea" type="text" name="username"
						value=<%=s_name%> readonly /><br><br>
				</td>
			</tr>
				<br>
				<br>
			<tr>
				<td><b>아이디</b> |&nbsp;&nbsp;&nbsp;<input class="inputArea" type="text" id="userid"
						name="userid" value=<%=session_id%> readonly /> <br><br></td>
			</tr>
			<tr>
				<td><b>비밀번호</b> |&nbsp;&nbsp;&nbsp;<input class="inputArea" type="password"
						name="password" id ="password" value=<%=s_pwd%> /><br><br></td>
			</tr>
			<tr>
				<td><b>소속</b> |&nbsp;&nbsp;&nbsp;<input class="inputArea" type="text" id="univ"
						name="univ" value=<%=s_univ%> readonly/> <br><br> 
				</td>
			</tr>			
			<tr>
				<td><b>전공</b> |&nbsp;&nbsp;&nbsp;<input class="inputArea" type="text" id="major"
						name="major" value=<%=s_major%> readonly /> <br><br></td>
			</tr>
			<tr>
				<td><b>학년</b> |&nbsp;&nbsp;&nbsp;<input class="inputArea" type="text" id="grade"
						name="grade" value=<%=s_grade%> readonly /> <br>
				<br></td>
			</tr>
			<tr>
				<td><b>연락처</b> |&nbsp;&nbsp; <input class="inputArea" type="text" id="tel"
						name="tel" value=<%=s_tel%> /><br></br></td>
			</tr>
			<tr>
				<td><b>주소</b> |&nbsp;&nbsp;&nbsp;<input class="inputArea" type="text" id="address"
						name="address" value=<%=s_addr%> /> <br><br></td>
			</tr>
			<tr>
				<td>
				<input class="searchButton" type="reset" value="초기화" />&nbsp;&nbsp;
				<input class="searchButton" type="submit" value="수정" /></td>
			</tr>
		</table>
	</form>
	<%} %>
</body>
</html>