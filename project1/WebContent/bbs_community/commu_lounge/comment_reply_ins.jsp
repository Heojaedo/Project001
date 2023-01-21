<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file='/include/pro_header.jsp' %>

<%
request.setCharacterEncoding("utf-8");

String id = session_id;
String commu_bbs = request.getParameter("commu_bbs");
String bbs_uid = request.getParameter("bbs_uid");
String comment_uid = request.getParameter("uid");
String comment = request.getParameter("comment_reply");
String fid = request.getParameter("fid");
String thread = request.getParameter("thread");
String to_nick = request.getParameter("to_nick"); //누구에게

//현재 날짜
Date today = new Date();
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd kk:mm:ss");
String signdate = sdf.format(today);

SimpleDateFormat sdf2 = new SimpleDateFormat("yyyyMMddkkmmss");
String signdate2 = sdf2.format(today);

//thread 값 설정
String sql_fid = "select thread,right(thread,1) as thread_right from poppy_comment where fid="+fid+" and length(thread)=length('"+thread+"')+1 AND locate('"+thread+"',thread)=1 order by thread desc limit 1";

//locate('AB','ABA') = 1

//첫 항의 'AB'가 두번째 항의 내용 중에 1번째 자리부터 매칭이 있는지 여부
Connection conn_count=DriverManager.getConnection(url, user, password);
Statement stmt_count=conn_count.createStatement();
ResultSet rs_count=stmt_count.executeQuery(sql_fid);

String o_thread = "";
String r_thread = "";
String thread_head = "";
String new_thread = "";
char thread_foot = 'a';

if(rs_count.next()){
	o_thread = rs_count.getString("thread");

	//끝자리 +1 처리
	r_thread = rs_count.getString("thread_right");
	thread_foot = (char) (r_thread.charAt(0) + 1);

	//out.print(thread_foot);
}

if(o_thread != null && o_thread != "") {
	thread_head = o_thread.substring(0,o_thread.length()-1);
	new_thread = thread_head + thread_foot;
} else {
	new_thread = thread + "A";
}

String sql = "insert into poppy_comment values(null,'"+commu_bbs+"','"+bbs_uid+"','"+session_id+"','"+header_rs.getString("nickname")+"','"+to_nick+"','"+comment+"','"+signdate+"','"+signdate2+"','"+fid+"','"+new_thread+"','n')";

Connection conn = DriverManager.getConnection(url, user, password);
Statement stmt = conn.createStatement();
stmt.executeUpdate(sql);
%>

<script>
	opener.parent.location.reload();
	window.close();
</script>