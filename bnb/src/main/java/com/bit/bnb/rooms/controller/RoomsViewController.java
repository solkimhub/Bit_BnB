package com.bit.bnb.rooms.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.bit.bnb.mypage.service.WishService;
import com.bit.bnb.rooms.model.AmenitiesVO;
import com.bit.bnb.rooms.model.RoomsImgVO;
import com.bit.bnb.rooms.model.RoomsVO;
import com.bit.bnb.rooms.service.RoomViewService;
import com.bit.bnb.user.model.UserVO;

@Controller
public class RoomsViewController {

	@Autowired
	RoomViewService roomViewService;

	@Autowired
	WishService wishService;

	@RequestMapping(value = "/rooms/viewRooms", method = RequestMethod.GET)
	public ModelAndView getRoomsHome(RoomsVO rv, AmenitiesVO av, RoomsImgVO rimgv, HttpSession session,
			@RequestParam("roomsId") int roomsId) {
		ModelAndView modelAndView = new ModelAndView();
		UserVO user = (UserVO) session.getAttribute("loginUser");

//		Paging paging = roomViewService.getPaging("review", currentPageNo, 4);
//		modelAndView.addObject("paging", paging);
//		System.out.println(roomViewService.getReviewList(paging, rv.getRoomsId()).toString());
//		modelAndView.addObject("review", roomViewService.getReviewList(paging, rv.getRoomsId()));
//		System.out.println(rv);

		UserVO hostVO = new UserVO();
		rv = roomViewService.getViewRooms(rv);
		hostVO.setUserId(rv.getHostId());
		modelAndView.addObject("hostInfo", roomViewService.getHostInfo(hostVO));
		modelAndView.addObject("amenities", roomViewService.getAmenities(av));
		modelAndView.addObject("selectedRoom", rv);
		modelAndView.addObject("reviewSummary", roomViewService.getReviewSummary());
		modelAndView.addObject("roomImages", roomViewService.getRoomImages(rimgv));

		if (user == null) {
			modelAndView.addObject("wish", 2);
		} else {
			modelAndView.addObject("wish", wishService.wishSelect(user.getUserId(), roomsId));
		}
		modelAndView.setViewName("rooms/viewRooms");

		return modelAndView;
	}

	@RequestMapping(value = "/rooms/viewRooms", method = RequestMethod.POST)
	public ModelAndView getSearchRoomsHome(RoomsVO rv) {
		ModelAndView modelAndView = new ModelAndView();

		modelAndView.setViewName("rooms/viewRooms");
		return modelAndView;
	}
}
