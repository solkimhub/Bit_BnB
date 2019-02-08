package com.bit.bnb.user.controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.security.GeneralSecurityException;
import java.security.NoSuchAlgorithmException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.bit.bnb.user.model.UserVO;
import com.bit.bnb.user.service.UserRegService;

@Controller
public class UserRegController {

	@Autowired
	private UserRegService userRegService;
	
	@RequestMapping(value="/userReg", method = RequestMethod.GET)
	public ModelAndView getUserRegForm() {
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("user/userRegForm");
		return modelAndView;
	}
	
	@RequestMapping(value="/userReg", method = RequestMethod.POST)
	public ModelAndView userReg(UserVO userVO, 
								//@RequestParam("fail-pw-1") String fail1,
								//@RequestParam("fail-pw-2") String fail2, 
								HttpServletRequest request,
								HttpSession session) throws IllegalStateException, IOException, NoSuchAlgorithmException, GeneralSecurityException {

		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.setViewName("redirect:/");
		int resultCnt = 0;
		
		//System.out.println(fail1 +" : " + fail2);

		//if(fail1.equals("ok") && fail2.equals("ok")) {
			resultCnt = userRegService.userReg(userVO, request, session);
		//} else {
	//		resultCnt = 0;
	//	}
		
		System.out.println(resultCnt);
		
		if(resultCnt != 1) {
			session.setAttribute("regFail", true);
			modelAndView.setViewName("redirect:/userReg");
		} else {
			session.removeAttribute("regFail");
		}
		return modelAndView;
	}
	
	// 아이디 중복검사
	@RequestMapping("/userIdChk")
	@ResponseBody
	public String userIdChk(@RequestParam("userId") String userId) {
		String userIdChk = userRegService.getUserIdChk(userId);
		System.out.println("사용할수 있는 아이디? : " + userIdChk);
		return userIdChk;
	}
	
	// 닉네임 중복검사
	@RequestMapping("/user/nickNameChk")
	@ResponseBody
	public String nickNameChk(@RequestParam("nickName") String nickName) {
		String nickNameChk = userRegService.getNickNameChk(nickName);
		System.out.println("사용할수 있는 닉네임? : " + nickNameChk);
		return nickNameChk;
	}
	
	
	// 계정인증
	@RequestMapping("/userKeyConfirm")
	public String userKeyConfirm(@RequestParam("userId") String userId, 
								 @RequestParam("userKey") String userKey,
								 HttpSession session)
								 throws NoSuchAlgorithmException, UnsupportedEncodingException, GeneralSecurityException {
		
		String result = "redirect:/user/mailConfirmError";
		
		int resultCnt = userRegService.userConfirm(userId, userKey);
		
		if(resultCnt == 1) {
			result =  "redirect:/";
			session.setAttribute("regSuccess", "regSuccess");
		}

		return result;
	}
	
	
	@RequestMapping(value="/googleReg", method=RequestMethod.GET)
	public String getGoogleRegForm(@RequestParam("gMail") String gMail,
								   @RequestParam("gName") String gName,
								   @RequestParam("gPhoto") String gPhoto,
								   Model model) {
		
		model.addAttribute("gMail", gMail);
		model.addAttribute("gName", gName);
		model.addAttribute("gPhoto", gPhoto);
		
		return "user/googleRegForm";
	}
	
	@RequestMapping(value="/googleReg", method=RequestMethod.POST)
	public String googleReg(UserVO userVO, HttpServletRequest request, HttpSession session) throws IllegalStateException, NoSuchAlgorithmException, IOException, GeneralSecurityException {
		
		String result = "redirect:/";
		
		int resultCnt = 0;
		
		resultCnt = userRegService.googleReg(userVO, request, session);
		
		if(resultCnt != 1) {
			session.setAttribute("regFail", true);
			
			// 이름이 한글로 들어오는 것을 위해 인코딩해서 파라미터값에 넣어준다
			String gName = URLEncoder.encode(userVO.getUserName(), "utf-8");
			
			result = "redirect:/googleReg?gMail="+userVO.getUserId()+"&gName="+gName+"&gPhoto="+userVO.getUserPhoto();
		} else {
			
			if (session.getAttribute("gRegSuccess") != null) {
				session.removeAttribute("gRegSuccess");
			}

			session.setAttribute("gRegSuccess", "gRegSuccess");
		}
		
		return result;
	}
	
	
	@RequestMapping("/user/mailConfirmError")
	public String mailConfirmError() {
		return "user/mailConfirmError";
	}
}
