<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>학생조회</title>
<style type="text/css">
.classtable {font-size:12px;color:#333333;width:75%;border-width: 1px;border-color: #729ea5;border-collapse: collapse; margin:50px auto; text-align:center;}
.classtable th {font-size:12px;background-color:#acc8cc;border-width: 1px;padding: 8px;border-style: solid;border-color: #729ea5;text-align:center;}
.classtable tr {background-color:#ffffff;}
.classtable td {font-size:12px;border-width: 1px;padding: 8px;border-style: solid;border-color: #729ea5;}
.classtable tr:hover {background-color:#ffff99;}
.title {margin-left: auto; margin-right: auto; margin-top: 50px; width: 200px;}
</style>
</head>
<body>
   <%@ include file="p_top.jsp"%>
   <%
	String c_class = (String) request.getParameter("c_class");
   %>
   <table class="classtable" width="75%" align="center" border>
      <tr>
         <th>이름</th>
         <th>학번</th>
         <th>학과</th>
         <th>학년</th>
         <th>연락처</th>
      </tr>
      <%
		 String c_id = (String)request.getParameter("c_id");
         Connection myConn = null;
         Statement stmt = null;
         ResultSet myResultSet = null;
         String mySQL = "";
         String mySQL2 = "";
         String mySQL3 = "";
         String result1 = "";
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
         CallableStatement cstmt1 = myConn.prepareCall(mySQL2);
         cstmt1.registerOutParameter(1,java.sql.Types.INTEGER);
         cstmt1.execute();
         int nYear = cstmt1.getInt(1);
         
          mySQL3 = "{? = call Date2EnrollSemester(SYSDATE)}";
         CallableStatement cstmt2 = myConn.prepareCall(mySQL3);
         cstmt2.registerOutParameter(1,java.sql.Types.INTEGER);
         cstmt2.execute();
         int nSemester = cstmt2.getInt(1);
         
         mySQL = "select s_name, s_id, s_major, s_grade, s_tel from student where s_id IN(select s_id from enroll where e_year ="
               + nYear + " and e_semester ="+ nSemester + " and c_id ="+ c_id + " and c_class = '"+ c_class +"') order by s_name";
         myResultSet = stmt.executeQuery(mySQL);
         if (myResultSet != null) {
            while (myResultSet.next()) {
               String s_name = myResultSet.getString("s_name");
               int s_id = myResultSet.getInt("s_id");
               String s_major = myResultSet.getString("s_major");
               int s_grade = myResultSet.getInt("s_grade");
               String s_tel = myResultSet.getString("s_tel");
      %>
      <tr>
         <td align="center"><%=s_name%></td>
         <td align="center"><%=s_id%></td>
         <td align="center"><%=s_major%></td>
         <td align="center"><%=s_grade%></td>
         <td align="center"><%=s_tel%></td>
      </tr>
      <%
         }
         }       
         CallableStatement cstmt = myConn.prepareCall("{call countStudent(?,?,?,?,?)}");
         cstmt.setString(1, c_id);
         cstmt.setString(2, c_class);
         cstmt.setInt(3, nYear);
         cstmt.setInt(4, nSemester);
         cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
         try {
            cstmt.execute();
            result1 = cstmt.getString(5);
                        %>
            <p class="title">
            
      <%=nYear%>-<%=nSemester%> 과목번호 <%=c_id%> <%=c_class%>분반
      </p>
         <table class="classtable">
         <tr>
            <td>총 수강인원</td>
            <td><%=result1%></td>
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
      <table class="classtable" width="75%" align="center" border>
      <tr>
      <td><input type="button" value="전체강의목록" OnClick="window.location='p_view.jsp'"></td></tr>
      </table>
      </p>
   </table>
</body>
</html>