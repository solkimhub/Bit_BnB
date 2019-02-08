package com.bit.bnb.user.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class AdminController {

	@RequestMapping("/admin")
	public String getAdminPage() {
		return "admin";
	}
	
	@RequestMapping("/user/wrongApproach")
	public String getWrongApproachPage() {
		return "user/wrongApproach";
	}
	
}
