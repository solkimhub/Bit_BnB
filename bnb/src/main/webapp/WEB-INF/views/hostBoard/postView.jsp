<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시물보기</title>
</head>
<body>
<%@ include file="/resources/common/includeHead.jsp"%>
<%@ include file="/resources/common/Navbar.jsp"%>

<div class="container" style="margin-bottom:100px;">
	<h1>VIEW PAGE</h1>
	<hr>
	<div class="table-responsive">
		<div style="height:50px; margin:10px; border-bottom:1px solid lightgrey;">
			<div style="float:left; margin-left:10px;"><h3>${post.title }</h3></div>
			<c:if test="${loginUser.userId eq post.userId or loginUser.admin eq 1}">
				<div style="float:right; margin-right:10px;"><a class="btn btn-outline-primary" role="button" onclick="return confirm('정말 삭제하시겠습니까?');" href="${pageContext.request.contextPath}/hostBoard/deletePost?postNo=${post.postNo}">삭제</a></div>
				<div style="float:right; margin-right:10px;"><a class="btn btn-outline-primary" role="button" href="${pageContext.request.contextPath}/hostBoard/modifyPost?postNo=${post.postNo}&page=${page}">수정</a></div>
			</c:if>
		
		</div>
		<div style="height:40px; padding:5px 10px;">  
			<div style="float:left;">작성자 : ${post.nickName}</div>
			<div style="float:right;"><fmt:formatDate value="${post.date}" pattern="yyyy-MM-dd HH:mm" /></div>
		</div>
		

		<div style="padding:10px; margin-top:50px;">${post.content }</div>

		<hr>
		<div style="float:right; height: 50px; margin-right:10px;"><a class="btn btn-outline-primary" role="button" href="${pageContext.request.contextPath}/hostBoard?page=${page}">목록</a></div>
		
		<div class="card card-default" style="margin-top:70px;">
			<div class="form-group">
				<input id="postNo" type="hidden" value="${post.postNo }">
				<input id="userId" type="hidden" value="${loginUser.userId }">
				<input id="nickName" type="text" class="form-control" style="float:left;" value="${loginUser.nickName }" readonly />
				<textarea id="commentContent" class="form-control" style="height:100px;"></textarea>
				<a class="btn btn-outline-primary" role="button" id="commentBtn">댓글달기</a>
				<!-- <input type="submit" value="댓글달기" style="float:right;"> -->
			</div>
		</div>
		
		<div id="commentListDiv" class="card card-default">
			
			<c:if test="${commentList.isEmpty()}">
			<div class="card card-body">
				댓글이 없습니다.				
			</div>
			</c:if>
		
			<c:if test="${commentList ne null }">
			<c:forEach var="comment" items="${commentList}">
			<div class="card card-body" id="commentOne_${comment.commentNo }">
				작성자 : ${comment.nickName } <br>
				작성일 : <fmt:formatDate value="${comment.commentDate }" pattern="yyyy-MM-dd HH:mm" /><hr>
				<div id="commentContentBox_${comment.commentNo}">내용 : ${comment.commentContent } </div>
				<c:if test="${comment.nickName eq loginUser.nickName or loginUser.admin eq 1}">
				<hr>
					<div style="float:right; ">
						<a class="btn btn-outline-primary" role="button" onclick="getModifyCommentForm(${comment.commentNo})">수정</a>
						<a class="btn btn-outline-primary" role="button" onclick="deleteComment(${comment.commentNo})">삭제</a>
					</div>
				</c:if>
			</div>
			</c:forEach>
			</c:if>
			
		</div>
		
	</div>
</div>


</body>

<script>

// 댓글달기 클릭시 댓글 인서트-뷰 ajax 조회수 변동 없어야함
$('#commentBtn').click(function(){
	
	var postNo = $('#postNo').val();
	var userId = $('#userId').val();
	var nickName = $('#nickName').val();
	var commentContent = $('#commentContent').val();
	var commentListStr = '';
	
	console.log('postNo : ' + postNo);
	console.log('userId : ' + userId);
	console.log('nickName : ' + nickName);
	console.log('commentContent : ' + commentContent);
	
	// 댓글박스 textarea 비우기
	$('#commentContent').val('');
	
	$.ajax({
		url : '${pageContext.request.contextPath}/hostBoard/writeComment',
		type : 'post',
		data : {
					'postNo' : postNo,
					'userId' : userId,
					'nickName' : nickName,
					'commentContent' : commentContent
		},
		//dataType : 'json',
		success : function(commentList){
			console.log(commentList);
			$('#commentListDiv').empty();
			
			for(var i = 0; i<commentList.length; i++){
				commentListStr += '<div class="card card-body" id="commentOne_'+commentList[i].commentNo+'">' + 
								  '작성자 : ' + commentList[i].nickName + '<br>' +
								  '작성일 : ' + commentList[i].commentDate + '<br>' + 
								  '<div id="commentContentBox_'+commentList[i].commentNo+'">내용 : ' + commentList[i].commentContent + '</div>' +
								  '<hr>' + 
								  '<div>' +
								  '<a class="btn btn-outline-primary" role="button" onclick="getModifyCommentForm('+commentList[i].commentNo+')">수정</a>' +
								  '<a class="btn btn-outline-primary" role="button" onclick="deleteComment('+commentList[i].commentNo+')">삭제</a>' +
								  '</div>' +
								  '</div>';
			}
			
			$('#commentListDiv').html(commentListStr);
			
		} // success 끝
		
	});/* ajax끝 */
	
});


