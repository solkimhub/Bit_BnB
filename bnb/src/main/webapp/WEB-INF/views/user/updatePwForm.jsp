<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script>


</script>
</head>
<body>
	<%@ include file="/resources/common/includeHead.jsp"%>
	<%@ include file="/resources/common/Navbar.jsp"%>

	<div id="userRegForm">
		<!-- Begin page content -->
		<div role="main" class="hyeon-container">
			<div class="row justify-content-md-center">
				<div class="col col-md-5 col-lg-4">
					<c:if test="${InvalidBirth ne null}">
						<div id="dateAlert" style="color:red;">생년월일을 정확하게 입력해주세요.</div> <br>
							<script>
								$(document).ready(function(){
									$('#dateAlert').fadeOut(5000);
								});
							</script>
						<c:remove var="InvalidBirth" scope="session"/>
					</c:if>
				<div class="hyeon-title"><h2>비밀번호 재설정</h2></div>
				
					<form action="${pageContext.request.contextPath }/user/updatePw" method="post">
					
						<label class="form-check-label mt-2 mb-2">비밀번호는 한 개 이상의 기호나 숫자를 포함하여 8자 이상이어야 합니다.
						 아이디를 포함할 수 없습니다.</label>
						<input type="hidden" id="inputUserId" name="userId" class="form-control hyeon-reg-input" style="margin-top: 5px;" value="${userId}" />
						<input type="password" id="userPw-1" name="userPw" class="form-control hyeon-reg-input" placeholder="비밀번호 설정" />
						<div id="alertPw" class="regAlert" style="display:none; color: #dc3545;"></div >
						<input type="password" id="userPw-2" class="form-control hyeon-reg-input" placeholder="비밀번호 확인" />
						<div id="chkPw" class="regAlert" style="display:none; color: #dc3545;"></div >
						<input type="hidden" id="fail-pw-1" class="form-control hyeon-reg-input" name="fail-pw-1"/>
						<input type="hidden" id="fail-pw-2" class="form-control hyeon-reg-input" name="fail-pw-2"/>
						<!-- <input type="hidden" id="fail-pw" name="fail-pw" /> -->
						<button class="btn btn-lg btn-danger btn-block" type="submit" style="margin-bottom: 20px">비밀번호 재설정</button>
					</form>
				</div>
			</div>
		</div>
	</div>
	
	
	<script>
		// 비밀번호 입력란에 포커스 주기
		$(document).ready(function(){
			$('#userPw-1').focus();
		});
		
		// 비밀번호 유효성 검사
		$('#userPw-1').blur(function checkPassword(){
				$('#alertPw').empty();
				$('#alertPw').css("display","none");
				$('#fail-pw-1').val('fail');
				
			var checkNumber = $('#userPw-1').val().search(/[0-9]/g);
			var checkEnglish = $('#userPw-1').val().search(/[a-z]/ig);
			var userIdPart = $('#inputUserId').val().split('@');

			if(!/^[a-zA-Z0-9]{8,15}$/.test($('#userPw-1').val())){
				$('#alertPw').css("display","");
				$('#alertPw').append("숫자와 영문자 조합으로 8~15자리를 사용해야 합니다.");
			} else if (checkNumber <0 || checkEnglish <0){
				$('#alertPw').css("display","");
				$('#alertPw').append("숫자와 영문자를 혼용하여야 합니다.");
			} else if (/(\w)\1\1\1/.test($('#userPw-1').val())){
				$('#alertPw').css("display","");
				$('#alertPw').append("같은 문자를 4번 이상 연속하여 사용하실 수 없습니다.");
			} else if ($('#inputUserId').val() != '' && $('#inputUserId').val() != null){
				if($('#userPw-1').val().search(userIdPart[0]) > -1){
					$('#alertPw').css("display","");
					$('#alertPw').append("비밀번호에 아이디가 포함될 수 없습니다.");
				}else{
					$('#fail-pw-1').val('ok');
				}
			} else {
				$('#fail-pw-1').val('ok');
			}
		});

		/* $('#userPw-1').blur(function(){
			if(!checkPassword($('#inputUserId').val(), $('#userPw-2').val())){
				$('#alertPw').text('fail');
			} else {
				$('#fail-pw').text('');
				$('#fail-pw').val('');
			}
		}); */

		 // 비밀번호 두개가 일치하는지 검사
		 $('#userPw-2').keyup(function(){
			if($('#userPw-1').val() != $('#userPw-2').val()){
				$('#chkPw').empty();
				$('#chkPw').css("display","");
				$('#chkPw').append("비밀번호를 다시 한 번 확인해주세요");
				$('#fail-pw-2').val('fail');
			} else {
				$('#chkPw').empty();
				$('#chkPw').css("display","none");
				$('#fail-pw-2').val('ok');
			}
		});
		
		// 아이디가 비밀번호와 겹치거나 아이디가 중복인지 확인
		$('#inputUserId').blur(function(){
			var userId = $('#inputUserId').val();
			
				if($('#userPw-1').val().search($('#inputUserId').val()) > -1){
					$('#alertPw').css("display","");
					$('#alertPw').empty();
					$('#alertPw').append("비밀번호에 아이디가 포함되었습니다.");
					return false;
				}
			});
	 	

	</script>
	

</body>
</html>