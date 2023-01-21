<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
String preURL = request.getParameter("preURL");

session.invalidate(); //세션 전체 삭제
%>

<script>
	location.href="<%=preURL %>";
</script>