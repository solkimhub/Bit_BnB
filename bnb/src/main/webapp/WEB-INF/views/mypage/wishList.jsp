<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>WishList</title>
<%@ include file="/resources/common/includeHead.jsp"%>
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=31560f6f51cc23c9f8ef204f4664e637&libraries=services"></script>
<style>
::-webkit-scrollbar {
	width: 8px;
	height: 8px;
	border: 3px solid #fff;
}

::-webkit-scrollbar-button:start:decrement, ::-webkit-scrollbar-button:end:increment
	{
	display: block;
	height: 10px;
	background: #efefef
}

::-webkit-scrollbar-track {
	background: #efefef;
	-webkit-border-radius: 10px;
	border-radius: 10px;
	-webkit-box-shadow: inset 0 0 4px rgba(0, 0, 0, .2)
}

::-webkit-scrollbar-thumb {
	height: 50px;
	width: 50px;
	background: rgba(0, 0, 0, .2);
	-webkit-border-radius: 8px;
	border-radius: 8px;
	-webkit-box-shadow: inset 0 0 4px rgba(0, 0, 0, .1)
}
</style>
</head>
<body style="background-color: #EEEEEE;">
	<%@ include file="/resources/common/Navbar.jsp"%>
	<div id="mypage_wrap_cont" class="row">
		<%@ include file="/WEB-INF/views/mypage/leftlist.jsp"%>
		<div id="mypage_cont" class="col-9">
			<h1 style="text-align: center; padding: 10px; font-weight: 800;">
				<i class="far fa-grin-hearts"></i> WISH LIST
			</h1>
			<div class="row"
				style="height: 600px; /* width: 900px; */ margin: 0 auto;">
				<div class="col-5 wishListCont"
					style="overflow: scroll; overflow-x: hidden;">
					<h2 style="font-weight: 600; text-align: center;">
						<i class="fas fa-map-marker-alt" style="color: red;"></i>&ensp;${address}
					</h2>
					<br>
					<c:forEach var="wl" items="${wishList}" varStatus="status">
						<c:set var="priceAvg"
							value="${wl.price_weekdays + wl.price_weekend / 2}" />
						<fmt:formatNumber type="int" var="price" value="${priceAvg}"
							pattern="#,###" />
						<div class="card" style="margin-bottom: 20px;">

							<div class="divImg imgTop"
								style="max-width: 100%; max-height: 350px; overflow: hidden; position: relative;">
								<a
									href="${pageContext.request.contextPath}/rooms/viewRooms?roomsId=${wl.roomsId}">
									<c:forEach var="wishImg" items="${wishImg}">
										<c:if test="${wl.roomsId == wishImg.roomsId}">
											<img class="card-img-top"
												src="http://13.209.99.134:8080/imgserver/resources/upload/${wishImg.filename}"
												style="width: 100%; object-fit: contain;">
										</c:if>
									</c:forEach>
								</a>
								<div class="top-right"
									style="position: absolute; top: 8px; right: 8px;">
									<button style="border: none; float: right; outline: 0; background-color: Transparent;"
										id="wishBtn" onclick="wishDelete('${wl.roomsId}','${address}')">
										<img id="wishIcon"
											src="${pageContext.request.contextPath}/resources/images/full2.png"
											style="width: 35px;">
									</button>
								</div>
							</div>
							<div class="card-body">
								<h5 class="card-title">
									<input type="hidden" value="${wl.roomsId}" class="wishRoomsId"
										style="width: 30px; border: none; text-align: center;"
										readonly> <a
										href="${pageContext.request.contextPath}/hostview?hostId=${wl.hostId}">
										<b>${wl.userName}</b>
									</a>님의 숙소<br> <span style="font-size: 15px;"
										class="wsAddress de_add" id="wsAddress">${wl.address}</span>
								</h5>
								<span class="card-text" id="price">￦ ${price} / 박</span>
								<c:choose>
									<c:when test="${0 ne wl.reviewCount and 0 ne wl.avgScope}">
										<span class="card-text"> <c:forEach var="scope"
												begin="1" end="${wl.avgScope}">
												<i class="fas fa-star fa-sm" style="color: #FF5A5F;"></i>
											</c:forEach>(${wl.reviewCount})
										</span>
									</c:when>
									<c:otherwise>
										<span class="card-text"><i
											class="fas fa-exclamation-circle" style="color: red;"></i>후기없음</span>
									</c:otherwise>
								</c:choose>
								<br> <br> <a
									href="${pageContext.request.contextPath}/rooms/viewRooms?roomsId=${wl.roomsId}"
									class="btn"
									style="background-color: #FF5A5F; color: white; float: right;">보러가기</a>
							</div>
						</div>
					</c:forEach>
				</div>
				<div class="col-7" id="map"></div>
			</div>
			<br>
			<div class="text-center">
				<button onclick="javascript:history.back();"
					class="btn btn-outline-secondary" style="margin: 10px;">목록으로</button>
			</div>
			<br>
		</div>
	</div>
	<script>
		function wishDelete(roomsId, address) {
			var com = confirm('즐겨찾기를 해제하시겠습니까?');
			if(com){
					$.ajax({
						url : '${pageContext.request.contextPath}/wishOut?roomsId='
								+ roomsId + '&address=' + address,
						success : function(data) {
							if(data[0].length && data[1].length){
							var address = '${address}';
							var cont = '';
							var price = '';

							// data[0][i] -> 룸정보 data[1][i] -> 사진정보
							cont += '<h2 style="font-weight: 600; text-align: center;"><i class="fas fa-map-marker-alt" style="color: red;"></i>&ensp;'
									+ address + '</h2><br>';
							for (var i = 0; i < data[0].length; i++) {
								var price = (data[0][i].price_weekdays + data[0][i].price_weekend) / 2;
								cont += '<div class="card" style="margin-bottom: 20px;"><div class="divImg imgTop"style="max-width: 100%; max-height: 350px; overflow: hidden; position:relative;">';
								cont += '<a href="${pageContext.request.contextPath}/rooms/viewRooms?roomsId='
										+ data[0][i].roomsId + '">';
								for (var j = 0; j < data[1].length; j++) {
									if (data[0][i].roomsId == data[1][j].roomsId) {
										cont += '<img class="card-img-top" src="http://13.209.99.134:8080/imgserver/resources/upload/'
												+ data[1][j].filename
												+ '" style="width: 100%; object-fit: contain;">';
									}
								}
								cont += '</a><div class="top-right" style="position: absolute; top: 8px; right: 8px;">'
										+ '<button style="border: none; float: right; outline: 0; background-color: Transparent;" id="wishBtn" onclick="wishDelete(\''
										+ data[0][i].roomsId
										+ '\',\''
										+ address
										+ '\')">'
										+ '<img id="wishIcon" src="${pageContext.request.contextPath}/resources/images/full2.png" style="width: 35px;"></button></div></div>';
								cont += '<div class="card-body"><h5 class="card-title"><input type="hidden" value="'+
										data[0][i].roomsId + '" class="wishRoomsId" style="width: 30px; border: none; text-align: center;" readonly>';
								cont += '<a href="${pageContext.request.contextPath}/hostview?hostId='
										+ data[0][i].hostId
										+ '"><b>'
										+ data[0][i].userName
										+ '</b></a>님의 숙소<br> <span style="font-size: 15px;" class="wsAddress de_add" id="wsAddress">'
										+ data[0][i].address
										+ '</span></h5> <span class="card-text" id="price">￦'
										+ price + ' / 박</span>';
								if (data[0][i].reviewCount != 0
										&& data[0][i].avgScope != 0) {
									cont += '<span class="card-text">';
									for (var k = 1; k < data[0][i].avgScope; k++) {
										cont += '<i class="fas fa-star fa-sm" style="color: #FF5A5F;"></i>';
									}
									cont += '(' + data[0][i].reviewCount
											+ ')</span>';
								} else {
									cont += '<span class="card-text"><i class="fas fa-exclamation-circle" style="color: red;"></i>후기없음</span>';
								}
								cont += '<br> <br> <a href="${pageContext.request.contextPath}/rooms/viewRooms?roomsId='
										+ data[0][i].roomsId
										+ '" class="btn" style="background-color: #FF5A5F; color: white; float: right;">보러가기</a></div></div>';
							}
							$('.wishListCont').html('');
							$('.wishListCont').append(cont);
						} else {
							location.replace('${pageContext.request.contextPath}/mypage/wish');
						}

					}
			});
			}
		}
	</script>
	<script>
		var mapContainer = document.getElementById('map'); // 지도를 표시할 div  
		mapOption = {
			center : new daum.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표 
			level : 6
		// 지도의 확대 레벨
		};

		var map = new daum.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
		var geocoder = new daum.maps.services.Geocoder();
		var addressArray = [];
		var wishList = $('.de_add');

		for (var i = 0; i < wishList.length; i++) {
			addressArray.push({
				'groupAddress' : $("span[id='wsAddress']").eq(i).text()
			});
		}
		for (var i = 0; i < addressArray.length; i++) {
			geocoder
					.addressSearch(
							addressArray[i].groupAddress,
							function(result, status, data) {

								// 정상적으로 검색이 완료됐으면 
								if (status === daum.maps.services.Status.OK) {

									var coords = new daum.maps.LatLng(
											result[0].y, result[0].x);

									// 결과값으로 받은 위치를 마커로 표시합니다
									var marker = new daum.maps.Marker({
										map : map,
										position : coords
									});

									// 마커를 지도에 표시합니다.
									marker.setMap(map);

									var content = '<div class ="labelWish"><span class="leftWish"></span><span class="centerWish cWish">'
											+ result[0].address_name
											+ '</span><span class="rightWish"></span></div>';

									// 커스텀 오버레이를 생성합니다
									var customOverlay = new daum.maps.CustomOverlay(
											{
												position : coords,
												content : content
											});

									// 커스텀 오버레이를 지도에 표시합니다
									customOverlay.setMap(map);

									// 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
									map.setCenter(coords);
								}
							});
		}
	</script>
</body>
</html>