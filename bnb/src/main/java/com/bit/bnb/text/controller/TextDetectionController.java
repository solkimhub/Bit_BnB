package com.bit.bnb.text.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.bit.bnb.text.service.TextDetectionService;
import com.bit.bnb.text.service.UserUpdateService;
import com.bit.bnb.user.model.UserVO;

@Controller
public class TextDetectionController {
	@Autowired
	TextDetectionService service1;
	@Autowired
	UserUpdateService service2;
	
	@RequestMapping(value="/hostapplication", method =RequestMethod.GET)
	public String text() {
		return "textDetection/detection";
	}
	
	@RequestMapping(value="/textDetection", method =RequestMethod.GET)
	@ResponseBody
	public UserVO text(String userId) {
		UserVO user = service1.checkInfo(userId);
		return user;
	}
	
	@RequestMapping(value="/textDetection", method =RequestMethod.POST)
	@ResponseBody
	public int infoUpdate(String userId, HttpSession session/*, @RequestParam("file") MultipartFile file*/) {
		int check = service2.userUpdate(userId);
		
		if(check == 1) {
			UserVO user = (UserVO) session.getAttribute("loginUser");
			user.setHost(1);    
		} else {
			check = 0;
		}
		
		return check;
	}
}
