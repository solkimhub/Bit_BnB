package com.bit.bnb.user.controller;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.security.NoSuchAlgorithmException;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bit.bnb.user.service.PasswordSearchService;

@Controller
public class PasswordSearchController {
	
	@Autowired
	private PasswordSearchService passwordSearchService;

	// 비밀번호 찾기용 유저키 재설정, 유저 아이디를 받아서 비밀번호 재설정 링크가 담긴 메일을 전송한다
	@RequestMapping(value="/sendPwUpdateLink", method=RequestMethod.POST)
	@ResponseBody
	public String searchPw(@RequestParam("userId") String userId) throws NoSuchAlgorithmException, UnsupportedEncodingException, GeneralSecurityException {
		
		System.out.println("컨트롤러진입");
		// 유저 아이디 받아서 서비스로 넘긴다
		String result = passwordSearchService.sendPwUpdateLink(userId);
		
		return result;
	}
	
	// 메일에서 비밀번호 재설정하기 링크 클릭했을때
	@RequestMapping(value="/user/updatePwForm", method=RequestMethod.POST)
	public String getUpdatePwForm(@RequestParam("userId") String userId,
									 @RequestParam("userKey") String userKey,
									 Model model) throws NoSuchAlgorithmException, UnsupportedEncodingException, GeneralSecurityException {
				
		System.out.println("유저아이디 : " + userId);
		System.out.println("유저키 : " + userKey);
		// 아이디 유저키 확인해서 입력한 비밀번호로 재설정하는 폼 띄워준다
		String result = passwordSearchService.getUpdateUserPwForm(userId, userKey);
		model.addAttribute("userId", userId);
		return result;
	}
	
	// 비밀번호 재설정 버튼 클릭
	@RequestMapping(value="/user/updatePw", method=RequestMethod.POST)
	public String updatePw(@RequestParam("userId") String userId,
						   @RequestParam("userPw") String userPw,
						   @RequestParam("fail-pw-1") String fail1,
						   @RequestParam("fail-pw-2") String fail2,
						   HttpSession session) {
			String result = "redirect:/";
			
			System.out.println("비밀번호재설정 컨트롤러진입");
			System.out.println(fail1 +" : "+ fail2);
		
			int resultCnt = 0;
			
		if(fail1.equals("ok") && fail2.equals("ok")) {
			// 입력한 비밀번호로 바꿔주기
			resultCnt = passwordSearchService.updateUserPw(userId, userPw, session);
		}	
		
		if(resultCnt != 1) {
			result = "user/mailConfirmError";
		}
			
		return result;
	}
}			
	


