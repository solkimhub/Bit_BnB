package com.bit.bnb.mypage.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.bit.bnb.mypage.service.HistoryViewService;
import com.bit.bnb.user.model.UserVO;

@Controller
public class HistoryViewController {
	
	@Autowired
	private HistoryViewService service;
	
	@RequestMapping("/mypage/history")
	public ModelAndView historyView(HttpSession session) {
		
		UserVO user = (UserVO)session.getAttribute("loginUser");
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.setViewName("mypage/history");
		modelAndView.addObject("historys", service.historyView(user.getUserId()));
		modelAndView.addObject("trip", service.tripView(user.getUserId()));
		modelAndView.addObject("historyImg", service.historyImg(user.getUserId()));
		modelAndView.addObject("tripImg", service.tripImg(user.getUserId()));
		
		return modelAndView;
	}

}
