<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/include/pro_header.jsp" %>

<style>
	.td_change_title {
		font-size: 26px;
	}
	
	.td_change_text {
		font-size: 18px;
	}
	
	.td_change_input {
		width: 300px;
		height: 35px;
		font-family: "Spoqa Han Sans Neo";
		font-size: 14px;
		text-indent: 5px;
	}
	
	.btn_change {
		width: 100px;
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
String id = request.getParameter("id"); //mypage에서 받은 값

String sql = "select * from poppy where memberid='"+id+"'"; //받은 값으로 데이터 불러오기

Connection conn = DriverManager.getConnection(url, user, password);
Statement stmt = conn.createStatement();
ResultSet rs = stmt.executeQuery(sql);

if(rs.next()) {
	
}
%>

<script>
	function pass_check() {
		if(pass.value == "") {
			alert("비밀번호를 입력하세요.");
			pass.focus();
			return false;
		}
		document.submit();
	}
</script>

<div style="height: 100px;"></div>
<form action="/member/pro_pass_check.jsp?id=<%=id %>" method="post" onsubmit="return pass_check()">
<input type="hidden" name="id2" value="<%=id %>">
<input type="hidden" name="nick" value="<%=rs.getString("nickname") %>">
<input type="hidden" name="email" value="<%=rs.getString("email") %>">
<table width=1100px border=0 align=center>
<tr>
<td>
	<table width=500px border=0 align=center>
	<tr>
		<td class="td_change_title" colspan=2>본인확인</td>
	</tr>
	<tr>
		<td class="td_change_text" colspan=2>회원님의 소중한 개인정보보호를 위해서 본인확인을 진행합니다.</td>
	</tr>
	<tr>
		<td>
			<div class="div_enter2"></div>
		</td>
	</tr>
	<tr>
		<td align=center>
			<input class="td_change_input" type="password" id="pass" name="pass" value="" placeholder="비밀번호를 입력해주세요.">
		</td>
		<td>
			<button class="btn_change">확인</button>
		</td>
	</tr>
	</table>
</td>
</tr>
</table>
</form>
<div style="height: 100px;"></div>

<%@ include file="/include/pro_footer.jsp" %>