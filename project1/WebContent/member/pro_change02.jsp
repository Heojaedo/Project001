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
		width: 75px;
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
String id = request.getParameter("id"); //pass_check에서 받은 값

String sql = "select * from poppy where memberid='"+id+"'";

Connection conn = DriverManager.getConnection(url, user, password);
Statement stmt = conn.createStatement();
ResultSet rs = stmt.executeQuery(sql);

if(rs.next()) {
	
}
%>

<script>
	function pro_change_insert() {
		if(nick.value == "") {
			alert("닉네임을 입력하세요.");
			nick.focus();
			return false;
		}
		if(email.value == "") {
			alert("이메일 주소를 입력하세요.");
			email.focus();
			return false;
		}
		if(nick_checkbox.value == "") {
			alert("닉네임 중복확인을 눌러주세요.");
			return false;
		}
		
		document.submit();
	}
	
	var popupWidth = 600; //팝업창 너비
	var popupHeight = 400; //팝업창 높이
	var popupX = Math.ceil(( window.screen.width - popupWidth )/2);
	var popupY = Math.ceil(( window.screen.height - popupHeight )/2);
	
	function pro_nick_check() {
		if(nick.value == ""){
			alert("닉네임을 입력하세요.");
			nick.focus();
			return false;
		}
		window.open('change_nick_check.jsp?id=<%=id %>&nick='+nick.value,'3','width=' + popupWidth + ',height=' + popupHeight + ',left='+ popupX + ', top='+ popupY);
	}
	
	function input_nick_click() {
		nick_checkbox.value = "";
	}
</script>

<div style="height: 100px;"></div>
<form action="/member/pro_change_insert.jsp?id=<%=id %>" method="post" onsubmit="return pro_change_insert()">
<input type="hidden" id="nick_checkbox" name="nick_checkbox" value="">
<table width=1100px border=0 align=center>
<tr>
<td>
	<table width=300px border=0 align=center>
	<tr>
		<td class="td_change_title">아이디
		<span class="span01">(변경불가)</span>
		</td>
	</tr>
	<tr>
		<td>
			<input class="td_change_input_id" type="text" id="id" name="id" value="<%=id %>" readonly>
		</td>
	</tr>
	<tr>
		<td>
			<div class="div_enter"></div>
		</td>
	</tr>
	<tr>
		<td class="td_change_title">닉네임</td>
	</tr>
	<tr>
		<td>
			<input class="td_change_input_nick" type="text" id="nick" name="nick" value="<%=rs.getString("nickname") %>" onclick="input_nick_click()">
			<input class="btn_nick_check" type="button" value="중복확인" onclick="pro_nick_check(nick.value)">
		</td>
	</tr>
	<tr>
		<td>
			<div class="div_enter"></div>
		</td>
	</tr>
	<tr>
		<td class="td_change_title">이메일 주소</td>
	</tr>
	<tr>
		<td>
			<input class="td_change_input" type="text" id="email" name="email" value="<%=rs.getString("email") %>">
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
			<button class="btn_change">회원정보수정</button>
		</td>
	</tr>
	</table>
</td>
</tr>
</table>
</form>
<div style="height: 100px;"></div>

<%@ include file="/include/pro_footer.jsp" %>