<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.*"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/include/pro_header.jsp" %>

<style>
	.lounge_img { /* 첨부 이미지 */
		width: 180px;
		height: 140px;
		object-fit: cover;
		border-radius: 15px;
		padding: 10px;
	}
	
	.preview_img { /* 이미지가 없는 게시물 대체 이미지 */
		width: 160px;
		height: 140px;
		object-fit: cover;
		margin-right: 20px;
		padding: 10px;
	}
	
	.div_nothing {
		background-color: #f6f6f9;
		height: 300px;
		font-size: 30px;
	}
	
	.div_nothing img {
		vertical-align: middle;
	}
	
	.span_title { /* 라운지 Q&A 글자 */
		font-size: 24px;
	}
	
	.div_category { /* 카테고리 div */
		display: flex;
	}
	
	.div_category a { /* 카테고리 div 링크 밑줄 없애기 */
		text-decoration: none;
		color: #000;
	}
	
	.div_category a:visited { /* 카테고리 div 링크 누른 후 글씨색 */
		color: #000;
	}
	
	.div_0, .div_1, .div_2, .div_3, .div_4 { /* 카테고리 */
		width: 120px;
		padding: 5px;
		margin-right: 15px;
		text-align: center;
		border-radius: 30px;
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
	
	.tb_post a { /* 포스트 링크 밑줄 없애기 */
		text-decoration: none;
		color: #000;
	}
	
	.span_contents { /* 글 내용 글자 */
		font-size: 14px;
		color: #666a6d;
	}
	
	.span_post_info { /* 글쓴이 작성일 글자 */
		font-size: 14px;
		color: #666a6d;
	}
	
	.span_post_comment { /* 글쓴이 작성일 댓글 수 글자 */
		font-size: 16px;
	}
	
	.btn_write { /* 글쓰기 버튼 */
		width: 120px;
		height: 35px;
		font-family: "Spoqa Han Sans Neo";
		font-size: 16px;
		background-color: #fcd11e;
		border: 0px;
		border-radius: 35px;
		cursor: pointer;
	}
	
	.td_search_input { /* 검색창 */
		width: 300px;
		height: 35px;
		font-family: "Spoqa Han Sans Neo";
		font-size: 14px;
		text-indent: 5px;
	}
	
	.btn_search { /* 검색 버튼 */
		width: 35px;
		height: 35px;
		font-family: "Spoqa Han Sans Neo";
		font-size: 16px;
		background-color: #fcd11e;
		border: 0px;
		border-radius: 30px;
		cursor: pointer;
	}
	
	.search_select { /* 검색 select */
		width: 80px;
		height: 35px;
		font-family: "Spoqa Han Sans Neo";
		font-size: 16px;
	}
	
	.img_search { /* 검색 버튼 돋보기 이미지 */
		width: 20px;
		vertical-align: middle;
	}
	
	.direct_page { /* 현재 페이지 숫자 글씨 */
		font-family: "Spoqa Han Sans Neo";
		font-size: 24px;
	}
	
	.other_page { /* 다른 페이지 숫자 글씨 */
		font-family: "Spoqa Han Sans Neo";
		font-size: 18px;
	}
	
	.other_page_link { /* 다른 페이지 링크 */
		color: #666666;
		text-decoration: none;
	}
	
	.tb_paging a:hover { /* 페이지 링크 마우스 오버 */
		text-decoration: underline;
	}
</style>

<%
String id = session_id; //로그인하면서 받은 session_id값
String code = request.getParameter("code"); //header에서 받은 값 (dog_lab)

//카테고리
String category_num = request.getParameter("category");

String category_str = "";

if(category_num == null){
	category_str = "";
}else{
	category_str = " category = '"+category_num+"'";
}
//검색 부분
String field = ""; //get
String search = "";

if(request.getParameter("field") != null) {
	field = request.getParameter("field");
}

if(request.getParameter("search") != null) {
	search = request.getParameter("search");
}

//총 게시글 수
String post_count = "";

if(category_num == null && search.equals("")) { //검색 없다.
	post_count = "select count(*) from "+code+"";
} else if(category_num == null && !search.equals("")) {
	post_count = "select count(*) from "+code+" where "+field+" like '%"+search+"%'";
} else if(category_num != null && search.equals("")) {
	post_count = "select count(*) from "+code+" where category='"+category_num+"'";
} else if(category_num != null && !search.equals("")) {
	post_count = "select count(*) from "+code+" where category='"+category_num+"' and "+field+" like '%"+search+"%'";
}

Connection conn_p = DriverManager.getConnection(url, user, password);
Statement stmt_p = conn_p.createStatement();
ResultSet rs_p = stmt_p.executeQuery(post_count);

int int_post_count = 0;

if(rs_p.next()) {
	int_post_count = rs_p.getInt(1);
}

rs_p.close();
stmt_p.close();
conn_p.close();

//페이징
int page_now = 1; //현재 페이지

if(request.getParameter("page_now") != null) {
	page_now = Integer.parseInt(request.getParameter("page_now"));
}

int post_per_page = 5; //한 페이지에 출력할 게시글 수
int page_per_block = 5; //한 블록에 출력할 페이지 수
int total_page = 0; //총 페이지 수
int first = 0; //limit 시작값

//총 페이지 수 = (총 게시글 수 / 한 페이지에 출력할 게시글 수)값에서 소수점을 올려야 함
total_page = (int) Math.ceil(int_post_count / (double) post_per_page);
first = post_per_page * (page_now - 1);

//출력 구문
String sql = "";

if(search.equals("")) { //검색 없다.
	sql = "select * from "+code+" order by uid desc limit "+first+","+post_per_page+"";
} else {
	sql = "select * from "+code+" where "+field+" like '%"+search+"%' order by uid desc limit "+first+","+post_per_page+"";
}

Connection conn = DriverManager.getConnection(url, user, password);
Statement stmt = conn.createStatement();
ResultSet rs = stmt.executeQuery(sql);

//카테고리를 출력 구문
String category_sql = "";

if(search.equals("")) { //검색 없다.
	category_sql = "select * from "+code+" where category='"+category_num+"' order by uid desc limit "+first+","+post_per_page+"";
} else {
	category_sql = "select * from "+code+" where category='"+category_num+"' and "+field+" like '%"+search+"%' order by uid desc limit "+first+","+post_per_page+"";
}

Connection cate_conn = DriverManager.getConnection(url, user, password);
Statement cate_stmt = cate_conn.createStatement();
ResultSet cate_rs = cate_stmt.executeQuery(category_sql);
%>

<style>
	.td_title a { /* 라운지 Q&A 링크 효과 */
		text-decoration: none;
	}
	
	.link_lounge { /* 강아지 연구소 링크 */
		<%if(code.equals("dog_lab")) { %>
			color: #000;
			font-weight: bold;
		<%} else { %>
			color: #afafb1;
		<%} %>
	}
	
	.link_qna { /* 고양이 연구소 링크 */
		<%if(code.equals("cat_lab")) { %>
			color: #000;
			font-weight: bold;
		<%} else { %>
			color: #afafb1;
		<%} %>
	}
	
	.span_post_title { /* 제목 글씨 스타일 */
		font-size: 18px;
	}
	
	.td_post_title, .td_post_contents {
		padding: 10px;
	}
	
	.td_post_title a:hover { /* 제목 링크 */
		border-bottom: 1px solid #000; padding-bottom: 1px;
	}
	
	.td_post_title { /* 제목 출력 박스 */
		overflow: hidden;
		white-space: nowrap;
		text-overflow: ellipsis;
		max-width: 700px;
	}
	
	.td_post_contents { /* 내용 출력 박스 */
		overflow: hidden;
		white-space: nowrap;
		text-overflow: ellipsis;
		max-width: 700px;
	}
	
	#contents_link { /* 내용 링크 */
		text-decoration: none;
		color: #666a6d;
	}
	
	.div_0 { /* 전체 카테고리 */
		<%if(category_num == null) { %>
			width: 150px;
			font-size: 24px;
		<%} %>
	}
	
	.div_1 { /* 강아지 건강 카테고리 */
		<%if(category_num != null && category_num.equals("1")) { %>
			width: 200px;
			font-size: 24px;
		<%} %>
	}
	
	.div_2 { /* 강아지 음식 카테고리 */
		<%if(category_num != null && category_num.equals("2")) { %>
			width: 200px;
			font-size: 24px;
		<%} %>
	}
	
	.div_3 { /* 강아지 행동 카테고리 */
		<%if(category_num != null && category_num.equals("3")) { %>
			width: 200px;
			font-size: 24px;
		<%} %>
	}
	
	.div_4 { /* 견종백과 카테고리 */
		<%if(category_num != null && category_num.equals("4")) { %>
			width: 200px;
			font-size: 24px;
		<%} %>
	}
	
	.div_0 a:hover { /* 카테고리 div 링크 위에 마우스 */
		<%if(category_num == null) { %>
			text-decoration: none;
		<%} else { %>
			border-bottom: 1px solid #000; padding-bottom: 1px;
		<%} %>
	}
	
	.div_1 a:hover { /* 카테고리 div 링크 위에 마우스 */
		<%if(category_num != null && category_num.equals("1")) { %>
			text-decoration: none;
		<%} else { %>
			border-bottom: 1px solid #000; padding-bottom: 1px;
		<%} %>
	}
	
	.div_2 a:hover { /* 카테고리 div 링크 위에 마우스 */
		<%if(category_num != null && category_num.equals("2")) { %>
			text-decoration: none;
		<%} else { %>
			border-bottom: 1px solid #000; padding-bottom: 1px;
		<%} %>
	}
	
	.div_3 a:hover { /* 카테고리 div 링크 위에 마우스 */
		<%if(category_num != null && category_num.equals("3")) { %>
			text-decoration: none;
		<%} else { %>
			border-bottom: 1px solid #000; padding-bottom: 1px;
		<%} %>
	}
	
	.div_4 a:hover { /* 카테고리 div 링크 위에 마우스 */
		<%if(category_num != null && category_num.equals("4")) { %>
			text-decoration: none;
		<%} else { %>
			border-bottom: 1px solid #000; padding-bottom: 1px;
		<%} %>
	}
	
	.img_samsek { /* 카테고리-삼색이 이미지 */
		vertical-align: top;
	}
