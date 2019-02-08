package com.bit.bnb.reservation.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.bit.bnb.reservation.model.ReservationInfo;
import com.bit.bnb.reservation.service.ReservationCheckService;

@Controller
public class ReservationPossibleController {
	
	@Autowired
	ReservationCheckService service;
	
	@RequestMapping(value = "/reservation/possible", method = RequestMethod.GET)
	@ResponseBody
	public List<ReservationInfo> getReservation(@RequestParam("roomsId") int roomsId) {
		List<ReservationInfo> reservationInfo = service.getDay(roomsId);
		
		return reservationInfo;
	}
}