<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
</head>
<body>
<%@ include file="/resources/common/includeHead.jsp"%>
<%@ include file="/resources/common/Navbar.jsp"%>


<div class="container">
<h2>HOST BOARD</h2>
<div class="table-responsive">
<table class="table table-hover text-center"> 
	<thead>
	<tr class="row" style="margin-right:0px;">
		<th class="col-2" >번호</th>
		<th class="col-5 text-left">제목</th>
		<th class="col-2">작성자</th>
		<th class="col-2">작성일</th>
		<th class="col-1">조회수</th>
	</tr>
	</thead>
	<tbody>
	<c:forEach var="post" items="${postListData.postList}">
		<tr class="row" style="margin-right:0px;">
			<td class="col-2">${post.postNo}</td>
			<td class="col-5 text-left"><a href="${pageContext.request.contextPath}/hostBoard/postView?postNo=${post.postNo }&page=${page}">${post.title}</a>
				<!-- 댓글갯수가 1개 이상일때만 댓글개수 보여주기 -->
				<c:if test="${post.commentCnt > 0 }">
					&nbsp;&nbsp;[${post.commentCnt}]
				</c:if>
			</td>
			<td class="col-2">${post.nickName}</td>
			<td class="col-2"><fmt:formatDate value="${post.date}" pattern="yyyy-MM-dd" /></td>
			<td class="col-1">${post.viewCnt}</td>
		</tr>  
	</c:forEach>
	</tbody>
</table>
<hr/>

<a class="btn btn-secondary" href="${pageContext.request.contextPath}/hostBoard/write" role="button">글쓰기</a>
<br>
<div class="text-center">
	<ul class="pagination justify-content-center">
		<li class="page-item"><a class="page-link" href="${pageContext.request.contextPath}/hostBoard?page=1">&lt;&lt;</a></li>
			
			<c:if test="${postListData.currentPageNumber eq 1 }">
				<li class="page-item disabled"><a class="page-link" href="${pageContext.request.contextPath}/hostBoard?page=${postListData.currentPageNumber-1}" tabindex="-1">이전페이지</a></li>
			</c:if>
			<c:if test="${postListData.currentPageNumber > 1 }">
				<li class="page-item"><a class="page-link" href="${pageContext.request.contextPath}/hostBoard?page=${postListData.currentPageNumber-1}">이전페이지</a></li>
			</c:if>
			
			<c:forEach var="num" begin="${postListData.startPage }" end="${postListData.endPage}">
				<c:if test="${num eq postListData.currentPageNumber}">
					<li class="page-item active"><a class="page-link" href="${pageContext.request.contextPath}/hostBoard?page=${num}">${num}</a></li>
				</c:if>
				<c:if test="${num ne postListData.currentPageNumber}">
					<li class="page-item"><a class="page-link" href="${pageContext.request.contextPath}/hostBoard?page=${num}">${num}</a></li>
				</c:if>
			</c:forEach>
			
			<c:if test="${postListData.currentPageNumber eq postListData.pageTotalCount}">
				<li class="page-item disabled"><a class="page-link" href="${pageContext.request.contextPath}/hostBoard?page=${postListData.currentPageNumber+1}" tabindex="-1">다음페이지</a></li>
			</c:if>
			<c:if test="${postListData.currentPageNumber < postListData.pageTotalCount }">
				<li class="page-item"><a class="page-link" href="${pageContext.request.contextPath}/hostBoard?page=${postListData.currentPageNumber+1}">다음페이지</a></li>
			</c:if>
	    
	    <li class="page-item"><a class="page-link" href="${pageContext.request.contextPath}/hostBoard?page=${postListData.pageTotalCount}">&gt;&gt;</a></li>
	</ul>
</div>
</div>
</div>
</body>

<script>
$('document').ready(function(){
	var page = ${page};
	console.log(page);
});
</script>


</html>