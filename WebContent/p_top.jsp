<%@ page contentType="text/html; charset=utf-8" %>
<link rel="stylesheet" href="topstyle.css" type="text/css">
<%
String session_id = (String)session.getAttribute("user");
String log;
if (session_id==null) log="<a href=login.jsp>로그인</a>";
else log="<a href=logout.jsp>로그아웃</a>";
%>
	<a href="p_main.jsp">
	<img src="home2.gif" width="250px" style="margin-left: auto; margin-right: auto; display: block;">
	<p class="subTitle" align="center">수강신청시스템</p>
	</a>
	<br>
	<br>
<table width="75%" align="center" bgcolor="#FFFF99" >
<tr>
<td align="center"><b><%=log%></b></td>
<td align="center"><b><a href="p_update.jsp">사용자 정보 수정</a></b></td>
<td align="center"><b><a href="p_view.jsp">수업목록 및 수업별 학생조회</a></b></td>
</tr>
</table>