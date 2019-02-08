<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>WishList</title>
<%@ include file="/resources/common/includeHead.jsp"%>
<style>
.wishDiv {
	display: none;
}
</style>
</head>
<body style="background-color: #EEEEEE;">
	<%@ include file="/resources/common/Navbar.jsp"%>
	<div id="mypage_wrap_cont" class="row">
		<%@ include file="/WEB-INF/views/mypage/leftlist.jsp"%>
		<div id="mypage_cont" class="col-9">
			<h1 style="text-align: center; padding: 10px; font-weight: 800;">
				<i class="far fa-grin-hearts"></i> WISH LIST
			</h1>
			<div id="wish_wrap">
				<div class="row">
				<c:if test="${empty wishDiv}">
					<h1 style="width:100%; text-align: center;">즐겨찾기 목록이 없습니다. 더 많은 숙소를 둘러보세요!</h1>
					<h5 style="margin: 0 auto;padding:20px;"><a href="${pageContext.request.contextPath}/rooms">보러가기</a></h5>
				</c:if> 
					<c:forEach var="wd" items="${wishDiv}">
						<div class="col-4 wishDiv">
							<a
								href="${pageContext.request.contextPath}/mypage/wishList?userId=${loginUser.userId}&address=${wd.address}"
								style="text-align: center; font-size: 18px; text-decoration: none; color: black;"
								class="wish_div">
							 	<div class="card border-light wish_hover"
									style="height: 200px; margin-bottom: 20px; overflow: hidden;">
									<c:forEach var="img" items="${wishDivImg}">
										<c:if test="${wd.address == img.address}">
											<img class="card-img divImg"
												src="http://13.209.99.134:8080/imgserver/resources/upload/${img.filename}"
												style="width: 100%; object-fit: contain; vertical-align: middle; opacity:0.85;">
										</c:if>
									</c:forEach>
									<div class="card-img-overlay">
										<div class="card-body" style="padding: 0px;">
											<span class="card-text"
												style="float: right; font-size: 18px; font-weight: 600;">
												<i class="fas fa-heart" style="color: #ff3232; text-shadow: -1px 0 white, 0 1px white, 1px 0 white, 0 -1px white;"></i> <span
												id="idx" style="color:white; text-shadow: -1px 0 black, 0 1px black, 1px 0 black, 0 -1px black;"></span>
											</span><br> <br>
											<div class="address_wrap">
											<span class="wishAddress text-center" id="address" style="font-weight: 1000; font-size:25px; color:white; 
													text-shadow: -1px 0 black, 0 1px black, 1px 0 black, 0 -1px black;">${wd.address}</span>
												<%-- <input
													class="form-control-plaintext wishAddress text-center"
													name="address" value="${wd.address}"
													style="font-weight: 1000; font-size:25px; color:white; 
													text-shadow: -1px 0 black, 0 1px black, 1px 0 black, 0 -1px black;" readonly /> --%>
											</div> 
										</div>
									</div>
								</div>
							</a>
						</div>
					</c:forEach>
					<c:if test="${!empty wishDiv && fn:length(wishDiv) > 6}">
						<button type="button" id="load" class="btn btn-sm btn-block"
							style="margin: 20px 10px; background-color: #EEEEEE">
							<b>더보기</b>
						</button>
					</c:if>
				</div>
			</div>
		</div>
	</div>
	<script>
		$(document).ready(function() {
			var wishList = $('.wishAddress');
			var arr = [];
			for (var i = 0; i < wishList.length; i++) {
				arr.push($("span[id='address']").eq(i).text());
			}

			var jsonInfo = JSON.stringify(arr);

			for (var j = 0; j < wishList.length; j++) {
				$("span[id='idx']").eq(j).addClass("wishIdx" + j);
			}

			$.ajax({
				type : 'post',
				url : '${pageContext.request.contextPath}/wishCnt',
				contentType : 'application/json',
				data : jsonInfo,
				success : function(response) {
					var obj = JSON.parse(response);
					$.each(obj, function(key, val) {
						for (var i = 0; i < wishList.length; i++) {
							var loc = $("span[id='address']").eq(i).text();
							if (loc == key) {
								$('.wishIdx' + i).text(val);
							}
						}
					});
				}
			});
		});

		$(function() {
			$(".wishDiv").slice(0, 6).show(); // 최초 6개 선택
			$("#load").click(function(e) { // Load More를 위한 클릭 이벤트e
				e.preventDefault();
				$(".wishDiv:hidden").slice(0, 6).show(); // 숨김 설정된 다음 6개를 선택하여 표시
				if ($(".wishDiv:hidden").length == 0) { // 숨겨진 DIV가 있는지 체크
					$('#load').css('display', 'none');// 더 이상 로드할 항목이 없는 경우
				}
			});
		});
	</script>
</body>
</html>