// 댓글삭제 클릭시 - 댓글 딜리트 처리-댓글뷰로 ajax 처리: 조회수 변동 없어야함
function deleteComment(commentNo){
	
	// 삭제할건지 확인
	if(confirm('정말 삭제하시겠습니까?')){
	
	var postNo = $('#postNo').val();
	var commentListStr = '';
	
	$.ajax({
		url : '${pageContext.request.contextPath}/hostBoard/deleteComment',
		type : 'post',
		data : {
				'commentNo' : commentNo,
				'postNo' : postNo
				},
		success : function(commentList){
			$('#commentListDiv').empty();
			
			for(var i = 0; i<commentList.length; i++){
				commentListStr += '<div class="card card-body" id="commentOne_'+commentList[i].commentNo+'">' + 
								  '작성자 : ' + commentList[i].nickName + '<br>' +
								  '작성일 : ' + commentList[i].commentDate + '<br>' + 
								  '<div id="commentContentBox_'+commentList[i].commentNo+'">내용 : ' + commentList[i].commentContent + '</div>' +
								  '<hr>' + 
								  '<div style="float:right; ">' +
								  '<a class="btn btn-outline-primary" role="button" onclick="getModifyCommentForm('+commentList[i].commentNo+')">수정</a>' +
								  '<a class="btn btn-outline-primary" role="button" onclick="deleteComment('+commentList[i].commentNo+')">삭제</a>' +
								  '</div>' +
								  '</div>';
			}
			
			if(commentList.length == 0){
				commentListStr = '<div class="card card-body">댓글이 없습니다.</div>';
			}
			
			$('#commentListDiv').html(commentListStr);
		}
		
	});
	}
}


// 댓글수정 눌렀을때 임시로 코멘트번호와 html 내용을 넣을 변수
var commentNoTmp;
var tmpHtml;

// 댓글 수정 클릭시 해당 댓글 대신에 수정 폼 띄우기
function getModifyCommentForm(commentNo){
	
	// 만약 이미 수정폼이 띄워져있으면 (아이디값으로 체크) 수정폼을 tmpHtml로 다시 바꾸기
	if($('#modifyForm').length){
		$('#modifyForm').remove();
		$('#commentOne_'+commentNoTmp).html(tmpHtml);	
	}
	
	// 댓글내용 받아두기
	$.ajax({
		url : '${pageContext.request.contextPath}/hostBoard/selectComment',
		type : 'post',
		data : {'commentNo' : commentNo},
		dataType : 'text',
		success : function(data){
			$('#modifyCommentContent').val(data);
			/* $('#modifyCommentContent_'+commentNo).val(data); */
		}
	});
	
	
	
	commentNoTmp = commentNo;
	tmpHtml = $('#commentOne_'+commentNo).html();
	var modifyFormStr = '';
	
	modifyFormStr += '<div id="modifyForm" class="form-group">' +
				  /* '<input type="hidden" id="commentNo_'+commentNo+'" value="'+commentNo+'">' + */
				  '<textarea id="modifyCommentContent" class="form-control" style="height:100px;"></textarea>' +
				  '<div style="float:right; ">' +
				  '<a class="btn btn-outline-primary" role="button" onclick="modifyComment('+commentNo+')">수정</a>' +
				  '<a class="btn btn-outline-primary" role="button" onclick="modifyCancel('+commentNo+')">취소</a>' +
				  '</div>' +
				  '</div>';
	
	
	$('#commentOne_'+commentNo).empty();
	
	$('#commentOne_'+commentNo).html(modifyFormStr);
	
}

// 댓글 수정 취소
function modifyCancel(commentNo){
	
	$('#modifyForm').remove();
	$('#commentOne_'+commentNoTmp).html(tmpHtml);	
	
}


// 댓글 수정
function modifyComment(commentNo){
	var modifyComment = $('#modifyCommentContent').val();
	
	$.ajax({
		url: '${pageContext.request.contextPath}/hostBoard/modifyComment',
		type: 'post',
		data: {'commentNo':commentNo, 'commentContent':modifyComment},
		success: function(mcc){
			
			console.log('mcc'+mcc);
			
			$('#modifyForm').remove();
			$('#commentOne_'+commentNo).html(tmpHtml);
			$('#commentContentBox_'+commentNo).html(mcc);
		}
		
	});
}

</script>

</html>