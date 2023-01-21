<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style>
	@import url(//spoqa.github.io/spoqa-han-sans/css/SpoqaHanSansNeo.css);
	
	body { /* 글씨체 */
		font-family: "Spoqa Han Sans Neo";
	}
	
	.table_id_check { /* 가로 세로 가운데 정렬 */
		margin: auto;
		margin-top: 60px;
		margin-bottom: 60px;
	}
	
	.td_id_check_title {
		font-size: 22px;
	}
	
	.td_id_check_input {
		width: 300px;
		height: 35px;
		font-family: "Spoqa Han Sans Neo";
		font-size: 14px;
		text-indent: 5px;
	}
	
	.btn_id_check { /* 중복확인 버튼 */
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
String id = request.getParameter("id");

String sql = "select count(*) from poppy where memberid='"+id+"'";

Connection conn = DriverManager.getConnection(url, user, password);
Statement stmt = conn.createStatement();
ResultSet rs = stmt.executeQuery(sql);

int sql_result = 0;
if(rs.next()) {
	sql_result = rs.getInt(1);
}

String result_text = "";
if(sql_result == 0) {
	result_text = "사용 가능한 아이디입니다.";
} else {
	result_text = "이미 사용 중인 아이디입니다.";
}
%>

<style>
	.input_text { /* 아이디 중복확인 문구 */
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

<input type="hidden" id="id_checkbox" name="id_checkbox" value="<%if(sql_result == 0) { %>Y<%} else { %>N<%} %>">
<table width=500px class="table_id_check" border=0 align=center>
<tr>
<td>
	<table width=400px border=0 align=center>
		<tr>
			<td class="td_id_check_title">
			아이디 중복확인
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
				<input class="td_id_check_input" type="text" id="id" name="id" value="<%=id %>" onclick="input_id_click()">
				<button class="btn_id_check" onclick="return id_check()">중복확인</button>
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
			<td rowspan=2 width=130px align=center>
				<%if(sql_result == 0) { %>
					<img class="img_yes" src="/img/samsek01.png">
				<%} else { %>
					<img class="img_no" src="/img/samsek04.png">
				<%} %>
			</td>
			<td>
				<button class="btn_select" onclick="id_reset()">변경할래요 !</button>
			</td>
		</tr>
		<tr>
			<td>
				<%if(sql_result == 0) { %>
				<button class="btn_select" onclick="id_use()">사용할래요 !</button>
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
	function input_id_click() {
		id_checkbox.value = "";
	}
	function id_use() {
		if(id.value == "") {
			alert("아이디를 입력해주세요.");
			return false;
		}
		if(id_checkbox.value == "") {
			alert("아이디 중복확인을 눌러주세요.");
			return false;
		}
		if(<%=sql_result %> != 0) {
			alert("이미 사용 중인 아이디입니다.");
			return false;
		} else {
			opener.document.getElementById("id").value = document.getElementById("id").value;
			opener.document.getElementById("id_checkbox").value = document.getElementById("id_checkbox").value;
			self.close();
		}
	}
	
	function id_reset() {
		id.value = "";
		id_checkbox.value = "";
		result_text.value = "";
	}
	
	function id_check() {
		if(id.value == "") {
			alert("아이디를 입력해주세요.");
			return false;
		} else return;
	}
</script>