<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style>
	@import url(//spoqa.github.io/spoqa-han-sans/css/SpoqaHanSansNeo.css);
	
	body { /* 글씨체 */
		font-family: "Spoqa Han Sans Neo";
	}
	
	.td_title { /* 답글 td */
		font-size: 18px;
		padding: 10px;
	}
	
	.textarea_reply {
		font-family: "Spoqa Han Sans Neo";
		font-size: 14px;
		width: 900px;
		height: 150px;
		resize: none;
		padding: 10px;
	}
	
	.btn_reply {
		width: 140px;
		height: 30px;
		font-family: "Spoqa Han Sans Neo";
		font-size: 16px;
		background-color: #fcd11e;
		border: 0px;
		border-radius: 35px;
		cursor: pointer;
	}
	
	.table_comment_reply { /* 가로 세로 가운데 정렬 */
		margin: auto;
		margin-top: 100px;
		margin-bottom: 60px;
	}
	
	.pre_comment { /* 답변을 다는 댓글 보여주기 */
		font-size: 14px;
		border : 1px solid #767676;
  		border-collapse : collapse;
	}
	
	.td_comment_nick { /* 댓글 작성자 날짜 위로 정렬 */
		vertical-align: top;
	}
	
	.td_comment_box { /* 이전 댓글 출력 박스 */
		overflow: hidden;
		white-space: nowrap;
		text-overflow: ellipsis;
		max-width: 450px;
	}
</style>

<%@ include file="/include/dbconnection.jsp" %>

<%
String comment_uid = request.getParameter("comment_uid");

String sql = "select * from poppy_comment where uid='"+comment_uid+"'";

Connection conn = DriverManager.getConnection(url, user, password);
Statement stmt = conn.createStatement();
ResultSet rs = stmt.executeQuery(sql);

if(rs.next()) {
	
}
%>

<table class="pre_comment" width=800px border=1>
	<tr>
		<td class="td_comment_nick" width=150px style="padding: 5px;" align=left>
			<%=rs.getString("nick") %>
		</td>
		<td class="td_comment_box" width=500px style="padding: 5px">
			<%=rs.getString("comment") %>
		</td>
		<td class="td_comment_nick" width=150px style="padding: 5px" align=center>
			<%=rs.getString("date") %>
		</td>
	</tr>
</table>

<form action="dog_lab_comment_reply_ins.jsp" method="post">
<input type="hidden" name="commu_bbs" value="<%=rs.getString("commu_bbs") %>">
<input type="hidden" name="bbs_uid" value="<%=rs.getString("bbs_uid") %>">
<input type="hidden" name="uid" value="<%=rs.getString("uid") %>">
<input type="hidden" name="to_nick" value="<%=rs.getString("nick") %>">
<input type="hidden" name="fid" value="<%=rs.getString("fid") %>">
<input type="hidden" name="thread" value="<%=rs.getString("thread") %>">
<table class="table_comment_reply" width=900px border=0 align=center>
	<tr>
		<td class="td_title">답글</td>
	</tr>
	<tr>
		<td>
			<textarea class="textarea_reply" name="comment_reply"></textarea>
		</td>
	</tr>
	<tr>
		<td>
		<div style="height: 10px;"></div>
		</td>
	</tr>
	<tr>
		<td>
			<button class="btn_reply">등록</button>
		</td>
	</tr>
</table>
</form>