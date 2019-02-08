<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Review</title>
<%@ include file="/resources/common/includeHead.jsp"%>
</head>
<body style="background-color: #EEEEEE;">
	<%@ include file="/resources/common/Navbar.jsp"%>

	<div id="mypage_wrap_cont" class="row">
		<%@ include file="/WEB-INF/views/mypage/leftlist.jsp"%>
		<div id="mypage_cont" class="col-9">
			<h1 style="text-align: center; padding: 10px; font-weight: 800;">
				<i class="fas fa-star"></i> REVIEW
			</h1>
			<div class="container">
				<br>
				<!-- Nav tabs -->
				<ul class="nav nav-tabs" role="tablist">
					<li class="nav-item"><a class="nav-link active"
						data-toggle="tab" href="#myReview">내가 쓴 후기</a></li>
					<li class="nav-item"><a class="nav-link" data-toggle="tab"
						href="#hostReview">내게 쓴 후기</a></li>
					<li style="margin-left: 478px;"><form
							class="form-inline my-2 my-lg-0" method="get" id="searchForm"
							action="${pageContext.request.contextPath }/reviewSearchList">
							<select class="custom-select" id="inputGroupSelect01"
								name="searchType">
								<option value="all"
									<c:out value="${rvs.searchType == all?'selected':''}" />>전체검색</option>
								<option value="reviewContent"
									<c:out value="${rvs.searchType eq 'reviewContent'?'selected':''}" />>내용</option>
								<option value="hostId"
									<c:out value="${rvs.searchType eq 'hostId'?'selected':''}" />>호스트명</option>
								<%-- <option value="scope"
									<c:out value="${rvs.searchType eq 'scope'?'selected':''}" />>별점</option> --%>
							</select>&ensp; <input class="form-control mr-sm-2" type="search"
								placeholder="검색하기" aria-label="Search" name="keyword"
								id="keywordInput" value="${rvs.keyword}">
							<button class="btn my-2 my-sm-0" id="searchBtn"
								style="background-color: #FF5675; color: white;">검색</button>
						</form></li>
				</ul>

				<div class="tab-content">
					<div id="myReview" class="container tab-pane active">
						<br>
						<c:if test="${empty reviewSearch}">
							<h1 style="text-align: center; padding: 20px; font-weight: 800;">검색
								결과가 없습니다.</h1>
						</c:if>
						<!-- 내가 쓴 것만 나타내줌! 리뷰쓴내역 -->
						<c:forEach var="res" items="${reviewSearch}">
							<c:if test="${res ne null}">
								<div class="media"
									style="background-color: #FFEAEA; border-radius: 10px; margin-bottom: 15px;">
									<div id="review_photo" class="align-self-center">
										<img class="align-self-center mr-3 rounded"
											src="http://13.209.99.134:8080/imgserver/resources/img/userphoto/${res.userPhoto}"
											style="width: 100%; object-fit: contain;">
									</div>
									<div class="media-body" style="padding: 0 10px;">
										<div class="row">
											<h6 class="mt-3 col-6">
												<b>${res.hostId}</b>님의 대한 후기
											</h6>
											<h6 class="mt-3 col-3">
												<c:forEach var="scope" begin="1" end="${res.scope}">
													<i class="fas fa-star" style="color: #FF5675"></i>
												</c:forEach>
											</h6>
											<div class="mt-3 col-3" style="left: 65px;">
												<button type="button" class="btn btn-secondary btn-sm"
													onclick="javascript:location.href='${pageContext.request.contextPath}/reviewEdit?reservationNum=${reTo.reservationNum}'">수정</button>
												<!-- Button trigger modal -->
												<button type="button" class="btn btn-secondary btn-sm"
													data-toggle="modal" data-target="#deleteModal">삭제</button>
												<!-- Modal -->
												<div class="modal fade" id="deleteModal" tabindex="-1"
													role="dialog" aria-labelledby="deleteModal"
													aria-hidden="true">
													<div class="modal-dialog modal-dialog-centered"
														role="document">
														<div class="modal-content">
															<div class="modal-header">
																<h5 class="modal-title" id="exampleModalCenterTitle">후기삭제</h5>
																<button type="button" class="close" data-dismiss="modal"
																	aria-label="Close">
																	<span aria-hidden="true">&times;</span>
																</button>
															</div>
															<div class="modal-body" style="text-align: center;">
																<b>${res.hostId}</b>님의 대한 후기를 삭제하시겠습니까?
															</div>
															<div class="modal-footer">
																<button type="button" class="btn btn-danger"
																	onclick="javascript:location.href='review_delete?reservationNum=${res.reservationNum}'">삭제하기</button>
																<button type="button" class="btn btn-secondary"
																	data-dismiss="modal">취소</button>
															</div>
														</div>
													</div>
												</div>
											</div>
										</div>
										<p class="mb-0" style="margin-top: 10px;">${res.reviewContent}<br>
											<br>
											<fmt:formatDate pattern="yyyy년 MM월 dd일"
												value="${res.reviewDate}" />
											<br> <br>
										</p>
									</div>
								</div>
							</c:if>
						</c:forEach>
						<a href="javascript:history.back(-1)"><img
							src="${pageContext.request.contextPath}/resources/images/back.png"
							style="width: 35px;">뒤로가기</a>
					</div>
					<div id="hostReview" class="container tab-pane fade">
						<br>
						<c:if test="${empty hostReviewSearch}">
							<h1 style="text-align: center; padding: 20px; font-weight: 800;">검색
								결과가 없습니다.</h1>
						</c:if>
						<!-- 내가 쓴 것만 나타내줌! 리뷰쓴내역 -->
						<c:forEach var="hrs" items="${hostReviewSearch}">
							<c:if test="${hrs ne null}">
								<div class="media"
									style="background-color: #FFEAEA; border-radius: 10px; margin-bottom: 15px;">
									<div id="review_photo" class="align-self-center">
										<img class="align-self-center mr-3 rounded"
											src="http://13.209.99.134:8080/imgserver/resources/img/userphoto/${hrs.userPhoto }"
											style="height: 100px; object-fit: contain;">
									</div>
									<div class="media-body" style="padding: 0 10px;">

										<h6 class="mt-3">
											나에 대한 <b>${hrs.userName}</b>님의 후기
										</h6>
										<br>
										<p>${hrs.evaluationContent}<br> <br>
										<fmt:formatDate pattern="yyyy년 MM월 dd일" value="${hrs.reviewDate}" /><br>
										</p>
									</div>
								</div>
							</c:if>
						</c:forEach>
						<a href="javascript:history.back(-1)"><img
							src="${pageContext.request.contextPath}/resources/images/back.png"
							style="width: 35px;">뒤로가기</a>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>