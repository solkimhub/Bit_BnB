package com.bit.bnb.reservation.service;



import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.bit.bnb.reservation.dao.ReservationDao;


@Service
public class ReservationPriceService {
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	ReservationDao dao;
	
	int price = 0;
	
	@Transactional
	public int getPrice(String checkInStr, String checkOutStr, int cnt, int roomsId) {
		dao = sqlSessionTemplate.getMapper(ReservationDao.class);
		
		try {
			price = dao.getPrice(checkInStr, checkOutStr, cnt, roomsId);
		} catch (Exception e) {
			System.out.println("체크아웃 또는 체크아웃 둘중 한개 안눌림");
		}
		
		return price;
	}
}