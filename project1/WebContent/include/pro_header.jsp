<%@page import="java.net.URLDecoder"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/include/dbconnection.jsp" %>

<style>
	@import url(//spoqa.github.io/spoqa-han-sans/css/SpoqaHanSansNeo.css);
	
	body { /* 글씨체 */
		font-family: "Spoqa Han Sans Neo";
	}
	
	.td_hi { /* ~님, 안녕하세요! 칸 */
		align: left;
	}
	
	.btn_header_login { /* 로그인 버튼 */
		font-family: "Spoqa Han Sans Neo";
		font-size: 15px;
		width: 100px;
		height: 30px;
		background-color: #ffffff;
		border: 0px;
		cursor: pointer;
	}
	
	.btn_header { /* 로그아웃 마이페이지 버튼 div */
		display: flex;
		justify-content: flex-end;
		vertical-align: middle;
	}
	
	.div_logo { /* 로고 이미지를 감싼 블록 */
		display: flex;
		width: 100px;
		height: 100px;
	}
	
	.div_logo > div {
		flex: 1;
	}
	
	.img_logo { /* 로고 이미지 */
		width: 100px;
		height: 100px;
		object-fit: cover;
		border: 3px solid #000;
	}
	
	.div_title { /* 연구소 블록들을 감싼 블록 */
		display: flex;
		justify-content: flex-end;
		height: 100px;
	}
	
	.div_title > div {
		flex: 0 0 100;
	}
	
	.div_home { /* 홈 블록 */
		width: 120px;
		height: 60px;
		text-align: center;
		line-height: 150px;
		margin-right: 30px;
	}
	
	.div_contents { /* 컨텐츠 블록 */
		width: 100px;
		height: 100px;
		text-align: center;
		line-height: 150px;
		margin-right: 30px;
	}
	
	.div_commu { /* 커뮤니티 블록 */
		width: 100px;
		height: 100px;
		text-align: center;
		line-height: 150px;
		margin-right: 30px;
	}
	
	.div_event { /* 이벤트 블록 */
		width: 100px;
		height: 100px;
		text-align: center;
		line-height: 150px;
	}
	
	.tb_header { /* 안내 문구 로그인 로그아웃 테이블 크기 */
		width: 1100px;
		height: 40px;
	}
	
	.tb_header a { /* 로그인 링크 밑줄 없애기 */
		text-decoration: none;
		color: #000;
	}
	
	.tb_header a:hover { /* 로그인 링크 위에 마우스 갖다대면 */
		border-bottom: 1px solid #000; padding-bottom: 1px;
	}
	
	.tb_title { /* 로고 이미지, 게시판 링크 */
		width: 1100px;
		height: 100px;
	}
	
	.tb_title a { /* 연구소 블록 링크 밑줄 없애기 */
		text-decoration: none;
		color: #000;
		font-size: 24px;
		vertical-align: middle;
	}
	
	.header_nick {
		font-size: 22px;
	}
</style>

<%
request.setCharacterEncoding("utf-8");

String session_id = (String)session.getAttribute("id"); //login_insert에서 부여받은 session (id)
String session_nick = (String)session.getAttribute("nick"); //login_insert에서 부여받은 session (nick)
String session_level = (String)session.getAttribute("level"); //login_insert에서 부여받은 session (level)

//로그인 & 로그아웃 후 원래 있던 페이지로 이동
String query_str = request.getRequestURI() + "?" + request.getQueryString();
//out.print(query_str);

//닉네임 호출
String header_sql = "select * from poppy where memberid='"+session_id+"'";
Connection header_conn = DriverManager.getConnection(url, user, password);
Statement header_stmt = header_conn.createStatement();
ResultSet header_rs = header_stmt.executeQuery(header_sql);
if(header_rs.next()){}

//현재 URL값 구하기
String nowURL = "";

StringBuffer requestURL = request.getRequestURL();
String queryString = request.getQueryString();

if(queryString == null) {
	nowURL = requestURL.toString();
} else {
	nowURL = requestURL.append('?').append(queryString).toString();
}
%>

<!-- 헤더 -->
<table class="tb_header" border=0 align=center>
	<tr>
		<td class="td_hi" width=50% height=30px>
		<div>
		<%if(session_id != null && session_level.equals("10")) { %>
			<img src="/img/admin.png" style="width: 25px; vertical-align: middle;"> 
		<%} %>
		<%if(session_id != null) { //로그인 상태 %>
		<span class="header_nick"><%=header_rs.getString("nickname") %></span>님, 안녕하세요!
		<%} %>
		</div>
		</td>
		<td align=right width=50%>
		<%if(session_id == null) { //비로그인 상태 %>
		<form action="/member/pro_login.jsp">
			<input type="hidden" name="preURL" value="<%=query_str %>">
			<button class="btn_header_login">로그인</button>
		</form>
		<%} else { //로그인 상태 %>
		<div class="btn_header">
		<button class="btn_header_login" onclick="location.href='/member/pro_mypage.jsp?id=<%=session_id %>'">마이페이지</button>
		&nbsp;&nbsp;
		<form action="/member/pro_logout.jsp">
			<input type="hidden" name="preURL" value="<%=query_str %>">
			<button class="btn_header_login">로그아웃</button>
		</form>
		</div>
		<%} %>
		</td>
	</tr>
</table>
<div style="height: 10px"></div>
<table class="tb_title" border=0 align=center>
	<tr>
		<td width=120px align=center>
			<div class="div_logo">
				<a href="/"><img class="img_logo" src="/img/bemypet.png"></a>
			</div>
		</td>
		<td align=right>
			<div class="div_title">
				<div class="div_home"><a href="/">홈</a></div>
				<div class="div_contents"><a href="/bbs_contents/contents_main.jsp?code=dog_lab">콘텐츠</a></div>
				<div class="div_commu"><a href="/bbs_community/commu_main.jsp?code=poppy_lounge">커뮤니티</a></div>
				<div class="div_event"><a href="/bbs_event/commu_main.jsp?code=poppy_event&category=1">이벤트</a></div>
			</div>
		</td>
	</tr>
</table>
<br>
<hr>