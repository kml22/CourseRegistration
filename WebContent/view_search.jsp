<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*"%>
<html>
<head>
<title>수강신청 조회</title>
<style type="text/css">
.classtable {
font-size:12px;
color:#333333;width:75%;border-width: 1px;border-color: #729ea5;border-collapse: collapse; margin:50px auto;}
.classtable th {font-size:12px;background-color:#acc8cc;border-width: 1px;padding: 8px;border-style: solid;border-color: #729ea5;text-align:center;}
.classtable tr {background-color:#ffffff;}
.classtable td {font-size:12px;border-width: 1px;padding: 8px;border-style: solid;border-color: #729ea5;}
.title {margin-left: auto; margin-right: auto; margin-top: 50px; width: 180px;}
.view {margin-left: auto; margin-right: auto; margin-top: 50px; width: 180px;}
.simpletable { 
   width: 75%; 
   border-collapse: collapse; 
   margin:50px auto;
    font-family: 'Nanum Gothic', sans-serif;
}
.simpletable th { 
   background: #3498db; 
   color: white; 
   font-weight: bold; 
   }
.simpletable td, th { 
   padding: 8px; 
   border: 1px solid #ccc;  
   font-size: 12px;
   text-align : center;
   }
</style>
</head>
<body>
	<%@ include file="top.jsp"%>
	<%
		if (session_id == null)
			response.sendRedirect("top.jsp");
	%>
	<form id="my_form" action="view_search.jsp" method="post">
		<table class="classtable" width="75%" align="center" border>
			<tr>
				<th>과목번호</th>
				<th>분반</th>
				<th>과목명</th>
				<th>강의실</th>
				<th>시간</th>
				<th>학점</th>
				<th>교수명</th>
			</tr>
			<%
			    int nYear = Integer.parseInt(request.getParameter("nYear"));
			    int nSemester = Integer.parseInt(request.getParameter("nSemester"));
				String result1 = null;
				String result2 = null;
				Connection myConn = null;
				Statement stmt = null;
				Statement stmt2 = null;
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
				
				mySQL = "select c_id, c_name, c_class, c_classroom, c_day, c_credit, c_time, p_name from course c, professor p where c.p_id = p.p_id and (c.c_id, c.c_class) in (select c_id, c_class from enroll where e_year ="
						+ nYear + " and e_semester ="+ nSemester + " and s_id='"+ session_id + "')";
				myResultSet = stmt.executeQuery(mySQL);

				if (myResultSet != null) {
					while (myResultSet.next()) {
						int c_id = myResultSet.getInt("c_id");
						String c_name = myResultSet.getString("c_name");
						String c_class = myResultSet.getString("c_class");
						String c_classroom = myResultSet.getString("c_classroom");
						String c_credit = myResultSet.getString("c_credit");
						String p_name = myResultSet.getString("p_name");
						String c_dayAndTime = myResultSet.getString("c_day") + myResultSet.getString("c_time");
			%>
			<tr>
				<td align="center"><%=c_id%></td>
				<td align="center"><%=c_class%></td>
				<td align="center"><%=c_name%></td>
				<td align="center"><%=c_classroom%></td>
				<td align="center"><%=c_dayAndTime%></td>
				<td align="center"><%=c_credit%></td>
				<td align="center"><%=p_name%></td>
				</td>
			</tr>
	
			<%
				}
				}
		
				CallableStatement cstmt = myConn.prepareCall("{call SelectTimeTable(?,?,?,?,?)}");
				cstmt.setString(1, session_id);
				cstmt.setInt(2, nYear);
				cstmt.setInt(3, nSemester);
				cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
				cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
				try {
					cstmt.execute();
					result1 = cstmt.getString(4);
					result2 = cstmt.getString(5);
			%>
		<p class="view">
		<%=nYear%>년도 <%=nSemester%>학기 수강조회
		</p>
			<table class="simpletable">
			<tr>
				<td>총 신청 과목 수</td>
				<td><%=result1%></td>
			</tr>
			<tr>
				<td>총 신청 학점 수</td>
				<td><%=result2%></td>
			</tr>
			</table>	
			<table class="simpletable">
			<tr align="center">
				<td><input type="text" id="nYear" name="nYear" value=<%=nYear%> /> 년도</td>
				<td><input type="text" id="nSemester" name="nSemester" value=<%=nSemester%> />학기</td>
				<td><input type="submit" value="조회" /></td>
			</tr>
			</table>
			<%
				} catch (SQLException ex) {
					System.err.println("SQLException: " + ex.getMessage());
				} finally {
					if (cstmt != null)
						try {
							myConn.commit();
							cstmt.close();
							myConn.close();
						} catch (SQLException ex) {
						}
				}
			%>
		</table>
		</form>
	</body>
</html>