<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*"  %>
<html>
<head> 
<title>수강신청취소 페이지입니다</title>
<style type="text/css">
.classtable {font-size:12px;color:#333333;width:75%;border-width: 1px;border-color: #729ea5;border-collapse: collapse; margin:50px auto;}
.classtable th {font-size:12px;background-color:#acc8cc;border-width: 1px;padding: 8px;border-style: solid;border-color: #729ea5;text-align:center;}
.classtable tr {background-color:#ffffff;}
.classtable td {font-size:12px;border-width: 1px;padding: 8px;border-style: solid;border-color: #729ea5;}
.classtable tr:hover {background-color:#ffff99;}
.title {margin-left: auto; margin-right: auto; margin-top: 50px; width: 180px;}
</style>
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
	%>
<table class="classtable" border="1" align="center" >
<tr>
	<th>과목번호</th>
	<th>과목명</th>
	<th>분반</th>
	<th>강의실</th>
	<th>시간</th>
	<th>교수명</th>
	<th>수강취소</th>
</tr>
<%	
	Connection myConn = null; 
	Statement stmt = null;	
	ResultSet myResultSet = null; 
	String mySQL = "";
	String mySQL2 = "";
	String mySQL3 = "";

	String dburl  = "jdbc:oracle:thin:@localhost:1521:xe";
	String user="siss";
	String passwd="5155";
	String dbdriver = "oracle.jdbc.driver.OracleDriver";    
	try {
		Class.forName(dbdriver);
	    myConn =  DriverManager.getConnection (dburl, user, passwd);
		stmt = myConn.createStatement();	
    } catch(SQLException ex) {
	     System.err.println("SQLException: " + ex.getMessage());
	}
	mySQL2 = "{? = call Date2EnrollYear(SYSDATE)}";
	CallableStatement cstmt1 = myConn.prepareCall(mySQL2);
	cstmt1.registerOutParameter(1,java.sql.Types.INTEGER);
	cstmt1.execute();
	int nYear = cstmt1.getInt(1);
	
 	mySQL3 = "{? = call Date2EnrollSemester(SYSDATE)}";
	CallableStatement cstmt2 = myConn.prepareCall(mySQL3);
	cstmt2.registerOutParameter(1,java.sql.Types.INTEGER);
	cstmt2.execute();
	int nSemester = cstmt2.getInt(1);
%>
<p class="title">
<%=nYear%>년도 <%=nSemester%>학기 수강삭제
</p>
<%
	mySQL = "select c_id, c_name, c_class, c_classroom, c_day, c_credit, c_time, p_name from course c, professor p where c.p_id = p.p_id and (c.c_id, c.c_class) in (select c_id, c_class from enroll where e_year ="
			+ nYear + " and e_semester ="+ nSemester + " and s_id='" + session_id + "')";
	myResultSet = stmt.executeQuery(mySQL);	
	if (myResultSet != null) {
		while (myResultSet.next()) {
			int c_id = myResultSet.getInt("c_id");	
			String c_name = myResultSet.getString("c_name");
			String c_class = myResultSet.getString("c_class");	
			String c_classroom = myResultSet.getString("c_classroom");
			String p_name = myResultSet.getString("p_name");
			String c_dayAndTime = myResultSet.getString("c_day")+myResultSet.getString("c_time");
%>
	<tr>
	  <td align="center"><%= c_id %></td>
	  <td align="center"><%= c_name %></td>
	  <td align="center"><%= c_class %></td>
	  <td align="center"><%= c_classroom %></td>
	  <td align="center"><%= c_dayAndTime %></td>
	  <td align="center"><%= p_name %></td>
	  <td align="center"><a href="delete_verify.jsp?c_id=<%= c_id %>&c_id=<%= c_id %>&c_class=<%= c_class %>" >삭제</a></td>
	</tr>
<%
	}
	}
	stmt.close(); 
	myConn.close();
%>
</table>
</body>
</html>
			