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
<h2>포스팅하기</h2>
<hr>
<div class="card">
 <form method="post" id="modifyForm">
<div class="card card-header"><input type="text" id="modifyTitle" name="title" value="${post.title }" placeholder="제목" />
<input type="hidden" name="postNo" value="${post.postNo }" readonly/>
<input type="hidden" name="page" value="${page}" readonly/>
</div>

<div>
<textarea id="summernote" name="content">${post.content }</textarea>
</div>

<div class="card card-footer" style="text-align: center">
<div style="float:left"><button id="modifyBtn" type="button" class="btn btn-primary">수정</button></div>
<div style="float:right"><button id="modifyCancel" type="button" class="btn btn-primary">취소</button></div>
</div>

</form>
</div>
</div>
<script>
$('#summernote').summernote({
	  height: 300,                 // set editor height
	  minHeight: null,             // set minimum height of editor
	  maxHeight: null,             // set maximum height of editor
	  focus: true                  // set focus to editable area after initializing summernote
	});
	
	
$('#modifyBtn').click(function(){
	if($('#modifyTitle').val() == '' || $('#modifyTitle').val() == null){
		$('#modifyTitle').val('제목없음');
	}
	$('#modifyForm').submit();
	
});

// 수정 취소시 전 페이지로 되돌아간다
$('#modifyCancel').click(function(){
	window.history.go(-1);
	
});
</script>


</body>
</html>