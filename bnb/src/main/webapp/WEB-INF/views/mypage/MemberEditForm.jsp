<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Mypage Edit</title>
<%@ include file="/resources/common/includeHead.jsp"%>
</head>
<body style="background-color: #EEEEEE;">
	<%@ include file="/resources/common/Navbar.jsp"%>
	<div id="mypage_wrap_cont" class="row">
		<%@ include file="/WEB-INF/views/mypage/leftlist.jsp"%>
		<div id="mypage_cont" class="col-9">
			<h1 style="text-align: center; font-weight: 800; padding: 10px;">
				<i class="fas fa-user-edit"></i> PROFILE EDIT
			</h1>
			<div id="editForm_wrap">
				<form method="post" id="modiform" enctype="multipart/form-data">
					<!-- 아이디 -->
					<div class="form-group row">
						<label for="staticEmail" class="col-sm-2 col-form-label">ID</label>
						<div class="col-sm-10">
							<input type="text" readonly class="form-control-plaintext"
								id="staticEmail" name="userId" value="${userId}">
						</div>
					</div>
					<!-- 이름 -->
					<div class="form-group row">
						<label for="inputName" class="col-sm-2 col-form-label">이름</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" id="inputName"
								placeholder="이름" name="userName" value="${member.userName }"
								required>
						</div>
					</div>
					<!-- 닉네임 -->
					<div class="form-group row">
						<label for="staticEmail" class="col-sm-2 col-form-label">닉네임</label>
						<div class="col-sm-10">
							<input type="text" class="form-control" placeholder="닉네임"
								id="inputNickName" name="nickName" value="${member.nickName}">
								<span
									id="nickNameChk" style="color: red; font-size: 13px;"></span>
						</div>
					</div>
					<script>
						// 닉네임 중복체크
						$('#inputNickName').blur(
										function() {
											var nName = $('#inputNickName').val();

											if (nName == '' || nName == null) {
												$('#nickNameChk').empty();
												$('#nickNameChk').append("<b>닉네임을 입력해주세요.</b>");
											}

											if (nName != '' && nName != null) {
												$.ajax({
															type : "GET",
															url : "${pageContext.request.contextPath}/user/nickNameChk",
															data : {"nickName" : nName},
															success : function(data) {
																if (data == "n") {
																	$('#nickNameChk').empty();
																	$('#nickNameChk').append("<b>이미 사용중인 닉네임입니다</b>");
																} else if (data == "y") {
																	$('#nickNameChk').empty();
																	$('#nickNameChk').css("display","none");
																}
															}
														});
											}
										});
					</script>
					<c:if test="${member.userKey ne 'g'}">
						<!-- 현재비밀번호 -->
						<div class="form-group row">
							<label for="inputPassword" class="col-sm-2 col-form-label">비밀번호</label>
							<div class="col-sm-10">
								<input type="password" class="form-control" id="inputPassword"
									placeholder="Password" name="userPw" required> <span
									id="pwOkCk" style="color: red; font-size: 13px;"></span>
							</div>
						</div>
						<!-- 비밀번호 확인 -->
						<div class="form-group row">
							<label for="inputPassword" class="col-sm-2 col-form-label">비번확인</label>
							<div class="col-sm-10">
								<input type="password" class="form-control" id="passwordCk"
									placeholder="Password" required> <span id="pwCk"
									style="color: red; font-size: 13px;"></span>
							</div>
						</div>

						<script>
							// 비밀번호 유효성 검사
							$('#inputPassword').blur(
											function checkPassword() {

												var checkNumber = $('#inputPassword').val().search(/[0-9]/g);
												var checkEnglish = $('#inputPassword').val().search(/[a-z]/ig);

												if (!/^[a-zA-Z0-9]{8,15}$/.test($('#inputPassword').val())) {
													$('#pwOkCk').html("<b>숫자와 영문자 조합으로 8~15자리를 사용해야 합니다.</b>");
													return false;
												} else if (checkNumber < 0 || checkEnglish < 0) {
													$('#pwOkCk').html("<b>숫자와 영문자를 혼용하여야 합니다.</b>");
													return false;
												} else if (/(\w)\1\1\1/.test($('#inputPassword').val())) {
													$('#pwOkCk').html("<b>같은 문자를 4번 이상 연속하여 사용하실 수 없습니다.</b>");
													return false;
												} else {
													$('#pwOkCk').html('');
													return true;
												}
											});

							$('#passwordCk').blur(function checkPw() {
								var pw = $('#inputPassword').val();
								var pwck = $('#passwordCk').val();

								if (pw != pwck) {
									$('#pwCk').html('<b>비밀번호가 일치하지 않습니다.</b>');
									return false;
								} else {
									$('#pwCk').html('');
									return true;
								}
							});
						</script>
					</c:if>
					<!-- 생년월일 -->
					<div class="form-group row">
						<label for="birth" class="col-sm-2 col-form-label">생년월일</label>
						<div class="col-sm-10">
							<input type="text" class="form-control-plaintext" id="birth"
								value="${member.birth}" readonly> <span
								style="font-size: 13px;"> <i
								class="fas fa-exclamation-circle"></i>&ensp;<b>수정을 원하시는 분은
									관리자에게 문의해주세요.</b></span>
						</div>
					</div>

					<!-- 자기소개 -->
					<div class="form-group">
						<label for="exampleFormControlTextarea1">자기소개</label>
						<textarea class="form-control" id="exampleFormControlTextarea1"
							rows="3" name="userInfo">${member.userInfo }</textarea>
					</div>
					<!-- 사진업로드 -->
					<div class="custom-file">
						<input type="file" class="custom-file-input" id="customFile"
							name="photoFile"> <input type="hidden" id="before"
							name="before" value="${member.userPhoto}"> <input
							type="hidden" id="userPhoto" name="userPhoto"> <label
							class="custom-file-label" for="customFile">파일을 선택하세요.</label>
					</div>
					<br> <br>
					<div id="editButton">
						<button id="uploadbutton" class="btn btn-outline-secondary">수정하기</button>
						<button type="reset" class="btn btn-outline-danger"
							onclick="javascript:history.back();">취소</button>
					</div>
				</form>
				<script>
					$(function() {
						$("#uploadbutton").click(
										function() {
											var pW = $('#inputPassword').val();
											console.log($('#inputPassword').val());

											var form = $('#modiform')[0];
											var formData = new FormData(form);
											if (pW != '') {
												$.ajax({
															url : 'http://13.209.99.134:8080/imgserver/upload/userPhoto',
															processData : false,
															contentType : false,
															datatype : 'JSON',
															data : formData,
															type : 'POST',
															success : function(result) {
																if (result == '') {
																	result = $('#before').val();
																}
																$('#userPhoto').val(''+ result);
																$('#modiform').submit();
															}
														});
											}
										});
					});
				</script>
			</div>
		</div>
	</div>
</body>
</html>