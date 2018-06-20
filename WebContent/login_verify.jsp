<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	String dbdriver = "oracle.jdbc.driver.OracleDriver";
	Class.forName(dbdriver);
	String dburl = "jdbc:oracle:thin:@localhost:1521:xe";
	String user = "siss";
	String passwd = "5155";
	Connection myConn = null;
    
    Statement stmt = null;
    Statement stmt2 = null;
    
    String mySQL = null;
    String mySQL2 = null;
    
    ResultSet rs = null;
    ResultSet rs2 = null;
    
    String userID = request.getParameter("userID");
    String userPassword= request.getParameter("userPassword");
    String id="";
    
    mySQL = "select s_id from student where s_id='"+userID+"' and s_pwd='"+userPassword+"'";
	mySQL2 = "select p_id from professor where p_id='"+userID+"' and p_pwd='"+userPassword+"'";
    
    try{
    	myConn = DriverManager.getConnection(dburl, user, passwd);
    	stmt = myConn.createStatement();
    	stmt2 = myConn.createStatement();
    }
    catch(SQLException e){
    	
    }  
    try{	
    	rs = stmt.executeQuery(mySQL);
		rs2 = stmt2.executeQuery(mySQL2);	
    }
 	catch(SQLException e){
    	System.out.println("rs try catch문  "+userID+' '+userPassword);	
    }
	
    System.out.println(userID+' '+userPassword);	
	
    if(rs != null && rs.next()){// 학생 로그인 
		id=rs.getString(1);
		System.out.println("Student log in : "+rs.getString(1));
		session.setAttribute("user",id);
	%>
		<script>
		alert("로그인 되었습니다.");
		location.href("main.jsp");
		</script>
	<%
	}else if(rs2 != null && rs2.next()){// 교수 로그인
		id=rs2.getString(1);
		System.out.println("Professor log in : "+rs2.getString(1));
		session.setAttribute("user",id);
		%>	
		<script>
		alert("로그인 되었습니다.");
		location.href("p_main.jsp");
		</script>
		<% 
	}else {
		System.out.println("로그인 실패");
		%>
		<script>
		alert("아이디와 비밀번호를 확인하세요.");
		location.href("main.jsp");
		</script>	
	<%
	}
	stmt.close();
	myConn.close();
    %>