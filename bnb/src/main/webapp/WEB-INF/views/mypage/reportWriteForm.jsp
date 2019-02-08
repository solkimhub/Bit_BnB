<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Report Write</title>
<%@ include file="/resources/common/includeHead.jsp"%>
</head>
<body style="background-color: #EEEEEE;">
	<%@ include file="/resources/common/Navbar.jsp"%>

	<div id="mypage_wrap_cont" class="row">
		<%@ include file="/WEB-INF/views/mypage/leftlist.jsp"%>
		<div id="mypage_cont" class="col-9">
			<div id="reviewCont_wrap" >
				<form method="post" name="reWrite">
					<input type="text" name="reservationNum" class="form-control-plaintext"
						value="${reservationNum}"
						style="width: 300px;" readonly><br>
					<div class="form-group">
						<label>신고 내용</label>
					</div>

					<div class="input-group">
						<div class="input-group-prepend">
							<div class="input-group-text">
								<input type="radio" name="ck" value="호스트가 매우 불친절합니다.">
							</div>
						</div>
						<input type="text" class="form-control" disabled value="호스트가 매우 불친절합니다.">
					</div>
					<div class="input-group">
						<div class="input-group-prepend">
							<div class="input-group-text">
								<input type="radio" name="ck"  value="호스트가 허위정보를 게시하였습니다.">
							</div>
						</div>
						<input type="text" class="form-control" disabled value="호스트가 허위정보를 게시하였습니다.">
					</div>
					<div class="input-group">
						<div class="input-group-prepend">
							<div class="input-group-text">
								<input type="radio" name="ck"  value="호스트의 방이 사용하기 좋은 환경이 아닙니다.">
							</div>
						</div>
						<input type="text" class="form-control" disabled value="호스트의 방이 사용하기 좋은 환경이 아닙니다.">
					</div>
					<div class="input-group">
						<div class="input-group-prepend">
							<div class="input-group-text">
								<input type="radio" name="ck" value="기타">
							</div>
						</div>
						<input type="text" id="ecttt" class="form-control" placeholder="기타">
					</div>

					<button type="button" class="btn btn-danger" onclick="testt()" style="float:right;">신고</button>
				</form>

			</div>
			<script>
                function testt() {
                    var msg = $('input[name=ck]:checked').val();
                    if ( msg == '기타'){
                        msg=$('#ecttt').val();
                    }
                    if(msg!=''){

                        $.ajax({
                            url: '${pageContext.request.contextPath}/reportWrite',
                            type: 'post',
                            data: {
                                reservationNum:'${reservationNum}',
                                reportContent:msg
                            },
                            datatype: 'json',
                            success: function (data) {

                                $('#reviewCont_wrap').html('의견 감사합니다. 신고하신 내용은 관리자가 확인하여 처리합니다.');

								setTimeout(function () {
									window.location.href='${pageContext.request.contextPath}/mypage/review';
                                },2500)
                            },
                            error: function () {
                            }
                        });
                    }
                }
			</script>
		</div>
	</div>
</body>
</html>