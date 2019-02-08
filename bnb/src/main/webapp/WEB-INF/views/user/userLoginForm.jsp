<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<%@ include file="/resources/common/includeHead.jsp"%>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://apis.google.com/js/platform.js" async defer></script>
<meta name = "google-signin-client_id"content = "173449746481-er69j4j9c3d2im90aprllmfr7jcpcs71.apps.googleusercontent.com">


</head>
<body>
	<%@ include file="/resources/common/Navbar.jsp"%>
	<div id="loginForm">
		<!-- Begin page content -->
		<main role="main" class="container">
		<div class="row justify-content-md-center">
			<div class="col col-md-6 col-lg-4">
				<form method="post">
					<label class="form-check-label mt-2 mb-2">아이디 :</label> <input
						type="email" name="userId" class="form-control"
						placeholder="example@example.com" value="${cookieUserId}" /> <br>
					<label class="form-check-label mt-2 mb-2">비밀번호 :</label><input
						type="password" name="userPw" class="form-control" /> <label
						class="form-check-label mt-2 mb-2">Remember Me! </label> <input
						type="checkbox" name="rememberMe" ${rememberChk}
						class="form-control-input" />
					<button class="btn btn-lg btn-danger btn-block" type="submit" onkeyup="enterkey()">로그인</button>
				</form>
				<!-- 구글 로그인 버튼 -->
				<br>
				<div>구글로그인 아직 사용하지마세요</div>
				<div id="my-signin2"></div>
 					<script>
    					function onSuccess(googleUser) {
      						console.log('Logged in as: ' + googleUser.getBasicProfile().getName());
   						}
    					function onFailure(error) {
      						console.log(error);
    					}
    					function renderButton() {
      						gapi.signin2.render('my-signin2', {
        					'scope': 'profile email',
        					'width': 289,
        					'height': 48,
        					'longtitle': true,
        					'theme': 'dark',
        					'onsuccess': onSuccess,
        					'onfailure': onFailure
      						});
    					}
  					</script>
				</div>
				<!-- 구글 로그인 버튼 -->
			</div>
		</main>
	</div>
<script src="https://apis.google.com/js/platform.js?onload=renderButton" async defer></script>
</body>
</html>