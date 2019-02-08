package com.bit.bnb.reservation.service;


import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.bit.bnb.reservation.dao.ReservationDao;
import com.bit.bnb.reservation.model.ReservationInfo;


@Service
public class ReservationDoService {
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	ReservationDao dao;
	int check = 0;
	
	@Transactional
	public int reservationDo(ReservationInfo info) {
		dao = sqlSessionTemplate.getMapper(ReservationDao.class);
		try {
			check = dao.ReservationDo(info);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return check;
	}
}