<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<%@ include file="/resources/common/includeHead.jsp" %>
</head>
<body id="mainback">
<%@ include file="/resources/common/Navbar.jsp" %>
<div id="frame" style="position: absolute; right: 0px; bottom: 0px;">
    <div id="sidepanel">
        <div id="profile">
            <div class="wrap">
                <%--${loginUser.userPhoto}로 바껴야함--%>
                <img id="profile-img" src="${pageContext.request.contextPath}/resources/images/userphoto/nopic.jpg" class="online" alt=""/>
                <p>${loginUser.userName}</p>
            </div>
        </div>
        <div id="search1">
            <i class="fa fa-search" aria-hidden="true"></i>
            <input type="text" placeholder="Search contacts..."/>
        </div>
        <div id="contacts">
            <ul>
                <c:forEach var="list" items="${chatRoomList}">
                            <c:choose>
                            <c:when test="${list.userId eq loginUser.userId}">
                                <li class="contact" onclick="getDBMessage('${list.userId}','${list.hostId}','${list.roomsId}','${list.hostName}','${list.hostPhoto}')">
                                <div class="wrap">
                                <c:if test="${list.readCk == 'F' and list.receive=='U'}">
                                    <span class="contact-status online"></span>
                                </c:if>
                                <%--${list.hostPhoto}로 바꿔야함--%>
                            <img src="${pageContext.request.contextPath}/resources/images/userphoto/nopic.jpg" alt=""/>
                            <div class="meta">
                                    <p class="name">${list.hostName}( ${list.roomsId} )</p>
                                    <p class="preview"><c:choose><c:when test="${list.receive eq 'U'}">you</c:when><c:otherwise>me</c:otherwise></c:choose> : ${list.messagecontent}</p>
                                </c:when>
                                <c:otherwise>
                                    <li class="contact" onclick="getDBMessage('${list.userId}','${list.hostId}','${list.roomsId}','${list.userName}','${list.userPhoto}')">
                                    <div class="wrap">
                                    <c:if test="${list.readCk == 'F'and list.receive=='H'}">
                                        <span class="contact-status online"></span>
                                    </c:if>
                                    <%--${list.userPhoto}로 바껴야함--%>
                                <img src="${pageContext.request.contextPath}/resources/images/userphoto/nopic.jpg" alt=""/>
                                <div class="meta">
                                    <p class="name">${list.userName}( ${list.roomsId} )</p>
                                    <p class="preview"><c:choose><c:when test="${list.receive eq 'U'}">you</c:when><c:otherwise>me</c:otherwise></c:choose> : ${list.messagecontent}</p>
                                </c:otherwise>
                            </c:choose>
                            </div>
                        </div>
                    </li>
                </c:forEach>
            </ul>
        </div>

    </div>
    <div class="content">
        <div class="contact-profile">
            <img id="con" src="" alt=""/>
            <p id="conname"></p>
            <div class="social-media">
                <i class="fa fa-instagram" aria-hidden="true" style="visibility: hidden"></i>
                <i class="fas fa-times-circle" aria-hidden="true"></i>
            </div>
        </div>
        <div class="messages">
            <ul>
            </ul>
        </div>
        <div class="message-input">
            <div class="wrap">
                <input type="text" id="message" placeholder="Write your message..."/>
                <button class=""><i class="fa fa-paper-plane" aria-hidden="true"></i></button>
            </div>
        </div>
    </div>
</div>

<script>

    $(".expand-button").click(function() {
        $("#profile").toggleClass("expanded");
        $("#contacts").toggleClass("expanded");
    });

    $("#status-options ul li").click(function() {
        $("#profile-img").removeClass();
        $("#status-online").removeClass("active");
        $("#status-away").removeClass("active");
        $("#status-busy").removeClass("active");
        $("#status-offline").removeClass("active");
        $(this).addClass("active");

        if($("#status-online").hasClass("active")) {
            $("#profile-img").addClass("online");
        } else if ($("#status-away").hasClass("active")) {
            $("#profile-img").addClass("away");
        } else if ($("#status-busy").hasClass("active")) {
            $("#profile-img").addClass("busy");
        } else if ($("#status-offline").hasClass("active")) {
            $("#profile-img").addClass("offline");
        } else {
            $("#profile-img").removeClass();
        };

        $("#status-options").removeClass("active");
    });



    $(".messages").animate({scrollTop: $('.messages')[0].scrollHeight}, "fast");

    function getDBMessage(userId, hostId, roomsId,name,photo){
        //photo로 바껴야함
        $('#con').attr('src','${pageContext.request.contextPath}/resources/images/userphoto/nopic.jpg');
        $('#conname').text(name);
        $('.messages ul').text('');
       messagehostId=hostId;//고정값이여야함
        messageuserId=userId;//고정값이여야함
         messageroomsId=roomsId;
        $.ajax({
            url: '${pageContext.request.contextPath}/chat/list/message?roomsId=' + roomsId + '&hostId=' + hostId + '&userId=' + userId,
            type: 'get',
            datatype: 'json',
            success: function (data) {
                $(data).each(function (key, value){
                    if ((value.userId == '${sessionScope.loginUser.userId}' && value.receive == 'H') || (value.hostId == '${sessionScope.loginUser.userId}' && value.receive == 'U')) {
                        $('<li class="replies"><p>' +value.messagecontent + '</p></li>').appendTo($('.messages ul'));
                       // $('<li>' + getTimeStamp(value.messageDate) + '</li>').appendTo($('.messages ul'));
                        $('.message-input input').val(null);
                        $('.contact.active .preview').html('<span>me : </span>' + value.messagecontent);
                    } else {
                        $('<li class="sent"><img src="'+ '${pageContext.request.contextPath}/resources/images/userphoto/nopic.jpg' +'" alt="" /><p>' + value.messagecontent + '</p></li>').appendTo($('.messages ul'));
                     //   $('<li>' + getTimeStamp(value.messageDate) + '</li>').appendTo($('.messages ul'));
                        $('.message-input input').val(null);
                        $('.contact.active .preview').html('<span>You : </span>' +value.messagecontent);
                    }
                });
                $(".messages").animate({scrollTop: $('.messages')[0].scrollHeight}, "fast");
             /*   $(".messages").animate({scrollTop: $(document).height()}, "fast");*/
            },
            error: function () {
                alert(error);
            }
        });
    }

    $("#profile-img").click(function () {
        $("#status-options").toggleClass("active");
    });

    connect();

    function connect() {
        sock = new SockJS('${pageContext.request.contextPath}/chat');
        sock.onopen = function () {
            console.log('open');
        };
        sock.onmessage = function (evt) {
            console.log('소캣을 왜 못받니')
            var data = evt.data;
            var obj = JSON.parse(data);
            console.log(obj);
            console.log('들어와라');
            appendMessage(obj);
        };
    }
