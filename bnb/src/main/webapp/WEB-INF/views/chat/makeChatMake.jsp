
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>

    <script
            src="https://code.jquery.com/jquery-3.3.1.js"
            integrity="sha256-2Kok7MbOyxpgUVvAk/HJ2jigOSYS2auK4Pfzbm7uH60="
            crossorigin="anonymous"></script>
    <script type="text/javascript"
            src="../../../resources/js/sockjs.js"></script>
    <%@ include file="/resources/common/includeHead.jsp"%>
</head>
<body>
<%@ include file="/resources/common/Navbar.jsp"%>
<div class="row justify-content-center">
    <div class="col-3 form-group" style="text-align: center">
    <p> 호스트에게 문의 사항이 있으시면 적어주세요!</p>
    <textarea class="form-control" cols="50" rows="10" placeholder="문의 사항을 써주세요!" id="messageeeeee"></textarea>
    <button class="form-control" onclick="created()">문의 하기</button>
    </div>

    </div>
<script>
    connect();
    function connect() {
        sock12 = new SockJS('${pageContext.request.contextPath}/chat');
        sock12.onopen = function () {
            console.log('open');
        };
    }

    function created() {
        var msg = $("#messageeeeee").val();
        if (msg != "") {
            message = {};
            message.messagecontent = $("#messageeeeee").val()
            message.hostId = '${ChatRoomInfo.hostId}'//고정값이여야함
            message.userId = '${sessionScope.loginUser.userId}'//고정값이여야함
            message.roomsId = '${ChatRoomInfo.roomsId}'//고정값이여야함
            message.sender = '${sessionScope.loginUser.userId}'
        }
        sock12.send(JSON.stringify(message));
        location.href='${pageContext.request.contextPath}'+'/';
    }
</script>
</body>
</html>
