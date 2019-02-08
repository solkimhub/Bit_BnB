package com.bit.bnb.rooms.controller;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bit.bnb.rooms.model.RoomsVO;
import com.bit.bnb.rooms.service.RoomViewService;
import com.bit.bnb.rooms.util.Paging;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
public class RoomsReviewListController {

	@Autowired
	RoomViewService roomViewService;

	@RequestMapping(value = "/rooms/getReveiws", method = RequestMethod.GET, produces = "application/text; charset=utf8")
	@ResponseBody
	public String getRoomsReviewList(RoomsVO rv,
			@RequestParam(value = "page", required = false, defaultValue = "1") int currentPageNo)
			throws JsonProcessingException {
		// Paging paging = roomViewService.getPaging("review", currentPageNo, 4);
		Paging paging = roomViewService.getReviewaging(rv.getRoomsId(), currentPageNo, 2);

		// Object to JSON in String
		ObjectMapper mapper = new ObjectMapper();
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("review", roomViewService.getReviewList(paging, rv.getRoomsId()));
		map.put("paging", paging);
		// System.out.println(roomViewService.getReviewList(paging, rv.getRoomsId()));
		// https://www.baeldung.com/jackson-serialize-dates

		String jsonInString = mapper.writerWithDefaultPrettyPrinter().writeValueAsString(map);
		return jsonInString;
	}
}
