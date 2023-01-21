<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/include/pro_header.jsp" %>

<%
request.setCharacterEncoding("utf-8");

String id = request.getParameter("id"); //change02에서 받은 값
String nick = request.getParameter("nick"); //change02에서 받은 값
String email = request.getParameter("email"); //change02에서 받은 값

String sql = "update poppy set nickname='"+nick+"',email='"+email+"' where memberid='"+id+"'";

Connection conn = DriverManager.getConnection(url, user, password);
Statement stmt = conn.createStatement();
stmt.executeUpdate(sql);
%>

<script>
	alert("회원정보가 수정되었습니다.");
	location.href="/member/pro_mypage.jsp?id=<%=id %>";
</script>