<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/include/pro_header.jsp" %>

<style>
	.td_title { /* 제목 */
		height: 30px;
		font-size: 24px;
		text-indent: 10px;
	}
	
	.td_nick_time { /* 닉네임 작성일 */
		font-size: 14px;
		text-indent: 10px;
	}
	
	.td_contents { /* 내용 */
		height: 300px;
		padding: 10px;
		vertical-align: top;
	}
	
	.table_comment {
		font-size: 14px;
	}
	
	.text_comment { /* 댓글 입력란 */
		font-family: "Spoqa Han Sans Neo";
		font-size: 14px;
		width: 900px;
		height: 150px;
		resize: none;
		padding: 10px;
	}
	
	.td_contents_img { /* 본문 이미지 */
		padding: 10px;
	}
	
	.view_img { /* 본문 이미지 크기 */
		max-width: 900px;
	}
	
	.div_post_category { /* 포스트 카테고리 박스 */
		width: 80px;
		height: 25px;
		font-size: 14px;
		background-color: #ffeb99;
		margin-right: 10px;
		text-align: center;
		border-radius: 25px;
		line-height: 25px;
	}
	
	.btn_edit { /* 수정, 삭제 버튼 */
		width: 80px;
		height: 30px;
		font-family: "Spoqa Han Sans Neo";
		font-size: 14px;
		background-color: #fcd11e;
		border: 0px;
		border-radius: 35px;
		cursor: pointer;
	}
	
	.td_reply { /* 대댓글 표시 이미지 */
		width: 30px;
	}
	
	.td_comment { /* 댓글 */
		font-size: 14px;
		vertical-align: top;
	}
	
	.btn_comment { /* 댓글 답변 수정 버튼 */
		width: 30px;
		height: 20px;
		font-family: "Spoqa Han Sans Neo";
		font-size: 11px;
		background-color: #ffeb99;
		border: 0px;
		border-radius: 20px;
		text-align: center;
		cursor: pointer;
	}
	
	.btn_comment_del { /* 댓글 삭제 버튼 */
		width: 30px;
		height: 20px;
		font-family: "Spoqa Han Sans Neo";
		font-size: 11px;
		background-color: #ff6060;
		color: #fafafa;
		border: 0px;
		border-radius: 20px;
		text-align: center;
		cursor: pointer;
	}
	
	.td_comment_del { /* 댓글 삭제 버튼 위로 정렬 */
		vertical-align: top;
	}
	
	.td_comment_nick { /* 댓글 작성자 날짜 위로 정렬 */
		vertical-align: top;
	}
	
	.div_nothing {
		background-color: #f6f6f9;
		width: 900px;
		height: 150px;
		font-size: 18px;
		line-height: 150px;
	}
	
	.no_answer_img {
		vertical-align: middle;
	}
	
	.btn_write { /* 목록 버튼 */
		width: 120px;
		height: 35px;
		font-family: "Spoqa Han Sans Neo";
		font-size: 16px;
		background-color: #fcd11e;
		border: 0px;
		border-radius: 35px;
		cursor: pointer;
	}
	
	.contents_img { /* 이미지가 없는 게시글에 출력되는 이미지 */
		width: 150px;
	}
</style>

<%
String uid = request.getParameter("post"); //commu_main에서 넘어온 post값 (uid)
String code = request.getParameter("code"); //commu_main에서 넘어온 code값 (lounge)

String sql = "select * from "+code+" where uid='"+uid+"'";

Connection conn = DriverManager.getConnection(url, user, password);
Statement stmt = conn.createStatement();
ResultSet rs = stmt.executeQuery(sql);

String signdate = "";
String view_signdate = "";

if(rs.next()) {
	signdate = rs.getString("signdate");
	view_signdate = signdate.substring(0, 16);
}
%>

