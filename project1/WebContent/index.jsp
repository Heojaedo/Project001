<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/include/pro_header.jsp" %>

<style>
	.input_search { /* 홈 화면 search */
		width: 300px;
		height: 50px;
		font-family: "Spoqa Han Sans Neo";
		padding: 10px;
		font-size: 24px;
	}
	
	.home_img { /* 홈 화면 게시글 첨부 이미지 */
		width: 420px;
		height: 300px;
		object-fit: cover;
		border-radius: 10px;
	}
	
	.td_new_contents { /* 최신 콘텐츠 글씨 */
		font-family: "Spoqa Han Sans Neo";
		padding: 10px;
		font-size: 28px;
	}
	
	.new_contents_img { /* 최신 콘텐츠 이미지 */
		padding: 2px;
	}
	
	.new_contents_title { /* 최신 콘텐츠 제목 */
		font-family: "Spoqa Han Sans Neo";
		padding: 15px;
		font-size: 20px;
	}
	
	.btn_show { /* 더보기 버튼 */
		width: 120px;
		height: 35px;
		font-family: "Spoqa Han Sans Neo";
		font-size: 16px;
		background-color: #fcd11e;
		border: 0px;
		border-radius: 35px;
		cursor: pointer;
	}
	
	.table_new_contents a {
		text-decoration: none;
		color: #000;
	}
	
	.new_contents_title a:hover { /* 제목 링크 */
		border-bottom: 1px solid #000; padding-bottom: 1px;
	}
	
	.btn_search { /* 검색 버튼 */
		width: 50px;
		height: 50px;
		font-family: "Spoqa Han Sans Neo";
		font-size: 16px;
		background-color: #fcd11e;
		border: 0px;
		border-radius: 30px;
		cursor: pointer;
	}
	
	.img_search { /* 검색 버튼 돋보기 이미지 */
		width: 35px;
		vertical-align: middle;
	}
</style>

<%
String new_dog_lab = "select * from dog_lab order by uid desc limit 0,3";

Connection nd_conn = DriverManager.getConnection(url, user, password);
Statement nd_stmt = nd_conn.createStatement();
ResultSet nd_rs = nd_stmt.executeQuery(new_dog_lab);

String new_cat_lab = "select * from cat_lab order by uid desc limit 0,3";

Connection nc_conn = DriverManager.getConnection(url, user, password);
Statement nc_stmt = nc_conn.createStatement();
ResultSet nc_rs = nc_stmt.executeQuery(new_cat_lab);
%>
<div style="height: 20px;"></div>
<div style="height: 20px;"></div>
<form action="home_search.jsp">
<table width=1100px border=0 align=center>
	<tr>
		<td>
			<table width=800px border=0 align=center>
				<tr>
					<td width=200px>
					</td>
					<td width=300px align=center>
						<input class="input_search" name="search" value="" placeholder="키워드 검색">
					</td>
					<td width=200px>
						<button class="btn_search"><img class="img_search" src="/img/search.png""></button>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</form>
<div style="height: 20px;"></div>
<div style="height: 20px;"></div>
<table width=1100px border=0 align=center>
	<tr>
		<td>
			<table width=1000px border=0 align=center>
				<tr>
					<td colspan=2 align=center class="td_new_contents">
						최신 콘텐츠
					</td>
				</tr>
				<tr>
					<td>
						<div style="height: 20px;"></div>
					</td>
				</tr>
				<tr>
					<td>
						<table class="table_new_contents" width=450px border=0 align=right>
			
								<%while(nd_rs.next()) { %>
								<tr>
									<td class="new_contents_img" align=center>
										<a href="/bbs_contents/dog_lab/dog_lab_view.jsp?code=dog_lab&post=<%=nd_rs.getString("uid") %>"><img class="home_img" src="/../upload/<%=nd_rs.getString("loungefile") %>"></a>
									</td>
								</tr>
								<tr>
									<td class="new_contents_title">
										<a href="/bbs_contents/dog_lab/dog_lab_view.jsp?code=dog_lab&post=<%=nd_rs.getString("uid") %>"><%=nd_rs.getString("title") %></a>
									</td>
								</tr>
								<%} %>
						</table>
					</td>
					<td>
						<table class="table_new_contents" width=450px border=0 align=left>
			
								<%while(nc_rs.next()) { %>
								<tr>
									<td class="new_contents_img" align=center>
										<a href="/bbs_contents/dog_lab/dog_lab_view.jsp?code=cat_lab&post=<%=nc_rs.getString("uid") %>"><img class="home_img" src="/../upload/<%=nc_rs.getString("loungefile") %>"></a>
									</td>
								</tr>
								<tr>
									<td class="new_contents_title">
										<a href="/bbs_contents/dog_lab/dog_lab_view.jsp?code=cat_lab&post=<%=nc_rs.getString("uid") %>"><%=nc_rs.getString("title") %></a>
									</td>
								</tr>
								<%} %>
						</table>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<div style="height: 20px">
</div>
<table width=1100px border=0 align=center>
	<tr>
		<td align=center>
			<input class="btn_show" type="button" value="더보기" onclick="location.href='/bbs_contents/contents_main.jsp?code=dog_lab'">
		</td>
	</tr>
</table>
<div style="height: 20px">
</div>

<%@ include file="/include/pro_footer.jsp" %>