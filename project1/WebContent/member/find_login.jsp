<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/include/pro_header.jsp" %>

<style>
	.tb_join a { /* 회원가입 아이디 비밀번호 찾기 링크 밑줄 없애기 */
		color: #000000;
		text-decoration: none;
	}
	
	.tb_join a:visited { /* 회원가입 아이디 비밀번호 찾기 링크 방문기록 있을 경우 */
		color: #000000;
	}
	
	.td_login_title {
		font-size: 22px;
	}
	
	.td_login_input {
		width: 300px;
		height: 35px;
		font-family: "Spoqa Han Sans Neo";
		font-size: 14px;
		text-indent: 5px;
	}
	
	.btn_login {
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
String preURL = request.getParameter("preURL");
%>

<script>
	function pro_login_insert() {
		if(id.value == "") {
			alert("아이디를 입력하세요.");
			id.focus();
			return false;
		}
		if(pass.value == "") {
			alert("비밀번호를 입력하세요.");
			pass.focus();
			return false;
		}
		document.submit();
	}
</script>

<div style="height: 100px;"></div>
<form action="/member/find_login_insert.jsp" method="post" onsubmit="return pro_login_insert()">
<input type="hidden" name="preURL" value="<%=preURL %>" style="width: 1000px">
<table width=1100px align=center border=0>
<tr>
<td>
	<table width=300px align=center border=0>
		<tr>
			<td class="td_login_title">아이디</td>
		</tr>
		<tr>
			<td>
				<input class="td_login_input" type="text" id="id" name="id" value="">
			</td>
		</tr>
		<tr>
			<td>
				<div class="div_enter"></div>
			</td>
		</tr>
		<tr>
			<td class="td_login_title">비밀번호</td>
		</tr>
		<tr>
			<td>
				<input class="td_login_input" type="password" id="pass" name="pass" value="">
			</td>
		</tr>
	</table>
</td>
</tr>
</table>
<div class="div_enter2">
</div>
<table width=1100px align=center border=0>
<tr>
<td>
	<table width=300px align=center>
		<tr>
			<td>
				<button class="btn_login">로그인</button>
			</td>
		</tr>
	</table>
</td>
</tr>
</table>
<div class="div_enter2">
</div>
<table class="tb_join" width=1100px align=center border=0>
<tr>
<td>
	<table width=500px align=center border=0>
		<tr>
			<td align=center>
				<a href="/member/pro_join.jsp">회원가입</a>
				&nbsp;|&nbsp;
				<a href="/member/pro_id_find.jsp">아이디 찾기</a>
				&nbsp;|&nbsp;
				<a href="/member/pro_pass_find.jsp">비밀번호 찾기</a>
			</td>
		</tr>
	</table>
</td>
</tr>
</table>
</form>
<div style="height: 100px;"></div>

<%@ include file="/include/pro_footer.jsp" %>