var messagehostId=null;
    var messageuserId=null;
    var messageroomsId=null;
    function send() {
        console.log('보냈니');
        var msg = $("#message").val();
        console.log(msg);
        if (msg != "") {
            message = {};
            message.messagecontent = $("#message").val()
            message.hostId = messagehostId//고정값이여야함
            message.userId = messageuserId//고정값이여야함
            message.roomsId = messageroomsId//고정값이여야함
            message.sender = '${sessionScope.loginUser.userId}'
        }
        console.log('진짜보냄');
        sock.send(JSON.stringify(message));
        console.log('리얼로다가');
        $("#message").val("");
    }

    function appendMessage(obj) {
        console.log('들어와라2');
        console.log(obj);
        message = $("#message").val();

        if (obj.userId == messageuserId && obj.hostId == messagehostId && obj.roomsId == messageroomsId) {
            if (obj.messagecontent == '') {
                return false;
            } else {
                if (obj.sender == '${sessionScope.loginUser.userId}') {
                    $('<li class="replies"><p>' + obj.messagecontent + '</p></li>').appendTo($('.messages ul'));
                  //  $('<li>' + getTimeStamp(obj.messageDate) + '</li>').appendTo($('.messages ul'));
                    $('.message-input input').val(null);
                    $('.contact.active .preview').html('<span>me : </span>' + obj.messagecontent);
                } else {
                    //$('#con').attr('src')로 수정해야댐
                    $('<li class="sent"><img src="${pageContext.request.contextPath}/resources/images/userphoto/nopic.jpg" alt="" /><p>' + obj.messagecontent + '</p></li>').appendTo($('.messages ul'));
                  //  $('<li>' + getTimeStamp(obj.messageDate) + '</li>').appendTo($('.messages ul'));
                    $('.message-input input').val(null);
                    $('.contact.active .preview').html('<span>You : </span>' + obj.messagecontent);
                }

                $(".messages").animate({scrollTop: $(document).height()}, "fast");
            }
            $(".messages").animate({scrollTop: $('.messages')[0].scrollHeight}, "fast");
            $.ajax({
                url: '${pageContext.request.contextPath}/chat/list/ck?roomsId=' + obj.roomsId + '&hostId=' + obj.hostId + '&userId=' + obj.userId,
                type: 'get',
                datatype: 'json',
                success: function (data) {
                    var cnt = 0;
                    for (var i = 1; i < 5; i++) {
                        if ($('#list' + i).text() == '') {
                            cnt++
                        }
                    }
                    if (cnt == 0) {
                        $('#jchannotice').css('display', 'inline');
                    }
                },
                error: function () {
                    alert(error);
                }
            });
        }
    };

    $(document).ready(function () {
        $('.submit').click(function () {
            send();
        });

        $('#message').keypress(function (event) {
            var keycode = (event.keyCode ? event.keyCode : event.which);
            if (keycode == '13') {
                send();
            }
            event.stopPropagation();
        });
        $('#message').keyup(function (event) {
            var keycode = (event.keyCode ? event.keyCode : event.which);
            if (keycode == '13') {
                $("#message").val("");
            }
            event.stopPropagation();
        });
    });

    //# sourceURL=pen.js
</script>


<script>

    function getTimeStamp(datea) {
        var d = null;

        if (datea) {
            d = new Date(datea);
        } else {
            d = new Date();
        }
        var s =
            leadingZeros(d.getFullYear(), 4) + '-' +
            leadingZeros(d.getMonth() + 1, 2) + '-' +
            leadingZeros(d.getDate(), 2) + ' ' +
            leadingZeros(d.getHours(), 2) + ':' +
            leadingZeros(d.getMinutes(), 2);
        return s;
    }

    function leadingZeros(n, digits) {
        var zero = '';
        n = n.toString();

        if (n.length < digits) {
            for (i = 0; i < digits - n.length; i++)
                zero += '0';
        }
        return zero + n;
    }
</script>

</body>
</html>