<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>수강신청 페이지입니다</title>
<style type="text/css">
.classtable {font-size:12px;color:#333333;width:75%;border-width: 1px;border-color: #729ea5;border-collapse: collapse; margin:50px auto;}
.classtable th {font-size:12px;background-color:#acc8cc;border-width: 1px;padding: 8px;border-style: solid;border-color: #729ea5;text-align:center;}
.classtable tr {background-color:#ffffff;}
.classtable td {font-size:12px;border-width: 1px;padding: 8px;border-style: solid;border-color: #729ea5;}
.classtable tr:hover {background-color:#ffff99;}
.title {margin-left: auto; margin-right: auto; margin-top: 50px; width: 180px;}
.searchTable {margin-top : 80px;margin-right : auto;margin-left : auto;}
.searchArea {width : 250px;height : 30px;}
</style>
</head>
<body>
<%@ include file="top.jsp" %>
<%
		if(session_id == null){
			%>
			<script>
			alert("로그인 후 사용하세요.");
			location.href("main.jsp");
			</script>
			<% 
		}
	%>

<table class="classtable" border="1" align="center">
	<tr>
		<th>과목번호</th>
		<th>분반</th>
		<th>과목명</th>
		<th>시간</th>
		<th>강의실</th>
		<th>학점</th>
		<th>교수명</th>
		<th>신청</th>
		<th>정원</th>
		<th>수강신청</th>
	</tr>
	<%
		String dbdriver = "oracle.jdbc.driver.OracleDriver";
		Class.forName(dbdriver);
		String dburl = "jdbc:oracle:thin:@localhost:1521:xe";
		String user = "siss";
		String passwd = "5155";
		
		Connection myConn = null;
		Statement stmt = null;
		ResultSet rs = null;
		
		String mySQL = "";
		String mySQL2 = "";
		String mySQL3 = "";
		String studentCount = "";
		
		try {
			myConn = DriverManager.getConnection(dburl, user, passwd);
			stmt = myConn.createStatement();
		}catch(SQLException ex) {
			System.err.println("SQLException: " + ex.getMessage());
		}
		
		mySQL = "{? = call Date2EnrollYear(SYSDATE)}";
		CallableStatement cstmt = myConn.prepareCall(mySQL);
		cstmt.registerOutParameter(1, java.sql.Types.INTEGER);
		cstmt.execute();
		int nYear = cstmt.getInt(1);
		
		mySQL2 = "{? = call Date2EnrollSemester(SYSDATE)}";
		CallableStatement cstmt2 = myConn.prepareCall(mySQL2);
		cstmt2.registerOutParameter(1, java.sql.Types.INTEGER);
		cstmt2.execute();
		int nSemester = cstmt2.getInt(1);
		%>
		
		<p class="title">
		<%=nYear%>년도
		<%=nSemester%>학기 수강신청
		</p>	
		<%
		mySQL3 = "select c.c_classroom, c.c_max, c.c_id, c.c_name, c.c_day, c.c_time, c.c_class, c.c_credit, p.p_name from course c, professor p where c.p_id = p.p_id and (c.c_id, c.c_class) IN (select c_id, c_class from teach where t_year ="
				+ nYear + " and t_semester =" + nSemester + ") order by c_id, c_class";
		
		rs = stmt.executeQuery(mySQL3);
		
		if(rs != null) {
			while(rs.next()) {
				String c_id = rs.getString("c_id");
				String c_name = rs.getString("c_name");
				String c_credit = rs.getString("c_credit");
				String c_dayAndTime = rs.getString("c_day") + rs.getString("c_time");
				String c_class = rs.getString("c_class");
				String c_classroom = rs.getString("c_classroom");
				String c_max = rs.getString("c_max");
				String p_name = rs.getString("p_name");
				
				CallableStatement cstmt3 = myConn.prepareCall("{call countStudent(?,?,?,?,?)}");
				cstmt3.setString(1, c_id);
				cstmt3.setString(2, c_class);
				cstmt3.setInt(3, nYear);
				cstmt3.setInt(4, nSemester);
				cstmt3.registerOutParameter(5, java.sql.Types.VARCHAR);
				cstmt3.execute();
				studentCount = cstmt3.getString(5);
				%>		
				<tr>	
					<td align="center"><%=c_id%></td>
					<td align="center"><%=c_class%></td>
					<td align="center"><%=c_name%></td>
					<td align="center"><%=c_dayAndTime%></td>
					<td align="center"><%=c_classroom%></td>
					<td align="center"><%=c_credit%></td>
					<td align="center"><%=p_name%></td>
					<td align="center"><%=studentCount%></td>
					<td align="center"><%=c_max%></td>
					<td align="center"><a href="insert_verify.jsp?c_id=<%=c_id%>&c_class=<%=c_class%>">신청</a></td>
				</tr>					
<% 				
		}	
		}
		stmt.close();
		myConn.close();
%>
		<form action="search.jsp">
			<table class="searchTable" >
				<tr>
					<td align="center" width="700px"><input class="searchArea"
					type="text" name="search" value="검색할 과목명/과목 번호를 입력하세요."> <input
					class="searchButton" type="submit" value="검색"></td>
					</tr>
			</table>
		</form>	
</table>
</body>
</html>