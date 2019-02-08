package com.bit.bnb.reservation.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bit.bnb.reservation.model.ReservationInfo;
import com.bit.bnb.reservation.service.ReservationPriceService;

@Controller
public class ReservationPriceController {
	
	@Autowired
	ReservationPriceService service;
	
	@RequestMapping(value = "/reservation/price", method = RequestMethod.GET)
	@ResponseBody
	public int getReservation(@RequestParam("checkIn") Date checkIn,@RequestParam("checkOut") Date checkOut,@RequestParam("cnt") int cnt,@RequestParam("roomsId") int roomsId) {
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
	    String checkInStr = format.format(checkIn);
	    String checkOutStr = format.format(checkOut);
		int price = service.getPrice(checkInStr, checkOutStr, cnt, roomsId);
		
		return price;
	}
}