<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<hr class="my-4">
<h1 class="page_title color5">공지사항</h1>
<hr class="my-4">
<table class="jc_table" width="100%"
	style="border-top: 2px solid #547980; border-bottom: 2px solid #547980;">
	<tr>
		<th width="80">번호</th>
		<td>${viewLink.bId}</td>
	</tr>
	<tr>
		<th>이름</th>
		<td>${viewLink.bName}</td>
	</tr>
	<tr>
		<th>제목</th>
		<td>${viewLink.bTitle}</td>
	</tr>
	<tr>
		<th>내용</th>
		<td>${viewLink.bContent}</td>
	</tr>
</table>
<br>
<a href="${pageContext.request.contextPath}/member/notice"><button
		type="button" class="btn btn-dark">목록보기</button></a>
&nbsp;&nbsp;
<!-- 현 푸시테스트~~ -->
