<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/include/dbconnection.jsp" %>

<%
request.setCharacterEncoding("utf-8");

String id = request.getParameter("id");
String nick = request.getParameter("nick");
String pass = request.getParameter("pass1");
String email = request.getParameter("email");
String id_checkbox = request.getParameter("id_checkbox");

String sql = "insert into poppy (uid,memberid,password,nickname,email) values (null,'"+id+"','"+pass+"','"+nick+"','"+email+"')";

Connection conn = DriverManager.getConnection(url, user, password);
Statement stmt = conn.createStatement();
stmt.executeUpdate(sql);
%>

<script>
	alert("회원가입이 완료되었습니다.");
	location.href="/";
</script>