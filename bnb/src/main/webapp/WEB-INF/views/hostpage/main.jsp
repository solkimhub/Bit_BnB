<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Mypage</title>
    <%@ include file="/resources/common/includeHead.jsp" %>
<style>
.card-img-top {
	height: 300px;
	object-fit: cover;
}
</style>
</head>
<body style=" overflow-x: hidden">
<%@ include file="/resources/common/Navbar.jsp" %>
<div class="row justify-content-center">
    <div class="col-2">
        <div class="col-10 list-group" id="list-tab" role="tablist" style="position: absolute; top:0px; left: 40px;">
            <a class="list-group-item list-group-item-action active"
               id="list-home-list" data-toggle="list" href="#list-home" role="tab"
               aria-controls="home"><i class="far fa-calendar-alt"></i> 예약현황</a> <a
                class="list-group-item list-group-item-action"
                onclick="viewMyroomList()" id="list-profid" data-toggle="list"
                href="#list-profi" role="tab" aria-controls="profile"><i
                class="fas fa-home"></i> 내방보기</a> <a
                class="list-group-item list-group-item-action"
                id="list-profile-list" data-toggle="list" href="#list-profile"
                role="tab" aria-controls="profile" onclick="eval()"><i
                class="fas fa-user-check"></i> 사용자평가</a>  <a
                class="list-group-item list-group-item-action"
                id="list-settings-list" data-toggle="list" href="#list-settings"
                role="tab" aria-controls="settings" onclick="withdraw()"><i
                class="fas fa-hand-holding-usd"></i> 인출</a> <a
                class="list-group-item list-group-item-action"
                id="list-settings-li" data-toggle="list" href="#list-settings2"
                role="tab" aria-controls="settings" onclick="selectroom()"><i
                class="fas fa-chart-line"></i> 통계</a>
        </div>
    </div>
    <script>
        /* 스크롤따라 움직이는 Div */
        var currentPositiomm = parseInt($('#list-tab').css('top'));

        $(window).scroll(function() {
            var positions = $(window).scrollTop();
            $('#list-tab').stop().animate({
                'top' : positions + currentPositiomm + 'px'
            }, 500);
        });
    </script>

    <div class="col-9">
        <div class="tab-content" id="nav-tabContent">
            <div class="tab-pane fade show active" id="list-home"
                 role="tabpanel" aria-labelledby="list-home-list">
                <c:choose>
                    <c:when test="${empty myroomlist}">
                       <div class="col-12" style="text-align: center; font-size: 2em; padding-top: 30px"> <i class="fas fa-exclamation-triangle"></i> 호스트 님의 예약된 방이 없습니다. </div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="room" items="${myroomlist}">
                            <div id="mymy${room.roomsId}" onclick="myroomlistselect('${room.roomsId}')" style="cursor: pointer">
                                룸 번호 ( ${room.roomsId} ) <span
                                    class="badge badge-pill badge-primary">${room.reservationCount}</span>
                            </div>
                            <div class="dis row col-12" style="display: none"
                                 id="myroom${room.roomsId}"></div>
                        </c:forEach>

                        <script>
                            function myroomlistselect(roomsid) {
                                $('.dis').css('display', 'none');
                                $
                                    .ajax({
                                        url: '${pageContext.request.contextPath}/hostpage/getreser?roomsId='
                                            + roomsid,
                                        type: 'get',
                                        datatype: 'json',
                                        success: function (data) {
                                            var str = '<div class="col-md-3 p-2" style=" background-color: #EEEEEE" ><b>예약자</b></div><div class="col-md-4 p-2" style="background-color: #EEEEEE"><b>예약 일시</b></div><div class="col-md-2 p-2" style=" background-color: #EEEEEE"><b> 결제 금액</b> </div><div class="col-md-3 p-2" style=" background-color: #EEEEEE"><b> 취소</b> </div>';
                                            var today = new Date();
                                            today.setDate(today
                                                .getDate() + 5);
                                            $(data)
                                                .each(
                                                    function (
                                                        key,
                                                        value) {
                                                        var year = value.checkIn
                                                            .substr(
                                                                0,
                                                                4);
                                                        var month = value.checkIn
                                                            .substr(
                                                                5,
                                                                2);
                                                        var day = value.checkIn
                                                            .substr(
                                                                8,
                                                                2);
                                                        var date = new Date(
                                                            year,
                                                            month,
                                                            day);
                                                        date
                                                            .setMonth(date
                                                                .getMonth() - 1);
                                                        str += '<div class="col-md-3 p-2" style="margin-bottom: 10px"><img style="width:30px; height:30px" src="http://13.209.99.134:8080/imgserver/resources/img/userphoto/' + value.userPhoto + '" alt="" /> '
                                                            +value.userName
                                                            + '('
                                                            + value.userId
                                                            + ') </div> <div class="col-md-4 p-2">'
                                                            + value.checkIn
                                                                .substring(
                                                                    0,
                                                                    10)
                                                            + ' ~ '
                                                            + value.checkOut
                                                                .substring(
                                                                    0,
                                                                    10)
                                                            + '</div><div class="col-md-2 p-2">'
                                                            + value.price
                                                            +'</div>';
                                                        if (date > today) {
                                                            str += '<div class="col-md-3 p-2"><button class="btn" onclick="rescancle('
                                                                + value.reservationNum
                                                                + ','+roomsid+')">예약 취소</button></div>';
                                                        } else {
                                                            str += '<div class="col-md-3 p-2"></div>';
                                                        }

                                                    });
                                            $('#myroom' + roomsid)
                                                .html(str);
                                            $('#myroom' + roomsid).css(
                                                'display', 'flex');
                                            $('#mymy' + roomsid).removeAttr("onclick");
                                            $('#mymy' + roomsid).attr("onclick", "closeee(" + roomsid + ")")

                                        },
                                        error: function () {
                                            alert(error);
                                        }
                                    });

                            }

                            function closeee(roomsid) {
                                $('.dis').css('display', 'none');
                                $('#mymy' + roomsid).removeAttr("onclick");
                                $('#mymy' + roomsid).attr("onclick", "myroomlistselect(" + roomsid + ")")
                            }

                            function rescancle(reservationNum, roomsId) {
                                $
                                    .ajax({
                                        url: '${pageContext.request.contextPath}/hostpage/delreser?Idx='
                                            + reservationNum,
                                        type: 'get',
                                        datatype: 'json',
                                        success: function (data) {
                                            if(data==1){
                                                    myroomlistselect(roomsId);
                                            }
                                        },
                                        error: function () {
                                            alert(error);
                                        }
                                    });
                            }
                        </script>

                    </c:otherwise>
                </c:choose>
            </div>
            <div class="tab-pane fade" id="list-profi" role="tabpanel"
                 aria-labelledby="list-messages-list">
                <div id="llllist" class="row"></div>

                <script>
                    var pageeee=1;
                    function viewMyroomList() {
                        $('#llllist').html('');
                        str = '<div class="col-md-3"> <div class="card mb-3 box-shadow">'
                            + '<div class="card-body"> <p class="card-text" style="font-size: 3.0em; text-align: center; padding-top:70px; padding-bottom:70px" ><i class="fas fa-plus"></i> <br></p>'
                            + ' <div class="d-flex justify-content-between align-items-center"><small class="text-muted">'
                            + '  </small>'
                            + '<div class="btn-group">'
                            + '<a href="${pageContext.request.contextPath}/rooms/registerRooms"><button type="button" class="btn btn-sm btn-outline-secondary ml-1">new</button></a>'
                            + ' </div></div></div></div></div>';
                        var output = '';
                        // http://fruitdev.tistory.com/174
                        var queryString ='hostId=${loginUser.userId}&checkIn=&checkOut=&page='+pageeee;
                        /* $
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
                                        $('#llllist')
                                            .html(str);
                                    } else {
                                        for (i = 0; i < data.roomsList.length; i++) {

                                            output += '<div class="col-lg-3">';
                                            output += '<div class="card mb-3 box-shadow">';
                                            for(k=0; k<data.thumbnail.length; k++){
                                                if (data.roomsList[i].roomsId == data.thumbnail[k].roomsId) {
                                                    output += '<a href="${pageContext.request.contextPath}/rooms/viewRooms?roomsId='
                                                        + data.roomsList[i].roomsId;
                                                    output += '				&hostId='
                                                        + data.roomsList[i].hostId + '">';
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
                                                + '<br>￦';
                                            output += data.roomsList[i].price_weekdays
                                                    .toString().replace(
                                                    /\B(?=(\d{3})+(?!\d))/g,
                                                    ",")
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
                                            pageeee=data.paging.currentPageNo;
                                        } else {
                                            // console.log($('#page').val());
                                            pageeee=-1;
                                        }
                                        $('#llllist').html(str+output);

                                        // console.log(markers);
                                        // console.log('--- ajax ---');
                                    }
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
    								$('#llllist').html(str);
    							} else {
    								/* output += '<div class="container-fluid row content-row">'; */
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
    											+ '<br>￦';
    									output += data.roomsList[i].price_weekdays
    											.toString().replace(
    													/\B(?=(\d{3})+(?!\d))/g,
    													",")
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
    								$('#llllist').html(str+output);
    							}
    						},
    						error : function(error) {
    							console.log("error : " + error);
    						}
    					});

                    }

                    $(window).scroll(
                        function() {
                            if ($(window).scrollTop() == $(document).height()
                                - $(window).height()) {
                                // 마지막 페이지가 아닐 때
                                if ($('#page').val() != -1) {
                                    $('#page').val(+$('#page').val() + 1);
                                    viewMyroomList();
                                }
                            }
                        });//end of 무한스크롤
                </script>


            </div>
            <div class="tab-pane fade" id="list-profile" role="tabpanel"
                 aria-labelledby="list-profile-list">
                <div class="row" id="evalu">
                    <div class="col-12 row justify-content-center" id="noteval"
                         style="margin-bottom: 70px;"></div>
                    <div class="col-12 row justify-content-center" id="yeseval">
                    </div>

                </div>
                <script>
                    function eval() {
                        $('#noteval').html('');
                        $('#yeseval').html('');
                        var str1 = '<div class="col-md-9 p-3" ><h2>호스트님의 방을 사용한 회원들을 평가해주세요 !</h2></div>';
                        var str2 = '<div class="col-md-9 p-3" ><h2>평가 리스트</h2></div>';

                        $
                            .ajax({
                                url: '${pageContext.request.contextPath}/hostpage/eval',
                                type: 'get',
                                datatype: 'json',
                                success: function (data) {
                                    if (data[0].length != 0) {
                                        $(data[0])
                                            .each(
                                                function (key,
                                                          value) {
                                                    str1 += '<div class="col-md-9 row justify-content-center p-3" style="background-color: #EEEEEE; margin-bottom: 10px; border-radius: 15px">'
                                                        + '<div class="col-md-2" ><img width="80px" src="http://13.209.99.134:8080/imgserver/resources/img/userphoto/' + value.userPhoto + '"></div>'
                                                        + '<div class="col-md-8">'
                                                        + value.checkIn
                                                            .substr(
                                                                0,
                                                                10)
                                                        + ' ~ '
                                                        + value.checkOut
                                                            .substr(
                                                                0,
                                                                10)
                                                        + '<br>'
                                                        + value.roomsId
                                                        + '방을 이용한 사용자 '
                                                        + value.userName
                                                        + '('
                                                        + value.userId
                                                        + ')님을 평가해주세요!</div>'
                                                        + '<div class="col-md-2 pt-3"><button class="btn btn-success m-auto" onclick="writee('
                                                        + value.reservationNum
                                                        + ')">평가하기</button></div>'
                                                        + '  </div>'
                                                });

                                    } else {
                                        str1 += '<div class="col-md-9" style="text-align:center; font-weight: lighter; font-size: 1.2em; padding-top: 30px"> <i class="fas fa-exclamation-triangle">평가할 사용자가 없습니다!<div>'
                                    }
                                    if (data[1].length != 0) {

                                        $(data[1])
                                            .each(
                                                function (key,
                                                          value) {
                                                    str2 += '<div class="col-md-9 row justify-content-center p-3" style="background-color: #EEEEEE; margin-bottom: 10px; border-radius: 15px" >'
                                                        + '<div class="col-md-2" ><img width="100px" src="http://13.209.99.134:8080/imgserver/resources/img/userphoto/' + value.userPhoto + '"></div>'
                                                        + '<div class="col-md-8"><p>['
                                                        + value.reservationNum
                                                        + '] '
                                                        + value.checkIn
                                                            .substr(
                                                                0,
                                                                10)
                                                        + ' ~ '
                                                        + value.checkOut
                                                            .substr(
                                                                0,
                                                                10)
                                                        + '에 '
                                                        + value.roomsId
                                                        + '방을 이용한 사용자 '
                                                        + value.userName
                                                        + '('
                                                        + value.userId
                                                        + ')님을 평가했습니다.</p>'
                                                        + value.evaluationContent
                                                        + '<p style="text-align: right">'
                                                        + value.evaluationDate
                                                            .substr(
                                                                0,
                                                                10)
                                                        + '</p> </div>'
                                                        + '<div class="col-md-2 pt-3"><button class="btn btn-warning m-auto" onclick="moddiy('
                                                        + value.reservationNum
                                                        + ')">수정하기</button></div>'
                                                        + '</div>'

                                                });
                                    }
                                    $('#noteval').html(str1);
                                    $('#yeseval').html(str2);
                                },
                                error: function () {
                                    alert(error);
                                }
                            });

                    }

                    function writee(reservationNum) {
                        $(window).scrollTop(0);
                        $('#yeseval').html('');
                        $('#noteval').html('');
                        var str = '<div class="col-12 row justify-content-center"> <div class="col-md-7 form-group"><label for="evalcontent">예약번호 : '
                            + reservationNum
                            + '</label> '
                            + '<textarea class="form-control" rows="10" id="evalcontent"></textarea><input type="button" onclick="inserteval('
                            + reservationNum
                            + ')" class="form-control" value="작성하기"> </div></div>'
                        $('#noteval').html(str);
                    }

                    function moddiy(num) {
                        $(window).scrollTop(0);
                        $('#yeseval').html('');
                        $('#noteval').html('');
                        $
                            .ajax({
                                url: '${pageContext.request.contextPath}/hostpage/eval/select',
                                type: 'post',
                                data: {
                                    reservationNum: num
                                },
                                datatype: 'json',
                                success: function (data) {
                                    $('#yeseval').html('');
                                    $('#noteval').html('');
                                    var str = '<div class="col-12 row justify-content-center"> <div class="col-md-7 form-group"><label for="evalcontent">예약번호 : '
                                        + data.reservationNum
                                        + '</label> '
                                        + '<textarea class="form-control" rows="10" id="evalcontent" >'
                                        + data.evaluationContent
                                        + '</textarea><input type="button" onclick="realmodi('
                                        + data.reservationNum
                                        + ')" class="form-control" value="작성하기"> </div></div>'
                                    $('#noteval').html(str);
                                },
                                error: function () {
                                    alert(error);
                                }
                            });

                    }

                    function realmodi(num) {
                        var msg = $('#evalcontent').val();
                        if (msg != '') {
                            $
                                .ajax({
                                    url: '${pageContext.request.contextPath}/hostpage/eval/modi',
                                    type: 'post',
                                    data: {
                                        reservationNum: num,
                                        evaluationContent: msg
                                    },
                                    datatype: 'json',
                                    success: function (data) {
                                        eval();
                                    },
                                    error: function () {
                                        alert(error);
                                    }
                                });
                        } else {
                            eval();
                        }
                    }

                    function inserteval(num) {
                        var msg = $('#evalcontent').val();
                        if (msg != '') {
                            $
                                .ajax({
                                    url: '${pageContext.request.contextPath}/hostpage/eval/write',
                                    type: 'post',
                                    data: {
                                        reservationNum: num,
                                        evaluationContent: msg
                                    },
                                    datatype: 'json',
                                    success: function (data) {
                                        eval();
                                    },
                                    error: function () {
                                        alert(error);
                                    }
                                });
                        } else {
                            eval();
                        }
                    }
                </script>

            </div>
            <div class="tab-pane fade" id="list-settings" role="tabpanel"
                 aria-labelledby="list-settings-list">
                <div id="withdraw">${loginUser.userId}님, 아직 호스팅 중인 방이 없으시네요!</div>
                <script>
                    function withdraw() {
                        html = '';
                        $
                            .ajax({
                                /* async: false, */
                                url: '${pageContext.request.contextPath}/reservation/withdraw',
                                type: 'POST',
                                datatype: 'json',
                                data: {
                                    "userId": "${loginUser.userId}"
                                },
                                success: function (data) {
                                    html += '<input id="checkPrice" type="hidden" value = "' + data.point + '"/>'
                                    html += '<div class="alert alert-success pt-3" role="alert">'
                                    html += '<h1 class="alert-heading text-center">인출 가능 금액 : '
                                        + data.point
                                            .toString()
                                            .replace(
                                                /\B(?=(\d{3})+(?!\d))/g,
                                                ",")
                                        + '원</h1>';
                                    html += '<hr><h4>예약 후 대금 수령</h4>게스트가 예약하면 해당 금액이 적립됩니다.<br>'
                                    html +=	'적립된 금액은 페이팔, 계좌 입금 또는 기타 대금 수령 방법으로 인출이 가능합니다!<br>'
                                    html += '</div>'
                                    // html += '<h2>인출 금액 :'
                                    html += '<div class="form-row">'
                                    // html += '<label for="pricee" class="col-12">인출 금액</label>'
                                    html += '<div class="input-group input-group-lg">'
                                    html += '<div class="input-group-prepend">'
                                   	html += '<span class="input-group-text" id="inputGroup-sizing-lg">￦</span>'
                                   	html += '</div>'
                                    html += '<input style="text-align : right;" aria-label="\\" aria-describedby="inputGroup-sizing-sm" class="col-6 form-control" id="pricee" type="text" numberonly="true"/>'
                                    html += '<div class="input-group-prepend">'
                                    html += '<button onclick="maxWithdraw()" class="btn btn-success" type="button" style="border-top-right-radius: 0.3em !important; border-bottom-right-radius: 0.3em !important;">인출하기</button></h2>';
                                   	html += '</div>'
                                    html += '</div>'
                                    html += '</div>'
                                    $('#withdraw').html(html);
                                }
                            });
                    }

                    $(document).on("keyup", "input:text[numberOnly]", function () {
                        $(this).val($(this).val().replace(/[^0-9]/gi, ""));

                        if (Number($('#pricee').val()) > Number($('#checkPrice').val())) {
                            $('#pricee').val($('#checkPrice').val());
                        }
                    });

                    function maxWithdraw() {
                        if ($('#pricee').val() == "") {
                            alert("금액이 입력되지 않았습니다. 다시 확인해 주세요.");
                        } else {
                            $('#pricee').val($('#pricee').val().replace(/[^0-9]/gi, ""));
                            $.ajax({
                                async: false,
                                url: '${pageContext.request.contextPath}/reservation/withdrawDo',
                                type: 'GET',
                                data: {
                                    "price": $('#pricee').val(),
                                    "userId": "${loginUser.userId}"
                                },
                                success: function (data) {
                                    if (data == 1) {
                                        alert("성공적으로 인출이 완료되었습니다.");
                                    } else if (data == 0) {
                                        alert("다시 시도 해주세요.")
                                    }
                                }
                            });
                            withdraw();
                        }
                    }

                </script>


                <div class="jus"></div>
            </div>
            <div class="tab-pane fade" id="list-settings2" role="tabpanel"
                 aria-labelledby="list-settings-li">
                <div class="row my-3 justify-content-between">
                    <div class="col-1"></div>
                    <div class="col-4">
                        <h4 id="id11"></h4>
                    </div>
                    <div class="col-2"></div>
                    <div class="col-2">
                        <select class="form-control" id="roomselectlist"
                                onchange="totall()">

                        </select>
                    </div>
                    <div class="col-1"></div>
                </div>
                <div id="stchart" style="visibility: hidden">
                    <div class="row my-2 justify-content-center">
                        <div class="col-md-9 py-1">
                            <h4 id="id22"></h4>
                            <div class="card">
                                <div class="card-body">
                                    <canvas id="chLine"></canvas>
                                </div>
                            </div>
                        </div>

                    </div>
                    <div class="row py-2 justify-content-center">
                        <div class="col-md-3 py-1">
                            <div class="card">
                                <div class="card-body">
                                    <canvas id="chDonut1"></canvas>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3 py-1">
                            <div class="card">
                                <div class="card-body">
                                    <canvas id="chDonut2"></canvas>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3 py-1">
                            <div class="card">
                                <div class="card-body">
                                    <canvas id="chDonut3"></canvas>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row justify-content-center">
                        <div class="col-md-9">
                            <p id="id33"></p>

                        </div>

                    </div>
                </div>
                <script>
                    function selectroom() {
                        var str = '<option >방 선택</option>';
                        $
                            .ajax({
                                url: '${pageContext.request.contextPath}/hostpage/getlist',
                                type: 'GET',
                                datatype: 'json',
                                success: function (data) {
                                    $(data)
                                        .each(
                                            function (key, value) {
                                                str += '<option value="' + value + '">'
                                                    + value
                                                    + ' 방</option>'
                                            });
                                    $('#roomselectlist').html(str);
                                }
                            });

                    }

                    function totall() {
                        var impossible = new Array();
                        var counttt = new Array(12);
                        var nextcounttt= new Array(12);
                        var pricemonth = new Array(12);
                        var nextmonth = new Array(12);
                        var datee = new Date();
                        var room = $('#roomselectlist').val();

                        var lastDay1 = (new Date(datee.getFullYear(), datee
                            .getMonth() - 1, 0)).getDate();
                        var lastDay2 = (new Date(datee.getFullYear(), datee
                            .getMonth(), 0)).getDate();
                        if(datee.getMonth()==11){
                            var lastDay3 = (new Date(datee.getFullYear()+1, 0, 0)).getDate();
                        } else{
                            var lastDay3 = (new Date(datee.getFullYear(), datee
                                .getMonth() + 1, 0)).getDate();
                        }

                        var totalday = 0;
                        var totalprice = 0;
                        var realtotalprice = 0;
                        $('#id11').text('' + room + '방의 매출 통계입니다');
                        $('#id22').text('이번년도 매출');
                        for (var i = 0; i < counttt.length; i++) {
                            counttt[i] = 0;
                            pricemonth[i] = 0;
                            nextmonth[i]=0;
                            nextcounttt[i]=0;
                        }
                        $
                            .ajax({
                                url: '${pageContext.request.contextPath}/hostpage/getprice',
                                async: false,
                                type: 'GET',
                                datatype: 'json',
                                success: function (data) {
                                    realtotalprice = data;
                                    $
                                        .ajax({
                                            async: false,
                                            url: '${pageContext.request.contextPath}/reservation/possible',
                                            type: 'GET',
                                            datatype: 'json',
                                            data: {
                                                "roomsId": room
                                            },
                                            success: function (data) {
                                                $(data)
                                                    .each(
                                                        function (
                                                            key,
                                                            value) {
                                                            day = value.day;
                                                            inyy = Number(value.checkIn
                                                                .substring(
                                                                    0,
                                                                    4));
                                                            inmm = Number(value.checkIn
                                                                .substring(
                                                                    5,
                                                                    7));
                                                            indd = Number(value.checkIn
                                                                .substring(
                                                                    8,
                                                                    10));
                                                            if (datee
                                                                .getFullYear() == inyy) {
                                                                pricemonth[inmm - 1] = pricemonth[inmm - 1]
                                                                    + value.price;
                                                            } else if(datee.getFullYear()+1 == inyy){
                                                                nextmonth[inmm - 1] = nextmonth[inmm - 1]
                                                                    + value.price;
                                                            }
                                                            totalprice = totalprice
                                                                + value.price;
                                                            if (inmm != 12) {
                                                                for (i = 0; i < day; i++) {
                                                                    impossible
                                                                        .push(new Date(
                                                                            inyy,
                                                                            inmm - 1,
                                                                            indd
                                                                            + i));
                                                                    totalday++;
                                                                }
                                                            } else if (inmm == 12) {
                                                                for (i = 0; i < day; i++) {
                                                                    impossible
                                                                        .push(new Date(
                                                                            inyy + 1,
                                                                            0 - 1,
                                                                            indd
                                                                            + i));
                                                                    totalday++;
                                                                }
                                                            }
                                                        });
                                                $(impossible)
                                                    .each(
                                                        function (
                                                            key,
                                                            value) {
                                                            if (value
                                                                .getFullYear() == datee
                                                                .getFullYear()) {
                                                                counttt[value
                                                                    .getMonth()] = counttt[value
                                                                    .getMonth()] + 1;
                                                            }else if (value.getFullYear() == (datee.getFullYear()+1)) {
                                                                nextcounttt[value
                                                                    .getMonth()] = counttt[value
                                                                    .getMonth()] + 1;
                                                            }

                                                        });
                                                lastDay1 = counttt[datee
                                                        .getMonth() - 1]
                                                    / lastDay1
                                                    * 100;
                                                lastDay2 = counttt[datee
                                                        .getMonth()]
                                                    / lastDay2
                                                    * 100;
                                                if(datee.getMonth()==11){
                                                    lastDay3 = nextcounttt[0]
                                                        / lastDay3
                                                        * 100;

                                                }else{
                                                    lastDay3 = counttt[datee
                                                            .getMonth() + 1]
                                                        / lastDay3
                                                        * 100;

                                                }

                                                $('#id33')
                                                    .html(
                                                        '${sessionScope.loginUser.userName}의 총매출은 '
                                                        + realtotalprice
                                                        + '원 입니다.<br/>'
                                                        + room
                                                        + '번 방의 전체 매출은 '
                                                        + totalprice
                                                        + '원 입니다<br/>'
                                                        + room
                                                        + '번 방의 총 예약일수는 '
                                                        + totalday
                                                        + '일 입니다.');
                                                $('#stchart')
                                                    .css(
                                                        'visibility',
                                                        'visible')
                                            }
                                        });
                                }
                            });
                        /* chart.js chart examples */
                        // chart colors
                        var colors = ['#007bff', '#28a745', '#333333',
                            '#c3e6cb'];
                        /* large line chart */
                        var chLine = document.getElementById("chLine");
                        var chartData = {
                            labels: ["1", "2", "3", "4", "5", "6", "7",
                                "8", "9", "10", "11", "12"],
                            datasets: [{
                                data: [pricemonth[0], pricemonth[1],
                                    pricemonth[2], pricemonth[3],
                                    pricemonth[4], pricemonth[5],
                                    pricemonth[6], pricemonth[7],
                                    pricemonth[8], pricemonth[9],
                                    pricemonth[10], pricemonth[11]],
                                backgroundColor: colors[3],
                                borderColor: colors[1],
                                borderWidth: 4,
                                pointBackgroundColor: colors[1]
                            }]
                        };
                        if (chLine) {
                            new Chart(chLine, {
                                type: 'line',
                                data: chartData,
                                options: {
                                    scales: {
                                        yAxes: [{
                                            ticks: {
                                                beginAtZero: false
                                            }
                                        }]
                                    },
                                    legend: {
                                        display: false
                                    },
                                    responsive: true
                                }
                            });
                        }
                        /* 3 donut charts */
                        var donutOptions = {
                            cutoutPercentage: 85,
                            legend: {
                                position: 'bottom',
                                padding: 5,
                                labels: {
                                    pointStyle: 'circle',
                                    usePointStyle: true
                                }
                            }
                        };
                        // donut 1
                        var chDonutData1 = {
                            labels: [(datee.getMonth()) + '월 예약률'],
                            datasets: [{
                                backgroundColor: colors.slice(2, 3),
                                borderWidth: 0,
                                data: [lastDay1, 100 - lastDay1]
                            }]
                        };
                        var chDonut1 = document.getElementById("chDonut1");
                        if (chDonut1) {
                            new Chart(chDonut1, {
                                type: 'pie',
                                data: chDonutData1,
                                options: donutOptions
                            });
                        }
                        // donut 2
                        if(datee.getMonth()==11){
                            var lastmon = 1;
                        }else{
                            var lastmon = datee.getMonth()+1;
                        }
                        var chDonutData2 = {
                            labels: [(datee.getMonth()+1)  + '월 예약률'],
                            datasets: [{
                                backgroundColor: colors.slice(0, 1),
                                borderWidth: 0,
                                data: [lastDay2, 100 - lastDay2]
                            }]
                        };
                        var chDonut2 = document.getElementById("chDonut2");
                        if (chDonut2) {
                            new Chart(chDonut2, {
                                type: 'pie',
                                data: chDonutData2,
                                options: donutOptions
                            });
                        }
                        // donut 3
                        var chDonutData3 = {
                            labels: [lastmon + '월 예약률'],
                            datasets: [{
                                backgroundColor: colors.slice(3, 4),
                                borderWidth: 0,
                                data: [lastDay3, 100 - lastDay3]
                            }]
                        };
                        var chDonut3 = document.getElementById("chDonut3");
                        if (chDonut3) {
                            new Chart(chDonut3, {
                                type: 'pie',
                                data: chDonutData3,
                                options: donutOptions
                            });
                        }
                    }
                </script>
            </div>
        </div>

    </div>
</div>

</body>
<html>