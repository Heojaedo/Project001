<%@ page import="com.oreilly.servlet.*" %>
<%@ page import="com.oreilly.servlet.multipart.*" %>
<%@page import="java.util.Enumeration"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.util.Enumeration"%>
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
String uid = multi.getParameter("post");
String category = multi.getParameter("category");
String title = multi.getParameter("title");
String contents = multi.getParameter("contents"); //lounge_write에서 받아온 값들

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

String sql = "";
if(multi.getOriginalFileName(loungefile) != null) { //첨부 파일 수정
	sql = "update "+code+" set title='"+title+"',contents='"+contents+"',category='"+category+"',loungefile='"+loungefile_rename+"',loungefile_o='"+loungefile_name+"' where uid='"+uid+"'";
} else { //첨부 파일 수정 x
	sql = "update "+code+" set title='"+title+"',contents='"+contents+"',category='"+category+"' where uid='"+uid+"'";
}
Connection conn = DriverManager.getConnection(url, user, password);
Statement stmt = conn.createStatement();
stmt.executeUpdate(sql);
%>

<script>
	location.href="lounge_view.jsp?code=<%=code %>&post=<%=uid %>";
</script>