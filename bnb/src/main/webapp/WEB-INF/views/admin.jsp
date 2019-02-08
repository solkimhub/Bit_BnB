<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BITBNB ADMIN</title>
</head>
<body>
	<%@ include file="/resources/common/includeHead.jsp"%>
	<%@ include file="/resources/common/Navbar.jsp"%>

	<h1>관리자페이지</h1>
	<a href="${pageContext.request.contextPath}/adminpage/report?page=1"><button>신고 목록보기</button></a>

</body>
</html>