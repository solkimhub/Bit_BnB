package com.bit.bnb.user.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class UserLogoutController {

	@RequestMapping("/logout")
	public String logout(HttpSession session) {
		
		//세션의 종료
		session.invalidate();
		
		return "redirect:/"; // 인덱스로 돌아간다
	}
}
