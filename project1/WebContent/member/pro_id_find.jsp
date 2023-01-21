<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/include/pro_header.jsp" %>

<style>
	.td_id_find_title {
		font-size: 26px;
	}
	
	.td_id_find_text {
		font-size: 18px;
	}
	
	.td_id_find_input {
		width: 300px;
		height: 35px;
		font-family: "Spoqa Han Sans Neo";
		font-size: 14px;
		text-indent: 5px;
	}
	
	.btn_id_find {
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

<script>
	function email_check() {
		if(email.value == "") {
			alert("이메일 주소를 입력하세요.")
			email.focus();
			return false;
		}
		document.submit();
	}
</script>

<div style="height: 100px;"></div>
<form action="/member/pro_id_find_email.jsp" method="post" onsubmit="return email_check()">
<table width=1100px border=0 align=center>
<tr>
<td>
	<table width=380px border=0 align=center>
		<tr>
			<td class="td_id_find_title">아이디찾기</td>
		</tr>
		<tr>
			<td class="td_id_find_text">회원정보에 등록한 이메일 주소를 입력해주세요.</td>
		</tr>
		<tr>
			<td>
				<div class="div_enter2"></div>
			</td>
		</tr>
		<tr>
			<td align=center>
				<input class="td_id_find_input" type="text" id="email" name="email" value="">
			</td>
		</tr>
	</table>
</td>
</tr>
</table>
<div class="div_enter2"></div>
<table width=1100px border=0 align=center>
<tr>
<td>
	<table width=100px border=0 align=center>
		<tr>
			<td>
				<button class="btn_id_find">다음</button>
			</td>
		</tr>
	</table>
</td>
</tr>
</table>
</form>
<div style="height: 100px;"></div>

<%@ include file="/include/pro_footer.jsp" %>