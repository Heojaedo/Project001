<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/include/pro_header.jsp" %>

<style>
	.td_id_find_title {
		font-size: 26px;
	}
	
	.td_id_find_text {
		font-size: 24px;
	}
	
	.td_id_find_input {
		width: 300px;
		height: 35px;
		font-family: "Spoqa Han Sans Neo";
		font-size: 14px;
		text-indent: 5px;
	}
	
	.btn_id_find {
		width: 150px;
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
String email = request.getParameter("email");

String sql = "select * from poppy where email='"+email+"'";

Connection conn = DriverManager.getConnection(url, user, password);
Statement stmt = conn.createStatement();
ResultSet rs = stmt.executeQuery(sql);

String id_find = "";

if(rs.next()) {
	id_find = rs.getString("memberid");
}

if(id_find.equals("")) {
%>
	<script>
		alert("입력하신 이메일 주소와 일치하는 아이디 정보가 없습니다.");
		history.back();
	</script>
<%
} else {
%>
	<div style="height: 100px;"></div>
	<table width=1100px border=0 align=center>
	<tr>
	<td>
		<table width=500px border=0 align=center>
			<tr>
				<td class="td_id_find_text" align=center>
					입력하신 이메일 주소와 일치하는 아이디는			
				</td>
			</tr>
			<tr>
				<td class="td_id_find_text" align=center>
					<%=id_find %>입니다.
				</td>
			</tr>
			<tr>
				<td>
					<div class="div_enter2"></div>
				</td>
			</tr>
			<tr>
				<td align=center>
					<input class="btn_id_find" type="button" value="로그인" onclick="location.href='/member/find_login.jsp'">
					&nbsp;&nbsp;
					<input class="btn_id_find" type="button" value="비밀번호 찾기" onclick="location.href='/member/pro_pass_find.jsp'">
				</td>
			</tr>
		</table>
	</td>
	</tr>
	</table>
	<div style="height: 100px;"></div>
<%
}
%>

<%@ include file="/include/pro_footer.jsp" %>