package com.bit.bnb.reservation.controller;


import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bit.bnb.reservation.service.ReservationCheckService;

@Controller
public class ReservationPossibleDurationController {
   
   @Autowired
   ReservationCheckService service;
   
   @RequestMapping(value = "/reservation/possibleDuration", method = RequestMethod.GET)
   @ResponseBody
   public int getReservation(@RequestParam("checkIn") Date checkIn, @RequestParam("now") Date now,@RequestParam("roomsId") int roomsId) {
      DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
      String checkInStr = format.format(checkIn);
      String nowStr = format.format(now);
      int duration = service.getDuration(checkInStr, nowStr, roomsId);
	  

      return duration;
   }
}