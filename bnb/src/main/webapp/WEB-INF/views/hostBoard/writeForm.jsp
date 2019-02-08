<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/resources/common/includeHead.jsp"%>
<%@ include file="/resources/common/Navbar.jsp"%>
<html>
<head>
<!-- include summernote css/js-->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.11/summernote-lite.css" rel="stylesheet">
    
<!-- <script>
$(document).ready(function() {
	$('#submitBtn').click(function() {
		$('#content').val($('#content').val().replace(/\n/g, '<br>'));
		$('#target').submit();
	});
});
</script> -->
</head>
<body>

<script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.11/summernote-lite.js"></script>
<div class="container">
<h2>글쓰기</h2>
<hr>
<div class="card">
 <form method="post" id="writeForm">
<div class="card card-header"><input type="text" id="writeTitle" name="title" placeholder="제목" />

<input type="hidden" name="userId" value="${loginUser.userId }" readonly />
<input type="hidden" name="nickName" value="${loginUser.nickName }" readonly/>
</div>

<div>
<textarea id="summernote" name="content"></textarea>
</div>

<div class="card card-footer" style="text-align: center">
	<div role="group">
		<button id="writeBtn" type="button" class="btn btn-primary">입력</button>
		<button id="writeCancel" type="button" class="btn btn-primary" style="margin-left:10px">취소</button>
	</div>
</div>

</form>
</div>
</div>
<script>
// 섬머노트
$('#summernote').summernote({
	  height: 300,                 // set editor height
	  minHeight: null,             // set minimum height of editor
	  maxHeight: null,             // set maximum height of editor
	  focus: true                  // set focus to editable area after initializing summernote
	});
	
	
	// 제목 안쓰면 제목없음으로
$('#writeBtn').click(function(){
	if($('#writeTitle').val() == '' || $('#writeTitle').val() == null){
		$('#writeTitle').val('제목없음');
	}
	$('#writeForm').submit();
	
});

// 취소버튼 누르면 게시판 목록으로 돌아감
$('#writeCancel').click(function(){
	location.href = '${pageContext.request.contextPath}/hostBoard';
	
});

</script>


</body>
</html>