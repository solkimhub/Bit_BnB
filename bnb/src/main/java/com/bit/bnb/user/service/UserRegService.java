package com.bit.bnb.user.service;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.security.NoSuchAlgorithmException;
import java.text.SimpleDateFormat;
import java.util.Locale;
import java.util.Random;

import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.bit.bnb.user.dao.UserDao;
import com.bit.bnb.user.model.UserVO;

@Service
public class UserRegService {
	
	@Autowired
	private UserDao userDao;
	
	@Autowired
	private EncryptSHA256Service sha256Service;
	
	@Autowired
	private EncryptAES256Service aes256Service;
	
	/*@Autowired
	private JavaMailSender mailSender;*/
	
	@Autowired
	private MailSendService mailSendService;
	
	@Autowired
	private DateCheckService dateCheckService;
	
	@Autowired
	private GetRandomStringService getRandomStringService;
	
	private UserVO user;
	
	@Transactional
	public int userReg(UserVO userVO, HttpServletRequest request, HttpSession session) throws IllegalStateException, IOException, NoSuchAlgorithmException, GeneralSecurityException {
		
		int resultCnt = 0;
		
		// 빠짐없이 가입항목을 다 입력했는지 확인
		if(userVO.getUserId() != null && userVO.getUserPw() != null && 
		   userVO.getUserName() != null && userVO.getYear() != null && 
		   userVO.getMonth() !=null &&  userVO.getDay() != null && userVO.getNickName() != null) {
			
			// 아이디 중복검사
			user = userDao.selectUser(userVO.getUserId());
			
			// 아이디 중복이 아니면 가입시도
			if(user == null) {
				
				// 이름 암호화해서 다시 넣어주기
				/*String eName = aes256Service.encrypt(userVO.getUserName());
				userVO.setUserName(eName);*/
				
				// 비밀번호 암호화해서 다시 넣어준다
				String ePw = sha256Service.encrypt(userVO.getUserPw());
				userVO.setUserPw(ePw);
				
				// 생년월일을 합친다
				String birth = userVO.getYear()+"-"+userVO.getMonth()+"-"+userVO.getDay();
				
				int year = Integer.parseInt(userVO.getYear());
				int month = Integer.parseInt(userVO.getMonth());
				int day = Integer.parseInt(userVO.getDay());
				
				int age = dateCheckService.getAge(year, month, day);
				
				// 생년월일이 유효한지 검사해서 유효하지 않으면 OR 만나이 18세 미만일 경우 리턴 0 
				if(!dateCheckService.dateCheck(birth) || age<18) {
					session.setAttribute("InvalidBirth", "InvalidBirth");
					System.out.println("생년월일의 상태가...???");
					return 0;
				}
				
				// 생년월일이 유효하면 userVO에 추가한 후 가입 진행
				userVO.setBirth(birth);

				String userKey = getRandomStringService.getRandomString();
				
				// 유저키를 암호화 - AES
				String aesKey = aes256Service.encrypt(userKey);
				
				userVO.setUserKey(aesKey);
				
				// 인서트 시도
				resultCnt = userDao.insertUser(userVO);
				
				// 인서트가 성공적으로 되었으면 인증메일 발송하고 세션 생성(메일인증안내)
				if(resultCnt == 1) {
					mailSendService.mailSendWithUserKey(userVO.getUserId(), userVO.getUserName(), userKey, request);
					
					if (session.getAttribute("mailConfirm") != null) {
						session.removeAttribute("mailConfirm");
					}
					session.setAttribute("mailConfirm", "mailConfirm");
				}
				
			// 아이디 중복이면 가입실패
			} else { 
				resultCnt = 0;
			}
		// 입력시 빠진 항목이 있으면 가입실패
		} else {
			resultCnt = 0;
		}
		return resultCnt;
	}
	
