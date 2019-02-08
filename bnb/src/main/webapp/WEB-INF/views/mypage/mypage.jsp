<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Mypage</title>
<%@ include file="/resources/common/includeHead.jsp"%>
</head>
<body style="background-color: #EEEEEE;">
	<%@ include file="/resources/common/Navbar.jsp"%>

	<div id="mypage_wrap_cont" class="row justify-content-end">
		<%@ include file="/WEB-INF/views/mypage/leftlist.jsp"%>
		<div id="mypage_cont" class="col-9">
			<h1 style="text-align: center; padding: 10px; font-weight: 800;">
				<i class="fas fa-id-card"></i> MY PROFILE
			</h1>
			<div class="row profile_wrap">
				<div class="col-sm-5 profile_left">
					<div class="thumbnail_mypage">
						<div class="centered_mypage">
							<img
								src="http://13.209.99.134:8080/imgserver/resources/img/userphoto/${user.userPhoto}">
						</div>
					</div>
					<br>
					<h4>
						<span class="badge badge-pill badge-warning">Id</span>&ensp;${loginUser.userId }
					</h4>
					<h5><span class="badge badge-pill badge-warning">Name</span>&ensp;${user.userName}</h5>
					<h5><span class="badge badge-pill badge-warning">NickName</span>&ensp;${user.nickName}</h5>
				</div>
				<div class="col-sm-6 profile_right">
					<dl>
						<dt style="font-size: 19px;">생년월일</dt>
						<dd>${user.birth}</dd>
						<dt style="font-size: 19px;">자기소개</dt>
						<dd>${user.userInfo}</dd>
						<dt style="font-size: 19px;">본인확인여부</dt>
						<dd>
							<c:choose>
								<c:when test="${user.userCheck eq 1}">
									<i class="far fa-check-circle" style="color: #329632"></i> 확인 되었습니다.
								</c:when>
								<c:otherwise>
									<i class="far fa-times-circle" style="color: #CD0000"></i> 본인 확인을 진행해 주세요.
								</c:otherwise>
							</c:choose>
						</dd>
						<dt style="font-size: 19px;">호스트여부</dt>
						<dd>
							<c:choose>
								<c:when test="${user.host eq 1}">
									<i class="far fa-check-circle" style="color: #329632"></i> 호스트 등록되어있습니다.
								</c:when>
								<c:otherwise>
									<i class="far fa-times-circle" style="color: #CD0000"></i> 호스트가 아닙니다.
									<dt>
										호스트가 되길 원하신다면? &ensp;
										<a href="${pageContext.request.contextPath}/hostapplication">호스트신청</a>
									</dt>
								</c:otherwise>
							</c:choose>
						</dd>

					</dl>
					<br>
					<button type="button" class="btn btn-outline-secondary"
						onclick="javascript:location.href='${pageContext.request.contextPath}/mypageEdit?userId=${loginUser.userId}'">프로필수정</button>
					&ensp;
					<%-- <button type="button" class="btn btn-outline-danger"
						onclick="javascript:location.href='${pageContext.request.contextPath}/userDelete?userId=${loginUser.userId}'">회원
						탈퇴</button> --%>
					<button type="button" class="btn btn-outline-danger"
						data-toggle="modal" data-target="#userDeleteModal">회원 탈퇴</button>
					<!-- Modal -->
					<div class="modal fade" id="userDeleteModal" tabindex="-1"
						role="dialog" aria-labelledby="userDeleteModal" aria-hidden="true">
						<div class="modal-dialog modal-dialog-centered" role="document">
							<div class="modal-content">
								<div class="modal-header">
									<h5 class="modal-title" id="exampleModalCenterTitle">회원 탈퇴</h5>
									<button type="button" class="close" data-dismiss="modal"
										aria-label="Close">
										<span aria-hidden="true">&times;</span>
									</button>
								</div>
								<div class="modal-body" style="text-align: center;">
									<b>${loginUser.userName }</b>님 회원을 탈퇴하시겠습니까?
								</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-danger"
										onclick="javascript:location.href='userDelete?userId=${loginUser.userId}'">탈퇴</button>
									<button type="button" class="btn btn-secondary"
										data-dismiss="modal">취소</button>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>