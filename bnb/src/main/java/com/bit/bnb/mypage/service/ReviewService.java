package com.bit.bnb.mypage.service;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bit.bnb.mypage.dao.ReviewDao;
import com.bit.bnb.mypage.model.ReviewSearchVO;
import com.bit.bnb.mypage.model.ReviewVO;
import com.bit.bnb.reservation.model.ReservationInfo;

@Service
public class ReviewService {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	private ReviewDao reviewDao;

	public int reviewWrite(ReviewVO review) { // 리뷰쓰기
		reviewDao = sqlSessionTemplate.getMapper(ReviewDao.class);
		return reviewDao.reviewWrite(review);
	}

	public List<ReviewVO> reviewSearchList(String userId, ReviewSearchVO rvs) { // 리뷰 찾기
		reviewDao = sqlSessionTemplate.getMapper(ReviewDao.class);
		return reviewDao.searchReview(userId, rvs);
	}

	public List<ReviewVO> HostReviewSearchList(String userId, ReviewSearchVO rvs) { // 호스트가써준리뷰찾기
		reviewDao = sqlSessionTemplate.getMapper(ReviewDao.class);
		return reviewDao.searchReviewHost(userId, rvs);
	}

	public int reviewEdit(ReviewVO review) { // 리뷰 수정
		reviewDao = sqlSessionTemplate.getMapper(ReviewDao.class);
		return reviewDao.reviewEdit(review);
	}

	public ReviewVO reviewPick(int reservationNum) { // 리뷰가져오기
		reviewDao = sqlSessionTemplate.getMapper(ReviewDao.class);
		return reviewDao.reviewPick(reservationNum);
	}

	public int reviewDelete(int reservationNum) { // 리뷰 지우기
		reviewDao = sqlSessionTemplate.getMapper(ReviewDao.class);
		return reviewDao.reviewDelete(reservationNum);
	}
	
	public List<ReviewVO> reviewToListView(String userId) { // 내가 쓴 후기
		reviewDao = sqlSessionTemplate.getMapper(ReviewDao.class);
		return reviewDao.reviewToList(userId);
	}

	public List<ReviewVO> reviewWriteList(String userId) { // 써야할리스트
		reviewDao = sqlSessionTemplate.getMapper(ReviewDao.class);
		return reviewDao.reviewWriteList(userId);
	}
	
	public List<ReviewVO> hostReview(String userId) { // 호스트가 써준거 ㅎ
		reviewDao = sqlSessionTemplate.getMapper(ReviewDao.class);
		return reviewDao.hostReview(userId);
	}
	
	public List<ReservationInfo> reviewChk(int reservationNum){ // 리뷰 숙박정보
		reviewDao = sqlSessionTemplate.getMapper(ReviewDao.class);
		return reviewDao.reviewChk(reservationNum);
	}
	
	public List<ReservationInfo> reviewChk2(int reservationNum){ // 리뷰 숙박정보
		reviewDao = sqlSessionTemplate.getMapper(ReviewDao.class);
		return reviewDao.reviewChk2(reservationNum);
	}

}
