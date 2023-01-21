<%@page import="com.mysql.cj.protocol.Resultset"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/include/pro_header.jsp" %>

<style>
	.span_title { /* 게시판 타이틀 글자 */
		font-size: 26px;
		font-weight: bold;
	}
	
	.span_head { /* 게시판 타이틀 머리글 */
		font-size: 22px;
		font-weight: bold;
	}
	
	.td_search_title {
		padding: 5px;
	}
	
	.td_search_contents {
		padding: 5px;
	}
	
	.span_post_title { /* 제목 글씨 스타일 */
		font-size: 18px;
	}
	
	.span_contents { /* 글 내용 글자 */
		font-size: 14px;
		color: #666a6d;
	}
	
	.div_nothing {
		background-color: #f6f6f9;
		width: 1000px;
		height: 150px;
		font-size: 18px;
		line-height: 150px;
	}
	
	.div_search {
		background-color: #fff7d5;
		width: 900px;
		height: 100px;
		font-size: 24px;
		line-height: 100px;
	}
	
	.no_answer_img {
		vertical-align: middle;
	}
	
	.td_search_contents { /* 내용 출력 박스 */
		overflow: hidden;
		white-space: nowrap;
		text-overflow: ellipsis;
		max-width: 700px;
	}
	
	.td_search_title a { /* 제목 링크 */
		text-decoration: none;
		color: #000;
		font-weight: 2px;
	}
	
	.td_search_title a:hover {
		border-bottom: 1px solid #000; padding-bottom: 1px;
	}
	
	.search_text { /* 검색 결과 안내 문구 */
		font-size: 28px;
	}
</style>

<%
String keyword = request.getParameter("search");
%>

<table width=1100px border=0 align=center>
	<tr>
		<td>
			<table width=500px border=0 align=center>
				<tr>
					<td class="search_text" align=center>
						<div class="div_search">
						키워드 '<%=keyword %>' 검색 결과입니다.
						<div>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<div style="height: 20px;"></div>
