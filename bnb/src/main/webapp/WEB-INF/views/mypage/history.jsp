<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>History</title>
<%@ include file="/resources/common/includeHead.jsp"%>
<script>
	$(window).on('load', function() {
		$('.post-module').hover(function() {
			$(this).find('.description').stop().animate({
				height : "toggle",
				opacity : "toggle"
			}, 300);
		});
	});
</script>
</head>
<body style="background-color: #EEEEEE;">
	<%@ include file="/resources/common/Navbar.jsp"%>
	<div id="mypage_wrap_cont" class="row">
		<%@ include file="/WEB-INF/views/mypage/leftlist.jsp"%>
		<div id="mypage_cont" class="col-9">
			<h1 style="text-align: center; padding: 10px; font-weight: 800;">
				<i class="fas fa-home"></i> MY TRIP
			</h1>
			<div class="container">
				<!-- Nav pills -->
				<ul class="nav nav-tabs">
					<li class="nav-item"><a class="nav-link active"
						data-toggle="pill" href="#trip">이전 예약</a></li>
					<li class="nav-item"><a class="nav-link" data-toggle="pill"
						href="#history">현재 예약</a></li>
				</ul>

				<!-- Tab panes -->
				<br>
				<div class="tab-content">
					<div class="tab-pane container active" id="trip">
						<c:if test="${empty historys}">
							<h1 style="text-align: center;">다녀온 여행이 없습니다.</h1>
						</c:if>
						<div class="container_sol row">
							<c:forEach var="his" items="${historys}">
								<!-- Normal Demo-->
								<div class="column col-4">
									<!-- Post-->
									<div class="post-module">
										<!-- Thumbnail-->
										<div class="thumbnail">
											<c:forEach var="hisImg" items="${historyImg}">
												<c:if test="${his.roomsId == hisImg.roomsId}">
													<img
														src="http://13.209.99.134:8080/imgserver/resources/upload/${hisImg.filename }" style="height:100%;">
												</c:if>
											</c:forEach>
										</div>
										<!-- Post Content-->
										<div class="post-content">
											<div class="category">
												<fmt:formatNumber type="int" var="price"
													value="${his.price}" pattern="#,###" />
												￦ ${price}
											</div>
											<h1 class="title">${his.address}</h1>
											<!-- <h2 class="sub_title">The city that never sleeps.</h2> -->
											<p class="description">
												<a
													href="${pageContext.request.contextPath}/rooms/viewRooms?roomsId=${his.roomsId}">
													${his.details}...</a>
											</p>
											<div class="post-meta">
												<span class="timestamp"><i class="fa fa-clock-">O</i>
													<fmt:formatDate pattern="YY년MM월dd일" value="${his.checkIn}" />~<fmt:formatDate pattern="YY년MM월dd일"
														value="${his.checkOut}" /></span><span class="comments"><br>
												<i class="fas fa-user"></i>&ensp;게스트 ${his.people}명</span>
											</div>
										</div>
									</div>
								</div>
							</c:forEach>
						</div>
					</div>
					<div class="tab-pane container" id="history">
						<c:if test="${empty trip}">
							<h1 style="text-align: center;">예정된 여행이 없습니다.</h1>
						</c:if>
						<div class="container_sol row">
							<c:forEach var="trip" items="${trip}">
								<!-- Normal Demo-->
								<div class="column col-4">
									<!-- Post-->
									<div class="post-module">
										<!-- Thumbnail-->
										<div class="thumbnail">
											<!-- <div class="date">
												<div class="day">27</div>
												<div class="month">Mar</div>
											</div> -->
											<c:forEach var="tripImg" items="${tripImg}">
												<c:if test="${trip.roomsId == tripImg.roomsId}">
													<img
														src="http://13.209.99.134:8080/imgserver/resources/upload/${tripImg.filename }" style="height::100%;">
												</c:if>
											</c:forEach>
										</div>
										<!-- Post Content-->
										<div class="post-content">
											<div class="category">
												<fmt:formatNumber type="int" var="price"
													value="${trip.price}" pattern="#,###" />
												￦ ${price}
											</div>
											<h1 class="title">${trip.address}</h1>
											<!-- <h2 class="sub_title">The city that never sleeps.</h2> -->
											<p class="description">
												<a
													href="${pageContext.request.contextPath}/rooms/viewRooms?roomsId=${trip.roomsId}">
													${trip.details}...</a>
											</p>
											<div class="post-meta">
												<span class="timestamp"><i class="fa fa-clock-">O</i>
													<fmt:formatDate pattern="YY년MM월dd일" value="${trip.checkIn}" />~<fmt:formatDate pattern="YY년MM월dd일"
														value="${trip.checkOut}" /></span><span class="comments"><br>
												<i class="fas fa-user"></i>&ensp;게스트 ${trip.people}명</span>
											</div>
										</div>
									</div>
								</div>
							</c:forEach>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>