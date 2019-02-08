package com.bit.bnb.user.service;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.security.NoSuchAlgorithmException;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.bit.bnb.user.dao.UserDao;
import com.bit.bnb.user.model.UserVO;

@Service
public class PasswordSearchService {

	@Autowired
	private GetRandomStringService getRandomStringService;

	@Autowired
	private MailSendService mailSendService;

	@Autowired
	private EncryptSHA256Service sha256Service;
	
	@Autowired
	private EncryptAES256Service aes256Service;

	@Autowired
	private UserDao userDao;

	// 유저키 변경 + 메일보내기
	@Transactional
	public String sendPwUpdateLink(String userId) throws NoSuchAlgorithmException, UnsupportedEncodingException, GeneralSecurityException {

		System.out.println("서비스진입 - 유저아이디 : " + userId);

		UserVO user = new UserVO();
		String result = "idNotFound";

		user = userDao.selectUser(userId);
		// 입력된 이메일의 계정있는지 확인

		System.out.println("user : " + user);

		if (user != null) {
			// 존재하는 계정일 경우
			if (user.getUserKey().equals("g")) {
				
				// 구글 계정일 경우
				result = "google";
				
			} else if (!user.getUserKey().equals("g") && user.getDisabled() != 0) {
				// 구글계정이 아니고 탈퇴하지 않은 회원인 경우 비밀번호를 재설정할 수 있는 링크를 메일로 전송합니다.
				// 유저키 랜덤발생
				String userKey = getRandomStringService.getRandomString();
				String aesKey = aes256Service.encrypt(userKey);

				HashMap<String, Object> map = new HashMap<String, Object>();
				
				map.put("userId", userId);
				map.put("userKey", aesKey);
				map.put("disabled", 2);

				System.out.println("유저로그인서비스 - 맵: " + map);

				int resultCnt = userDao.forSearchPw(map);

				System.out.println("쿼리결과 : " + resultCnt);

				// 그리고 메일발송
				if (resultCnt == 1) {
					mailSendService.mailSendSearchPw(userId, user.getUserName(), userKey);

					result = "mailSendForPw";
				} else { // 인증키 업데이트 실패시

					result = "mailSendForPwFail";
				}
			}

		}
		System.out.println("패스워드서치서비스 result: " + result);
		return result;
	}


	// 메일 링크 클릭 - 유저 아이디와 키를 비교해서 비밀번호 재설정하는 폼을 띄워준다
	@Transactional
	public String getUpdateUserPwForm(String userId, String userKey) throws NoSuchAlgorithmException, UnsupportedEncodingException, GeneralSecurityException {

		String result = "user/expiredUpdatePw";
		UserVO user = new UserVO();
		user = userDao.selectUser(userId);
		String dKey = aes256Service.decrypt(user.getUserKey());

		if (dKey.equals(userKey)) {
			// model.addAttribute("userId", userId);
			result = "user/updatePwForm";
		}

		return result;
	}

	// 비밀번호 재설정
	@Transactional
	public int updateUserPw(String userId, String userPw, HttpSession session) {

		System.out.println("서비스진입");

		String ePw = sha256Service.encrypt(userPw);

		HashMap<String, String> map1 = new HashMap<String, String>();
		map1.put("userPw", ePw);
		map1.put("userId", userId);

		System.out.println("맵1 : " + map1);

		
		HashMap<String, Object> map2 = new HashMap<String, Object>();
		map2.put("userId", userId);
		map2.put("userKey", "y");
		map2.put("disabled", 1);
		userDao.forSearchPw(map2);
		
		int resultCnt = userDao.updateUserPw(map1);

		System.out.println("결과값 : " + resultCnt);

		if (resultCnt == 1) {
			if (session.getAttribute("updatePw") != null) {
				session.removeAttribute("updatePw");
			}
			session.setAttribute("updatePw", "updatePw");
		}

		return resultCnt;
	}
}