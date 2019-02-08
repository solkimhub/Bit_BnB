<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<%@ include file="/resources/common/includeHead.jsp"%>
</head>
<body>
	<%@ include file="/resources/common/Navbar.jsp"%>
	<script type="text/javascript">
		$(document).ready(function() {
			$('input:checkbox').change(function() {
				var check = '';
				$('input:checkbox').each(function() {
					if ($(this).is(':checked')) {
						check = check + 'T';
					} else {
						check = check + 'F';
					}
				});
				$('#amenities').val(check);
			});

		});
	</script>
	<script>
		$(document)
				.ready(
						function() {
							$('#wishBtn')
									.click(
											function() {
												var roomsId = $('#roomsId')
														.val();
												var url = '${pageContext.request.contextPath}/wishIn?roomsId='
														+ roomsId;
												$
														.ajax({
															url : url,
															success : function(
																	response) {
																if (response == 1) {
																	$(
																			'#wishIcon')
																			.attr(
																					"src",
																					"${pageContext.request.contextPath}/resources/images/full.png");
																} else {
																	$(
																			'#wishIcon')
																			.attr(
																					"src",
																					"${pageContext.request.contextPath}/resources/images/empty.png");
																}
															}
														});
											});
						});
	</script>
	<!-- Begin page content -->
	<!-- https://shaack.com/projekte/bootstrap-input-spinner/ -->
	<main role="main" class="container">
	<div class="row justify-content-md-center">
		<div class="col-lg-7">
			<h1>
				<b>숙소 보기</b>
				<button
					style="border: none; background-color: white; float: right; outline: 0;"
					id="wishBtn">
					<c:choose>
						<c:when test="${0 eq wish}">
							<img id="wishIcon"
								src="${pageContext.request.contextPath}/resources/images/empty.png"
								style="width: 45px; padding-bottom: 5px;">
						</c:when>
						<c:when test="${2 eq wish}"></c:when>
						<c:otherwise>
							<img id="wishIcon"
								src="${pageContext.request.contextPath}/resources/images/full.png"
								style="width: 45px; padding-bottom: 5px;">
						</c:otherwise>
					</c:choose>
				</button>
			</h1>
			<form method="post">
				<table class="table">
					<tr>
						<%-- <td class="w-25">호스트 아이디</td>
						<td class="w-75">${selectedRoom.hostId}</td> --%>
						<td colspan="2"><c:if test="${!empty roomImages}">
								<div id="carousel_thumbnail" class="carousel slide"
									data-ride="carousel">
									<ol class="carousel-indicators">
										<c:set var="count" value="0"></c:set>
										<c:forEach var="item" items="${roomImages}">
											<li data-target="#carousel_thumbnail"
												data-slide-to="${count}"
												<c:if test="${count eq 0}">class="active"</c:if>></li>
											<c:set var="count" value="${count+1}"></c:set>
										</c:forEach>
									</ol>
									<div class="carousel-inner">
										<c:set var="count" value="0"></c:set>
										<c:forEach var="item" items="${roomImages}">
											<div
												class="carousel-item<c:if test="${count eq 0}"> active</c:if>">
												<img class="d-block w-100"
													src="http://13.209.99.134:8080/imgserver/resources/upload/${item.filename}"
													height="400px" style="object-fit: cover;">
											</div>
											<c:set var="count" value="${count+1}"></c:set>
										</c:forEach>
									</div>
									<a class="carousel-control-prev" href="#carousel_thumbnail"
										role="button" data-slide="prev"> <span
										class="carousel-control-prev-icon" aria-hidden="true"></span>
										<span class="sr-only">Previous</span>
									</a> <a class="carousel-control-next" href="#carousel_thumbnail"
										role="button" data-slide="next"> <span
										class="carousel-control-next-icon" aria-hidden="true"></span>
										<span class="sr-only">Next</span>
									</a>
								</div>
							</c:if></td>
					</tr>
					<tr>
						<td class="w-25 text-center">소개</td>
						<td class="w-75">${selectedRoom.details}</td>
					</tr>
					<tr>
						<td class="text-center">인원</td>
						<td class="text-center"><c:if
								test="${0 ne selectedRoom.avail_adults}">
						어른 ${selectedRoom.avail_adults}명</c:if> <c:if
								test="${0 ne selectedRoom.avail_children}">
						어린이 ${selectedRoom.avail_children}명</c:if> <c:if
								test="${0 ne selectedRoom.avail_infants}">
						유아 ${selectedRoom.avail_infants}명</c:if></td>

					</tr>
					<tr>
						<td class="text-center">시설</td>
						<td class="text-center"><c:if
								test="${0 ne selectedRoom.avail_bedroom}">
						침실 ${selectedRoom.avail_bedroom}개</c:if> <c:if
								test="${0 ne selectedRoom.avail_bed}">
						침대 ${selectedRoom.avail_bed}개</c:if> <c:if
								test="${0 ne selectedRoom.avail_bathroom}">
						욕실 ${selectedRoom.avail_bathroom}개</c:if></td>

					</tr>
					<tr>
						<td class="text-center">편의시설</td>
						<td><c:set var="count" value="0" /> <c:set var="divideChk"
								value="1" /> <c:forEach items="${amenities}" var="item">
								<c:set var="count" value="${count+1}" />
								<c:if
									test="${'T' eq fn:substring(selectedRoom.amenities, count-1, count)}">
									<c:if
										test="${divideChk ne (item.amenities_idx-(item.amenities_idx mod 100))/100}">
										<%-- <c:if
										test="${divideChk ne (item.amenities_idx-(item.amenities_idx mod 100))/100 && divideChk ne 1}"> --%>
										<hr>
										<c:set var="divideChk"
											value="${(item.amenities_idx-(item.amenities_idx mod 100))/100}" />
									</c:if>
									<label for="amcb${count}" class="form-check-label">${item.amenities_details}</label>
									<br>
								</c:if>
							</c:forEach><input type="hidden" class="form-control"
							value="${selectedRoom.amenities}" id="amenities" name="amenities"></td>
					</tr>
					<tr>
						<td class="text-center">체크인</td>
						<td class="text-center">${selectedRoom.time_checkin}</td>
					</tr>
					<tr>
						<td class="text-center">체크아웃</td>
						<td class="text-center">${selectedRoom.time_checkout}</td>
					</tr>
					<tr>
						<td class="text-center">주중가격</td>
						<td class="text-center"><fmt:formatNumber
								value="${selectedRoom.price_weekdays}" pattern="\###,###,###" /></td>
					</tr>
					<tr>
						<td class="text-center">주말가격<br>(공휴일 포함)
						</td>
						<td class="text-center align-middle"><fmt:formatNumber
								value="${selectedRoom.price_weekend}" pattern="\###,###,###" /></td>
					</tr>
					<tr>
						<td class="text-center">주소</td>
						<td class="text-center">${selectedRoom.address}</td>
					</tr>
					<tr>
						<td colspan="2"><div id="map"
								style="width: 100%; height: 500px;"></div></td>
					</tr>
					<tr>
						<td colspan="2"><div class="alert alert-secondary"
								role="alert">이 숙소의 호스트</div>
							<table class="table">
								<tr>
									<td
										class="w-25 text-center border-top-0 border-bottom-0 align-top"
										onclick="getHostInfo()"><img
										src="http://13.209.99.134:8080/imgserver/resources/img/userphoto/${hostInfo.userPhoto}"
										class="viewRoomsProfile mb-1"><br>${hostInfo.userName}</td>
									<td class="w-75 border-top-0 border-bottom-0">${hostInfo.userInfo}</td>
								</tr>
							</table></td>
					</tr>
					<script>
						function getHostInfo() {
							location.href = "${pageContext.request.contextPath}/hostview?hostId=${hostInfo.userId}";
						}
					</script>
					<tr>
						<td colspan="2"><div class="alert alert-secondary"
								role="alert">
								이 숙소의 후기
								<c:forEach items="${reviewSummary}" var="reviewSummary">
									<c:if test="${selectedRoom.roomsId eq reviewSummary.roomsId}">
										<small class="text-muted"> <c:forEach begin="1"
												end="${reviewSummary.avgScope}" step="1">★</c:forEach> <fmt:formatNumber
												value="${reviewSummary.avgScope}" pattern="0.0" />
											(${reviewSummary.reviewCount})
										</small>
									</c:if>
								</c:forEach>
							</div>
							<table class="table" id="review">
							</table></td>
					</tr>
					<tr>
						<td colspan="2" class="text-center"><input type="hidden"
							id="roomsId" name="roomsId" value="${selectedRoom.roomsId}"><input
							type="hidden" id="disabled" name="disabled"
							value="${selectedRoom.disabled}"> <a
							href="${pageContext.request.contextPath}/chat/sendmessage?roomsId=${selectedRoom.roomsId}&hostId=${selectedRoom.hostId}"><input
								type="button" class="btn btn-danger ml-1 mr-1" value="문의하기"></a>
							<%-- <c:choose>
								<c:when test="${0 eq wish}">
									<button type="button" class="btn btn-danger ml-1 mr-1"
										id="wishBtn">
										<span class="wishIn">즐겨찾기추가</span>
									</button>
								</c:when>
								<c:when test="${2 eq wish}"></c:when>
								<c:otherwise>
									<button type="button" class="btn btn-danger ml-1 mr-1"
										id="wishBtn">
										<span class="wishIn">즐겨찾기해제</span>
									</button>
								</c:otherwise>
							</c:choose> --%></td>
					</tr>
				</table>
			</form>
		</div>
		<div class="col-lg-5">
			<%@ include file="../reservation/reservationForm.jsp"%>
		</div>
	</div>
	</main>
	<script type="text/javascript">
		var output = '';
		$(document).ready(function() {
			getReviews(1);
		});

		// 리뷰를 가져온다
		function getReviews(i) {
			$
					.ajax({
						type : 'GET',
						url : "${pageContext.request.contextPath}/rooms/getReveiws?roomsId="
								+ $('#roomsId').val() + '&page=' + i,
						contentType : "application/x-www-form-urlencoded; charset=UTF-8",
						dataType : 'JSON',
						success : function(json) {
							if (json.review.length == 0) {
								$('#review')
										.html(
												'<tr><td class="border-top-0 text-center align-middle">후기가 없습니다.</td></tr>');
							} else {
								for (i = 0; i < json.review.length; i++) {
									output += '<tr>';
									output += '<td rowspan="3" class="border-top-0 border-bottom-0 border-right-0 w-25 text-center align-top">'
											+ '<img src="http://13.209.99.134:8080/imgserver/resources/img/userphoto/' + json.review[i].userPhoto + '" class="viewRoomsProfile mb-1"><br>'
											+ json.review[i].userName + '</td>';
									output += '<td class="w-75 border-top-0 border-bottom-0"><small class="text-muted">';
									for (j = 0; j < json.review[i].scope; j++) {
										output += '★';
									}
									output += ' (' + json.review[i].scope + ')'
											+ '</small></td>';
									output += '</tr>';
									output += '<tr>';
									output += '<td class="border-top-0 border-bottom-0">'
											+ json.review[i].reviewContent
											+ '</td>';
									output += '</tr>';
									output += '<tr>';
									output += '<td class="border-top-0 border-bottom-0"><small class="text-muted">이 후기는 '
											+ json.review[i].reviewDate.substr(
													0, 4)
											+ '년 '
											+ json.review[i].reviewDate.substr(
													5, 2)
											+ '월 '
											+ json.review[i].reviewDate.substr(
													8, 2)
											+ '일'
											+ '에 작성되었습니다.</small></td>';
									/* output += '<td>' +json.review[i].reviewDate + '</td>'; */
									output += '</tr>';
									output += '<tr><td colspan="2" class="border-top-0 border-bottom-0"><hr></tr>'
								}
								if (json.paging.currentPageNo < json.paging.lastPageNo) {
									// 출력할 것이 남은 경우
									var moreBtn = '<tr><td colspan="2" class="text-center align-middle">'
											+ '<input type="button" class="btn btn-light col-12 " value="더보기" '
											+ 'onclick="getReviews('
											+ json.paging.nextPageNo
											+ ');"></td></tr>';
								}
								$('#review').html(output + moreBtn);
							}
							// console.log(json.review);
						},
						error : function(error) {
							console.log("error : " + error);
						}
					});
		};
	</script>
	<script type="text/javascript"
		src="https://openapi.map.naver.com/openapi/v3/maps.js?clientId=RjRRELdZtqF2DId12vbe&submodules=geocoder"></script>
	<script>
		// 초기값 경복궁
		var map = new naver.maps.Map("map", {
			center : new naver.maps.LatLng(37.5788408, 126.9770162),
			zoom : 10,
			scaleControl : true,
			scaleControlOptions : {
				position : naver.maps.Position.TOP_LEFT
			},
			zoomControl : true,
			zoomControlOptions : {
				position : naver.maps.Position.TOP_RIGHT
			},
			mapTypeControl : true
		});

		var infoWindow = new naver.maps.InfoWindow({
			borderWidth : 0,
			backgroundColor : 'transparant',
			anchorSize : {
				width : 10,
				height : 10
			}
		});

		map.setCursor('pointer');

		// result by latlng coordinate
		function searchAddressToCoordinate(address) {
			naver.maps.Service
					.geocode(
							{
								address : address
							},
							function(status, response) {
								if (status === naver.maps.Service.Status.ERROR) {
									$('#address').val('');
									return alert('유효하지 않은 주소 입니다! 주소를 확인해 주세요.');
								}

								var item = response.result.items[0], addrType = item.isRoadAddress ? '[도로명주소]'
										: '[지번주소]', point = new naver.maps.Point(
										item.point.x, item.point.y);

								$('#address').val(item.address);

								infoWindow
										.setContent([
												'<div class="alert alert-light border border-secondary map_info mb-0" role="alert">',
												//'<b>검색 주소 : '
												//		+ response.result.userquery
												//		+ '</b><br>',
												addrType + ' ' + item.address
														+ '<br>', '</div>' ]
												.join('\n'));

								map.setCenter(point);
								infoWindow.open(map, point);
							});
		}

		function initGeocoder() {

			searchAddressToCoordinate('${selectedRoom.address}');
		}

		naver.maps.onJSContentLoaded = initGeocoder;
	</script>
</body>
</html>