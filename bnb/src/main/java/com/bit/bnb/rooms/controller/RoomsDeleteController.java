package com.bit.bnb.rooms.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.bit.bnb.rooms.model.RoomsImgVO;
import com.bit.bnb.rooms.model.RoomsVO;
import com.bit.bnb.rooms.service.RoomsDeleteService;

@Controller
public class RoomsDeleteController {

	@Autowired
	RoomsDeleteService roomsDeleteService;

	@RequestMapping(value = "/rooms/deleteRoom", method = RequestMethod.GET)
	public ModelAndView deleteRooms(RoomsVO rv, RoomsImgVO rimgv) {
		ModelAndView modelAndView = new ModelAndView();

		// 방의 정보를 diabled 처리, 예약이 불가능 하다
		if (roomsDeleteService.disabledRooms(rv) > 0) {
			modelAndView.setViewName("redirect:/rooms");
		} else {
			// 삭제에 실패하였으면
			modelAndView.addObject("msg", "삭제에 실패하였습니다.");
			modelAndView.setViewName("/rooms/modifyRooms");
		}
		return modelAndView;
	}

}
