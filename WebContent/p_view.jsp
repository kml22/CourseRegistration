<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>수업 목록</title>
<style type="text/css">
.classtable {font-size:12px;color:#333333;width:75%;border-width: 1px;border-color: #729ea5;border-collapse: collapse; margin:50px auto;}
.classtable th {font-size:12px;background-color:#acc8cc;border-width: 1px;padding: 8px;border-style: solid;border-color: #729ea5;text-align:center;}
.classtable tr {background-color:#ffffff;}
.classtable td {font-size:12px;border-width: 1px;padding: 8px;border-style: solid;border-color: #729ea5;}
.classtable tr:hover {background-color:#ffff99;}
.title {margin-left: auto; margin-right: auto; margin-top: 50px; width: 300px;}
</style>
</head>
<body>
	<%@ include file="p_top.jsp"%>
	<%
		if (session_id == null)
			response.sendRedirect("login.jsp");
	%>
	<table class="classtable" width="75%" align="center" border>
		<tr>
			<th>과목번호</th>
			<th>분반</th>
			<th>과목명</th>
		</tr>
		<%
			Connection myConn = null;
			Statement stmt = null;
			ResultSet myResultSet = null;
			String mySQL = "";
			String mySQL2 = "";
			String mySQL3 = "";
			String dburl = "jdbc:oracle:thin:@localhost:1521:xe";
			String user = "siss";
			String passwd = "5155";
			String dbdriver = "oracle.jdbc.driver.OracleDriver";
			try {
				Class.forName(dbdriver);
				myConn = DriverManager.getConnection(dburl, user, passwd);
				stmt = myConn.createStatement();
			} catch (SQLException ex) {
				System.err.println("SQLException: " + ex.getMessage());
			}
			
			mySQL2 = "{? = call Date2EnrollYear(SYSDATE)}";
			CallableStatement cstmt = myConn.prepareCall(mySQL2);
			cstmt.registerOutParameter(1, java.sql.Types.INTEGER);
			cstmt.execute();
			int nYear = cstmt.getInt(1);

			mySQL3 = "{? = call Date2EnrollSemester(SYSDATE)}";
			CallableStatement cstmt2 = myConn.prepareCall(mySQL3);
			cstmt2.registerOutParameter(1, java.sql.Types.INTEGER);
			cstmt2.execute();
			int nSemester = cstmt2.getInt(1);

			
			mySQL = "select c.c_id, c.c_class, c.c_name from course c, professor p where c.p_id=p.p_id and p.p_id=" + session_id +"and (c.c_id, c.c_class) IN (select c_id, c_class from teach where t_year ="
					+ nYear + " and t_semester =" + nSemester + ") order by c_id, c_class";
			myResultSet = stmt.executeQuery(mySQL);
			if (myResultSet != null) {
				while (myResultSet.next()) {
					int c_id = myResultSet.getInt("c_id");
					String c_class = myResultSet.getString("c_class");
					String c_name = myResultSet.getString("c_name");
		%>
		<tr>
			<td align="center"><%=c_id%></td>
			<td align="center"><%=c_class%></td>
			<td align="center">
			<a href="p_view_student.jsp?c_id=<%=c_id%>&c_class=<%=c_class%>"><%=c_name%></a></td>			
		</tr>
		<%
			}
			}
			stmt.close();
			myConn.close();
		%>
		<p class="title" align="center">
			<%=nYear%>년도 <%=nSemester%>학기 수업 목록<br></br>
			과목명을 누르면 수강생 조회가 가능합니다¸
		</p>
	</table>
</body>
</html>
