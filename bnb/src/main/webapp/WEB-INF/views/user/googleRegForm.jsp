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
	
	<c:if test="${regFail ne null}">
		<script>alert("회원가입 실패. 다시 시도해주세요.");</script>
		<c:remove var="regFail" scope="session"/>
	</c:if>

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
				
				<div class="hyeon-title"><h2>회원가입</h2></div>
				
					<form method="post" id="gRegForm" enctype="multipart/form-data">
					
						<input type="email" id="inputUserId" name="userId" class="form-control hyeon-reg-input" value="${gMail}" readonly />
						<input type="hidden" id="userPw-1" name="userPw" class="form-control hyeon-reg-input" value="" />
						<input type="text" id="inputUserName" name="userName" class="form-control hyeon-reg-input" value="${gName}" placeholder="이름" />
						<div id="chkName" class="regAlert" style="display:none; color: #dc3545;"></div>
						<input type="text" id="inputNickName" name="nickName" class="form-control hyeon-reg-input" placeholder="닉네임" />
						<div id="alertNickName" class="regAlert" style="display:none; color: #dc3545;"></div>
						<label class="form-check-label mt-2 mb-2" style="margin-bottom: 3px; font-weight: bold;">사진 </label>
						<input type="file" name="photoFile" class="form-control hyeon-reg-input" />
						<input type="hidden" name="host" value=0 style="display:none" />
						<input type="hidden" name="admin" value=0 style="display:none" />
						<!-- <input type="hidden" name="userKey" value="asd123" style="display:none" /> -->
						<input type="hidden" name="userCheck" value=1 style="display:none" />
						<input type="hidden" name="point" value=0 style="display:none" />
						<input type="hidden" name="disabled" value=1 style="display:none" />
						
						<div>
						<label class="form-check-label mt-2 mb-2" style="margin-bottom: 3px; font-weight: bold;">생일</label>
						<p>회원 가입을 하시려면 만 18세 이상이어야 합니다.<br>
						생일은 다른 회원에게는 공개되지 않습니다.</p>
						</div>
						<div>
						<select id="select-month" name="month" class="hyeon-form-control hyeon-left">
					 		<option value="">월</option>
								<c:forEach begin="1" end="12" var="month" >
									<option>${month}</option>
								</c:forEach>
						</select>
						
						<select id="select-day" name="day" class="hyeon-form-control">
					 		<option value="">일</option>
								<c:forEach begin="1" end="31" var="day" >
									<option>${day}</option>
								</c:forEach>
						</select>
						
						<select id="select-year" name="year" class="hyeon-form-control hyeon-right">
					    	<option value="">년도</option>

      						    <c:set var="today" value="<%=new java.util.Date()%>" />

          						<fmt:formatDate value="${today}" pattern="yyyy" var="nowYear"/> 

         						<c:forEach begin="0" end="120" var="i">

           							<option><c:out value="${nowYear - i}" /></option>

          						</c:forEach>

						</select>
						</div>
						<div> 
							<textarea name="userInfo" class="form-control hyeon-reg-input" cols="30" placeholder="자기소개"></textarea>
						</div>
						<input id="gRegBtn" class="btn btn-lg btn-danger btn-block" type="button" style="margin-bottom: 20px" value="회원가입" />
					</form>
				</div>
			</div>
		</div>
	</div>
	
	
	<script>
	
	
	// 가입항목 제대로 들어갔는지 확인할 변수
	//	이름체크, 닉네임체크
	var chkArr = ['y', 'n'];
	
	// 아이디 입력란에 포커스 주기
	$(document).ready(function(){
		$('#inputNickName').focus();
		
	});
	
	// 이름 입력했는지 검사
	$('#inputUserName').blur(function(){
		if($('#inputUserName').val() == null ||$('#inputUserName').val() == ''){
			$('#chkName').empty();
			$('#chkName').css("display","");
			$('#chkName').append("이름을 입력해주세요");
			chkArr[0] = 'n';
		} else {
			$('#chkName').empty();
			$('#chkName').css("display","none");
			chkArr[0] = 'y';
		}
	});
	
		// 닉네임 중복체크
	$('#inputNickName').blur(function(){
		var nName = $('#inputNickName').val();
		
		if(nName != '' && nName != null){
			$.ajax({
				type: "GET",
				url: "${pageContext.request.contextPath}/user/nickNameChk",
				data: {"nickName" : nName},
				success: function(data){
					if(data == "n") {
						$('#alertNickName').empty();
						$('#alertNickName').css("display","");
						$('#alertNickName').append("이미 사용중인 닉네임입니다");
					} else if(data == "y"){
						$('#alertNickName').empty();
						$('#alertNickName').css("display","none");
						chkArr[1] = 'y';
					}
				}
			});
		}
	});
	

	 $(function() {
		 $("#gRegBtn").click(function() {
			 
			// 가입항목 유효성 체크할 변수
             var validChk = 'y';
         	
         	// 가입항목에 문제 있으면 validChk를 n으로 바꿔서 submit 안되게...
             for(var i=0; i<chkArr.length; i++){
            	console.log(chkArr[i]);
             	if(chkArr[i] == 'n'){
             		validChk = 'n';
             	}
             }
              
             var pattern = /[0-9]{4}-[0-9]{2}-[0-9]{2}/;
             var year = $('#select-year').val();
             var month = $('#select-month').val();
             var day = $('#select-day').val();
             if(month<10){
             	month = '0'+month;
             }
             if(day<10){
              	day = '0'+day;
             }
                
             var birth = $('#select-year').val()+'-'+month+'-'+day;
             var lastDay = new Date(new Date(year, month, 0)).getDate();
             
             var today = new Date();
             var tYear = today.getFullYear();
             var tMonth = today.getMonth()+1;
             var tDay = today.getDate();
	             
             if(tMonth<10){
             	tMonth = ''+tMonth;
             }
             if(tDay<10){
                tDay = ''+tDay;
             }
                
             var age = tYear-year;
             
             if((month*100 + day) > tMonth*100 + tDay){
                age--;
             }
                
             
             console.log()
             
             if(pattern.test(birth) && day<=lastDay && age>=18 && validChk == 'y'){
            	 var form = $('#gRegForm');
            	 var formData = new FormData(form);
            	 
            	 $.ajax({
            	     url : 'http://13.209.99.134:8080/imgserver/upload/userPhoto',
            	     processData : false,
            	     contentType : false,
            	     datatype : 'JSON',
            	     data : formData,
            	     type : 'POST',
            	     success : function(result) {
            	           		
            	    	 if(result==''){
            	             	result='nopic.jpg'
							}
            	         $('#userPhoto').val('' + result);
            	         $('#regBtn').val('가입처리중입니다...');
            	         $('#regForm').submit();
            	       }
            		});
            	 
            	 
             	$('#gRegForm').submit();
                $('#gRegBtn').val('가입처리중...');
            
             }else if(day>lastDay){ 
            	alert('유효하지 않은 생년월일입니다.');
	         }else if(age<18){ 
	           	console.log('만나이: ' + age);
	           	alert('만 18세 이상만 가입 가능합니다');
	         }else{ 
	           	console.log('생년월일 : ' + birth);
	           	alert('가입항목을 다시 한 번 확인해주세요.');
	         }
	           	
	      });
	   });
	
	
	</script>
	
</body>
</html>