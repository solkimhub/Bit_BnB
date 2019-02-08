<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>left_list</title>
<%@ include file="/resources/common/includeHead.jsp"%>
</head>
<body>

<div id="gggg" class="col-2" style="position: absolute; top:0px; left: 40px;">
	<div>
		<div class="list-group">
			<a class="list-group-item list-group-item-action"
				href="${pageContext.request.contextPath}/mypage"> <i class="fas fa-user-circle"></i>&ensp;프로필</a> 
			<a class="list-group-item list-group-item-action"
				href="${pageContext.request.contextPath}/mypage/wish"><i class="fas fa-heart" style="color: #EB0000"></i>&ensp;즐겨찾기</a> 
			<a class="list-group-item list-group-item-action"
				href="${pageContext.request.contextPath}/mypage/history"><i class="fas fa-home"></i>&ensp;나의 여행</a> 
			<a class="list-group-item list-group-item-action"
				href="${pageContext.request.contextPath}/mypage/review"><i class="fas fa-star" style="color: #FFB400"></i>&ensp;후기</a>
		</div>
	</div>
	</div>
	<%-- <div id="left_list" class="col-2">
		<div id="list">
			<ul>
				<li class="mypage_list"><i class="fas fa-user-circle"></i>&ensp;<a
					href="${pageContext.request.contextPath}/mypage">프로필</a></li>
				<li class="mypage_list"><i class="fas fa-heart"
					style="color: #EB0000"></i>&ensp;<a href="${pageContext.request.contextPath}/wish">즐겨찾기</a></li>
				<li class="mypage_list"><i class="fas fa-home"></i>
				<a href="${pageContext.request.contextPath}/history">나의여행</a></li>
				<li class="mypage_list"><i class="fas fa-star"
					style="color: #FFB400"></i>&ensp;<a
					href="${pageContext.request.contextPath}/review">후기</a></li>
			</ul>
		</div>
	</div> --%>
<script>
    /* 스크롤따라 움직이는 Div */
    var currentPositio = parseInt($('#gggg').css('top'));

    $(window).scroll(function() {
        var position = $(window).scrollTop();
        $('#gggg').stop().animate({
            'top' : position + currentPositio + 'px'
        }, 500);
    });
</script>
</body>
</html>