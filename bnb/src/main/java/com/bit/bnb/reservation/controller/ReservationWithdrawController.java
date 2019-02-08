package com.bit.bnb.reservation.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bit.bnb.reservation.service.ReservationWithdrawService;
import com.bit.bnb.user.model.UserVO;

@Controller
public class ReservationWithdrawController {
	
	@Autowired
	ReservationWithdrawService service;
	UserVO userInfo = null;
	
	@RequestMapping(value="/reservation/withdraw", method = RequestMethod.POST)
	@ResponseBody
	public UserVO withdraw(UserVO user) {
		userInfo = service.withdraw(user);
		return userInfo;
	}
	
	@RequestMapping(value="/reservation/withdrawDo", method = RequestMethod.GET)
	@ResponseBody
	public int withdrawDo(int price, String userId) {
		int check = service.withdrawDo(price, userId);
		return check;
	}
}
