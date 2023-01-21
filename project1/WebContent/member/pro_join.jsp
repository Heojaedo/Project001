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
	
	.td_join_title {
		font-size: 22px;
	}
	
	.td_join_title2 { /* 비밀번호 확인, 비밀번호 입력 */
		color: #585858;
		font-size: 14px;
		text-indent: 5px;
	}
	
	.td_join_input {
		width: 300px;
		height: 35px;
		font-family: "Spoqa Han Sans Neo";
		font-size: 14px;
		text-indent: 5px;
	}
	
	.td_join_input_id {
		width: 220px;
		height: 35px;
		font-family: "Spoqa Han Sans Neo";
		font-size: 14px;
		text-indent: 5px;
	}
	
	.td_join_input_nick {
		width: 220px;
		height: 35px;
		font-family: "Spoqa Han Sans Neo";
		font-size: 14px;
		text-indent: 5px;
	}
	
	.btn_join {
		width: 300px;
		height: 35px;
		font-family: "Spoqa Han Sans Neo";
		font-size: 16px;
		background-color: #fcd11e;
		border: 0px;
		border-radius: 35px;
		cursor: pointer;
	}
	
	.btn_id_check, .btn_nick_check {
		width: 75px;
		height: 30px;
		font-family: "Spoqa Han Sans Neo";
		font-size: 14px;
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
	function pro_join_insert() {
		if(id.value == "") {
			alert("아이디를 입력하세요.");
			id.focus();
			return false;
		}
		if(nick.value == "") {
			alert("닉네임을 입력하세요.");
			nick.focus();
			return false;
		}
		if(pass1.value == "") {
			alert("비밀번호를 입력하세요.");
			pass1.focus();
			return false;
		}
		if(pass2.value == "") {
			alert("비밀번호를 확인하세요.");
			pass2.focus();
			return false;
		}
		if(email.value == "") {
			alert("이메일 주소를 입력하세요.");
			email.focus();
			return false;
		}
		if(pass1.value != pass2.value) {
			alert("비밀번호가 일치하지 않습니다.");
			return false;
		}
		if(id_checkbox.value != "Y") {
			alert("아이디 중복확인을 눌러주세요.");
			return false;
		}
		if(nick_checkbox.value != "Y") {
			alert("닉네임 중복확인을 눌러주세요.");
			return false;
		}
		document.submit();
	}
	
	var popupWidth = 600; //팝업창 너비
	var popupHeight = 400; //팝업창 높이
	var popupX = Math.ceil(( window.screen.width - popupWidth )/2);
	var popupY = Math.ceil(( window.screen.height - popupHeight )/2);
	
	function pro_id_check() {
		if(id.value == ""){
			alert("아이디를 입력하세요.");
			id.focus();
			return false;
		}
		var id_form = id.value;
		var regex = /^[a-z|A-Z|0-9|]+$/;
		
		if(regex.test(id_form)) {
			
		} else {
			alert("영문, 숫자만 입력하세요.")
			return false;
		}
		window.open('pro_id_check.jsp?id='+id.value,'1','width=' + popupWidth + ',height=' + popupHeight + ',left='+ popupX + ', top='+ popupY);
	}
	
	function input_id_click() {
		id_checkbox.value = "";
	}
	
	function pro_nick_check() {
		if(nick.value == ""){
			alert("닉네임을 입력하세요.");
			nick.focus();
			return false;
		}
		window.open('pro_nick_check.jsp?nick='+nick.value,'2','width=' + popupWidth + ',height=' + popupHeight + ',left='+ popupX + ', top='+ popupY);
	}
	
	function input_nick_click() {
		nick_checkbox.value = "";
	}
</script>

<div style="height: 50px;"></div>
<form action="/member/pro_join_insert.jsp" method="post" onsubmit="return pro_join_insert()">
<input type="hidden" id="id_checkbox" name="id_checkbox" value="" style="width: 20px;">
<input type="hidden" id="nick_checkbox" name="nick_checkbox" value="" style="width: 20px;">
<table width=1100px align=center border=0>
<tr>
<td>
	<table width=300px align=center border=0>
		<tr>
			<td class="td_join_title">아이디</td>
		</tr>
		<tr>
			<td>
				<input class="td_join_input_id" type="text" id="id" name="id" value="" maxlength="16" onclick="input_id_click()">
				<input class="btn_id_check" type="button" value="중복확인" onclick="pro_id_check(id.value)">	
			</td>
		</tr>
		<tr>
			<td class="td_join_title2">
				영문, 숫자만 입력
			</td>
		</tr>
		<tr>
			<td>
				<div class="div_enter"></div>
			</td>
		</tr>
		<tr>
			<td class="td_join_title">닉네임</td>
		</tr>
		<tr>
			<td>
				<input class="td_join_input_nick" type="text" id="nick" name="nick" value="" maxlength="16" onclick="input_nick_click()">
				<input class="btn_nick_check" type="button" value="중복확인" onclick="pro_nick_check(nick.value)">
			</td>
		</tr>
		<tr>
			<td>
				<div class="div_enter"></div>
			</td>
		</tr>
		<tr>
			<td class="td_join_title">비밀번호</td>
		</tr>
		<tr>
			<td>
				<input class="td_join_input" type="password" id="pass1" name="pass1" value="" maxlength="20">
			</td>
		</tr>
		<tr>
			<td class="td_join_title2">
				비밀번호 입력
			</td>
		</tr>
		<tr>
			<td>
				<input class="td_join_input" type="password" id="pass2" name="pass2" value="" maxlength="20">
			</td>
		</tr>
		<tr>
			<td class="td_join_title2">
				비밀번호 확인
			</td>
		</tr>
		<tr>
			<td>
				<div class="div_enter"></div>
			</td>
		</tr>
		<tr>
			<td class="td_join_title">
				이메일 주소
			</td>
		</tr>
		<tr>
			<td>
				<input class="td_join_input" type="text" id="email" name="email" value="" maxlength="30">
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
	<table width=300px align=center border=0>
		<tr>
			<td>
				<button class="btn_join">회원가입</button>
			</td>
		</tr>
	</table>
</td>
</tr>
</table>
</form>
<div style="height: 50px;"></div>

<%@ include file="/include/pro_footer.jsp" %>