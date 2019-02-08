package com.bit.bnb.text.dao;

import com.bit.bnb.user.model.UserVO;

public interface TextDetectionDao {

	UserVO checkInfo(String userId) throws Exception;

	int userUpdate(String userId) throws Exception;
	
}
