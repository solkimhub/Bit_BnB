package com.bit.bnb.mypage.service;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bit.bnb.mypage.dao.WishDao;
import com.bit.bnb.mypage.model.ReviewVO;
import com.bit.bnb.mypage.model.WishVO;

@Service
public class WishService {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	private WishDao wishDao;

	public int wishInput(String userId, int roomsId) { // 즐겨찾기 insert

		wishDao = sqlSessionTemplate.getMapper(WishDao.class);
		return wishDao.wishInsert(userId, roomsId);
	}

	public int wishDelete(String userId, int roomsId) { // 즐겨찾기 삭제

		wishDao = sqlSessionTemplate.getMapper(WishDao.class);
		return wishDao.wishDelete(userId, roomsId);
	}

	public int wishSelect(String userId, int roomsId) { // 즐겨찾기 있는지확인

		wishDao = sqlSessionTemplate.getMapper(WishDao.class);
		return wishDao.wishSelect(userId, roomsId);
	}

	public List<WishVO> wishList(String userId, String address) { // 지역별로나뉜 목록 + 리뷰수/리뷰평균

		wishDao = sqlSessionTemplate.getMapper(WishDao.class);
		return wishDao.wishList(userId, address);
	}

	public List<WishVO> wishDivList(String userId) { // div생성용 즐겨찾기 목록

		wishDao = sqlSessionTemplate.getMapper(WishDao.class);
		return wishDao.wishDivList(userId);
	}

	public int wishDivCnt(String userId, String address) { // 지역별 몇개 즐겨찾기했는지 찾아줌

		wishDao = sqlSessionTemplate.getMapper(WishDao.class);
		return wishDao.wishDivCnt(userId, address);
	}

	public List<WishVO> wishRoomImg(String userId, String address) {

		wishDao = sqlSessionTemplate.getMapper(WishDao.class);
		return wishDao.wishRoomImg(userId, address);
	}

	public List<WishVO> wishDivImg(String userId) {

		wishDao = sqlSessionTemplate.getMapper(WishDao.class);
		return wishDao.wishDivImg(userId);
	}

}
