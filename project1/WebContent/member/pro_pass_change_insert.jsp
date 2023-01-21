<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/include/dbconnection.jsp" %>

<%
String id = request.getParameter("id");
String pass = request.getParameter("new_pass1");

String sql = "update poppy set password='"+pass+"' where memberid='"+id+"'";

Connection conn = DriverManager.getConnection(url, user, password);
Statement stmt = conn.createStatement();
stmt.executeUpdate(sql);
%>

<script>
	alert("비밀번호가 변경되었습니다.");
	alert("재로그인이 필요합니다.");
	<%
	session.invalidate();
	%>
	location.href="/member/pro_login.jsp";
</script>