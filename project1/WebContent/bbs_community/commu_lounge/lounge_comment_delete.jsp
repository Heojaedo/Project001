<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/include/dbconnection.jsp" %>

<%
String uid = request.getParameter("comment_uid"); //lounge_view에서 받은 값(poppy_comment - uid)
String code = request.getParameter("code");
String post_uid = request.getParameter("post");

String ment_sql = "select * from poppy_comment where uid='"+uid+"'";

Connection ment_conn = DriverManager.getConnection(url, user, password);
Statement ment_stmt = ment_conn.createStatement();
ResultSet ment_rs = ment_stmt.executeQuery(ment_sql);

if(ment_rs.next()) {
	
}

String fid = ment_rs.getString("fid");

String ment_sql2 = "select count(*) from poppy_comment where fid='"+fid+"'";

Connection ment_conn2 = DriverManager.getConnection(url, user, password);
Statement ment_stmt2 = ment_conn2.createStatement();
ResultSet ment_rs2 = ment_stmt2.executeQuery(ment_sql2);

int num = 0;
if(ment_rs2.next()) {
	num = ment_rs2.getInt(1);
}

if(num != 1) { //같은 fid 갯수가 여러 개면
	//같은 fid에서 가장 최신 댓글
		String new_comment = "select * from poppy_comment where fid='"+fid+"' order by uid desc limit 0,1";
		
		Connection n_conn = DriverManager.getConnection(url, user, password);
		Statement n_stmt = n_conn.createStatement();
		ResultSet n_rs = n_stmt.executeQuery(new_comment);
		
		if(n_rs.next()) {
			
		}
		
		String sql = "";
		
		if(n_rs.getString("uid").equals(uid)) { //같은 fid에서 가장 최신 댓글이라면 그냥 삭제
			sql = "delete from poppy_comment where uid='"+uid+"'";
		
			Connection conn = DriverManager.getConnection(url, user, password);
			Statement stmt = conn.createStatement();
			stmt.executeUpdate(sql);
		} else {
			sql = "update poppy_comment set comment='삭제된 댓글입니다.',del='y' where uid='"+uid+"'";
			Connection conn = DriverManager.getConnection(url, user, password);
			Statement stmt = conn.createStatement();
			stmt.executeUpdate(sql);
		}
} else {
	String sql = "delete from poppy_comment where uid='"+uid+"'";

	Connection conn = DriverManager.getConnection(url, user, password);
	Statement stmt = conn.createStatement();
	stmt.executeUpdate(sql);
}

if(ment_rs.getString("del").equals("y")) {
	String sql = "delete from poppy_comment where uid='"+uid+"'";

	Connection conn = DriverManager.getConnection(url, user, password);
	Statement stmt = conn.createStatement();
	stmt.executeUpdate(sql);
}
%>

<script>
	location.href="lounge_view.jsp?code=<%=code %>&post=<%=post_uid %>";
</script>