</style>

<input type="hidden" value="<%=code %>">
<input type="hidden" value="총 게시글 수: <%=int_post_count %>">
<input type="hidden" value="검색 항목: <%=field %>">
<input type="hidden" value="검색어: <%=search %>">
<div style="height: 20px;"></div>
<table width=1100px border=0 align=center>
	<tr>
		<td class="td_title">
		<a href="/bbs_contents/contents_main.jsp?code=dog_lab" class="link_lounge"><span class="span_title">강아지 연구소</span></a>
		&nbsp;&nbsp;&nbsp;
		<a href="/bbs_contents/contents_main.jsp?code=cat_lab" class="link_qna"><span class="span_title">고양이 연구소</span></a>
		</td>
	</tr>
	<tr>
		<td><div style="height: 20px;"></div></td>
	</tr>
	<tr>
		<td colspan=2>
			<div class="div_category">
				<div class="div_0"><%if(category_num == null) { %><img class="img_samsek" src="/img/samsek08.png" width=60px><%} %><a href="/bbs_contents/contents_main.jsp?code=<%=code %>">전체</a></div>
				<div class="div_1"><%if(category_num != null && category_num.equals("1")) { %><img class="img_samsek" src="/img/samsek08.png" width=60px><%} %><a href="/bbs_contents/contents_main.jsp?code=<%=code %>&category=1"><%if(code.equals("dog_lab")) {%>강아지 건강<%} else if(code.equals("cat_lab")) {%>고양이 건강<%} %></a></div>
				<div class="div_2"><%if(category_num != null && category_num.equals("2")) { %><img class="img_samsek" src="/img/samsek08.png" width=60px><%} %><a href="/bbs_contents/contents_main.jsp?code=<%=code %>&category=2"><%if(code.equals("dog_lab")) {%>강아지 음식<%} else if(code.equals("cat_lab")) {%>고양이 음식<%} %></a></div>
				<div class="div_3"><%if(category_num != null && category_num.equals("3")) { %><img class="img_samsek" src="/img/samsek08.png" width=60px><%} %><a href="/bbs_contents/contents_main.jsp?code=<%=code %>&category=3"><%if(code.equals("dog_lab")) {%>강아지 행동<%} else if(code.equals("cat_lab")) {%>고양이 행동<%} %></a></div>
				<div class="div_4"><%if(category_num != null && category_num.equals("4")) { %><img class="img_samsek" src="/img/samsek08.png" width=60px><%} %><a href="/bbs_contents/contents_main.jsp?code=<%=code %>&category=4"><%if(code.equals("dog_lab")) {%>견종백과<%} else if(code.equals("cat_lab")) {%>묘종백과<%} %></a></div>
			</div>
		</td>
	</tr>
