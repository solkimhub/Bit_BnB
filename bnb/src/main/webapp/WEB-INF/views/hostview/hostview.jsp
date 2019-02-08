<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BitBnB</title>
<%@ include file="/resources/common/includeHead.jsp"%>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<style>
.card-img-top {
	height: 300px;
	object-fit: cover;
}
</style>
</head>
<body style="overflow-x: hidden">
	<%@ include file="/resources/common/Navbar.jsp"%>
	<div class="row justify-content-center">
		<div class="col-3">
			<div class="card" style="width: 18rem;">
				<img
					src="http://13.209.99.134:8080/imgserver/resources/img/userphoto/${requestScope.hostInfo.userPhoto}"
					style="height: 250px;">
				<div class="card-body">
					<h5 class="card-title text-center">
						<b>${requestScope.hostInfo.userId} /
							${requestScope.hostInfo.userName} /
							${requestScope.hostInfo.nickName}</b>
					</h5>
					<p class="card-text" style="text-align: center;">
						<span
							style="font-size: 30px; line-height: 50px; opacity: 0.4; float: left;">&#10077;</span>
						${requestScope.hostInfo.userInfo} <span
							style="font-size: 30px; line-height: 50px; opacity: 0.4; float: right;">&#10078;</span>
					</p>
				</div>
				<ul class="list-group list-group-flush text-center">
					<li class="list-group-item"><c:choose>
							<c:when test="${requestScope.avgScope eq -1}">
                        아직 호스트의 방에 대한 평가가 없습니다.
                    </c:when>
							<c:otherwise>
                        호스트의 방의 평균 점수는 <br>
								<b>${requestScope.avgScope}</b> 입니다.
                    </c:otherwise>
						</c:choose></li>
					<li class="list-group-item">BitBnB의 사용자들이 <br>
					<b>${requestScope.reservaionCnt}번</b> 이용했습니다!
					</li>
				</ul>
			</div>
			<%--  이것은 호스트 정보입니다.
    ${requestScope.hostInfo.userId}
        ${requestScope.hostInfo.userName}
        ${requestScope.hostInfo.nickName}
    <c:choose>
        <c:when test="${requestScope.avgScope eq -1}">
           아직 호스트의 방에 대한 평가가 없습니다.
        </c:when>
        <c:otherwise>
           호스트의 방의 평균 점수는 ${requestScope.avgScope} 입니다.
        </c:otherwise>
    </c:choose>
<p>이 BitBnB의 사용자들은 호스트의 방을 ${requestScope.reservaionCnt}번 이용했습니다!</p> --%>
			<%-- <img src="http://13.209.99.134:8080/imgserver/resources/img/userphoto/${requestScope.hostInfo.userPhoto}"> --%>
		</div>
		<div class="row col-8" id="llllist"></div>
	</div>



	<script>
		var pageeee = 1;
		$('#llllist')
				.html(
						'<h1 style="width:100%;">안녕하세요, ${requestScope.hostInfo.userName}입니다!</h1>'
								+ '<span style="width:100%;padding-bottom:30px;font-size:20px;"><i class="fas fa-check-circle" style="color:#329632;"></i>&ensp;인증된 호스트입니다.</span>');
		function viewMyroomList() {
			var output = '';

			// http://fruitdev.tistory.com/174
			var queryString = 'hostId=${requestScope.hostInfo.userId}&checkIn=&checkOut=&page='
					+ pageeee;
			/* $
			    .ajax({
			        type : 'POST',
			        async : false,
			        url : '${pageContext.request.contextPath}/rooms/getRoomsList',
			        contentType : "application/x-www-form-urlencoded; charset=UTF-8",
			        data : queryString,
			        dataType : 'JSON',
			        success : function(data) {

			            for (i = 0; i < data.roomsList.length; i++) {
			                output += '<div class="col-lg-3">';
			                output += '<div class="card mb-3 box-shadow">';
			                for (k = 0; k < data.thumbnail.length; k++) {
			                    if (data.roomsList[i].roomsId == data.thumbnail[k].roomsId) {
			                        output += '<a href="${pageContext.request.contextPath}/rooms/viewRooms?roomsId='
			                            + data.roomsList[i].roomsId;
			                        output += '				&hostId='
			                            + data.roomsList[i].hostId
			                            + '">';
			                        output += '<img class="card-img-top" src="http://13.209.99.134:8080/imgserver/resources/upload/' +data.thumbnail[k].filename+ '">';
			                        output += '</a>';
			                    } else { // 이미지가 없을 경우, 노이미지
			                        output += '<img class="card-img-top">';
			                    }
			                }

			                output += '<div class="card-body">';
			                output += '	<p class="card-text">';
			                output += '		' + data.roomsList[i].roomsId
			                    + '<br>' + data.roomsList[i].address
			                    + '<br>￦';
			                output += data.roomsList[i].price_weekdays
			                        .toString().replace(
			                        /\B(?=(\d{3})+(?!\d))/g, ",")
			                    + ' - ￦'
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
			                        + data.roomsList[i].hostId + '">';
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
			            console.log(data.paging.currentPageNo);
			            console.log(data.paging.lastPageNo);

			            if (data.paging.currentPageNo < data.paging.lastPageNo) {
			                // 출력할 것이 남은 경우
			                pageeee = data.paging.currentPageNo;
			            } else {
			                // console.log($('#page').val());
			                pageeee = -1;
			            }
			            $('#llllist').html( $('#llllist').html()+output);

			            // console.log(markers);
			            // console.log('--- ajax ---');

			        },
			        error : function(error) {
			            console.log("error : " + error);
			        }
			    }); */
			$
					.ajax({
						type : 'POST',
						async : false,
						url : '${pageContext.request.contextPath}/rooms/getRoomsList',
						contentType : "application/x-www-form-urlencoded; charset=UTF-8",
						data : queryString,
						dataType : 'JSON',
						success : function(data) {
							console.log(data)

							if (data.roomsList.length == 0) {
								$('#llllist').html('해당하는 숙소가 없습니다 \' ㅅ\');;');
							} else {
								output += '<div class="container-fluid row content-row">';
								for (i = 0; i < data.roomsList.length; i++) {
									output += '<div class="col-lg-3 d-flex align-items-stretch">';
									output += '<div class="w-100 card mb-3 box-shadow">';
									for (k = 0; k < data.thumbnail.length; k++) {
										if (data.roomsList[i].roomsId == data.thumbnail[k].roomsId) {
											output += '<a href="${pageContext.request.contextPath}/rooms/viewRooms?roomsId='
													+ data.roomsList[i].roomsId
													+ '">';
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
								$('#llllist').html(output);
							}
						},
						error : function(error) {
							console.log("error : " + error);
						}
					});

		}

		viewMyroomList();

		$(window).scroll(
				function() {
					if ($(window).scrollTop() == $(document).height()
							- $(window).height()) {
						// 마지막 페이지가 아닐 때
						if (pageeee != -1) {
							pageeee = pageeee + 1;
							viewMyroomList();
						}
					}
				});//end of 무한스크롤
	</script>
</body>
</html>
