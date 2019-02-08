package com.bit.bnb.user.service;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.security.NoSuchAlgorithmException;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.bit.bnb.chatting.service.NewMessageCkServie;
import com.bit.bnb.user.dao.UserDao;
import com.bit.bnb.user.model.UserVO;

@Service
public class UserLoginService {

	@Autowired
	private UserDao userDao;

	@Autowired
	private EncryptSHA256Service sha256Service;
	
	@Autowired
	private NewMessageCkServie messageCkServie;

	@Transactional
	public String userLogin(String userId, String userPw, HttpSession session) throws NoSuchAlgorithmException, UnsupportedEncodingException, GeneralSecurityException {

		String result = "loginFail";

		UserVO user = userDao.selectUser(userId);

		String ePw = sha256Service.encrypt(userPw);
		
		
		if(user != null) {
		
			if(user.getUserKey().equals("g") && user.getDisabled() == 1) {
				// 로그인 시도한 아이디가 구글계정이고 탈퇴하지 않은 회원이면
				result = "google";
				
			} else if(user.getUserKey().equals("y") && user.getUserPw().equals(ePw) && user.getDisabled() == 1) {
				// 로그인 시도한 아이디가 일반계정이고 탈퇴하지 않은 회원이면 - 로그인처리
				// 세션에 사용자 데이터를 저장한다 - 보안을 위해서 패스워드는 비워줌
				user.setUserPw("");
				// 이름은 복호화해서 넣어준다
				/*String dName = aes256Service.decrypt(user.getUserName());
				user.setUserName(dName);*/

				// 만약 loginUser라는 세션값이 이미 존재하고 있다면 지워준다
				if (session.getAttribute("loginUser") != null) {
					session.removeAttribute("loginUser");
				}

				// 세션에 loginUser라는 이름으로 유저 인스턴스를 저장
				session.setAttribute("loginUser", user);

				messageCkServie.getList(user.getUserId(), session);

				result = "loginSuccess";
				// 로그인 처리 끝
			} else if(user.getUserKey().length()>1) {
				// 유저키의 사이즈가 1 이상이면(난수인 경우)
				
				if(user.getDisabled() == 1) {
					// 이메일 인증 요망
					result = "userKeyConfirm";
				} else if(user.getDisabled() == 2) {
				
					HashMap<String, Object> map = new HashMap<String, Object>();
					map.put("userId", userId);
					map.put("userKey", "y");
					map.put("disabled", 1);
					userDao.forSearchPw(map);
					
					// 세션에 사용자 데이터를 저장한다 - 보안을 위해서 패스워드는 비워줌
					user.setUserPw("");

					// 만약 loginUser라는 세션값이 이미 존재하고 있다면 지워준다
					if (session.getAttribute("loginUser") != null) {
						session.removeAttribute("loginUser");
					}

					// 세션에 loginUser라는 이름으로 유저 인스턴스를 저장
					session.setAttribute("loginUser", user);

					messageCkServie.getList(user.getUserId(), session);

					result = "loginSuccess";
				}
			}
		}
		return result;
	}

	@Transactional
	public String googleLogin(String gId, HttpSession session) throws NoSuchAlgorithmException, UnsupportedEncodingException, GeneralSecurityException {

		UserVO userVO = userDao.selectUser(gId);

		String result = "";

		// 구글아이디가 db에 있고 유저키가 g이면 로그인처리 : 구글계정으로 가입되어있는 경우
		if (userVO != null && userVO.getUserKey().equals("g") && userVO.getDisabled() == 1) {

			// 세션에 사용자 데이터를 저장한다 - 보안을 위해서 패스워드는 비워줌
			userVO.setUserPw("");
			// 이름은 복호화해서 넣어준다
//			String dName = aes256Service.decrypt(userVO.getUserName());
//			userVO.setUserName(dName);

			// 만약 loginUser라는 세션값이 이미 존재하고 있다면 지워준다
			if (session.getAttribute("loginUser") != null) {
				session.removeAttribute("loginUser");
			}

			// 세션에 유저VO 저장
			session.setAttribute("loginUser", userVO);

			messageCkServie.getList(userVO.getUserId(), session);

			result = "googleLoginSuccess";

		} else if (userVO != null && !userVO.getUserKey().equals("g") && userVO.getDisabled() == 1) {

			if (session.getAttribute("loginUser") != null) {
				session.removeAttribute("loginUser");
			}

			result = "notGoogleUser";

		} else if (userVO != null && userVO.getDisabled() == 0) {

			if (session.getAttribute("loginUser") != null) {
				session.removeAttribute("loginUser");
			}

			result = "disabled";

		} else {

			result = "googleUserReg";
		}
		return result;
	}
	
}
