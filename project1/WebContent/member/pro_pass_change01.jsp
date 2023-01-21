<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/include/pro_header.jsp" %>

<style>
	.td_change_title {
		font-size: 22px;
	}
	
	.span01 { /* 변경불가 문구 */
		color: red;
		font-size: 14px;
	}
	
	.td_change_input {
		width: 300px;
		height: 35px;
		font-family: "Spoqa Han Sans Neo";
		font-size: 14px;
		text-indent: 5px;
	}
	
	.td_change_input_id {
		width: 300px;
		height: 35px;
		font-family: "Spoqa Han Sans Neo";
		font-size: 14px;
		text-indent: 5px;
		background-color: #edeef1;
	}
	
	.td_change_input_nick {
		width: 220px;
		height: 35px;
		font-family: "Spoqa Han Sans Neo";
		font-size: 14px;
		text-indent: 5px;
	}
	
	.btn_nick_check {
		width: 80px;
		height: 30px;
		font-family: "Spoqa Han Sans Neo";
		font-size: 14px;
		background-color: #fcd11e;
		border: 0px;
		border-radius: 35px;
		cursor: pointer;
	}
	
	.btn_change {
		width: 300px;
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
String id = request.getParameter("id");

String sql = "select * from poppy where memberid='"+id+"'";

Connection conn = DriverManager.getConnection(url, user, password);
Statement stmt = conn.createStatement();
ResultSet rs = stmt.executeQuery(sql);

String pass = "";

if(rs.next()) {
	pass = rs.getString("password");
}
%>

<script>
	function pass_change_insert() {
		if(pass.value == "") {
			alert("현재 비밀번호를 입력하세요.");
			pass.focus();
			return false;
		}
		if(new_pass1.value == "") {
			alert("새 비밀번호를 입력하세요.");
			new_pass1.focus();
			return false;
		}
		if(new_pass2.value == "") {
			alert("새 비밀번호를 확인하세요.");
			new_pass2.focus();
			return false;
		}
		if(new_pass1.value != new_pass2.value){
			alert("새 비밀번호가 일치하지 않습니다.");
			return false;
		}
		if(pass.value != "<%=pass %>"){
			alert("현재 비밀번호가 일치하지 않습니다.");
			pass.focus();
			return false;
		}
		document.submit();
	}
</script>

<div style="height: 100px;"></div>
<form action="/member/pro_pass_change_insert.jsp?id=<%=id %>" method="post" onsubmit="return pass_change_insert()">
<table width=1100px border=0 align=center>
<tr>
<td>
	<table width=300px border=0 align=center>
		<tr>
			<td class="td_change_title">현재 비밀번호</td>
		</tr>
		<tr>
			<td>
				<input class="td_change_input" type="password" id="pass" name="pass" value="">
			</td>
		</tr>
		<tr>
			<td>
				<div class="div_enter"></div>
			</td>
		</tr>
		<tr>
			<td class="td_change_title">새 비밀번호</td>
		</tr>
		<tr>
			<td>
				<input class="td_change_input" type="password" id="new_pass1" name="new_pass1" value="">
			</td>
		</tr>
		<tr>
			<td>
				<div class="div_enter"></div>
			</td>
		</tr>
		<tr>
			<td class="td_change_title">새 비밀번호 확인</td>
		</tr>
		<tr>
			<td>
				<input class="td_change_input" type="password" id="new_pass2" name="new_pass2" value="">
			</td>
		</tr>
	</table>
</td>
</tr>
</table>
<div class="div_enter2">
</div>
<table width=1100px border=0 align=center>
<tr>
<td>
	<table width=300px border=0 align=center>
		<tr>
			<td>
				<button class="btn_change">비밀번호 변경</button>
			</td>
		</tr>
	</table>
</td>
</tr>
</table>
</form>
<div style="height: 100px;"></div>

<%@ include file="/include/pro_footer.jsp" %>