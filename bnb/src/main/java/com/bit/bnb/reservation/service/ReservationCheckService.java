package com.bit.bnb.reservation.service;

import java.util.Date;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.bit.bnb.reservation.dao.ReservationDao;
import com.bit.bnb.reservation.model.ReservationInfo;


@Service
public class ReservationCheckService {
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	ReservationDao dao;
	
	List<ReservationInfo> reservationInfo = null;
	int duration = 0;
	
	@Transactional
	public List<ReservationInfo> getDay(int roomsId) {
		dao = sqlSessionTemplate.getMapper(ReservationDao.class);
		
		try {
			reservationInfo = dao.getReservation(roomsId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return reservationInfo;
	}
	
	@Transactional
	public int getDuration(String checkInStr, String nowStr, int roomsId) {
		dao = sqlSessionTemplate.getMapper(ReservationDao.class);
		try {
			duration = dao.getDuration(checkInStr, nowStr, roomsId);
		} catch (Exception e) { // 다음 체크인이 없을 때
			duration = 400;
		}
		
		return duration;
	}
}