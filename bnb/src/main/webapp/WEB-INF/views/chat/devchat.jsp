<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <%@ include file="/resources/common/includeHead.jsp"%>
</head>
<body id="mainback">
<%@ include file="/resources/common/Navbar.jsp"%>

<!-- 채팅 내용 -->
<div class="col-12">
    <div class="col-11"
         style="margin: 0 auto; border: 1px solid #01D1FE; height: 400px; border-radius: 10px; overflow:scroll"
         id="chatArea">
        <div id="chatMessageArea" style="margin-top : 10px; margin-left:10px;"></div>
    </div>
</div>

<c:forEach var="item" items="${lists}">
    <script>
        if ('${item.userName}' == '${sessionScope.loginUser.userName}') {
            $("#chatMessageArea").append("나 : ${item.message} <br>")
        } else {
            $("#chatMessageArea").append("${item.userName} : ${item.message} <br>")
        }
        var chatAreaHeight = $("#chatArea").height();
        var maxScroll = $("#chatMessageArea").height() - chatAreaHeight;
        $("#chatArea").scrollTop(maxScroll);

    </script>

</c:forEach>

<!-- 채팅 입력창 -->
<div class="col-12" style="margin-top: 20px; margin-bottom: 15px;">
    <div class="col-12" style="float: left">
        <textarea class="form-control" style="border: 1px solid #01D1FE; height: 65px; float: left; width: 80%" placeholder="Enter ..." id="message1"></textarea>
        <span
                style="float: right; width: 18%; height: 65px; text-align: center; background-color: #01D1FE; border-radius: 5px;">
				<a
                        style="margin-top: 30px; text-align: center; color: white; font-weight: bold;" id="sendBtn1"><br>전송</a>
			</span>
    </div>

</div>

<script type="text/javascript">
    connect();

    function connect() {
        sock = new SockJS('${pageContext.request.contextPath}/devchat');
        sock.onopen = function () {
            console.log('open');
        };
        sock.onmessage = function (evt) {
            var data = evt.data;
            console.log(data);
            var obj = JSON.parse(data);
            console.log(obj);
            appendMessage2(obj.message, obj.userName);
        };
    }


    function send2() {
        var msg = $("#message1").val();
        console.log(msg)
        if (msg != "") {
            message = {};
            message.message = $("#message1").val()
            message.userName = '${loginUser.userName}'

        }
        console.log(JSON.stringify(message))//고정값이여야함
        sock.send(JSON.stringify(message));
        $("#message1").val("");
    }


    function appendMessage2(msg, aa) {
        console.log(aa);
        if (msg == '') {
            return false;
        } else {

            if ( aa == '${sessionScope.loginUser.userName}') {
                $("#chatMessageArea").append("나 : "+msg+"<br>");
            } else {
                $("#chatMessageArea").append(aa+" : "+msg+"<br>")
            }


            var chatAreaHeight = $("#chatArea").height();
            var maxScroll = $("#chatMessageArea").height() - chatAreaHeight;
            $("#chatArea").scrollTop(maxScroll);

        }
    }

    $(document).ready(function () {
        $('#message1').keypress(function(event) {
            var keycode = (event.keyCode ? event.keyCode : event.which);
            if (keycode == '13') {
                send2();
            }
            event.stopPropagation();
        });
        $('#message1').keyup(function(event) {
            var keycode = (event.keyCode ? event.keyCode : event.which);
            if (keycode == '13') {
                $("#message1").val("");
            }
            event.stopPropagation();
        });

        $('#sendBtn1').click(function () {
            send2();
        });
        /* $('#enterBtn').click(function() { connect(); }); $('#exitBtn').click(function() { disconnect(); }); */
    });
</script>

</body>
</html>

