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
<body>

	<%@ include file="/resources/common/Navbar.jsp"%>
	<!-- Begin page content -->
	<script>
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
				<div class="dropdown-menu" id="avail">
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
			
			<%@ include file="searchCal.jsp"%>
			
			<div class="alert alert-secondary text-center mt-1 mb-0" role="alert"
				id="amount"></div>
			<div id="slider-range"></div>

			<input type="hidden" class="form-control mt-1" id="address"
				name="address" placeholder="주소로 검색.."> <input type="hidden"
				id="price_weekdays" name="price_weekdays" value="${min_price}">
			<input type="hidden" id="price_weekend" name="price_weekend"
				value="${max_price}">

			<script>
				$(function() {
					// $("#slider-range").slider("option", "values", [50,500]);
					// https://stackoverflow.com/questions/8795431/how-do-i-dynamically-change-min-max-values-for-jquery-ui-slider

					$("#slider-range").slider(
									{
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

					$("#amount").html(
							"\\"
									+ $("#slider-range").slider("values", 0)
											.toString().replace(
													/\B(?=(\d{3})+(?!\d))/g,
													",")
									+ " - \\"
									+ $("#slider-range").slider("values", 1)
											.toString().replace(
													/\B(?=(\d{3})+(?!\d))/g,
													","));
				});
				// 드롭다운 메뉴의 유지 처리
				$(document).on('click', '#avail', function(e) {
					e.stopPropagation();
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
					searchRoomsList();
				});
			</script>
			<!-- <table class="table">
				<tr>
					<td>체크인</td>
					<td><input type="time" class="form-control" id="time_checkin"
						name="time_checkin" value="14:00"></td>
				</tr>
				<tr>
					<td>체크아웃</td>
					<td><input type="time" class="form-control" id="time_checkout"
						name="time_checkout" value="12:00"></td>
				</tr>
			</table> -->
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

		$(document).ready(function() {
			getRoomsList();
		});
		function searchRoomsList() {
			output = '';
			$('#page').val(1);
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
							// console.log(data)

							if (data.roomsList.length == 0) {
								$('#roomsList')
										.html(
												'<tr><td class="border-top-0 text-center align-middle">해당하는 숙소가 없습니다 \' ㅅ\');;</td></tr>');
							} else {
								for (i = 0; i < data.roomsList.length; i++) {
									output += '<div class="col-md-3">';
									output += '<div class="card mb-3 box-shadow">';
									output += '<img class="card-img-top">';
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
											+ data.roomsList[i].roomsId;
									output += '				&hostId='
											+ data.roomsList[i].hostId + '">';
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
							}
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

		var infoWindow = new naver.maps.InfoWindow({
			borderWidth : 0,
			backgroundColor : 'transparant',
			anchorSize : {
				width : 10,
				height : 10
			}
		});

		map.setCursor('pointer');

		// search by tm128 coordinate
		function searchCoordinateToAddress(latlng) {
			var tm128 = naver.maps.TransCoord.fromLatLngToTM128(latlng);

			infoWindow.close();

			naver.maps.Service
					.reverseGeocode(
							{
								location : tm128,
								coordType : naver.maps.Service.CoordType.TM128
							},
							function(status, response) {
								if (status === naver.maps.Service.Status.ERROR) {
									$('#address').val('');
									return alert('유효하지 않은 주소 입니다! 주소를 확인해 주세요.');
								}

								var items = response.result.items, htmlAddresses = [];

								for (var i = 0, ii = items.length, item, addrType; i < ii; i++) {
									item = items[i];

									if (i == 0) {
										addrType = item.isRoadAddress ? '[도로명주소]'
												: '[지번주소]';

										// htmlAddresses.push((i + 1) + '. ' + addrType+ ' ' + item.address);
										htmlAddresses.push(addrType + ' '
												+ item.address);
										$('#address').val(item.address);
									}
								}

								infoWindow
										.setContent([
												'<div class="alert alert-light border border-secondary map_info mb-0" role="alert">',
												'<b>검색 좌표</b><br>',
												htmlAddresses.join('<br>'),
												'</div>' ].join('\n'));

								infoWindow.open(map, latlng);
							});
		}

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
												'<b>검색 주소 : '
														+ response.result.userquery
														+ '</b><br>',
												addrType + ' ' + item.address
														+ '<br>', '</div>' ]
												.join('\n'));

								map.setCenter(point);
								infoWindow.open(map, point);
							});
		}

		function initGeocoder() {
			map.addListener('click', function(e) {
				searchCoordinateToAddress(e.coord);
			});

			// 주소창에 enter 입력시
			/* $('#address').on('keydown', function(e) {
				var keyCode = e.which;
				if (keyCode === 13) { // Enter Key
					searchAddressToCoordinate($('#address').val());
				}
			});

			// 주소창에 입력후 엔터를 입력하지 않았으나, 포커스를 벗어날  경우
			$('#address').blur(function(e) {
				searchAddressToCoordinate($('#address').val());
			}); */
		}

		naver.maps.onJSContentLoaded = initGeocoder;
	</script>
</body>
</html>