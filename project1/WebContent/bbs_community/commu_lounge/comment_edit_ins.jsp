<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file='/include/pro_header.jsp' %>

<%
request.setCharacterEncoding("utf-8");

String id = session_id;
String commu_bbs = request.getParameter("commu_bbs");
String bbs_uid = request.getParameter("bbs_uid");
String comment_uid = request.getParameter("uid");
String comment = request.getParameter("comment_edit");
String fid = request.getParameter("fid");
String thread = request.getParameter("thread");

String sql = "update poppy_comment set comment='"+comment+"' where uid='"+comment_uid+"'";

Connection conn = DriverManager.getConnection(url, user, password);
Statement stmt = conn.createStatement();
stmt.executeUpdate(sql);
%>

<script>
	opener.parent.location.reload();
	window.close();
</script>