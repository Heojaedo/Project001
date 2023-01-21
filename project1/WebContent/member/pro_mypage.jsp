<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/include/pro_header.jsp" %>

<style>
	.td_mypage_title {
		font-size: 26px;
	}
	
	.td_mypage_text {
		font-size: 18px;
	}
	
	.td_id_find_input {
		width: 300px;
		height: 35px;
		font-family: "Spoqa Han Sans Neo";
		font-size: 14px;
		text-indent: 5px;
	}
	
	.btn_mypage {
		width: 120px;
		height: 35px;
		font-family: "Spoqa Han Sans Neo";
		font-size: 16px;
		background-color: #fcd11e;
		border: 0px;
		border-radius: 35px;
		cursor: pointer;
	}
	
	.div_enter { /* 줄 띄우기용 div */
		height: 10px;
	}
	
	.div_enter2 { /* 줄 띄우기용 div */
		height: 20px;
	}
</style>

<%
String id = request.getParameter("id"); //header에서 받은 값 (session_id)

String sql = "select * from poppy where memberid='"+id+"'"; //받은 값으로 데이터 불러오기

Connection conn = DriverManager.getConnection(url, user, password);
Statement stmt = conn.createStatement();
ResultSet rs = stmt.executeQuery(sql);

if(rs.next()) {
	
}
%>

<input type="hidden" name="id" value="<%=id %>">
<input type="hidden" name="nick" value="<%=rs.getString("nickname") %>">
<input type="hidden" name="email" value="<%=rs.getString("email") %>">
<div style="height: 100px;"></div>
<table width=1100px border=0 align=center>
<tr>
<td>
	<table width=200px border=0 align=center>
	<tr>
		<td>
			<img src="/img/samsek02.gif" width=200px>
		</td>
	</tr>
	<tr>
		<td>
			<div class="div_enter2"></div>
		</td>
	</tr>
	<tr>
		<td class="td_mypage_text">닉네임 <%=rs.getString("nickname") %></td>
	</tr>
	<tr>
		<td class="td_mypage_text">레벨 <%=rs.getString("level") %></td>
	</tr>
	</table>
</td>
</tr>
</table>
<div class="div_enter2"></div>
<table width=1100px border=0 align=center>
<tr>
<td>
	<table width=500px border=0 align=center>
	<tr>
		<td align=center>
			<input class="btn_mypage" type="button" value="회원정보변경" onclick="location.href='/member/pro_change01.jsp?id=<%=id %>'">
			<input class="btn_mypage" type="button" value="비밀번호변경" onclick="location.href='/member/pro_pass_change01.jsp?id=<%=id %>'">
		</td>
	</tr>
	</table>
</td>
</tr>

</table>
<div style="height: 100px;"></div>

<%@ include file="/include/pro_footer.jsp" %>