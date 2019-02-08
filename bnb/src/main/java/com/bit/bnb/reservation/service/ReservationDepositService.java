package com.bit.bnb.reservation.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bit.bnb.reservation.dao.ReservationDao;
import com.bit.bnb.reservation.model.ReservationInfo;

@Service
public class ReservationDepositService {
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	ReservationDao dao;
	
	public void deposit(ReservationInfo reservationInfo) {
		dao = sqlSessionTemplate.getMapper(ReservationDao.class);
		
		try {
			dao.deposit(reservationInfo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
}
