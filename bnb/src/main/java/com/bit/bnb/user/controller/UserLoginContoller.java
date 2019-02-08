package com.bit.bnb.user.controller;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.security.NoSuchAlgorithmException;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.bit.bnb.user.service.UserLoginService;

@Controller
public class UserLoginContoller {

	@Autowired
	private UserLoginService userLoginService;

	@RequestMapping(value="/login", method = RequestMethod.GET)
	public ModelAndView getLoginForm(HttpServletRequest request) {

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("user/userLoginForm");

		// 쿠키 가져오기
		Cookie[] cookies = request.getCookies();

		// 이름이 loginUser인 쿠키가 있으면 값을 가져와서 모델앤뷰에 cookieUserId라는 이름으로 저장
		if (cookies != null) {
			for (int i = 0; i < cookies.length; i++) {
				if (cookies[i].getName().equals("cookieUserId")) {
					modelAndView.addObject("cookieUserId", cookies[i].getValue());
					modelAndView.addObject("rememberChk", "checked");
				}
			}
		}
		return modelAndView;
	}

	@RequestMapping(value="/login", method = RequestMethod.POST)
	@ResponseBody
	public String userLogin(@RequestParam(value = "userId", required = false) String userId,
			@RequestParam(value = "userPw", required = false) String userPw, String rememberMe, HttpSession session,
			HttpServletResponse response) throws UnsupportedEncodingException, GeneralSecurityException {

		String result = "";

		if (userId != null && userPw != null) {

			// 로그인서비스의 로그인 처리 결과를 담는다.
			result = userLoginService.userLogin(userId, userPw, session);

			// 로그인 처리 경우의 수 :
			// 1. 구글계정인경우 - 구글계정으로 로그인 요청(메인에 얼럿띄우기) : google
			// 2. 아이디와 패스워드가 일치하고 메일인증 완료된 경우 - 로그인 처리(+쿠키생성) : loginSuccess
			// 3. 아이디와 패스워드는 일치하지만 메일인증이 안된경우 - 메일인증요청 : userKeyConfirm
			// 4. 아이디로 셀렉되는 로우가 없거나 패스워드가 일치하지 않는 경우 - 아이디와 패스워드 확인요청 : loginFail
			// 5. 이미 탈퇴한 회원의 아이디 - disabled가 0인경우 : disabled

			if (result.equals("loginSuccess")) {

				if (rememberMe.equals("true")) {
					Cookie cookie = new Cookie("cookieUserId", userId);
					cookie.setMaxAge(60 * 60 * 24 * 7);
					response.addCookie(cookie);

				} else {
					// rememberMe가 false면 쿠키 삭제
					Cookie cookie = new Cookie("cookieUserId", null);
					cookie.setMaxAge(0);
					response.addCookie(cookie);
				}
			}

		}
		return result;
	}
	
	
	// 구글 로그인
	@RequestMapping(value="/googleLogin", method=RequestMethod.POST)
	@ResponseBody
	public String googleLogin(@RequestParam(value = "gId", required = false) String gId,
							  HttpSession session) throws UnsupportedEncodingException, GeneralSecurityException {
		
		String result = userLoginService.googleLogin(gId, session);
		
		return result;
	}
}
