package com.bit.bnb.mypage.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.bit.bnb.mypage.model.ReviewSearchVO;
import com.bit.bnb.mypage.model.ReviewVO;
import com.bit.bnb.reservation.model.ReservationInfo;

public interface ReviewDao {
	
	public List<ReviewVO> reviewToList(String userId); // 내가쓴 리뷰 리스트
	public List<ReviewVO> reviewWriteList(String userId); // 써야할 리스트 찾아줌
	public ReviewVO reviewPick(int reservationNum); // 수정해야할 리뷰 찾기
	public int reviewWrite(ReviewVO review); // 후기쓰기
	public int reviewDelete(int reservationNum); // 삭제하기
	public int reviewEdit(ReviewVO review); // 리뷰 수정
	public List<ReviewVO> searchReview(@Param("userId") String userId, @Param("rvs") ReviewSearchVO rvs); // 리뷰 검색하기 내가쓴거
	public List<ReviewVO> searchReviewHost(@Param("userId") String userId, @Param("rvs") ReviewSearchVO rvs); // 리뷰 검색 내게쓴거
	public List<ReviewVO> hostReview(String userId); // 호스트가 쓴 리뷰
	public List<ReservationInfo> reviewChk(int reservationNum); // 리뷰 예약정보조회
	public List<ReservationInfo> reviewChk2(int reservationNum); // 리뷰 예약정보조회
}
