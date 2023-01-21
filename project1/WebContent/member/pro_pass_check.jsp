<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/include/dbconnection.jsp" %>

<%
String id = request.getParameter("id"); //change01에서 받은 값
String pass = request.getParameter("pass"); //change01에서 받은 값
String nick = request.getParameter("nick"); //change01에서 받은 값
String email = request.getParameter("email"); //change01에서 받은 값 

String sql = "select * from poppy where memberid='"+id+"' and password='"+pass+"'";

Connection conn = DriverManager.getConnection(url, user, password);
Statement stmt = conn.createStatement();
ResultSet rs = stmt.executeQuery(sql);

String pass_check = "";

if(rs.next()) {
	pass_check = rs.getString("memberid");
}

if(pass_check.equals("")) {
%>
	<script>
		alert("비밀번호가 일치하지 않습니다.");
		history.back();
	</script>
<%
} else {
%>
	<script>
		location.href="/member/pro_change02.jsp?id=<%=id %>";
	</script>
<%
}
%>