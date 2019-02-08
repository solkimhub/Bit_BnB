<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <%@ include file="/resources/common/includeHead.jsp" %>
    <meta charset="UTF-8">
    <title>BITBNB ADMIN</title>
</head>
<body>
<%@ include file="/resources/common/Navbar.jsp" %>


<div class="container">
<h1>신고 관리하기</h1>
<div class="table-responsive">


<table class="table table-hover text-center">
	<thead>
    <tr class="row" style="margin-right:0px;">
        <th class="col-2">예약번호</th>
        <th class="col-7 text-left">신고내용</th>
        <th class="col-3"> 승인/보류</th>
    </tr>
    </thead>
    <tbody>
    <c:if test="${!empty reportList}">
        <c:forEach var="list" items="${reportList}">
            <tr class="row" style="margin-right:0px;">
                <td class="col-2">
                        ${list.reservationNum}
                </td>
                <td class="col-7 text-left">
                        ${list.reportContent}
                </td>
                <td class="col-3">
                    <c:choose>
                        <c:when test="${list.reportCk eq 'F'}">
                            <a href="${pageContext.request.contextPath}/adminpage/report/comfirm?reservationNum=${list.reservationNum}&reportCk=T">
                                <button class="btn btn-danger">승인</button>
                            </a>
                            <a href="${pageContext.request.contextPath}/adminpage/report/comfirm?reservationNum=${list.reservationNum}&reportCk=B">
                                <button class="btn btn-warning">보류</button>
                            </a>
                        </c:when>
                        <c:when test="${list.reportCk eq 'T'}">
                            승인됨
                        </c:when>
                        <c:otherwise>
                            보류됨
                        </c:otherwise>
                    </c:choose>
                </td>
            </tr>
        </c:forEach>
    </c:if>
    </tbody>
</table>
</div>
</div>

<div class="text-center">
<nav aria-label="Page navigation example">
    <ul class="pagination justify-content-center">
        <c:forEach begin="1" end="${totalPage}" var="i">
            <li class="page-item"><a class="page-link" href="${pageContext.request.contextPath}/adminpage/report?page=${i}">${i}</a></li>
        </c:forEach>

    </ul>
</nav>
</div>
</body>
</html>