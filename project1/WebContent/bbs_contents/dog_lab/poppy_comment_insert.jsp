<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/include/pro_header.jsp" %>

<%
request.setCharacterEncoding("utf-8");

String commu_bbs = request.getParameter("commu_bbs"); 
String bbs_uid = request.getParameter("bbs_uid"); 
String nick = request.getParameter("nick");
String comment = request.getParameter("comment");

//현재 날짜
Date today = new Date();
SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String signdate = sd.format(today);

SimpleDateFormat sdf2 = new SimpleDateFormat("yyyyMMddkkmmss");
String signdate2 = sdf2.format(today);

String sql = "";

//답변 fid 값 설정
String sql_fid = "select max(fid) from poppy_comment";

Connection conn_fid = DriverManager.getConnection(url, user, password);
Statement stmt_fid = conn_fid.createStatement();
ResultSet rs_fid = stmt_fid.executeQuery(sql_fid);

int fid = 1; //default = 1 처리
		
if(rs_fid.next()) { //while
	if(rs_fid.getInt(1) > 0) { //첫 글이 아니라면
		fid = rs_fid.getInt(1) + 1; //최대값에 +1 처리
	} else { //첫 게시물 작성
		fid = 1;																
	}
}
%>

<%
if(session_id == null) {
%>	
	<script>
		alert("로그인이 필요한 서비스입니다.");
		history.back();
	</script>
<%
} else {
	sql = "insert into poppy_comment (uid,commu_bbs,bbs_uid,id,nick,comment,date,signdate2,fid,thread) values (null,'"+commu_bbs+"','"+bbs_uid+"','"+session_id+"','"+nick+"','"+comment+"','"+signdate+"','"+signdate2+"','"+fid+"','A')";
	
	Connection conn = DriverManager.getConnection(url, user, password);
	Statement stmt = conn.createStatement();
	stmt.executeUpdate(sql);
}
%>

<script>
	location.href="dog_lab_view.jsp?code=<%=commu_bbs %>&post=<%=bbs_uid %>";
</script>