<table width=1100px border=0 align=center>
	<tr>
		<td>
			<table width=1000px border=0 align=center>
				<tr>
					<td class="td_search_title">
						<span class="span_head">콘텐츠/</span><span class="span_title">강아지 연구소</span>
					</td>
				</tr>
				<%
				//강아지 연구소에서 검색
				String sql_03 = "select count(*) from dog_lab where title like '%"+keyword+"%'";

				Connection conn_03 = DriverManager.getConnection(url, user, password);
				Statement stmt_03 = conn_03.createStatement();
				ResultSet rs_03 = stmt_03.executeQuery(sql_03);

				int num_03 = 0;

				if(rs_03.next()) {
					num_03 = rs_03.getInt(1);
				}

				String sql_003 = "";

				if(num_03 != 0) { //결과 있음
					sql_003 = "select * from dog_lab where title like '%"+keyword+"%' order by uid desc limit 0,5";

					Connection conn_003 = DriverManager.getConnection(url, user, password);
					Statement stmt_003 = conn_003.createStatement();
					ResultSet rs_003 = stmt_003.executeQuery(sql_003);
					
					while(rs_003.next()) { 
						//엔터키 다시 치환해서 출력
						String contents = rs_003.getString("contents");
						contents = contents.replace("<br>","\r\n");
					%>
					<tr>
						<td class="td_search_title">
							<a href="/bbs_contents/dog_lab/dog_lab_view.jsp?code=dog_lab&post=<%=rs_003.getString("uid") %>"><span class="span_post_title"><%=rs_003.getString("title") %></span></a>
						</td>
					</tr>
					<tr>
						<td class="td_search_contents">
							<span class="span_contents"><%=contents %></span>
						</td>
					</tr>
				<%} //if				
				} else { %>
					<tr>
						<td align=center>
							<div class="div_nothing">
								검색 결과가 없네요 ...
								<img class="no_answer_img" src="/img/samsek09.png" style="height: 150px">
							</div>
						</td>
					</tr>
				<%} %>
				<tr>
					<td>
						<hr>
					</td>
				</tr>
				<tr>
					<td class="td_search_title">
						<span class="span_head">콘텐츠/</span><span class="span_title">고양이 연구소</span>
					</td>
				</tr>
				<%
				//고양이 연구소에서 검색
				String sql_04 = "select count(*) from cat_lab where title like '%"+keyword+"%'";

				Connection conn_04 = DriverManager.getConnection(url, user, password);
				Statement stmt_04 = conn_04.createStatement();
				ResultSet rs_04 = stmt_04.executeQuery(sql_04);

				int num_04 = 0;

				if(rs_04.next()) {
					num_04 = rs_04.getInt(1);
				}

				String sql_004 = "";

				if(num_04 != 0) { //결과 있음
					sql_004 = "select * from cat_lab where title like '%"+keyword+"%' order by uid desc limit 0,5";

					Connection conn_004 = DriverManager.getConnection(url, user, password);
					Statement stmt_004 = conn_004.createStatement();
					ResultSet rs_004 = stmt_004.executeQuery(sql_004);
					
					while(rs_004.next()) { 
						//엔터키 다시 치환해서 출력
						String contents = rs_004.getString("contents");
						contents = contents.replace("<br>","\r\n");
					%>
					<tr>
						<td class="td_search_title">
							<a href="/bbs_contents/dog_lab/dog_lab_view.jsp?code=cat_lab&post=<%=rs_004.getString("uid") %>"><span class="span_post_title"><%=rs_004.getString("title") %></span></a>
						</td>
					</tr>
					<tr>
						<td class="td_search_contents">
							<span class="span_contents"><%=contents %></span>
						</td>
					</tr>
				<%} //if				
				} else { %>
					<tr>
						<td align=center>
							<div class="div_nothing">
								검색 결과가 없네요 ...
								<img class="no_answer_img" src="/img/samsek09.png" style="height: 150px">
							</div>
						</td>
					</tr>
				<%} %>
				<tr>
					<td>
						<hr>
					</td>
				</tr>
				<tr>
					<td class="td_search_title">
						<span class="span_head">커뮤니티/</span><span class="span_title">라운지</span>
					</td>
				</tr>
				<%
				//라운지에서 검색
				String sql_01 = "select count(*) from poppy_lounge where title like '%"+keyword+"%'";

				Connection conn_01 = DriverManager.getConnection(url, user, password);
				Statement stmt_01 = conn_01.createStatement();
				ResultSet rs_01 = stmt_01.executeQuery(sql_01);

				int num_01 = 0;

				if(rs_01.next()) {
					num_01 = rs_01.getInt(1);
				}

				String sql_001 = "";

				if(num_01 != 0) { //결과 있음
					sql_001 = "select * from poppy_lounge where title like '%"+keyword+"%' order by uid desc limit 0,5";

					Connection conn_001 = DriverManager.getConnection(url, user, password);
					Statement stmt_001 = conn_001.createStatement();
					ResultSet rs_001 = stmt_001.executeQuery(sql_001);
					
					while(rs_001.next()) { 
						//엔터키 다시 치환해서 출력
						String contents = rs_001.getString("contents");
						contents = contents.replace("<br>","\r\n");
					%>
					<tr>
						<td class="td_search_title">
							<a href="/bbs_community/commu_lounge/lounge_view.jsp?code=poppy_lounge&post=<%=rs_001.getString("uid") %>"><span class="span_post_title"><%=rs_001.getString("title") %></span></a>
						</td>
					</tr>
					<tr>
						<td class="td_search_contents">
							<span class="span_contents"><%=contents %></span>
						</td>
					</tr>
				<%} //if				
				} else { %>
					<tr>
						<td align=center>
							<div class="div_nothing">
								검색 결과가 없네요 ...
								<img class="no_answer_img" src="/img/samsek09.png" style="height: 150px">
							</div>
						</td>
					</tr>
				<%} %>
				<tr>
					<td>
						<hr>
					</td>
				</tr>
				<tr>
					<td class="td_search_title">
						<span class="span_head">커뮤니티/</span><span class="span_title">Q&A</span>
					</td>
				</tr>
				<%
				//Q&A에서 검색
				String sql_02 = "select count(*) from poppy_qna where title like '%"+keyword+"%'";

				Connection conn_02 = DriverManager.getConnection(url, user, password);
				Statement stmt_02 = conn_02.createStatement();
				ResultSet rs_02 = stmt_02.executeQuery(sql_02);

				int num_02 = 0;

				if(rs_02.next()) {
					num_02 = rs_02.getInt(1);
				}

				String sql_002 = "";

				if(num_02 != 0) { //결과 있음
					sql_002 = "select * from poppy_qna where title like '%"+keyword+"%' order by uid desc limit 0,5";

					Connection conn_002 = DriverManager.getConnection(url, user, password);
					Statement stmt_002 = conn_002.createStatement();
					ResultSet rs_002 = stmt_002.executeQuery(sql_002);
					
					while(rs_002.next()) { 
						//엔터키 다시 치환해서 출력
						String contents = rs_002.getString("contents");
						contents = contents.replace("<br>","\r\n");
					%>
					<tr>
						<td class="td_search_title">
							<a href="/bbs_community/commu_lounge/lounge_view.jsp?code=poppy_qna&post=<%=rs_002.getString("uid") %>"><span class="span_post_title"><%=rs_002.getString("title") %></span></a>
						</td>
					</tr>
					<tr>
						<td class="td_search_contents">
							<span class="span_contents"><%=contents %></span>
						</td>
					</tr>
				<%} //if				
				} else { %>
					<tr>
						<td align=center>
							<div class="div_nothing">
								검색 결과가 없네요 ...
								<img class="no_answer_img" src="/img/samsek09.png" style="height: 150px">
							</div>
						</td>
					</tr>
				<%} %>
				<tr>
					<td>
						<hr>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>

<%@ include file="/include/pro_footer.jsp" %>