	// 아이디 중복검사
	@Transactional
	public String getUserIdChk(String userId) {
		user = userDao.selectUser(userId);
		
		String userIdChk = "n";
		
		if(user == null) {
			userIdChk = "y";
		} /*else if(user != null && user.getDisabled() == 0) {
			userIdChk = "d";
		}*/
		
		return userIdChk;
	}

	
	// 닉네임 중복검사
	@Transactional
	public String getNickNameChk(String nickName) {
		user = userDao.selectNickName(nickName);
		
		String nickNameChk = "n";
		
		if(user == null) {
			nickNameChk = "y";
		}
		return nickNameChk;
	}
	
	
	// 인증메일 확인
	@Transactional
	public int userConfirm(String userId, String userKey) throws NoSuchAlgorithmException, UnsupportedEncodingException, GeneralSecurityException {
		
		int result = 0;
		UserVO user = new UserVO();
		
		user = userDao.selectUser(userId);
		
		// 해당 유저의 유저키를 복호화해서 dKey에 저장
		String dKey = aes256Service.decrypt(user.getUserKey());
		
		// 이미 인증된 회원이면 ( 유저키가 y )
		if(user != null && user.getUserKey().equals("y")) {
			result = 0;
		} else if (user != null && dKey.equals(userKey)) {
			// 인증키 업데이트 쿼리
			result = userDao.updateUserKey(userId);
		}

		/*if(user != null && user.getUserKey().equals(userKey)) {
				// 인증키 업데이트 쿼리
				result = userDao.updateUserKey(userId);
		}*/
		
		return result;
	}
	
	
	
	@Transactional
	public int googleReg(UserVO userVO, HttpServletRequest request, HttpSession session) throws IllegalStateException, IOException, NoSuchAlgorithmException, GeneralSecurityException {
		int resultCnt = 0;

		// DB 저장용 파일 이름, 물리적 저장할때의 이름
		String imgName = "";
				
		// 물리적 저장 경로
		String uploadUri = "/resources/images/userphoto";
				
		// uploadUri 경로의 시스템 경로
		String dir = request.getSession().getServletContext().getRealPath(uploadUri);
				
		if(!userVO.getPhotoFile().isEmpty()) {
				
			imgName = userVO.getUserId()+"_"+userVO.getPhotoFile().getOriginalFilename();
					
			// 물리적 저장
			userVO.getPhotoFile().transferTo(new File(dir, imgName));
					
			// DB에 저정할 이름 SET
			userVO.setUserPhoto(imgName);
			
			// System.out.println(dir);
			// System.out.println(imgName);
		}
		
		// 빠짐없이 가입항목을 다 입력했는지 확인
		if(userVO.getUserId() != null && userVO.getUserPw() != null && 
		   userVO.getUserName() != null && userVO.getYear() != null && 
		   userVO.getMonth() !=null &&  userVO.getDay() != null && userVO.getNickName() != null) {
			
			// 아이디 중복검사
			user = userDao.selectUser(userVO.getUserId());
			
			// 아이디 중복이 아니면 가입시도
			if(user == null) {
				
				// 이름 암호화해서 다시 넣어주기
				/*String eName = aes256Service.encrypt(userVO.getUserName());
				userVO.setUserName(eName);*/
				
				// 비밀번호 암호화해서 다시 넣어준다
				String ePw = sha256Service.encrypt(userVO.getUserPw());
				userVO.setUserPw(ePw);
			
				// 생년월일을 합친다
				String birth = userVO.getYear()+"-"+userVO.getMonth()+"-"+userVO.getDay();
				
				int year = Integer.parseInt(userVO.getYear());
				int month = Integer.parseInt(userVO.getMonth());
				int day = Integer.parseInt(userVO.getDay());
				
				int age = dateCheckService.getAge(year, month, day);
				
				// 생년월일이 유효한지 검사해서 유효하지 않으면 OR 만나이 18세 미만일 경우 리턴 0 
				if(!dateCheckService.dateCheck(birth) || age<18) {
					session.setAttribute("InvalidBirth", "InvalidBirth");
					System.out.println("생년월일의 상태가...???");
					return 0;
				}
				
				// 생년월일이 유효하면 userVO에 추가한 후 가입 진행
				userVO.setBirth(birth);

				// 구글 계정이므로 유저키에는 g를 삽입한다
				userVO.setUserKey("g");
				
				// 인서트 시도
				resultCnt = userDao.insertUser(userVO);
				
			// 아이디 중복이면 가입실패
			} else {
				resultCnt = 0;
			}
		// 입력시 빠진 항목이 있으면 가입실패
		} else {
			resultCnt = 0;
		}
		return resultCnt;
	}
	
}