</table>
<div style="height: 20px;"></div>
<table class="table1" width=1100px border=0 align=center>
	<tr>
		<td>
		<%
		//넘버링 초기값
		int post = int_post_count - ((page_now - 1) * post_per_page); 
		%>
		<%if(category_num == null) { //카테고리 x
			while(rs.next()) {
				String loungefile = rs.getString("loungefile");
				String signdate = rs.getString("signdate");
				
				String post_signdate = rs.getString("signdate").substring(11, 16); //오늘 게시글 작성 시간
				String last_post_signdate = rs.getString("signdate").substring(0, 10); //지난 게시글 작성 시간
				
				//새 글에 new 표시하기
				
				//현재 시각
				Date nowtime = new Date();
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
				String post_signdate11 = sdf.format(nowtime);
						
				SimpleDateFormat sdf2 = new SimpleDateFormat("yyyyMMddkkmmss");
				String post_signdate22 = sdf2.format(nowtime);
				
				String today_date = post_signdate22.substring(0, 8); //현재 날짜
				String post_date = rs.getString("signdate2").substring(0, 8); //작성 날짜
				
				//글 작성 시각
				long a = Long.parseLong(post_signdate22);
				long b = 0;
				if(!rs.getString("signdate2").equals("")) {
					b = Long.parseLong(rs.getString("signdate2"));
				}
				
				//댓글 수 출력
				String comment_sql = "select count(*) from poppy_comment where commu_bbs='"+code+"' and bbs_uid='"+rs.getString("uid")+"'";
	
				Connection comment_conn = DriverManager.getConnection(url, user, password);
				Statement comment_stmt = comment_conn.createStatement();
				ResultSet comment_rs = comment_stmt.executeQuery(comment_sql);
	
				int comment_count = 0;
				if(comment_rs.next()) {
					comment_count = comment_rs.getInt(1);
				}
				
				//엔터키 다시 치환해서 출력
				String contents = rs.getString("contents");
				contents = contents.replace("<br>","\r\n");
			%>
				<table class="tb_post" width=1000px height=165px border=0 align=center>
					<%
					String nowpage_num = request.getParameter("page_now"); //현재 페이지 번호
					
					String sql_mrp = "";
					int page_post_count = 0; //limit 앞의 숫자
					String top_post_num = "";
					
					if(nowpage_num == null || nowpage_num.equals("1")) { //1페이지 맨 꼭대기 글 위에 줄 삽입
						if(category_num == null && search.equals("")) { //검색 없다.
							sql_mrp = "select * from "+code+" order by uid desc limit "+page_post_count+",1";
						} else if(category_num == null && !search.equals("")) { //전체 카테고리에서 검색
							sql_mrp = "select * from "+code+" where "+field+" like '%"+search+"%' order by uid desc limit "+page_post_count+",1";
						} else if(category_num != null && search.equals("")) { //카테고리 선택
							sql_mrp = "select * from "+code+" where category='"+category_num+"' order by uid desc limit "+page_post_count+",1";
						} else if(category_num != null && !search.equals("")) { //카테고리 선택 후 검색
							sql_mrp = "select * from "+code+" where category='"+category_num+"' and "+field+" like '%"+search+"%' order by uid desc limit "+page_post_count+",1";
						}
						
						Connection conn_mrp = DriverManager.getConnection(url, user, password);
						Statement stmt_mrp = conn_mrp.createStatement();
						ResultSet rs_mrp = stmt_mrp.executeQuery(sql_mrp);
						
						if(rs_mrp.next()) {
							
						}
						
						if(rs_mrp.getString("uid").equals(rs.getString("uid"))) { %>
							<tr>
								<td colspan=5>
									<hr>
								</td>
							</tr>
						<%}
					} else if(nowpage_num != null && !nowpage_num.equals("1")) { //2페이지부터 맨 꼭대기 글 위에 줄 삽입
						int npn = Integer.parseInt(nowpage_num);
						page_post_count = (npn-1) * post_per_page; //limit 앞의 숫자
						
						if(page_post_count < int_post_count) {
							if(category_num == null && search.equals("")) { //검색 없다.
								sql_mrp = "select * from "+code+" order by uid desc limit "+page_post_count+",1";
							} else if(category_num == null && !search.equals("")) { //전체 카테고리에서 검색
								sql_mrp = "select * from "+code+" where "+field+" like '%"+search+"%' order by uid desc limit "+page_post_count+",1";
							} else if(category_num != null && search.equals("")) { //카테고리 선택
								sql_mrp = "select * from "+code+" where category='"+category_num+"' order by uid desc limit "+page_post_count+",1";
							} else if(category_num != null && !search.equals("")) { //카테고리 선택 후 검색
								sql_mrp = "select * from "+code+" where category='"+category_num+"' and "+field+" like '%"+search+"%' order by uid desc limit "+page_post_count+",1";
							}
							
							Connection conn_mrp2 = DriverManager.getConnection(url, user, password);
							Statement stmt_mrp2 = conn_mrp2.createStatement();
							ResultSet rs_mrp2 = stmt_mrp2.executeQuery(sql_mrp);
							
							if(rs_mrp2.next()) {
								
							}
							
							if(rs_mrp2.getString("uid").equals(rs.getString("uid"))) { %>
								<tr>
									<td colspan=5>
										<hr>
									</td>
								</tr>
							<%} 
						}	
					} %>
					
			 		<tr height=50px>
						<!-- 제목 -->
						<td class="td_post_title" colspan=4 width=800px>
						<span class="span_post_title">
						<a href="dog_lab/dog_lab_view.jsp?code=<%=code %>&post=<%=rs.getInt("uid") %>"><%=rs.getString("title") %></a>
						</span>
						&nbsp;&nbsp;
						<%if(a-b <= 10000) { %>
							<img src="img/main_new.gif">
						<%} %>
						</td>
						<!-- 사진 -->
						<td rowspan=3 width=200px height=160px align=right>
						<%if(!loungefile.equals("")) { //첨부파일이 있다면 %>
							<img class="lounge_img" src="/upload/<%=loungefile %>">
						<%} else {
								if(code.equals("poppy_qna")) { %>
								<img class="preview_img" src="/img/curioussamsek.png">
								<%} else { %>
								<img class="preview_img" src="/img/samsek06.png">
								<%}
						} %>
						</td>
					</tr>
					<tr height=40px>
						<!-- 내용 -->
						<td class="td_post_contents" colspan=4 width=800px>
						<span class="span_contents">
						<a href="dog_lab/dog_lab_view.jsp?code=<%=code %>&post=<%=rs.getInt("uid") %>" id="contents_link">
						<%=contents %>
						</a>
						</span>
						</td>
					</tr>
					<tr height=25px>
						<!-- 카테고리 -->
						<td width=100px align=center>
							<div class="div_post_category">
								<%if(code.equals("dog_lab")) { %>
									<%if(rs.getString("category").equals("1")) { //카테고리가 1일 때 %>
										강아지 건강
									<%} else if(rs.getString("category").equals("2")) { //카테고리가 2일 때 %>
										강아지 음식
									<%} else if(rs.getString("category").equals("3")) { //카테고리가 3일 때 %>
										강아지 행동
									<%} else { %>
										견종백과
									<%}
								} else { %>
									<%if(rs.getString("category").equals("1")) { //카테고리가 1일 때 %>
										고양이 건강
									<%} else if(rs.getString("category").equals("2")) { //카테고리가 2일 때 %>
										고양이 음식
									<%} else if(rs.getString("category").equals("3")) { //카테고리가 3일 때 %>
										고양이 행동
									<%} else { %>
										묘종백과
									<%}
								}%>
							</div>
						</td>
						<!-- 닉네임 -->
						<td width=200px><span class="span_post_info">글쓴이 | <%=rs.getString("nickname") %></span></td>
						<!-- 작성일 -->
						<td width=200px>
							<span class="span_post_info">
							<%if(today_date.equals(post_date)) { %>
								<%=post_signdate %>
							<%} else { %>
								<%=last_post_signdate %>
							<%} %>
							</span>
						</td>
						<!-- 댓글 수 -->
						<td width=100px>
							<span class="span_post_comment">댓글 수 : <%=comment_count %></span>
						</td>
					</tr>
					<tr>
						<td colspan=5>
						<hr>
					</td>
					</tr>
				</table>
			<%
				post--;
			} //while
		} else { //카테고리 o
			while(cate_rs.next()) {
				String loungefile = cate_rs.getString("loungefile");
				String signdate = cate_rs.getString("signdate");
				
				String post_signdate = cate_rs.getString("signdate").substring(11, 16); //오늘 게시글 작성 시간
				String last_post_signdate = cate_rs.getString("signdate").substring(0, 10); //지난 게시글 작성 시간
				
				//새 글에 new 표시하기
				
				//현재 시각
				Date nowtime = new Date();
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
				String post_signdate11 = sdf.format(nowtime);
						
				SimpleDateFormat sdf2 = new SimpleDateFormat("yyyyMMddkkmmss");
				String post_signdate22 = sdf2.format(nowtime);

				String today_date = post_signdate22.substring(0, 8); //현재 날짜
				String post_date = cate_rs.getString("signdate2").substring(0, 8); //작성 날짜
						
				//글 작성 시각
				long a = Long.parseLong(post_signdate22);
				long b = 0;
				if(!cate_rs.getString("signdate2").equals("")) {
					b = Long.parseLong(cate_rs.getString("signdate2"));
				}
				
				//댓글 수 출력
				String comment_sql = "select count(*) from poppy_comment where commu_bbs='"+code+"' and bbs_uid="+cate_rs.getString("uid")+"";
	
				Connection comment_conn = DriverManager.getConnection(url, user, password);
				Statement comment_stmt = comment_conn.createStatement();
				ResultSet comment_rs = comment_stmt.executeQuery(comment_sql);
	
				int comment_count = 0;
				if(comment_rs.next()) {
					comment_count = comment_rs.getInt(1);
				}
				
				//엔터키 다시 치환해서 출력
				String contents = cate_rs.getString("contents");
				contents = contents.replace("<br>","\r\n");
			%>
				<table class="tb_post" width=1000px height=165px border=0 align=center>
					<%
					String nowpage_num = request.getParameter("page_now"); //현재 페이지 번호
					
					String sql_mrp = "";
					int page_post_count = 0; //limit 앞의 숫자
					String top_post_num = "";
					
					if(nowpage_num == null || nowpage_num.equals("1")) { //1페이지 맨 꼭대기 글 위에 줄 삽입
						if(category_num == null && search.equals("")) { //검색 없다.
							sql_mrp = "select * from "+code+" order by uid desc limit "+page_post_count+",1";
						} else if(category_num == null && !search.equals("")) { //전체 카테고리에서 검색
							sql_mrp = "select * from "+code+" where "+field+" like '%"+search+"%' order by uid desc limit "+page_post_count+",1";
						} else if(category_num != null && search.equals("")) { //카테고리 선택
							sql_mrp = "select * from "+code+" where category='"+category_num+"' order by uid desc limit "+page_post_count+",1";
						} else if(category_num != null && !search.equals("")) { //카테고리 선택 후 검색
							sql_mrp = "select * from "+code+" where category='"+category_num+"' and "+field+" like '%"+search+"%' order by uid desc limit "+page_post_count+",1";
						}
						
						Connection conn_mrp = DriverManager.getConnection(url, user, password);
						Statement stmt_mrp = conn_mrp.createStatement();
						ResultSet rs_mrp = stmt_mrp.executeQuery(sql_mrp);
						
						if(rs_mrp.next()) {
							
						}
						
						if(rs_mrp.getString("uid").equals(cate_rs.getString("uid"))) { %>
							<tr>
								<td colspan=5>
									<hr>
								</td>
							</tr>
						<%}
					} else if(nowpage_num != null && !nowpage_num.equals("1")) { //2페이지부터 맨 꼭대기 글 위에 줄 삽입
						int npn = Integer.parseInt(nowpage_num);
						page_post_count = (npn-1) * post_per_page; //limit 앞의 숫자
						
						if(page_post_count < int_post_count) {
							if(category_num == null && search.equals("")) { //검색 없다.
								sql_mrp = "select * from "+code+" order by uid desc limit "+page_post_count+",1";
							} else if(category_num == null && !search.equals("")) { //전체 카테고리에서 검색
								sql_mrp = "select * from "+code+" where "+field+" like '%"+search+"%' order by uid desc limit "+page_post_count+",1";
							} else if(category_num != null && search.equals("")) { //카테고리 선택
								sql_mrp = "select * from "+code+" where category='"+category_num+"' order by uid desc limit "+page_post_count+",1";
							} else if(category_num != null && !search.equals("")) { //카테고리 선택 후 검색
								sql_mrp = "select * from "+code+" where category='"+category_num+"' and "+field+" like '%"+search+"%' order by uid desc limit "+page_post_count+",1";
							}
							
							Connection conn_mrp2 = DriverManager.getConnection(url, user, password);
							Statement stmt_mrp2 = conn_mrp2.createStatement();
							ResultSet rs_mrp2 = stmt_mrp2.executeQuery(sql_mrp);
							
							if(rs_mrp2.next()) {
								
							}
							
							if(rs_mrp2.getString("uid").equals(cate_rs.getString("uid"))) { %>
								<tr>
									<td colspan=5>
										<hr>
									</td>
								</tr>
							<%} 
						}	
					}
					%>
					<tr height=50px>
						<!-- 제목 -->
						<td class="td_post_title" colspan=4 width=800px>
						<span class="span_post_title">
						<a href="dog_lab/dog_lab_view.jsp?code=<%=code %>&post=<%=cate_rs.getInt("uid") %>"><%=cate_rs.getString("title") %></a>
						</span>
						&nbsp;&nbsp;
						<%if(a-b <= 10000) { %>
							<img src="img/main_new.gif">
						<%} %>
						</td>
						<!-- 사진 -->
						<td rowspan=3 width=200px height=160px align=right>
						<%if(!loungefile.equals("")) { //첨부파일이 있다면 %>
							<img class="lounge_img" src="/upload/<%=loungefile %>">
						<%} else {
								if(code.equals("poppy_qna")) { %>
								<img class="preview_img" src="/img/curioussamsek.png">
								<%} else { %>
								<img class="preview_img" src="/img/samsek06.png">
								<%}
						} %>
						</td>
					</tr>
					<tr height=40px>
						<!-- 내용 -->
						<td class="td_post_contents" colspan=4 width=800px>
						<span class="span_contents">
						<a href="dog_lab/dog_lab_view.jsp?code=<%=code %>&post=<%=cate_rs.getInt("uid") %>" id="contents_link">
						<%=contents %>
						</a>
						</span>
						</td>
					</tr>
					<tr height=25px>
						<!-- 카테고리 -->
						<td width=100px align=center>
							<div class="div_post_category">
								<%if(code.equals("dog_lab")) { %>
									<%if(category_num.equals("1")) { //카테고리가 1일 때 %>
										강아지 건강
									<%} else if(category_num.equals("2")) { //카테고리가 2일 때 %>
										강아지 음식
									<%} else if(category_num.equals("3")) { //카테고리가 3일 때 %>
										강아지 행동
									<%} else { %>
										견종백과
									<%}
								} else { %>
									<%if(category_num.equals("1")) { //카테고리가 1일 때 %>
										고양이 건강
									<%} else if(category_num.equals("2")) { //카테고리가 2일 때 %>
										고양이 음식
									<%} else if(category_num.equals("3")) { //카테고리가 3일 때 %>
										고양이 행동
									<%} else { %>
										묘종백과
									<%}
								}%>
							</div>
						</td>
						<!-- 닉네임 -->
						<td width=200px><span class="span_post_info">글쓴이 | <%=cate_rs.getString("nickname") %></span></td>
						<!-- 작성일 -->
						<td width=200px>
						<span class="span_post_info">
							<%if(today_date.equals(post_date)) { %>
								<%=post_signdate %>
							<%} else { %>
								<%=last_post_signdate %>
							<%} %>
						</span>
						</td>
						<!-- 댓글 수 -->
						<td width=100px>
							<span class="span_post_comment">댓글 수 : <%=comment_count %></span>
						</td>
					</tr>
					<tr>
						<td colspan=5>
						<hr>
						</td>
					</tr>
				</table>
			<%
				post--;
			} //while
		}
			%>
		</td>
		<%if(int_post_count == 0) { %>
			<tr>
				<td align=center>
					<div class="div_nothing">
						아직 작성된 글이 없어요!
						<img src="/img/no_answer.png" style="height: 300px">
					</div>
				</td>
			</tr>
		<%} %>
	</tr>
