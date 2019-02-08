package com.bit.bnb.mypage.service;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bit.bnb.mypage.dao.MypageUserDao;
import com.bit.bnb.user.model.UserVO;
import com.bit.bnb.user.service.EncryptSHA256Service;

@Service
public class MypageService {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	@Autowired
	private EncryptSHA256Service sha256Service; // 비밀번호 암호화처리

	private MypageUserDao mypageUserDao;

	public UserVO mypageView(String userId) { // 마이페이지 메인 보여주기
		mypageUserDao = sqlSessionTemplate.getMapper(MypageUserDao.class);
		return mypageUserDao.userPick(userId);
	}

	public int userDelete(String userId) { // 유저 탈퇴
		mypageUserDao = sqlSessionTemplate.getMapper(MypageUserDao.class);
		return mypageUserDao.userDelete(userId);
	}

	public int myUserUpdate(UserVO member, HttpServletRequest request) throws IllegalStateException, IOException { // 유저수정

		mypageUserDao = sqlSessionTemplate.getMapper(MypageUserDao.class);

		/*
		 * String uploadUri = "/resources/images/userphoto";
		 * 
		 * // uploadUri 경로의 시스템 경로 String dir =
		 * request.getSession().getServletContext().getRealPath(uploadUri);
		 * 
		 * // DB 저장용 파일 이름, 물리적 저장할때의 이름 String imgName = "";
		 * 
		 * if (!member.getUserPhotoFile().isEmpty()) {
		 * 
		 * imgName = member.getUserId()+"_" +
		 * member.getUserPhotoFile().getOriginalFilename();
		 * 
		 * // 물리적 저장 member.getUserPhotoFile().transferTo(new File(dir, imgName));
		 * 
		 * // DB 에 저장할 이름 SET member.setUserPhoto(imgName); } else { imgName =
		 * request.getParameter("before"); member.setUserPhoto(imgName); }
		 */

		System.out.println(member.getUserPhoto().equals(""));
		if (member.getUserPhoto().equals("")) {
			member.setUserPhoto(request.getParameter("before"));
		}

		if (member.getUserPw() != null) {
			// 비밀번호 암호화해서 다시 넣어준다
			String ePw = sha256Service.encrypt(member.getUserPw());
			member.setUserPw(ePw);
		}

		System.out.println(member.toString());
		return mypageUserDao.userUpdate(member);
	}

	public UserVO myUserPick(String userId) { // 유저선택

		mypageUserDao = sqlSessionTemplate.getMapper(MypageUserDao.class);
		return mypageUserDao.userPick(userId);
	}

}
