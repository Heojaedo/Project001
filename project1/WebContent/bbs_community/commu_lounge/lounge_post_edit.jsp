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
String uid_edit = request.getParameter("post"); //lounge_view에서 받은 값(uid)
String code_edit = request.getParameter("code"); //lounge_view에서 받은 값(poppy_lounge);

String sql_edit = "select * from "+code_edit+" where uid='"+uid_edit+"'";

Connection conn_edit = DriverManager.getConnection(url, user, password);
Statement stmt_edit = conn_edit.createStatement();
ResultSet rs_edit = stmt_edit.executeQuery(sql_edit);

if(rs_edit.next()) {
	
}

//엔터키 치환
String contents = rs_edit.getString("contents");
contents = contents.replace("<br>","\r\n");
%>

<script>
	//이미지 미리보기
	
	//input 태그(name이 insert_img인) 가져옴
	let fileTag = document.querySelector("input[name=f]");
	
	//fileTag에 변화가 있을 때 실행될 함수 작성
	fileTag.onchange = function() {
		let imgTag = document.querySelector("#profileImg");
		
		//파일이 있는지 확인
		if(fileTag.files.length > 0) {
			//파일을 선택한 경우
			//미리보기 생성 = 이미지 태그 src에 데이터(fileTag에서 선택한 파일)를 넣어주면 됨
			let reader = new FileReader();
			
			//reader 읽어들이는 작업(onload)를 끝냈을 때 함수 실행, 읽어온 데이터를 함수의 매개변수 파라미터로 줄 수 있음
			reader.onload = function(data) {
				console.log(data);
				imgTag.src = data.target.result;
				imgTag.width = 250;
				imgTag.height = 150;
			}
			reader.readAsdataURL(fileTag.files[0]);
		} else {
			//취소 버튼을 누른 경우
			imgTag.src = "";
		}
	}
</script>

<form action="post_edit_insert.jsp" method="post" enctype="multipart/form-data" onsubmit="return lounge_write()">
<input type="hidden" name="code" value="<%=code_edit %>">
<input type="hidden" name="post" value="<%=rs_edit.getString("uid") %>">
<table class="write_table" width=1100px border=1 align=center>
	<tr>
		<td class="td_cate">카테고리</td>
	</tr>
	<tr>
		<td class="td_cate_radio">
			<input type="radio" id="category" name="category" value="1" <%if(rs_edit.getString("category").equals("1")) {%>checked<%}%>> 강아지
			<input type="radio" id="category" name="category" value="2" <%if(rs_edit.getString("category").equals("2")) {%>checked<%}%>> 고양이
			<input type="radio" id="category" name="category" value="3" <%if(rs_edit.getString("category").equals("3")) {%>checked<%}%>> 소동물
			<input type="radio" id="category" name="category" value="4" <%if(rs_edit.getString("category").equals("4")) {%>checked<%}%>> 기타
		</td>
	</tr>
	<tr>
		<td align=center>
			<input class="input_title" type="text" id="title" name="title" value="<%=rs_edit.getString("title") %>" placeholder="제목을 입력해주세요." maxlength="30">
		</td>
	</tr>
	<tr>
		<td align=center>
			<textarea class="text_contents" type="textarea" id="contents" name="contents" placeholder="본문을 입력해주세요."><%=contents %></textarea>
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
			<img class="preview_img" src="/../upload/<%=rs_edit.getString("loungefile") %>" id="preview_img" style="width: 200px;height: 200px; object-fit: cover;">
			&nbsp;&nbsp;
    		<%=rs_edit.getString("loungefile") %>
		</td>
	</tr>
</table>
<div style="height: 20px;"></div>
<table width=1100px border=0 align=center>
	<tr>
		<td align=left>
			<input type="button" value="취소" class="btn_write" onclick="history.back()">
		</td>
		<td align=right>
			<button class="btn_write">수정하기</button>
		</td>
	</tr>
</table>
</form>

<%@ include file="/include/pro_footer.jsp" %>