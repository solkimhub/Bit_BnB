package com.bit.bnb.rooms.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class RoomsAccessDeniedController {

	@RequestMapping("/rooms/accessDenied")
	public ModelAndView getAccessDeniedPage() {
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("rooms/accessDenied");
		return modelAndView;
	}
}
