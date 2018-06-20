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
	<%@ include file="p_top.jsp"%>
	<%
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

		mySQL = "select * from professor where p_id='" + session_id + "'";

		ResultSet rs = stmt.executeQuery(mySQL);
		rs.next();
		String p_pwd = rs.getString("p_pwd");
		String p_name = rs.getString("p_name");
		String p_univ = rs.getString("p_univ");
		String p_major = rs.getString("p_major");
		String p_tel = rs.getString("p_tel");
		String p_office = rs.getString("p_office");
		String p_email = rs.getString("p_email");
	%>
	<form method="post" action="p_update_verify.jsp">
		<table width="50%" height="40%" align="center">
			<tr>
					<td><h3>내 정보 수정</h3>
					<font color="gray">
							<h5>(변경 가능 항목 : 비밀번호, 연락처, email)</h5> </br>
					</font> <b>이름</b> |&nbsp;&nbsp;&nbsp;<input class="inputArea" type="text" name="username"
						value=<%=p_name%> readonly /><br>
					<br></td>
				</tr>
				<br>
				<br>
				<tr>
					<td><b>아이디</b> |&nbsp;&nbsp;&nbsp;<input class="inputArea" type="text" id="userid"
						name="userid" value=<%=session_id%> readonly /> <br>
					<br></td>
				</tr>
				<tr>
					<td><b>비밀번호</b> |&nbsp;&nbsp;&nbsp;<input class="inputArea" type="password"
						name="password" id ="password" value=<%=p_pwd%> /><br><br></td>
				</tr>
				<tr>
					<td><b>소속</b> |&nbsp;&nbsp;&nbsp;<input class="inputArea" type="text" id="univ"
						name="univ" value=<%=p_univ%> readonly /> <br>
					<br></td>
				</tr>
				<tr>
					<td><b>전공</b> |&nbsp;&nbsp;&nbsp;<input class="inputArea" type="text" id="major"
						name="major" value=<%=p_major%> readonly /> <br>
					<br></td>
				</tr>
				<tr>
					<td><b>연락처</b> |&nbsp;&nbsp; <input class="inputArea" type="text" id="tel"
						name="tel" value=<%=p_tel%> /><br></br></td>
				</tr>
				<tr>
					<td><b>office</b> |&nbsp;&nbsp;&nbsp;<input class="inputArea" type="text" id="office"
						name="office" value=<%=p_office%> readonly /> <br><br></td>
				</tr>

				<tr>
					<td><b>e-mail</b> |&nbsp;&nbsp;&nbsp;<input class="inputArea" type="text" id="email"
						name="email" value=<%=p_email%> /> <br><br></td>
				</tr>
				<tr>
				<td>
				<input class="searchButton" type="reset" value="초기화" />&nbsp;&nbsp;
				<input class="searchButton" type="submit" value="수정" /></td>
				</tr>
		</table>
	</form>
</body>
</html>