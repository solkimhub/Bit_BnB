<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Review Write</title>
<%@ include file="/resources/common/includeHead.jsp"%>
</head>
<body style="background-color: #EEEEEE;">
	<%@ include file="/resources/common/Navbar.jsp"%>

	<div id="mypage_wrap_cont" class="row">
		<%@ include file="/WEB-INF/views/mypage/leftlist.jsp"%>
		<div id="mypage_cont" class="col-9">
			<div id="reviewCont_wrap">
				<form method="post" name="reWrite">
					<c:forEach var="reChk" items="${reviewChk}">
						<span><i class="fas fa-edit"></i>&ensp;${reChk.checkIn} 부터
							${reChk.checkOut}일까지 이용한 <a href="${pageContext.request.contextPath}/rooms/viewRooms?roomsId=${reChk.roomsId}">${reChk.roomsId}번</a>번 방에 대한 리뷰를 써주세요.</span><br><br>
					</c:forEach>
					<div class="form-group">
						<label for="reviewCont">리뷰 내용</label>
						<textarea class="form-control" name="reviewContent"
							id="reviewCont" rows="3" required></textarea>
					</div>
					<select class="form-control" name="scope" required>
						<option selected>별점</option>
						<option value="1">★</option>
						<option value="2">★★</option>
						<option value="3">★★★</option>
						<option value="4">★★★★</option>
						<option value="5">★★★★★</option>
					</select><br>
					<div id="editButton">
						<button type="button" class="btn btn-warning"
							onclick="javascript:document.reWrite.submit();">리뷰 쓰기</button>
						<button type="reset" class="btn btn-outline-danger"
							onclick="javascript:history.back();">취소</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</body>
</html>