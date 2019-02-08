package com.bit.bnb.mypage.dao;

import com.bit.bnb.user.model.UserVO;

public interface MypageUserDao {
	
	public int userUpdate(UserVO member); // 유저정보 수정
	public UserVO userPick(String userId); // 유저찾기
	public int userDelete(String userId); // 유저삭제

}
