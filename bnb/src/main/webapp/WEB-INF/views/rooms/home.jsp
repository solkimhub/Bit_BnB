<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<%@ include file="/resources/common/includeHead.jsp"%>
<!-- range slider -->
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
</head>
<style>
.card-img-top {
	height: 300px;
	object-fit: cover;
}
</style>
<body>

	<%@ include file="/resources/common/Navbar.jsp"%>
	<!-- Begin page content -->
	<script>
		$(window).on('load', function() {
			$('.post-module').hover(function() {
				$(this).find('.description').stop().animate({
					height : "toggle",
					opacity : "toggle"
				}, 300);
			});
		});
		$(document).ready(function() {
			// 지도 끄고 시작
			$('#map').css('display', 'none');
		});
	</script>
	<main role="main" class="row ml-5 mr-5">
	<div class="col-lg-2 border-right pr-4">
		<c:if test="${1 eq loginUser.host}">
			<a href="${pageContext.request.contextPath}/rooms/registerRooms"><button
					class="btn btn-danger col-12 btn-lg mb-2">방입력</button></a>
		</c:if>
		<form method="post" id="searchForm">
			<!-- <input type="button" onclick="searchRoomsList()"
				class="btn btn-dark col-12 btn-lg" value="숙소 검색"> -->
			<input type="button" id="mapBtn"
				class="btn btn-secondary col-12 btn-lg mt-2 mb-2" value="지도 보기">
			<input type="button" id="resetBtn" class="btn btn-dark col-12 btn-sm"
				value="검색 조건 초기화">

			<div class="dropdown mt-1">
				<button class="btn btn-light col-12 dropdown-toggle" type="button"
					id="dropdownMenu_avail" data-toggle="dropdown" aria-haspopup="true"
					aria-expanded="false">인원</button>
				<div class="dropdown-menu" id="avail">
					<span class="dropdown-item-text">어른<input type="hidden"
						value="0" id="avail_adults" name="avail_adults"></span><span
						class="dropdown-item-text"><input type="number"
						class="form-control dropdown-item" id="avail_adults_t"
						name="avail_adults_t" value="0" min="0" max="100" step="1"></span>
					<span class="dropdown-item-text">어린이 <small>(2~12세)</small></span><span
						class="dropdown-item-text"><input type="number"
						class="form-control" value="0" min="0" max="100" step="1"
						id="avail_children_t" name="avail_children_t"></span> <span
						class="dropdown-item-text">유아 <small>(2세 미만)</small></span> <span
						class="dropdown-item-text"><input type="number"
						class="form-control" value="0" min="0" max="100" step="1"
						id="avail_infants" name="avail_infants"></span>
				</div>
			</div>

			<div class="dropdown mt-1">
				<button class="btn btn-light col-12 dropdown-toggle" type="button"
					id="dropdownMenu_availf" data-toggle="dropdown"
					aria-haspopup="true" aria-expanded="false">침대와 침실</button>
				<div class="dropdown-menu" id="availf">
					<span class="dropdown-item-text">침실</span> <span
						class="dropdown-item-text"><input type="number"
						class="form-control" value="0" min="0" max="100" step="1"
						id="avail_bedroom" name="avail_bedroom"></span> <span
						class="dropdown-item-text">침대</span> <span
						class="dropdown-item-text"><input type="number"
						class="form-control" value="0" min="0" max="100" step="1"
						id="avail_bed" name="avail_bed"></span> <span
						class="dropdown-item-text">욕실</span> <span
						class="dropdown-item-text"><input type="number"
						class="form-control" value="0" min="0" max="100" step="1"
						id="avail_bathroom" name="avail_bathroom"></span>
				</div>
			</div>
			<input type="text" class="form-control mt-1 text-center" id="address"
				name="address" placeholder="주소로 검색..">
			<%@ include file="searchCal.jsp"%>

			<div class="alert alert-secondary text-center mt-1 mb-0" role="alert"
				id="amount"></div>
			<div id="slider-range"></div>

			<input type="hidden" id="price_weekdays" name="price_weekdays"
				value="${min_price}"> <input type="hidden"
				id="price_weekend" name="price_weekend" value="${max_price}">

			<script>
				// $("#slider-range").slider("option", "values", [50,500]);
				// https://stackoverflow.com/questions/8795431/how-do-i-dynamically-change-min-max-values-for-jquery-ui-slider
				$(function() {
					$("#slider-range").slider({
										range : true,
										min : ${min_price},
										max : ${max_price},
										step : 10,
										values : [ ${min_price}, ${max_price} ],
										slide : function(event, ui) {
											$("#amount").html("\\"+ ui.values[0].toString().replace(/\B(?=(\d{3})+(?!\d))/g,",")
																	+ " - \\"
																	+ ui.values[1].toString().replace(/\B(?=(\d{3})+(?!\d))/g,","));

											$('#price_weekdays').val(+ui.values[0].toString());
											$('#price_weekend').val(+ui.values[1].toString());
											
											searchRoomsList();
										}
									});

					$("#amount").html("\\" + $("#slider-range").slider("values", 0).toString().replace(/\B(?=(\d{3})+(?!\d))/g,
													",")
									+ " - \\"
									+ $("#slider-range").slider("values", 1)
											.toString().replace(
													/\B(?=(\d{3})+(?!\d))/g,
													","));
				});

				// ajax 실시간 검색 처리 부분: 인원 + 시설 부분
				$('input[name^=avail_]').change(
						function() {
							$('#avail_adults').val(
									+$('#avail_adults_t').val()
											+ +$('#avail_children_t').val());
							var btnLabel = '';
							if ($('#avail_adults').val() != 0) {
								btnLabel += '게스트' + $('#avail_adults').val()
										+ '명';
							}
							if ($('#avail_adults').val() != 0
									&& $('#avail_infants').val() != 0) {
								btnLabel += ', ';
							}
							if ($('#avail_infants').val() != 0) {
								btnLabel += '유아' + $('#avail_infants').val()
										+ '명';
							}
							if (btnLabel == '') {
								btnLabel = '인원';
							}
							$('#dropdownMenu_avail').html(btnLabel);
							searchRoomsList();
						});
				// ajax 주소 검색시 처리
				$('#address').keypress(function(event) {
					if (event.which == 13) {
						event.preventDefault();
						searchRoomsList();
					}
				});

				// 리셋버튼에 기능 부여
				$('#resetBtn').click(function() {
					$('#slider-range').slider("option", "values", [${min_price}, ${max_price}]);
					$('#dropdownMenu_avail').html('인원');
					$('#searchForm')[0].reset();
					// avail 값들이 초기화되지 않아서 따로 처리
					$('[name^=avail_]').val(0);
					// $('#avail > span:nth-child(even) > div > input').val(0);
					// $('#availf > span:nth-child(even) > div > input').val(0);
					searchRoomsList();
				});
			</script>

			<input type=hidden id="page" name="page" value="1">
		</form>

	</div>
	<div class="col-lg-10 pl-4">
		<div id="map" style="width: 100%; height: 500px;" class="mb-4"></div>
		<div class="row" id="roomsList">
			<input type=hidden id="page" name="page" value="1">
		</div>
	</div>
	</main>
	<!-- 스피너 사용을 위한 JS -->
	<script
		src="${pageContext.request.contextPath}/resources/js/bootstrap-input-spinner.js"></script>
	<script>
		// 스피너 사용	
		$("input[type='number']").inputSpinner()

		// input에서 엔터키 사용시 submit을 방지하기 위함
		/* $('input[type="text"]').keydown(function() {
			if (event.keyCode === 13) {
				event.preventDefault();
			}
		}); */

		$('#mapBtn').click(function() {
			$('#map').toggle();
			if ($(this).val() == '지도 보기') {
				$(this).val('지도 숨기기');
			} else if ($(this).val() == '지도 숨기기') {
				$(this).val('지도 보기');
			}
		});
	</script>
	<script type="text/javascript">
		// 전역변수 
		var output = '';

		// 드롭다운 메뉴의 유지 처리
		$('#avail').on('click', function(event){
		    // The event won't be propagated up to the document NODE and 
		    // therefore delegated events won't be fired
		    event.stopPropagation();
		});
		$('#availf').on('click', function(event){
		    // The event won't be propagated up to the document NODE and 
		    // therefore delegated events won't be fired
		    event.stopPropagation();
		});
		
		$(document).ready(function() {

			getRoomsList();
		});
		function searchRoomsList() {
			// 마커 모두 지우기
			for (var i = 0; i < markers.length; i++) {
		    	markers[i].setMap(null);
		    }
			minLat = 0, maxLat = 0, minLng = 0, maxLng = 0;
			// 네이버 지도 마커 초기화
			markers = [];
			// 숙소 리스트 카드 초기화
			output = '';
			// 페이징의 페이지 정보 초기화
			$('#page').val(1);
			// 숙소 정보 가져오기
			getRoomsList();
		}
		// 숙소 목록을 가져옴
		function getRoomsList() {
			// http://fruitdev.tistory.com/174
			var queryString = $("form[id=searchForm]").serialize();
			$
					.ajax({
						type : 'POST',
						async: false,
						url : '${pageContext.request.contextPath}/rooms/getRoomsList',
						contentType : "application/x-www-form-urlencoded; charset=UTF-8",
						data : queryString,
						dataType : 'JSON',
						success : function(data) {
							console.log(data)

							if (data.roomsList.length == 0) {
								// $('#roomsList')
								//		.html(
								//				'<tr><td class="border-top-0 text-center align-middle">해당하는 숙소가 없습니다 \' ㅅ\');;</td></tr>');
								$('#roomsList').html('해당하는 숙소가 없습니다 \' ㅅ\');;');
							} else {
								output += '<div class="container-fluid row content-row">';
								for (i = 0; i < data.roomsList.length; i++) {
									addPoints(data.roomsList[i]);
									
									/* <!-- Normal Demo-->
									output += '<div class="column col-4">';
									output += '<!-- Post-->';
									output += '	<div class="post-module">';
									output += '		<!-- Thumbnail-->';
									output += '		<div class="thumbnail">';
									for(k=0; k<data.thumbnail.length; k++){
										if (data.roomsList[i].roomsId == data.thumbnail[k].roomsId) {
											output += '<a href="${pageContext.request.contextPath}/rooms/viewRooms?roomsId='
												+ data.roomsList[i].roomsId + '">';
											output += '<img src="http://13.209.99.134:8080/imgserver/resources/upload/' +data.thumbnail[k].filename+ '" style="height:100%;">';
											output += '</a>';
										}
									}
									output += '		</div>';
									output += '		<!-- Post Content-->';
									output += '		<div class="post-content">';
									output += '			<div class="category">';
									output += '\\' + data.roomsList[i].price_weekdays
											.toString().replace(
													/\B(?=(\d{3})+(?!\d))/g,
													",")
											+ ' - \\'
											+ data.roomsList[i].price_weekend
													.toString()
													.replace(
															/\B(?=(\d{3})+(?!\d))/g,
															",") + ' /박';
									output += '	</p>';
									output += '			</div>';
									output += '			<h1 class="title">' + data.roomsList[i].address + '</h1>';
									output += '			<div class="post-meta">';

									
									
									output += '		<div class="d-flex justify-content-between align-items-center">';
									output += '			<small class="text-muted">';
									for (j = 0; j < data.reviewSummary.length; j++) {
										if (data.roomsList[i].roomsId == data.reviewSummary[j].roomsId) {
											for (k = 0; k <= data.reviewSummary[j].avgScope; k++) {
												output += '★';
											}
											output += ' ('
													+ data.reviewSummary[j].reviewCount
													+ ')';
										}
									}
									output += '			</small>';
									output += '			<div class="btn-group">';
									if ('${loginUser.userId}' !== ''
											&& data.roomsList[i].hostId == '${loginUser.userId}') {
										output += '					<a href="${pageContext.request.contextPath}/rooms/modifyRooms?roomsId=';
										output += '					'
												+ data.roomsList[i].roomsId
												+ '&_hostId='
												+ data.roomsList[i].hostId
												+ '">';
										output += '					<button type="button" class="btn btn-sm btn-outline-secondary ml-1">Edit</button></a>';
									}
									output += '				<a href="${pageContext.request.contextPath}/rooms/viewRooms?roomsId='
											+ data.roomsList[i].roomsId + '">';
									output += '				<button type="button" class="btn btn-sm btn-outline-secondary ml-1">View</button></a>';
									output += '			</div>';
									output += '</div>';
									
									
									output += '			</div>';
									output += '		</div>';
									output += '	</div>';
									output += '</div>';
									<!-- Normal Demo--> */
								
									
									output += '<div class="col-lg-3 d-flex align-items-stretch">';
									output += '<div class="w-100 card mb-3 box-shadow">';
									for(k=0; k<data.thumbnail.length; k++){
										if (data.roomsList[i].roomsId == data.thumbnail[k].roomsId) {
											output += '<a href="${pageContext.request.contextPath}/rooms/viewRooms?roomsId='
												+ data.roomsList[i].roomsId + '">';
											output += '<img class="card-img-top" src="http://13.209.99.134:8080/imgserver/resources/upload/' +data.thumbnail[k].filename+ '">';
											output += '</a>';
											break;
										}
									}
									
									output += '<div class="card-body">';
									output += '	<p class="card-text">';
									output += '		' + data.roomsList[i].roomsId
											+ '<br>'
											+ data.roomsList[i].address
											+ '<br>\\';
									output += data.roomsList[i].price_weekdays
											.toString().replace(
													/\B(?=(\d{3})+(?!\d))/g,
													",")
											+ ' - \\'
											+ data.roomsList[i].price_weekend
													.toString()
													.replace(
															/\B(?=(\d{3})+(?!\d))/g,
															",") + ' /박';
									output += '	</p>';
									output += '		<div class="d-flex justify-content-between align-items-center">';
									output += '			<small class="text-muted">';
									for (j = 0; j < data.reviewSummary.length; j++) {
										if (data.roomsList[i].roomsId == data.reviewSummary[j].roomsId) {
											for (k = 0; k <= data.reviewSummary[j].avgScope; k++) {
												output += '★';
											}
											output += ' ('
													+ data.reviewSummary[j].reviewCount
													+ ')';
										}
									}
									output += '			</small>';
									output += '			<div class="btn-group">';
									if ('${loginUser.userId}' !== ''
											&& data.roomsList[i].hostId == '${loginUser.userId}') {
										output += '					<a href="${pageContext.request.contextPath}/rooms/modifyRooms?roomsId=';
										output += '					'
												+ data.roomsList[i].roomsId
												+ '&_hostId='
												+ data.roomsList[i].hostId
												+ '">';
										output += '					<button type="button" class="btn btn-sm btn-outline-secondary ml-1">Edit</button></a>';
									}
									output += '				<a href="${pageContext.request.contextPath}/rooms/viewRooms?roomsId='
											+ data.roomsList[i].roomsId + '">';
									output += '				<button type="button" class="btn btn-sm btn-outline-secondary ml-1">View</button></a>';
									output += '			</div>';
									output += '</div>';
									output += '</div>';
									output += '</div>';
									output += '</div>';
								}
								if (data.paging.currentPageNo < data.paging.lastPageNo) {
									// 출력할 것이 남은 경우
									$('#page').val(data.paging.currentPageNo);
								} else {
									// console.log($('#page').val());
									$('#page').val(-1);
								}

								output += '</div>';
								$('#roomsList').html(output);

								// console.log(markers);
								// console.log('--- ajax ---');
							}
							
							/* if (data.roomsList.length == 0) {
								$('#roomsList')
										.html(
												'<tr><td class="border-top-0 text-center align-middle">해당하는 숙소가 없습니다 \' ㅅ\');;</td></tr>');
							} else {
								for (i = 0; i < data.roomsList.length; i++) {
									addPoints(data.roomsList[i]);
									
									output += '<div class="col-lg-3">';
									output += '<div class="card mb-3 box-shadow">';
									for(k=0; k<data.thumbnail.length; k++){
										if (data.roomsList[i].roomsId == data.thumbnail[k].roomsId) {
											output += '<a href="${pageContext.request.contextPath}/rooms/viewRooms?roomsId='
												+ data.roomsList[i].roomsId + '">';
											output += '<img class="card-img-top" src="http://13.209.99.134:8080/imgserver/resources/upload/' +data.thumbnail[k].filename+ '">';
											output += '</a>';
										} else { // 이미지가 없을 경우, 노이미지
											output += '<img class="card-img-top">';
										}
									}
									
									output += '<div class="card-body">';
									output += '	<p class="card-text">';
									output += '		' + data.roomsList[i].roomsId
											+ '<br>'
											+ data.roomsList[i].address
											+ '<br>\\';
									output += data.roomsList[i].price_weekdays
											.toString().replace(
													/\B(?=(\d{3})+(?!\d))/g,
													",")
											+ ' - \\'
											+ data.roomsList[i].price_weekend
													.toString()
													.replace(
															/\B(?=(\d{3})+(?!\d))/g,
															",") + ' /박';
									output += '	</p>';
									output += '		<div class="d-flex justify-content-between align-items-center">';
									output += '			<small class="text-muted">';
									for (j = 0; j < data.reviewSummary.length; j++) {
										if (data.roomsList[i].roomsId == data.reviewSummary[j].roomsId) {
											for (k = 0; k <= data.reviewSummary[j].avgScope; k++) {
												output += '★';
											}
											output += ' ('
													+ data.reviewSummary[j].reviewCount
													+ ')';
										}
									}
									output += '			</small>';
									output += '			<div class="btn-group">';
									if ('${loginUser.userId}' !== ''
											&& data.roomsList[i].hostId == '${loginUser.userId}') {
										output += '					<a href="${pageContext.request.contextPath}/rooms/modifyRooms?roomsId=';
										output += '					'
												+ data.roomsList[i].roomsId
												+ '&_hostId='
												+ data.roomsList[i].hostId
												+ '">';
										output += '					<button type="button" class="btn btn-sm btn-outline-secondary ml-1">Edit</button></a>';
									}
									output += '				<a href="${pageContext.request.contextPath}/rooms/viewRooms?roomsId='
											+ data.roomsList[i].roomsId + '">';
									output += '				<button type="button" class="btn btn-sm btn-outline-secondary ml-1">View</button></a>';
									output += '			</div>';
									output += '</div>';
									output += '</div>';
									output += '</div>';
									output += '</div>';
								}
								if (data.paging.currentPageNo < data.paging.lastPageNo) {
									// 출력할 것이 남은 경우
									$('#page').val(data.paging.currentPageNo);
								} else {
									// console.log($('#page').val());
									$('#page').val(-1);
								}
								$('#roomsList').html(output);

								// console.log(markers);
								// console.log('--- ajax ---');
							} */
						},
						error : function(error) {
							console.log("error : " + error);
						}
					});
		};

		$(window).scroll(
				function() {
					if ($(window).scrollTop() == $(document).height()
							- $(window).height()) {
						// 마지막 페이지가 아닐 때 
						if ($('#page').val() != -1) {
							$('#page').val(+$('#page').val() + 1);
							getRoomsList();
						}
					}
				});//end of 무한스크롤
	</script>
	<script type="text/javascript"
		src="https://openapi.map.naver.com/openapi/v3/maps.js?clientId=RjRRELdZtqF2DId12vbe&submodules=geocoder"></script>
	<script>
		// 지도 경계선을 위한 전역 변수 설정
		var minLat = 0, maxLat = 0, minLng = 0, maxLng = 0;

		// 지도 끄고 시작
		$('#map').css('display', 'none');

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

		map.setCursor('pointer');
		
		var markers = [];
		
		function addPoints(obj) {
			naver.maps.Service
					.geocode(
							{
								address : obj.address
							},
							
							function(status, response) {
								if (status === naver.maps.Service.Status.ERROR) {
									console.log("유효하지 않은 주소 : " + address);
								}

								var item = response.result.items[0], point = new naver.maps.Point(item.point.x, item.point.y);
								var position = new naver.maps.LatLng(item.point.y, item.point.x);
								
								if (minLat == 0 &&  maxLat == 0 && minLng == 0 && maxLng == 0){
									minLat = item.point.y;
									maxLat = item.point.y;
									minLng = item.point.x;
									maxLng = item.point.x;
								} else if (item.point.y < minLat){
						    		minLat = item.point.y;
						    	}
						    	if (item.point.y > maxLat){
						    		maxLat = item.point.y;
						    	}
						    	if (item.point.x < minLng){
						    		minLng = item.point.x;
						    	}
						    	if (item.point.x > maxLng){
						    		maxLng = item.point.x;
						    	}
						    	
							    bounds = new naver.maps.LatLngBounds(
						                new naver.maps.LatLng(minLat, minLng),
						                new naver.maps.LatLng(maxLat, maxLng));
							    map.fitBounds(bounds);
							    
							    // console.log(minLat);
							    // console.log(minLng);
							    // console.log(maxLat);
							    // console.log(maxLng);
							    // console.log(bounds);
								
								var marker = new naver.maps.Marker({
							        map: map,
							        position: position,
							        icon: {
							            content: [
							            	'<div class="alert alert-light border border-secondary map_info pt-1 pl-1 pr-1 pb-1 balloon text-center" role="alert">',
							            	'<a href="${pageContext.request.contextPath}/rooms/viewRooms?roomsId=', obj.roomsId,'&hostId=', obj.hostId, '">',
							            	' \\', obj.price_weekdays.toString().replace(/\B(?=(\d{3})+(?!\d))/g,","), ' - \\',
											obj.price_weekend.toString().replace(/\B(?=(\d{3})+(?!\d))/g,","), '</div>',
							                    ].join(''),
							            // size: new naver.maps.Size(200, 54),
							            anchor: new naver.maps.Point(0, 30)
							        },
								});
								
								markers.push(marker);
							});
		}
		// https://navermaps.github.io/maps.js/docs/tutorial-1-marker-simple.example.html
		// https://navermaps.github.io/maps.js/docs/tutorial-marker-viewportevents.example.html
	</script>
</body>
</html>