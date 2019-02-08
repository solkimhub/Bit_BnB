package com.bit.bnb.mypage.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.bit.bnb.mypage.model.WishVO;

public interface WishDao {
	
	public int wishInsert(@Param("userId") String userId, @Param("roomsId") int roomsId); // 즐겨찾기 넣어주기
	public int wishSelect(@Param("userId") String userId, @Param("roomsId") int roomsId); // 즐겨찾기 있는지 찾아주기
	public int wishDelete(@Param("userId") String userId, @Param("roomsId") int roomsId); // 즐겨찾기 삭제
	public List<WishVO> wishList(@Param("userId") String userId, @Param("address") String address); // 즐겨찾기 목록
	public List<WishVO> wishDivList(String userId); // div생성용 즐겨찾기 목록
	public int wishDivCnt(@Param("userId") String userId, @Param("address") String address); // 지역별 몇개있는지!
	public List<WishVO> wishRoomImg(@Param("userId") String userId, @Param("address") String address); // 즐겨찾기 사진목록
	public List<WishVO> wishDivImg(@Param("userId") String userId); // 즐겨찾기 div 이미지
}
