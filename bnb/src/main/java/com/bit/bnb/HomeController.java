package com.bit.bnb;

import java.util.Locale;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.bit.bnb.rooms.model.RoomsImgVO;
import com.bit.bnb.rooms.model.RoomsVO;
import com.bit.bnb.rooms.service.RoomViewService;
import com.bit.bnb.rooms.service.RoomsListService;

@Controller
public class HomeController {

	// private static final Logger logger =
	// LoggerFactory.getLogger(HomeController.class);

	@Autowired
	RoomsListService roomsListService;

	@Autowired
	RoomViewService roomViewService;

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public ModelAndView home(Locale locale, Model model) {

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("main");
		RoomsVO rv = roomsListService.getRandomRoom();
		modelAndView.addObject("randomRoom", rv);
		RoomsImgVO rimgv = new RoomsImgVO();
		rimgv.setRoomsId(rv.getRoomsId());
		modelAndView.addObject("roomImages", roomViewService.getRoomImages(rimgv));
		
		// logger.info("Welcome home! The client locale is {}.", locale);
		//
		// Date date = new Date();
		// DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG,
		// DateFormat.LONG, locale);
		//
		// String formattedDate = dateFormat.format(date);
		//
		// model.addAttribute("serverTime", formattedDate );

		// 랜덤방

		return modelAndView;
	}

}
