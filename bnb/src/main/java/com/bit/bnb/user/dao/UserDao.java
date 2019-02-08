package com.bit.bnb.user.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.bit.bnb.user.model.UserVO;

@Repository
public class UserDao {
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	private String userMapperPath = "mappers.UserMapper";
	
	public int insertUser(UserVO userVO) {
		return sqlSessionTemplate.update(userMapperPath+".insertUser", userVO);
	}
	
	public UserVO selectUser(String userId) {
		return sqlSessionTemplate.selectOne(userMapperPath+".selectUser", userId);
	}
	
	public UserVO selectNickName(String nickName) {
		return sqlSessionTemplate.selectOne(userMapperPath+".selectNickName", nickName);
	}
	
	public int updateUserKey(String userId) {
		return sqlSessionTemplate.update(userMapperPath+".updateUserKey", userId);
	}
	
	public int forSearchPw(HashMap<String, Object> map) {
		return sqlSessionTemplate.update(userMapperPath+".forSearchPw", map);
	}
	
	public int updateUserPw(HashMap<String, String> map) {
		return sqlSessionTemplate.update(userMapperPath+".updateUserPw", map);
	}
	
	public int updateUserDisabled(String userId) {
		return sqlSessionTemplate.update(userMapperPath+".updateUserDisabled", userId);
	}

}
