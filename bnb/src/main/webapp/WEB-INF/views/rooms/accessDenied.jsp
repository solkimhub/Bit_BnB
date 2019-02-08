<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<%@ include file="/resources/common/includeHead.jsp"%>
</head>
<body>

	<%@ include file="/resources/common/Navbar.jsp"%>
	<!-- Begin page content -->
	<main role="main" class="container"> <c:choose>
		<c:when test="${0 eq loginUser.host}">
			<h3>
				<b>숙소 등록을 할 수 없는 상태입니다 !<br>호스트 신청을 먼저 해주세요.
				</b>
			</h3>

		</c:when>
		<c:when test="${1 eq loginUser.host}">
			<h3>
				<b>이 숙소의 호스트가 아니시네요 !</b>
			</h3>
		</c:when>
	</c:choose> </main>
</body>
</html>