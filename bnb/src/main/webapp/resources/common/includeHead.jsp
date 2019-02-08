<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<meta charset="UTF-8">
<title>bitBnB</title>
<!-- font awesome -->
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.5.0/css/all.css">
<!-- jquery-3.3.1 -->
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<!-- bootstrap 4.1.3 -->
<!-- <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script> -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
<%--socket 도와주는 js--%>
<script type="text/javascript"
		src="${pageContext.request.contextPath}/resources/js/sockjs.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/toast.js"></script>

<%--채팅관련 --%>
<link rel="shortcut icon" type="image/x-icon" href="//production-assets.codepen.io/assets/favicon/favicon-8ea04875e70c4b0bb41da869e81236e54394d63638a1ef12fa558a4a835f1164.ico" />
<link rel="mask-icon" type="" href="//production-assets.codepen.io/assets/favicon/logo-pin-f2d2b6d2c61838f7e76325261b7195c27224080bc099486ddd6dccb469b8e8e6.svg" color="#111" />
<link rel="canonical" href="https://codepen.io/emilcarlsson/pen/ZOQZaV?limit=all&page=74&q=contact+" />
<link href='https://fonts.googleapis.com/css?family=Source+Sans+Pro:400,600,700,300' rel='stylesheet' type='text/css'>
<script src='//production-assets.codepen.io/assets/common/stopExecutionOnTimeout-b2a7b3fe212eaa732349046d8416e00a9dec26eb7fd347590fbced3ab38af52e.js'></script>
<script src="https://use.typekit.net/hoy3lrg.js"></script>
<script>try{Typekit.load({ async: true });}catch(e){}</script>
<link rel='stylesheet prefetch' href='https://cdnjs.cloudflare.com/ajax/libs/meyer-reset/2.0/reset.min.css'>

<%--통계관련--%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.5.0/Chart.js"></script>


<!-- <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"> -->
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/bootstrap.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/style-common.css?after">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/style-hyeon.css?after">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/style-jchan.css?after">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/style-jo.css?after">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/style-sol.css?after">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/style-umki.css?after">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/style-yun.css?after">
<%--이것은 알림창 띄우는 겁니다--%>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/jquery_toast.css"></link>


<!-- 구글 로그인 관련 -->
<script src="https://apis.google.com/js/platform.js" async defer></script>
<meta name = "google-signin-client_id"content = "173449746481-er69j4j9c3d2im90aprllmfr7jcpcs71.apps.googleusercontent.com">

<!-- 구글 폰트 -->
<link href="https://fonts.googleapis.com/css?family=Nanum+Brush+Script" rel="stylesheet">
