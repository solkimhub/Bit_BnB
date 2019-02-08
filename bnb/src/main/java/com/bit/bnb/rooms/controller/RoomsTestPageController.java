package com.bit.bnb.rooms.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class RoomsTestPageController {

	@RequestMapping("/rooms/test")
	public ModelAndView getTest() {
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/rooms/test_navermap");
		return modelAndView;
	}
}
