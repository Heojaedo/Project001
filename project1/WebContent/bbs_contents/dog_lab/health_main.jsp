<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/include/pro_header.jsp" %>

<%
String id = session_id; //로그인하면서 받은 session_id값
%>

<style>
	.div_post { /* 게시글 박스 */
		display: grid;
		grid-template-columns: 48% 4% 48%;
		grid-template-rows: 40px 80px 240px;
	}
	
	.div_post > div {
		margin: 10px;
	}
	
	.grid_pic { /* 그리드 사진 */
		grid-column-start: 1; grid-column-end: 2;
		grid-row-start: 1; grid-row-end: 4;
		background: lightyellow;
	}
	
	.grid_time { /* 그리드 시간 */
		grid-column-start: 3; grid-column-end: 4;
		grid-row-start: 1; grid-row-end: 2;
		background: lightgreen;
	}
	
	.grid_title { /* 그리드 제목 */
		grid-column-start: 3; grid-column-end: 4;
		grid-row-start: 2; grid-row-end: 3;
		background: lightblue;
	}
	
	.grid_contents { /* 그리드 내용 */
		grid-column-start: 3; grid-column-end: 4;
		grid-row-start: 3; grid-row-end: 4;
		background: lightpink;
	}
</style>

<table width=60% border=1 align=center>
	<tr>
		<td>홈/강아지 연구소/강아지 건강</td>
	</tr>
	<tr>
		<td>강아지 건강</td>
	</tr>
</table>
<hr>
<table width=60% border=1 align=center>
	<tr>
		<td>
			<div class="div_post">
				<div class="grid_pic">사진</div>
				<div class="grid_time">게시 시간</div>
				<div class="grid_title">제목</div>
				<div class="grid_contents">내용</div>
			</div>
		</td>
	</tr>
</table>
<table width=60% border=1 align=center>
	<tr>
		<td align=right>
			<input type="button" value="글쓰기" onclick="location.href='health_write.jsp?id=<%=id %>'">
		</td>
	</tr>
</table>