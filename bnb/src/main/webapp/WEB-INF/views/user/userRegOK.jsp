<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
</head>
<body>
<%@ include file="/resources/common/includeHead.jsp"%>
<h1>회원가입 성공</h1>

<div>
아이디 : ${userVO.userId} <br>
비밀번호 : ${userVO.userPw} <br>
이름 : ${userVO.userName} <br>
사진 : ${userVO.userPhoto} <br>
호스트 : ${userVO.host} <br>
어드민 : ${userVO.admin} <br>
유저키 : ${userVO.userKey} <br>
유저체크 : ${userVO.userCheck} <br>
포인트 : ${userVO.point} <br>
탈퇴여부 : ${userVO.disabled} <br>
생년월일 : ${userVO.birth} <br>
자기소개 : ${userVO.userInfo} <br>
</div>

<h3><a href="${pageContext.request.contextPath}/">메인페이지 돌아가기</a></h3>
</body>
</html>