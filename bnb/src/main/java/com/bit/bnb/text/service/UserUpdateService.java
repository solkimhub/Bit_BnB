package com.bit.bnb.text.service;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bit.bnb.text.dao.TextDetectionDao;
import com.bit.bnb.user.model.UserVO;

@Service
public class UserUpdateService {
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	TextDetectionDao dao;
	int check = 0;

	public int userUpdate(String userId) {
		dao = sqlSessionTemplate.getMapper(TextDetectionDao.class);
		
		try {
			check = dao.userUpdate(userId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return check;
	}
}
