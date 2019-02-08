package com.bit.bnb.rooms.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.bit.bnb.rooms.model.AmenitiesVO;
import com.bit.bnb.rooms.model.RoomsImgVO;
import com.bit.bnb.rooms.model.RoomsVO;
import com.bit.bnb.rooms.service.RoomsRegService;

@Controller
public class RoomsRegController {

	@Autowired
	RoomsRegService roomsRegService;

	// 숙소등록폼페이지
	@RequestMapping(value = "/rooms/registerRooms", method = RequestMethod.GET)
	public ModelAndView getRegRoomsForm(AmenitiesVO av) {
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("amenities", roomsRegService.getAmenities(av));
		modelAndView.setViewName("rooms/regRoomsForm");
		return modelAndView;
	}

	// 숙소등록페이지
	@RequestMapping(value = "/rooms/registerRooms", method = RequestMethod.POST)
	public @ResponseBody ModelAndView regRooms(RoomsVO rv, String filenames[]) {
		ModelAndView modelAndView = new ModelAndView();
		// 줄 바꿈 처리
		rv.setDetails(rv.getDetails().replaceAll("\r\n", "<br>"));
		System.out.println(rv);
		// 숙소등록에 성공하였을 경우
		if (roomsRegService.regRooms(rv) > 0) {
			modelAndView.setViewName("redirect:/rooms");
			System.out.println(rv.getRoomsId());
			// 이미지 등록
			RoomsImgVO rimgv = new RoomsImgVO();
			rimgv.setRoomsId(rv.getRoomsId());
			// for 이미지처리

			for (int i = 0; i < filenames.length; i++) {
				// 왜인지 모르겠으나 [, ", ]이 포함되어서 replace 처리
				rimgv.setFilename(filenames[i].replace("\"", "").replace("[", "").replace("]", ""));
				rimgv.setPriority(i + 1);
				roomsRegService.insertRoomsPhoto(rimgv);
				System.out.println(filenames[i]);
			}

		} else {
			modelAndView.addObject("msg", "등록에 실패하였습니다.");
			modelAndView.setViewName("rooms/regRoomsForm");
		}
		return modelAndView;
	}

}
