<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>수강신청 입력</title>
</head>
<%@ include file="top.jsp" %>
<body>
	<%
		String s_id = (String)session.getAttribute("user");
		String c_id = request.getParameter("c_id");
		String c_class = request.getParameter("c_class");
		
		String dbdriver = "oracle.jdbc.driver.OracleDriver";	
		String dburl = "jdbc:oracle:thin:@localhost:1521:xe";
		String user = "siss";
		String passwd = "5155";
		
		Connection myConn = null;
		String result = "";
		
		try {
			Class.forName(dbdriver);
			myConn = DriverManager.getConnection(dburl, user, passwd);
		}catch (SQLException ex) {
			System.err.println("SQLException: " + ex.getMessage());			
		}
		
		CallableStatement cstmt = myConn.prepareCall("{call InsertEnroll(?,?,?,?)}");
		cstmt.setString(1, s_id);
		cstmt.setString(2, c_id);
		cstmt.setString(3, c_class);
		cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
		
		try {
			cstmt.execute();
			result = cstmt.getString(4);	
	%>
	<script>
		alert("<%=result%>");
		location.href = "insert.jsp"
	</script>	
	<%
		}catch (SQLException ex) {
			System.err.println("SQLException: " + ex.getMessage());
		}finally {
			if(cstmt != null)
				try {
					myConn.commit();
					cstmt.close();
					myConn.close();
				}catch (SQLException ex) {
				}
		}
	%>	
</body>
</html>