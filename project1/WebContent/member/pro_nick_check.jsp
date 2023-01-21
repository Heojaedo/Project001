<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style>
	@import url(//spoqa.github.io/spoqa-han-sans/css/SpoqaHanSansNeo.css);
	
	body { /* 글씨체 */
		font-family: "Spoqa Han Sans Neo";
	}
	
	.table_nick_check { /* 가로 세로 가운데 정렬 */
		margin: auto;
		margin-top: 60px;
		margin-bottom: 60px;
	}
	
	.td_nick_check_title {
		font-size: 22px;
	}
	
	.td_nick_check_input {
		width: 300px;
		height: 35px;
		font-family: "Spoqa Han Sans Neo";
		font-size: 14px;
		text-indent: 5px;
	}
	
	.btn_nick_check { /* 중복확인 버튼 */
		width: 80px;
		height: 30px;
		font-family: "Spoqa Han Sans Neo";
		font-size: 14px;
		background-color: #fcd11e;
		border: 0px;
		border-radius: 35px;
		cursor: pointer;
	}
	
	.btn_select {
		width: 120px;
		height: 30px;
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
	
	.img_yes {
		height: 100px;
		vertical-align: middle;
	}
	
	.img_no {
		height: 100px;
		vertical-align: middle;
	}
</style>

<%@ include file="/include/dbconnection.jsp" %>

<%
String nick = request.getParameter("nick");

String sql = "select count(*) from poppy where nickname='"+nick+"'";

Connection conn = DriverManager.getConnection(url, user, password);
Statement stmt = conn.createStatement();
ResultSet rs = stmt.executeQuery(sql);

int sql_result = 0;
if(rs.next()) {
	sql_result = rs.getInt(1);
}

String result_text = "";
if(sql_result == 0) {
	result_text = "사용 가능한 닉네임입니다.";
} else {
	result_text = "이미 사용 중인 닉네임입니다.";
}
%>

<style>
	.input_text { /* 닉네임 중복확인 문구 */
		width: 300px;
		border: 0px;
		font-family: "Spoqa Han Sans Neo";
		font-size: 18px;
		<%if(sql_result == 0) { %>
			color: blue;
		<%} else { %>
			color: red;
		<%} %>
	}
</style>

<input type="hidden" id="nick_checkbox" name="nick_checkbox" value="<%if(sql_result == 0) { %>Y<%} else { %>N<%} %>">
<table class="table_nick_check" width=500px border=0 align=center>
<tr>
<td>
	<table width=400px align=center>
	<tr>
		<td class="td_nick_check_title">
		닉네임 중복확인
		</td>
	</tr>
	<tr>
		<td>
			<div class="div_enter"></div>
		</td>
	</tr>
	<form method="get">
	<tr>
		<td>
			<input class="td_nick_check_input" type="text" id="nick" name="nick" value="<%=nick %>" onclick="input_nick_click()">
			<button class="btn_nick_check" onclick="return nick_check()">중복확인</button>
		</td>
	</tr>
	</form>
	<tr>
		<td>
			<div class="div_enter"></div>
		</td>
	</tr>
	<tr>
		<td>
			<input class="input_text" type="text" id="result_text" name="result_text" value="<%=result_text %>" readonly>
		</td>
	</tr>
	<tr>
		<td>
			<div class="div_enter"></div>
		</td>
	</tr>
	</table>
	<table width=400px align=center border=0>
	<tr>
	<td>
		<table width=300px align=center border=0>
		<tr>
			<td rowspan=2 width=120px align=center>
				<%if(sql_result == 0) { %>
					<img class="img_yes" src="/img/samsek01.png">
				<%} else { %>
					<img class="img_no" src="/img/samsek04.png">
				<%} %>
			</td>
			<td>
				<button class="btn_select" onclick="nick_reset()">변경할래요 !</button>
			</td>
		</tr>
		<tr>
			<td>
				<%if(sql_result == 0) { %>
				<button class="btn_select" onclick="nick_use()">사용할래요 !</button>
				<%} %>
			</td>
		</tr>
		</table>
	</td>
	</tr>
	</table>
</td>
</tr>
</table>

<script>
	function input_nick_click() {
		nick_checkbox.value = "";
	}
	function nick_use() {
		if(nick.value == "") {
			alert("닉네임을 입력해주세요.");
			return false;
		}
		if(nick_checkbox.value == "") {
			alert("닉네임 중복확인을 눌러주세요.");
			return false;
		}
		if(<%=sql_result %> != 0) {
			alert("이미 사용 중인 닉네임입니다.");
			return false;
		} else {
			opener.document.getElementById("nick").value = document.getElementById("nick").value;
			opener.document.getElementById("nick_checkbox").value = document.getElementById("nick_checkbox").value;
			self.close();
		}
	}
	
	function nick_reset() {
		nick.value = "";
		nick_checkbox.value = "";
		result_text.value = "";
	}
	
	function nick_check() {
		if(nick.value == "") {
			alert("아이디를 입력해주세요.");
			return false;
		} else return;
	}
</script>