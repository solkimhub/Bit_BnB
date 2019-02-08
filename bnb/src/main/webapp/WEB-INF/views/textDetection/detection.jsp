<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>Cloud Vision Demo</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.2/jquery.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/key.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/main.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/canvas2image.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/0.4.1/html2canvas.js"></script>


<style>
#test1 {
	border: 3px solid red;
	position: absolute;
}

#test2 {
	border: 3px solid yellow;
	position: absolute;
}

#test3 {
	border: 3px solid black;
	position: absolute;
	background-color: black;
}

#left_div {
	float: left;
}

#right_div {
	float: left;
}
</style>
</head>

<body>
	<%@ include file="/resources/common/includeHead.jsp"%>
	<%@ include file="/resources/common/Navbar.jsp"%>

	<c:choose>
		<c:when test="${sessionScope.loginUser.host eq 2}">
			<div class="row justify-content-center" style="padding-top: 50px;">
				<div class="col-md-6">
					<h1
						style="color: darkred; text-align: center; font-size: 5em; padding-bottom: 35px">
						<i class="fas fa-exclamation-triangle"></i>
					</h1>
					<h4 style="line-height: 35px; text-align: center">
						" ${sessionScope.loginUser.userName} "님은 호스트 신청이 불가능한 상태입니다.<br>
						관리자에게 문의해주세요.

					</h4>
				</div>

			</div>

		</c:when>
		<c:otherwise>
			<div class="row ml-5 mr-5">
				<!-- 181226 Start -->
				<div class="col-1"></div>
				<div class="col-5 p-5">
					<h1>
						<b>bitBnB를 호스팅을 추천하는 이유</b>
					</h1>
					<br> 에어비앤비는 호스트가 공유하는 숙소의 유형과 관계없이 게스트를 쉽고 안전하게 호스팅할 수 있도록
					해줍니다. 예약 가능일, 요금, 숙소 이용규칙, 게스트와의 교류 방식은 전적으로 호스트가 결정합니다.
				</div>
				<div class="col-5 p-5">
					<h1>
						<b>안심하세요.</b>
					</h1>
					<br> 사고에 대비한 1백만 달러의 재산 피해 보호 프로그램 및 별도의 1백만 달러 보험 등, 에어비앤비는
					호스트, 호스트의 숙소와 재산 및 게스트를 보호할 수 있는 포괄적인 보호 장치를 마련해두고 있습니다.
				</div>
				<div class="col-1"></div>
				<div class="col-1"></div>
				<div class="col-10 mt-5 text-center">
					<h1>
						<b>호스팅 서비스를 시작하기 위해서는, 본인인증이 필요합니다.</b>
					</h1>
					<hr>
				</div>
				<div class="col-1"></div>
				<!-- 181226 End -->
				<div class="col-1"></div>
				<div class="col-5 pl-5 pr-5 text-center" id="left_div">
					<img style="width: 360px"
						src="${pageContext.request.contextPath}/resources/images/sample.png">
					<!-- <h3 class="mt-3">신분증을 위와 같이 촬영하여 등록해주세요.</h3> -->
					<form id="fileform" action="" enctype="multipart/form-data">
						<select style="display: none" name="type">
							<option value="TEXT_DETECTION">TEXT_DETECTION</option>
						</select><br /> <input type="file" name="fileField" id="upload_file"><br />
						<br /> <input style="display: none" type="submit" name="submit"
							value="Submit">
					</form>
					<!-- <div style="white-space: pre;" id="right_div"> -->
					<div id="right_div" class="col-12">
						<div class="alert alert-info pt-3" role="alert">
							<h4 id="host">신분증을 위와 같이 촬영하여 등록해주세요.</h4>
						</div>
					</div>
				</div>
				<div class="col-5 pl-5 pr-5 pt-3">
					<div id="holder" style="position: relative;"></div>
					<div class="col-12" id="results">
						<h3 id="host"></h3>
					</div>
					<div class="col-1"></div>
					<script type="text/javascript">
						var temp;
						var check = 0;
						var ratio = 0;

						$(function() {
							$("#upload_file").on('change', function() {
								/* $('#img').attr("src", ""); */
								$('#fileform').submit();
								temp = this;
							});
						});

						function readURL(input) {
							$('#img').remove();
							$('#results').text('');
							$('#results')
									.html(
											'<button style="margin-top : 20px" id="hostSubmit" class="btn btn-lg btn-danger">호스트 신청하기</button>');
							if (input.files && input.files[0]) {
								var reader = new FileReader();

								reader.onload = function(e) {
									var img = new Image();
									img.src = e.target.result;
									img.width = 360;
									console.log(ratio);
									$('#holder')
											.append(
													'<img style="width: 360px; z-index:999" id="img" src="' + e.target.result + '" alt="뭐야ㅡㅡ" />');
								}
								reader.readAsDataURL(input.files[0]);
							}
						}

						/**
						 * Displays the results.
						 */
						function displayJSON(data) {
							//  var contents = JSON.stringify(data, null, 4);
							//  $('#results').text(contents);
							//  var evt = new Event('results-displayed');
							//  evt.results = contents.description;

							var str = data.responses[0].fullTextAnnotation.text;
							var trimStr = str.replace(/ /gi, ""); // 모든 공백을 제거
							var tempName = '';
							var tempDob = '';
							/* console.log(trimStr);
							console.log(data.responses[0].textAnnotations); */

							$
									.ajax({
										async : false,
										url : '${pageContext.request.contextPath}/textDetection',
										type : 'GET',
										datatype : 'json',
										data : {
											"userId" : "${loginUser.userId}"
										},
										success : function(data) {
											tempDob = data.birth.substring(2,
													10).replace(/-/gi, '');
											tempName = data.userName;
										}
									});

							ratio = data.responses[0].fullTextAnnotation.pages[0].width / 360;
							console.log(ratio);

							$(data.responses[0].textAnnotations)
									.each(
											function(key, value) {

												/* console.log(value.description.substring(0, 6)); */
												if (check <= 2
														&& value.description == tempName) {
													tempName = '';

													var nameWidth = value.boundingPoly.vertices[2].x
															- value.boundingPoly.vertices[0].x
															+ 12;
													var nameHeight = value.boundingPoly.vertices[2].y
															- value.boundingPoly.vertices[0].y
															+ 12;

													$('#holder')
															.append(
																	'<div id="test1" style="z-index:999";></div>');
													$('#test1')
															.css(
																	"left",
																	""
																			+ (value.boundingPoly.vertices[0].x)
																			/ ratio
																			- 4
																			+ "px");
													$('#test1')
															.css(
																	"top",
																	""
																			+ (value.boundingPoly.vertices[0].y)
																			/ ratio
																			- 4
																			+ "px");
													$('#test1').css(
															"width",
															"" + nameWidth
																	/ ratio
																	+ "px");
													$('#test1').css(
															"height",
															"" + nameHeight
																	/ ratio
																	+ "px");
													check++;
													/* return false; */
												}
												if (check <= 2
														&& value.description
																.substring(0, 6) == tempDob) {
													/*                         var identityWidth = ((value.boundingPoly.vertices[2].x - value.boundingPoly.vertices[0].x + 12) / 2) * 0.92;
													                        var identityHeight = value.boundingPoly.vertices[2].y - value.boundingPoly.vertices[0].y + 12; */
													var identityWidth = (value.boundingPoly.vertices[2].x - value.boundingPoly.vertices[0].x) / 2;
													var identityHeight = value.boundingPoly.vertices[2].y
															- value.boundingPoly.vertices[0].y
															+ 12;

													console
															.log(value.boundingPoly.vertices);
													console
															.log(value.boundingPoly.vertices[2].x
																	- value.boundingPoly.vertices[0].x);
													$('#holder')
															.append(
																	'<div id="test2" style="z-index:999"></div>');
													$('#test2')
															.css(
																	"left",
																	""
																			+ (value.boundingPoly.vertices[0].x)
																			/ ratio
																			- 5
																			+ "px");
													$('#test2')
															.css(
																	"top",
																	""
																			+ (value.boundingPoly.vertices[0].y)
																			/ ratio
																			- 4
																			+ "px");
													$('#test2').css(
															"width",
															"" + identityWidth
																	/ ratio
																	+ "px");
													$('#test2').css(
															"height",
															"" + identityHeight
																	/ ratio
																	+ "px");
													$('#holder')
															.append(
																	'<div id="test3" style="z-index:999"></div>');
													$('#test3')
															.css(
																	"left",
																	""
																			+ ((value.boundingPoly.vertices[0].x)
																					/ ratio - 4)
																			* 3.35
																			+ "px");
													$('#test3')
															.css(
																	"top",
																	""
																			+ (value.boundingPoly.vertices[0].y)
																			/ ratio
																			- 4
																			+ "px");
													$('#test3').css(
															"width",
															"" + identityWidth
																	/ ratio
																	+ "px");
													$('#test3').css(
															"height",
															"" + identityHeight
																	/ ratio
																	+ "px");
													check++;
												}
											});
							if (check < 2) {
								$('#img').remove();
								$('#test1').remove();
								$('#test2').remove();
								$('#test3').remove();
								$('#results').text('사진을 다시 업로드 해주세요.');
							} else if (check == 2) {
								readURL(temp);
								check = 0;
							}

							$('#hostSubmit')
									.on(
											"click",
											function() {
												$
														.ajax({
															url : '${pageContext.request.contextPath}/textDetection',
															type : 'POST',
															datatype : 'json',
															data : {
																"userId" : "${loginUser.userId}",
															},
															success : function(
																	data) {
																if (data == 1) {
																	$(
																			'#results')
																			.text(
																					'');
																	$('#host')
																			.html(
																					'호스트가 되신걸 축하합니다.<hr><h5>이제 호스트 페이지에서 호스팅 서비스를 시작하실 수 있습니다.<br>3초 후 호스트페이지로 이동합니다.</h5>');
																	setTimeout(
																			function() {
																				window.location.href = '${pageContext.request.contextPath}/hostpage/main'
																			},
																			3000);
																} else {
																	$(
																			'#results')
																			.text(
																					'죄송합니다. 다시 시도해주세요.');
																}
															}
														});
											});

							function hostSubmit() {
								/*                 if ((trimStr.indexOf(tempName)) != -1 && trimStr.indexOf(tempDob) != -1) { */
								$
										.ajax({
											url : '${pageContext.request.contextPath}/textDetection',
											type : 'POST',
											datatype : 'json',
											data : {
												"userId" : "${loginUser.userId}"
											},
											success : function(data) {
												if (data == 1) {
													$('#results').text('');
													$('#host')
															.html(
																	'호스트가 되신걸 축하합니다.<br> 호스트페이지에서 방등록을 하실수 있습니다.<br><br> 3초후 호스트페이지로 이동합니다.');
													setTimeout(
															function() {
																window.location.href = '${pageContext.request.contextPath}/hostpage/main'
															}, 3000);

												} else {
													$('#results')
															.text(
																	'죄송합니다. 다시 시도해주세요.');
												}
											}
										});

								/*  } else {
								     $('#results').text('사진을 다시 업로드 해주세요.');
								 } */
							}
						}
					</script>
				</div>
		</c:otherwise>
	</c:choose>




	<!-- <image id="theimage" style="position: relative;"></image> -->

</body>


</html>
