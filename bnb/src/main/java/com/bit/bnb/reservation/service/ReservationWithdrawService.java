package com.bit.bnb.reservation.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bit.bnb.reservation.dao.ReservationDao;
import com.bit.bnb.user.model.UserVO;

@Service
public class ReservationWithdrawService {
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	ReservationDao dao;
	UserVO user = null;
	int check = 0;
	
	public UserVO withdraw(UserVO userInfo) {
		dao = sqlSessionTemplate.getMapper(ReservationDao.class);
		
		try {
			user = dao.withdraw(userInfo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return user;
	}

	public int withdrawDo(int price, String userId) {
		dao = sqlSessionTemplate.getMapper(ReservationDao.class);
		
		try {
			check = dao.withdrawDo(price, userId);
		} catch (Exception e) {
			
			e.printStackTrace();
		}
		return check;
	}
}
