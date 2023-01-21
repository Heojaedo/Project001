<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="/include/pro_header.jsp" %>

<style>
	.td_cate { /* 카테고리 글씨 */
		font-size: 20px;
		text-indent: 10px;
	}
	
	.td_cate_radio {
		text-indent: 10px;
	}
	
	.input_title { /* 제목 입력란 */
		width: 1000px;
		height: 30px;
		font-family: "Spoqa Han Sans Neo";
		font-size: 16px;
		padding: 10px;
	}
	
	.input_date {
		width: 200px;
		height: 30px;
		font-family: "Spoqa Han Sans Neo";
		font-size: 14px;
		padding: 10px;
	}
	
	.text_contents { /* 내용 입력란 */
		width: 1000px;
		height: 400px;
		resize: none;
		word-wrap: break-word;
		font-family: "Spoqa Han Sans Neo";
		font-size: 16px;
		padding: 10px;
	}
	
	.preview_img {
		witdh: 150px;
		height: 150px;
		object-fit: cover;
		border-radius: 10px;
	}
	
	.td_preview_img {
		padding: 10px;
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
	
	.td_upload { /* 첨부파일 td */
		text-indent: 10px;
	}
	
	.input_file { /* 첨부파일 버튼 */
		
	}
	
	.write_table {
		border : 1px solid #767676;
  		border-collapse : collapse;
	}
</style>

<%
String id = request.getParameter("id"); //commu_main에서 넘어온 session_id값
String code = request.getParameter("code"); //commu_main에서 넘어온 code값 (lounge)

if(session_id == null){
%>
	<script>
		alert("로그인이 필요한 서비스입니다.");
		history.back();
	</script>
<%	
}
%>

<script>
	function lounge_write() {
		if(title.value == "") {
			alert("제목을 입력하세요.");
			title.focus();
			return false;
		}
		if(contents.value == ""){
			alert("내용을 입력하세요.");
			contents.focus();
			return false;
		}
		document.submit();
	}
</script>

<script>
function uploadImgPreview() {
	// @breif 업로드 파일 읽기
	let fileInfo = document.getElementById("upImgFile").files[0];
	let reader = new FileReader();

    // @details readAsDataURL( )을 통해 파일을 읽어 들일때 onload가 실행
    reader.onload = function() {
        // @details 파일의 URL을 Base64 형태로 가져온다.
        document.getElementById("thumbnailImg").src = reader.result;
        document.getElementById("thumbnailUrl").innerText = reader.result;
    };
    // @details onload 대신 addEventListener( ) 사용가능
	// reader.addEventListener("load", function() {
    //    document.getElementById("thumbnailImg").src = reader.result;
    //    document.getElementById("thumbnailUrl").innerText = reader.result;
	// }, false);
	if( fileInfo ) {
        // @details readAsDataURL( )을 통해 파일의 URL을 읽어온다.
        reader.readAsDataURL( fileInfo );
    }
}
</script>

<form action="lounge_write_ins.jsp?id=<%=id %>&code=<%=code %>" method="post" enctype="multipart/form-data" onsubmit="return lounge_write()">
<input type="hidden" value="<%=id %>">
<input type="hidden" value="<%=code %>">
<table class="write_table" width=1100px border=1 align=center>
	<tr>
		<td class="td_cate">카테고리</td>
	</tr>
	<tr>
		<td class="td_cate_radio">
			<input type="radio" id="category" name="category" value="1" checked> 진행 중인 이벤트
			<input type="radio" id="category" name="category" value="2"> 종료된 이벤트
		</td>
	</tr>
	<tr>
		<td align=center>
			<input class="input_title" type="text" id="title" name="title" value="" maxlength="50" placeholder="제목">
		</td>
	</tr>
	<tr>
		<td style="text-indent: 48px;">
			<input class="input_date" type="date" id="startdate" name="startdate">
			<input class="input_date" type="date" id="enddate" name="enddate">
		</td>
	</tr>
	<tr>
		<td align=center>
			<textarea class="text_contents" type="textarea" id="contents" name="contents" value="" placeholder="내용"></textarea>
		</td>
	</tr>
	<tr>
		<td class="td_upload">
			첨부파일
			&nbsp;&nbsp;
    		<input type="file" id="upload_img" name="upload_img">
			<script>
				//이미지 미리보기
				const reader = new FileReader();
				
				reader.onload = (readerEvent) => {
					//파일을 읽는 이벤트가 발생하면 preview_img의 src 속성을 readerEvent의 결과물로 대체함
					document.querySelector("#preview_img").setAttribute("src",readerEvent.target.result);
				};
				
				document.querySelector("#upload_img").addEventListener("change",(changeEvent) => {
					//upload_file에 이벤트리스너를 장착
					
					const imgFile = changeEvent.target.files[0];
					reader.readAsDataURL(imgFile);
					//업로드한 이미지의 URL을 reader에 등록
				})
			</script>
		</td>
	</tr>
	<tr>
		<td class="td_preview_img">
			<img class="preview_img" id="preview_img" alt="이미지 미리보기" style="width: 200px;height: 200px; object-fit: cover;">
		</td>
	</tr>
</table>
<div style="height: 20px;"></div>
<table width=1100px border=0 align=center>
	<tr>
		<td align=left>
			<input type="button" value="목록" class="btn_write" onclick="history.back()">
		</td>
		<td align=right>
			<button class="btn_write">글쓰기</button>
		</td>
	</tr>
</table>
</form>

<%@ include file="/include/pro_footer.jsp" %>