<input type="hidden" value="<%=code %>">
<input type="hidden" value="<%=uid %>">
<table width=1100px border=0 align=center>
	<tr>
		<td>
			<div class="div_post_category">
				<%if(rs.getString("category").equals("1")) { //카테고리가 1일 때 %>
					진행중
				<%} else if(rs.getString("category").equals("2")) { //카테고리가 2일 때 %>
					종료
				<%} %>
			</div>
		</td>
	</tr>
	<tr>
		<td class="td_title">
			<%=rs.getString("title") %>
		</td>
	</tr>
	<tr>
		<td class="td_nick_time">
			<%=rs.getString("nickname") %>
			&nbsp;|&nbsp;
			<%=view_signdate %>
		</td>
	</tr>
	<tr>
		<td class="td_contents_img" align=center>
			<%if(!rs.getString("loungefile").equals("")) { //사진이 있으면 %>
				<img class="view_img" src="/../upload/<%=rs.getString("loungefile") %>">
			<%} else {
				if(code.equals("poppy_lounge")) { //라운지 게시판이라면 %>
					<img class="contents_img" src="/../img/samsek06.png">
				<%} else { //QnA 게시판이라면 %>
					<img class="contents_img" src="/../img/curioussamsek.png">
				<%}
			} %>
		</td>
	</tr>
	<tr>
		<td class="td_contents">
			<%
			//작은 따옴표 치환
			String contents = rs.getString("contents");
			contents = contents.replace("′","'");
			%>
			<%=contents %>
		</td>
	</tr>
	<tr>
	
	<script>
		function post_delete() {
			if(confirm("삭제하시겠습니까 ?")) {
				location.href="lounge_post_delete.jsp?code=<%=code %>&post=<%=uid %>";
				alert("삭제되었습니다.");
			} else return;
		}
	</script>
	
		<td align=center>
			<%if(rs.getString("memberid").equals(session_id)) { %>
				<input class="btn_edit" type="button" name="post_edit" value="수정" onclick="location.href='lounge_post_edit.jsp?code=<%=code %>&post=<%=uid %>'">
			<%}
			if(session_id != null && (rs.getString("memberid").equals(session_id) || session_level.equals("10"))) { %>
				<input class="btn_edit" type="button" name="post_delete" value="삭제" onclick="post_delete()">
			<%} %>
			
		</td>
	</tr>
