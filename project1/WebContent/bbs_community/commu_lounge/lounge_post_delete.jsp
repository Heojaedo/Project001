<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/include/dbconnection.jsp" %>

<%
String uid = request.getParameter("post"); //lounge_view에서 받은 값(uid)
String code = request.getParameter("code"); //lounge_view에서 받은 값(poppy_lounge);

String sql = "delete from "+code+" where uid='"+uid+"'";

Connection conn = DriverManager.getConnection(url, user, password);
Statement stmt = conn.createStatement();
stmt.executeUpdate(sql);
%>

<script>
	location.href="/bbs_community/commu_main.jsp?code=<%=code %>";
</script>