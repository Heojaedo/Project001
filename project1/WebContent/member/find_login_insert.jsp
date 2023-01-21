<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/include/dbconnection.jsp" %>

<%
String id = request.getParameter("id"); //login에서 아이디를 입력해서 받은 값
String pass = request.getParameter("pass"); //login에서 비밀번호를 입력해서 받은 값
String preURL = request.getParameter("preURL"); //login에서 받은 이전 페이지 url값

String sql = "select * from poppy where memberid='"+id+"'";

Connection conn = DriverManager.getConnection(url, user, password);
Statement stmt = conn.createStatement();
ResultSet rs = stmt.executeQuery(sql);

String id_login = "";

if(rs.next()) {
	id_login = rs.getString("memberid");
}

if(id_login.equals("")) { //조건에 맞는 아이디가 0
%>
	<script>
	alert("가입되지 않은 아이디입니다.");
	history.back();
	</script>
<%
} else {
	String sql2 = "select * from poppy where memberid='"+id+"' and password='"+pass+"'";
	
	Connection conn2 = DriverManager.getConnection(url, user, password);
	Statement stmt2 = conn2.createStatement();
	ResultSet rs2 = stmt2.executeQuery(sql2);
	
	String id2 = "";
	String nick = "";
	String level = "";
	
	if(rs2.next()) {
		id2 = rs2.getString("memberid");
		nick = rs2.getString("nickname");
		level = rs2.getString("level");
	}
	
	if(id2.equals("")) {
	%>
		<script>
			alert("비밀번호가 일치하지 않습니다.\n다시 확인해주세요.");
			history.back();
		</script>
	<%
	} else {
		session.setAttribute("id", id2); //db에 저장되어있는 memberid --> header로 보냄
		session.setAttribute("nick", nick); //db에 저장되어있는 nickname --> header로 보냄
		session.setAttribute("level", level); //db에 저장되어있는 level --> header로 보냄		
	%>
		<script>
			location.href="/";
		</script>
	<%
	}
}
%>