</table>
<hr>
<table class="table_comment" width=1100px border=0 align=center>
	
	<%
	String sql_comment = "select * from poppy_comment where commu_bbs='"+code+"' and bbs_uid='"+uid+"' order by fid asc";
	
	Connection conn_c = DriverManager.getConnection(url, user, password);
	Statement stmt_c = conn_c.createStatement();
	ResultSet rs_c = stmt_c.executeQuery(sql_comment);
	
	while(rs_c.next()) {
		//새 댓글에 new 표시하기
		
		//현재 시각
		Date nowtime = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
		String comment_signdate = sdf.format(nowtime);
		
		SimpleDateFormat sdf2 = new SimpleDateFormat("yyyyMMddkkmmss");
		String comment_signdate2 = sdf2.format(nowtime);
				
		//댓글 작성 시각
		long a = Long.parseLong(comment_signdate2);
		long b = 0;
		if(!rs_c.getString("signdate2").equals("")) {
			b = Long.parseLong(rs_c.getString("signdate2"));
		}
		
		//대댓글 길이
		String thread = rs_c.getString("thread");
		int len_thread = thread.length() - 1;
		
		int comm_uid = rs_c.getInt("uid"); //댓글 uid
	%>
	<style>
		.writer_nick { /* 글의 작성자라면 */
			background-color: #e5ebff;
		}
		
		.to_reply {
			background-color: #e5ebff;
		}
		
		.del_ment {
			color: #939397;
		}
	</style>
	<tr>
		<td width=50px>
		</td>
		<td class="td_comment_nick" width=150px>
		<%if(!thread.equals("A")) { //답변 들여쓰기 %>
			&nbsp;&nbsp;&nbsp;&nbsp;
		<%} %>
		<%if(rs.getString("memberid").equals(rs_c.getString("id"))) { //글의 작성자라면 %>
		<span class="writer_nick"><%=rs_c.getString("nick") %></span>
		<%} else { %>
		<span class="other_nick"><%=rs_c.getString("nick") %></span>
		<%} %>
		&nbsp;
		</td>
		<td class="td_comment" width=610px>
		<%if(!thread.equals("A")) { //답변 들여쓰기 %>
			<img src='/bbs_event/img/thread_new.gif'>
			<span class="to_reply">@<%=rs_c.getString("towho") %></span>
		<%} %>
		<%if(rs_c.getString("comment").equals("삭제된 댓글입니다.")) { %>
		<span class="del_ment"><%=rs_c.getString("comment") %></span>
		<%} else { %>
		<%=rs_c.getString("comment") %>
		<%} %>
		</td>
		<td class="td_comment_nick" align=right width=140px>
		<%=rs_c.getString("date") %>
		</td>
		<td class="td_comment_del" align=center width=100px>
			<%if(!rs_c.getString("del").equals("y")) { %>
				<%if(session_id != null) { %>
				<input class="btn_comment" type="button" name="reply" value="답글" onclick="comment_reply(<%=comm_uid %>)">
				<%} %>
				<%if(rs_c.getString("id").equals(session_id)) { %>
				<input class="btn_comment" type="button" name="edit" value="수정" onclick="comment_edit(<%=comm_uid %>)">
				<%} %>
				<%if(session_id != null && (rs_c.getString("id").equals(session_id) || session_level.equals("10"))) { %>
				<input class="btn_comment_del" type="button" name="delete" value="삭제" onclick="location.href='lounge_comment_delete.jsp?code=<%=code %>&post=<%=uid %>&comment_uid=<%=rs_c.getString("uid") %>'">
				<%}
			} %>
		</td>
	</tr>
		<script>
			var popupWidth = 1100; //팝업창 너비
			var popupHeight = 500; //팝업창 높이
			var popupX = Math.ceil(( window.screen.width - popupWidth )/2);
			var popupY = Math.ceil(( window.screen.height - popupHeight )/2);
		
			function comment_reply(uid) {
				window.open('comment_reply.jsp?comment_uid='+uid,'3','width=' + popupWidth + ',height=' + popupHeight + ',left='+ popupX + ', top='+ popupY);
			}
			
			function comment_edit(uid) {
				window.open('comment_edit.jsp?comment_uid='+uid,'4','width=' + popupWidth + ',height=' + popupHeight + ',left='+ popupX + ', top='+ popupY);
			}
		</script>
		<tr>
			<td>
				<div style="height: 10px;"></div>
			</td>
		</tr>
	<%
	}
	%>
	<% //댓글이 없을 때
	String comment_count_sql = "select count(*) from poppy_comment where commu_bbs='"+code+"' and bbs_uid='"+uid+"'";
	
	Connection cc_conn = DriverManager.getConnection(url, user, password);
	Statement cc_stmt = cc_conn.createStatement();
	ResultSet cc_rs = cc_stmt.executeQuery(comment_count_sql);
	
	int comment_count = 0;
	if(cc_rs.next()) {
		comment_count = cc_rs.getInt(1);
	}
	
	if(comment_count == 0) { //댓글이 없다면 %>
		<tr>
			<td align=center>
				<div class="div_nothing">
					첫 댓글을 작성해주세요 !
					<img class="no_answer_img" src="/img/samsek05.png" style="height: 150px">
				</div>
			</td>
		</tr>
	<%} %>
</table>

<form action="/commu_main.jsp" method="post">
	<input type="hidden" name="bbs_uid" value="<%=uid %>">
</form>
<form action="poppy_comment_insert.jsp" method="post">
<input type="hidden" name="commu_bbs" value="<%=code %>">
<input type="hidden" name="bbs_uid" value="<%=uid %>">
<input type="hidden" name="nick" value="<%if(session_id != null) {%><%=header_rs.getString("nickname") %><%}%>">
<table width=1100px border=0 align=center> <!-- 댓글 작성란 -->
	<tr>
		<td align=center>
			<textarea class="text_comment" name="comment" placeholder="댓글을 입력해주세요."></textarea>
		</td>
	</tr>
	<tr>
		<td align=right>
			<button class="btn_edit">등록</button>
		</td>
	</tr>
</table>
</form>
<table width=1100px border=0 align=center>
	<tr>
		<td>
			<input class="btn_write" type="button" value="목록" onclick="location.href='/bbs_event/commu_main.jsp?code=<%=code %>&category=1'">
		</td>
	</tr>
</table>

<%@ include file="/include/pro_footer.jsp" %>