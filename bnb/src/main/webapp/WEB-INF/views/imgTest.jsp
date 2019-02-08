<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Mypage</title>
    <%@ include file="/resources/common/includeHead.jsp"%>
</head>
<body style="background-color: #EEEEEE;">
<%@ include file="/resources/common/Navbar.jsp"%>
<form method="post" id="heee" enctype="multipart/form-data">
<input type="text" name="userId" value="park">
<input type="file" name="photoFile">
    <input type="hidden" name="userPhoto">

</form>

<button id="uploadbutton">전송</button>
<div id="dd"></div>
<script>
    //crossDomain 해결코드
/*    $(function() {
        $.ajaxPrefilter(function(options, originalOptions, jqXHR) {
            if (options.crossDomain && jQuery.support.cors) {
                options.url = "https://cors-anywhere.herokuapp.com/" + options.url;
            }
        });
    });*/

    $(function(){
        $("#uploadbutton").click(function(){
            var form = $('#heee')[0];
            var formData = new FormData(form);
            $.ajax({
                url: 'http://13.209.99.134:8080/imgserver/upload/userPhoto',
                processData: false,
                contentType: false,
                datatype : 'JSON',
                data: formData,
                type: 'POST',
                success: function(result){
                    console.log(result);
                    $('#dd').html('<img src="http://13.209.99.134:8080/imgserver/resources/img/userphoto/'+result+'">')
                    alert("업로드 성공!!");

                }
            });
        });
    })



</script>


</body>
</html>
