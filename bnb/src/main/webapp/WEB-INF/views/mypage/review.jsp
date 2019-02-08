<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Review</title>
<%@ include file="/resources/common/includeHead.jsp"%>
<style>
.more, .more1 {
	display: none;
}
</style>
</head>
<body style="background-color: #EEEEEE;">
	<%@ include file="/resources/common/Navbar.jsp"%>

	<div id="mypage_wrap_cont" class="row justify-content-end">
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

				<!-- Tab panes -->
				<div class="tab-content">
					<div id="myReview" class="container tab-pane active">
						<br>
						<table id="review_write_table" rules="none"
							style="border-radius: 10px;">
							<tr style="height: 30px;">
								<th colspan="2" style="text-align: center; height: 50px;"><i
									class="fas fa-edit"></i>&ensp;작성해야할 후기</th>
							</tr>
							<c:if test="${empty reviewWrite}">
								<tr>
									<td style="text-align: center;">작성해야할 후기가 없습니다.</td>
								</tr>
							</c:if>
							<c:set var="now" value="<%=new java.util.Date()%>" />
							<c:forEach var="reWrite" items="${reviewWrite}">
								<c:if
									test="${reWrite.reviewContent eq null && reWrite.checkOut <= now && loginUser.userId eq reWrite.userId}">
									<tr>
										<td style="height: 50px; text-align: center;"><b><fmt:formatDate
													pattern="MM월 dd일" value="${reWrite.checkIn}" /> - <fmt:formatDate
													pattern="MM월 dd일" value="${reWrite.checkOut}" /></b>에 숙박한 숙소에
											대한 후기를 써주세요.</td>
										<td><a
											href="${pageContext.request.contextPath}/reviewWrite?reservationNum=${reWrite.reservationNum}">후기쓰기</a>
											<a
											href="${pageContext.request.contextPath}/reportWrite?reservationNum=${reWrite.reservationNum}">신고</a>
										</td>
									</tr>
								</c:if>
							</c:forEach>
						</table>
						<c:if test="${empty reviewTo}">
							<h1 style="text-align: center; padding: 20px; font-weight: 800;">작성한
								리뷰가 없습니다.</h1>
						</c:if>
						<!-- 내가 쓴 것만 나타내줌! 리뷰쓴내역 -->
						<c:forEach var="reTo" items="${reviewTo}">
							<c:if test="${reTo ne null}">
								<div class="more">
									<div class="media"
										style="background-color: #FFEAEA; border-radius: 10px; margin-bottom: 15px;">
										<div id="review_photo" class="align-self-center">
											<img class="align-self-center mr-3 rounded"
												src="http://13.209.99.134:8080/imgserver/resources/img/userphoto/${reTo.userPhoto}"
												style="height: 100px; object-fit: contain;">
										</div>
										<div class="media-body" style="padding: 0 10px;">
											<div class="row">
												<h6 class="mt-3 col-6">
													<b>${reTo.hostId}</b>님의 대한 후기
												</h6>
												<h6 class="mt-3 col-3">
													<c:forEach var="scope" begin="1" end="${reTo.scope}">
														<i class="fas fa-star" style="color: #FF5675"></i>
													</c:forEach>
												</h6>
												<div class="mt-3 col-3">
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
																	<button type="button" class="close"
																		data-dismiss="modal" aria-label="Close">
																		<span aria-hidden="true">&times;</span>
																	</button>
																</div>
																<div class="modal-body" style="text-align: center;">
																	<b>${reTo.hostId}</b>님의 대한 후기를 삭제하시겠습니까?
																</div>
																<div class="modal-footer">
																	<button type="button" class="btn btn-danger"
																		onclick="javascript:location.href='review_delete?reservationNum=${reTo.reservationNum}'">삭제하기</button>
																	<button type="button" class="btn btn-secondary"
																		data-dismiss="modal">취소</button>
																</div>
															</div>
														</div>
													</div>
												</div>
											</div>
											<p class="mb-0" style="margin-top: 10px;">${reTo.reviewContent}<br>
												<br>
												<fmt:formatDate pattern="yyyy년 MM월 dd일"
													value="${reTo.reviewDate}" />
												<br> <br>
											</p>
										</div>
									</div>
								</div>
							</c:if>
						</c:forEach>
						<c:if test="${!empty reviewTo && fn:length(reviewTo) > 4}">
							<button type="button" id="load" class="btn btn-sm btn-block"
								style="margin: 20px 0; background-color: #EEEEEE"><b>더보기</b></button>
						</c:if>
						<script type="text/javascript">
							$(function() {
								$(".more").slice(0, 4).show(); // 최초 4개 선택
								$("#load").click(function(e) { // Load More를 위한 클릭 이벤트e
									e.preventDefault();
									$(".more:hidden").slice(0, 4).show(); // 숨김 설정된 다음 4개를 선택하여 표시
									if ($(".more:hidden").length == 0) { // 숨겨진 DIV가 있는지 체크
										$('#load').css('display', 'none');// 더 이상 로드할 항목이 없는 경우
									}
								});
							});
						</script>
					</div>

					<!-- 호스트가 써준 리뷰 -->
					<div id="hostReview" class="container tab-pane fade">
						<br>
						<c:if test="${empty hostReview}">
							<h1 style="text-align: center; padding: 20px; font-weight: 800;">호스트가
								작성해준 후기가 없습니다.</h1>
						</c:if>
						<!-- 내가 쓴 것만 나타내줌! 리뷰쓴내역 -->
						<c:forEach var="hostRe" items="${hostReview}">
							<c:if test="${hostRe ne null}">
								<div class="more1" id="more1">
									<div class="media"
										style="background-color: #FFEAEA; border-radius: 10px; margin-bottom: 15px;">
										<div id="review_photo" class="align-self-center">
											<img class="align-self-center mr-3 rounded"
												src="http://13.209.99.134:8080/imgserver/resources/img/userphoto/${hostRe.userPhoto }"
												style="height: 100px; object-fit: contain;">
										</div>
										<div class="media-body" style="padding: 0 10px;">

											<h6 class="mt-3">
												나에 대한 <b><a href="${pageContext.request.contextPath}/hostview?hostId=${hostRe.hostId}">${hostRe.userName}</a></b>님의 후기 / ${hostRe.roomsId}번 방
											</h6>
											<br>
											<p>${hostRe.evaluationContent}<br> <br>
												<fmt:formatDate pattern="yyyy년 MM월 dd일"
													value="${hostRe.reviewDate}" />
												<br>
											</p>
										</div>
									</div>
								</div>
							</c:if>
						</c:forEach>
						<c:if test="${!empty hostReview && fn:length(hostReview) > 4}">
							<button type="button" id="load1" class="btn btn-sm btn-block"
								style="margin: 20px 0; background-color: #EEEEEE"><b>더보기</b></button>
						</c:if>
						<script type="text/javascript">
							$(function() {
								$(".more1").slice(0, 4).show(); // 최초 4개 선택
								$("#load1").click(function(e) { // Load More를 위한 클릭 이벤트e
									e.preventDefault();
									$(".more1:hidden").slice(0, 4).show(); // 숨김 설정된 다음 4개를 선택하여 표시
									if ($(".more1:hidden").length == 0) { // 숨겨진 DIV가 있는지 체크
										$('#load1').css('display', 'none');// 더 이상 로드할 항목이 없는 경우
									}
								});
							});
						</script>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>