</table>
<div style="height: 20px">
</div>
<%if(session_id != null && session_level.equals("10")) { %>
<table width=1100px border=0 align=center>
	<tr>
		<td align=center>
			<input class="btn_write" type="button" value="글쓰기" onclick="location.href='dog_lab/dog_lab_write.jsp?id=<%=id %>&code=<%=code %>'">
		</td>
	</tr>
</table>
<%} %>
<div style="height: 20px">
</div>

<style>
	.link_page_move { /* 이전 페이지 다음 페이지 링크 */
		color: #000;
		font-size: 30px;
		text-decoration: none;
		hover: none;
	}
	
	.td_link_page_move a:hover {
		text-decoration: none;
	}
</style>

<table class="tb_paging" width=1100px border=0 align=center> <!-- 페이지 -->
	<tr>
		<td align=right width=475px class="td_link_page_move">
		<%
		//페이징 처리
		int total_block = 0; //총 블록 수
		int block = 0; //현재 블록
		int first_page = 0; //1~15페이지 --> 1, 6, 11페이지
		int last_page = 0; //5, 10, 15페이지
		int direct_page = 0;
		int my_page = 0;
		
		//총 블록 수 = (총 페이지 수 / 한 블록에 출력할 페이지 수)값에서 소수점을 올린 값
		total_block = (int) Math.ceil(total_page / (double) page_per_block);
		//현재 블록 = (현재 페이지 / 한 블록에 출력할 페이지 수)값에서 소수점을 올린 값
		block = (int) Math.ceil(page_now / (double) page_per_block);
		first_page = (block - 1) * page_per_block;
		last_page = block * page_per_block;
		
		if(total_block <= block) { //마지막 블록이라면
			last_page = total_page; //마지막 페이지는 총 페이지 수와 같다.
		}
		
		if(block == 1) { //첫번째 블록이라면
		%>
			
		<%
		} else { //첫번째 블록이 아니라면
			my_page = first_page;
		%>
			<a class="link_page_move" href="dog_lab.jsp?code=<%=code %>&page_now=<%=my_page %>">&#171;</a>
		<%
		}
		%>
		</td>
		
		<td align=center width=150px>
		<%
		for(direct_page = first_page + 1; direct_page <= last_page; direct_page++) {
			if(page_now == direct_page) { %>
				<span class="direct_page"><%=direct_page %></span>
			<%
			} else {
			%>
				<%if(category_num == null) { %>
				<span class="other_page"><a class="other_page_link" href="commu_main.jsp?code=<%=code %>&page_now=<%=direct_page %>&field=<%=field %>&search=<%=search %>"><%=direct_page %>&nbsp;</a></span>
				<%} else { %>
				<span class="other_page"><a class="other_page_link" href="commu_main.jsp?code=<%=code %>&category=<%=category_num %>&page_now=<%=direct_page %>&field=<%=field %>&search=<%=search %>"><%=direct_page %>&nbsp;</a></span>
				<%} %>
			<%
			}
		} //for
		%>
		</td>
		
		<td align=left width=475px class="td_link_page_move">
		<%
		//다음 블록
		if(block < total_block) {
			my_page = last_page + 1;
		%>
			<a class="link_page_move" href="dog_lab.jsp?code=<%=code %>&page_now=<%=my_page %>">&#187;</a>
		<%
		} else {
		%>
			
		<%
		}
		%>
		</td>
	</tr>
</table>
<div style="height: 20px">
</div>

<form action="/bbs_contents/contents_main.jsp?code=dog_lab" method="post">
<input type="hidden" name="code" value="<%=code %>">
<table width=1100px height=35px border=0 align=center>
	<tr>
		<td align=right style="vertical-align: middle;" width=390px>
			<select class="search_select" name="field">
				<option value="title" <%if(field.equals("title")) { %> selected <%} %>>제목</option>
				<option value="contents" <%if(field.equals("contents")) { %> selected <%} %>>내용</option>
				<option value="nickname" <%if(field.equals("nickname")) { %> selected <%} %>>닉네임</option>
			</select>
		</td>
		<td align=center width=320px>
			<input class="td_search_input" name="search" value="<%=search %>" maxlength="16">
		</td>
		<td align=left width=390px>
			<button class="btn_search"><img class="img_search" src="/img/search.png""></button>
		</td>
	</tr>
</table>
</form>

<div style="height: 20px;"></div>

<%@ include file="/include/pro_footer.jsp" %>