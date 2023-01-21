<%@ page import="com.oreilly.servlet.*" %>
<%@ page import="com.oreilly.servlet.multipart.*" %>
<%@page import="java.util.Enumeration"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/include/pro_header.jsp" %>

<%
request.setCharacterEncoding("utf-8");

//String uploadPath=request.getRealPath("../upload");
String uploadPath = "C:\\jsp_project\\project1\\WebContent\\upload";
int size = 10*1024*1024; //10메가

MultipartRequest multi = new MultipartRequest(request,uploadPath,size,"utf-8",new DefaultFileRenamePolicy());

String id = multi.getParameter("id");
String code = multi.getParameter("code");
String category = multi.getParameter("category");
String title = multi.getParameter("title");
String contents = multi.getParameter("contents"); //lounge_write에서 받아온 값들

//엔터키 치환
contents = contents.replace("\r\n","<br>");

//작은 따옴표 치환
contents = contents.replace("'","′");

String nick = header_rs.getString("nickname"); //pro_header에서 받아온 값

String loungefile = "";
String loungefile_name = "";
String loungefile_rename = "";
String thum_img = "";

//첨부파일 처리
Enumeration files = multi.getFileNames();	
	
loungefile = (String)files.nextElement(); //첨부 파일 하나의 요소

if(multi.getOriginalFileName(loungefile) != null) {
	loungefile_name = multi.getOriginalFileName(loungefile); //사용자가 올린 원래 파일명
	loungefile_rename = multi.getFilesystemName(loungefile); //시스템을 이용해서 중복된 파일명이 있다면 
}

//현재 날짜
Date today = new Date();
SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
String signdate = sd.format(today);

SimpleDateFormat sdf2 = new SimpleDateFormat("yyyyMMddkkmmss");
String signdate2 = sdf2.format(today);

String sql = "insert into "+code+" (uid,memberid,nickname,title,contents,signdate,signdate2,category,loungefile,loungefile_o) values (null,'"+id+"','"+nick+"','"+title+"','"+contents+"','"+signdate+"','"+signdate2+"','"+category+"','"+loungefile_rename+"','"+loungefile_name+"')";

Connection conn = DriverManager.getConnection(url, user, password);
Statement stmt = conn.createStatement();
stmt.executeUpdate(sql);
%>

<input value="<%=id %>">
<input value="<%=nick %>">
<input value="<%=title %>">
<input value="<%=contents %>">
<input value="<%=signdate %>">
<input value="<%=category %>">

<script>
	location.href="/bbs_community/commu_main.jsp?code=<%=code %>";
</script>