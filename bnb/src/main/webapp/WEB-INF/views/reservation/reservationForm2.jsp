<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <title>방 예약하기</title>
        <link rel="stylesheet" href="resources/css/style-umki.css">
        <script src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
        <script src="//ajax.googleapis.com/ajax/libs/jqueryui/1.11.1/jquery-ui.min.js"></script>
        <link rel="stylesheet" href="https://code.ionicframework.com/ionicons/2.0.1/css/ionicons.min.css" />


        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">

        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
    </head>

    <body class="umkibody">
        <form method="post">
            <div class="wrapperr">
                <input type="text" id="datepicker" placeholder=" 체크인 " readonly="true" /> <i class="ion-calendar"></i>
            </div>
            <div class="wrapperr">
                <input type="text" id="return" placeholder=" 체크아웃 " readonly="true">
                <i class="ion-calendar"></i>
            </div>
            <div class="wrapperr">

                <div id="umki_people" data-toggle="modal" data-target="#my80sizeCenterModal">게스트 1명</div>

                <!-- 80%size Modal at Center -->
                <div class="modal modal-center fade" id="my80sizeCenterModal" tabindex="-1" role="dialog" aria-labelledby="my80sizeCenterModalLabel">
                    <div class="modal-dialog modal-80size modal-center" role="document">
                        <div class="modal-content modal-80size">
                            <div class="modal-header">
                                <h4 class="modal-title" id="myModalLabel">Modal 제목</h4>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                     </button>
                            </div>

                            <div class="modal-body">
                                <div class="umki-people">성인</div>
                                <div class="umki-number">
                                    <div onclick="minusAdult(this)" class="umki-pd umki-rad-m">-</div>
                                    <div class="umki-pd">1</div>
                                    <div onclick="plusAdult(this)" class="umki-pd umki-rad-p">+</div>
                                </div>   
                            </div>      
                            <div class="modal-body">
                                <div class="umki-people">어린이</div>
                                <div class="umki-number">
                                    <div onclick="minusChild(this)" class="umki-pd umki-rad-m">-</div>
                                    <div class="umki-pd">0</div>
                                    <div onclick="plusChild(this)" class="umki-pd umki-rad-p">+</div>
                                </div>
                            </div>
                            <div class="modal-body">   
                                <div class="umki-people">유아</div>
                                <div class="umki-number">
                                    <div onclick="minusLittle(this)" class="umki-pd umki-rad-m">-</div>
                                    <div class="umki-pd-little">0</div>
                                    <div onclick="plusLittle(this)" class="umki-pd umki-rad-p">+</div>
                                </div>
                            </div>

                            <div class="modal-footer">
                                <button onclick="people()" type="button" class="btn btn-default" data-dismiss="modal">확인</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>


            <input type="text" value="${loginUser.userId}" name="hostId"/>
			<input type="text" value="${loginUser.userId}" name="userId"/>
			<input type="text" value="${selectedRoom.roomsId}" name="roomsId"/>
			<input type="text" value="${selectedRoom.price_weekdays}" name="price"/>
            <input type="submit" value="예약하기" />

        </form>
        <script>
            var impossible = new Array();
            var re;
            var now = new Date();
            var adult = 1;
            var child = 0;
            var little = 0;
            
            var limit = ${selectedRoom.avail_adults+selectedRoom.avail_children};
            
            function plusAdult(obj){
               if(limit > adult+child){
                  $(obj).prev().text(++adult);
               }
            }
            function plusChild(obj){
               if(limit > adult+child){
                  $(obj).prev().text(++child);
               }
            }  
            function plusLittle(obj){
               if(5 > little){
                  $(obj).prev().text(++little);
               }
            }
            
            function minusAdult(obj){
               if(1 < $(obj).next().text()){
                  $(obj).next().text(--adult);
               }
            }
            function minusChild(obj){
               if(0 < $(obj).next().text()){
                  $(obj).next().text(--child);
               }
            }
            function minusLittle(obj){
               if(0 < $(obj).next().text()){
                  $(obj).next().text(--little);  
               }
            }
            function people(){
               var peopleNum = adult+child;
               $("#umki_people").text("게스트 "+peopleNum+"명");
               
               if(little >= 1){
                  $("#umki_people").text("게스트 "+peopleNum+"명, 유아 "+little+"명");
               }
            }

            function temp() {  
                $.ajax({
                    async: false,
                    url: '${pageContext.request.contextPath}/reservation/possible',
                    type: 'GET',   
                    datatype: 'json',
                    data: {
                        "roomsId": "${selectedRoom.roomsId}"   
                    },
                    success: function(data) {
                        $(data).each(
                            function(key, value) {
                                day = value.day;
                                inyy = Number(value.checkIn.substring(
                                    0, 4));
                                inmm = Number(value.checkIn.substring(
                                    5, 7));
                                indd = Number(value.checkIn.substring(
                                    8, 10));
                                if (inmm != 12) {
                                    for (i = 0; i < day; i++) {
                                        impossible.push(new Date(inyy,
                                            inmm - 1, indd + i));
                                    }
                                } else if (inmm == 12) {
                                    for (i = 0; i < day; i++) {
                                        impossible.push(new Date(
                                            inyy + 1, 0 - 1, indd +
                                            i));
                                    }
                                }
                            });
                    }
                });
            }

            temp();

            $(function() {
                $("#datepicker").datepicker();

            });

            $.datepicker.setDefaults({
                closeText: "닫기",
                prevText: "이전달",
                nextText: "다음달",
                currentText: "오늘",
                monthNames: ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월",
                    "9월", "10월", "11월", "12월"
                ],
                monthNamesShort: ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월",
                    "9월", "10월", "11월", "12월"
                ],
                dayNames: ["일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일"],
                dayNamesShort: ["일", "월", "화", "수", "목", "금", "토"],
                dayNamesMin: ["일", "월", "화", "수", "목", "금", "토"],
                weekHeader: "주",
                dateFormat: "yy-mm-dd",  
                firstDay: 0,
                isRTL: false,
                showMonthAfterYear: true,
                yearSuffix: "년"
            })

            $("#datepicker")
                .datepicker({
                    showAnim: 'drop',
                    minDate: 0,
                    onSelect: function(selected, event) {
                        window.parent.postMessage(selected, "*");
                    },
                    beforeShowDay: function(date) {

                        $(impossible)
                            .each(
                                function(key, value) {

                                    if (String(date) == String(value) &&
                                        (value
                                            .getFullYear() == now
                                            .getFullYear() &&
                                            value
                                            .getMonth() >= now
                                            .getMonth() && value
                                            .getDate() >= now
                                            .getDate())) {
                                        re = [false, "not", ""];
                                        return false;
                                    } else if (value
                                        .getFullYear() > now
                                        .getFullYear() &&
                                        String(date) == String(value)) {
                                        re = [false, "not", ""];
                                        return false;
                                    } else {
                                        re = [true];
                                        return true;
                                    }
                                });

                        return re;
                    },
                    onClose: function(selected) {
                        var year = Number(selected.substring(0, 4));
                        var month = Number(selected.substring(5, 7));
                        var date = Number(selected.substring(8, 10));
                        
                        var checkIn = new Date(year, month - 1, date);
                        var checkIn2 = new Date(year, month - 1,
                            date + 1);
                        console.log(typeof selected);

                        if (selected != "") {
                            $
                                .ajax({
                                    async: false,
                                    url: '${pageContext.request.contextPath}/reservation/possibleDuration',
                                    type: 'GET',
                                    data: {
                                        "checkIn": checkIn,
                                        "now": now,
                                        "roomsId": "${selectedRoom.roomsId}"
                                    },
                                    datatype: 'json',
                                    success: function(data) {
                                        $(data).each(
                                                function(
                                                    key,
                                                    value) {
                                                    $('#return').datepicker(
                                                        "option", "maxDate", "+" + value + "d");
                                                });
                                    }
                                });

                            $('#return').datepicker("option",
                                "minDate", checkIn2);
                        }
                        temp();

                    },

                    onChangeMonthYear: function() {
                        impossible = [];
                        temp();
                    }

                });

            $("#return").datepicker({
                showAnim: 'drop',
                minDate: new Date(),
                onSelect: function(selected, event) {

                    window.parent.postMessage(selected, "*");
                }

            });

        </script>
    </body>

    </html>