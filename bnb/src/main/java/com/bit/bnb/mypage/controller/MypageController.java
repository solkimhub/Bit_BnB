package com.bit.bnb.mypage.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.bit.bnb.mypage.service.MypageService;
import com.bit.bnb.user.model.UserVO;

@Controller
public class MypageController {

	@Autowired
	private MypageService service;

	@RequestMapping("/mypage")
	public ModelAndView Listview(HttpSession session) {

		UserVO user = (UserVO) session.getAttribute("loginUser");
		String userId = user.getUserId();
		ModelAndView modelAndView = new ModelAndView();

		modelAndView.addObject("user", service.mypageView(userId));
		modelAndView.setViewName("mypage/mypage");

		return modelAndView;
	}

	@RequestMapping(value = "/mypageEdit", method = RequestMethod.GET)
	public ModelAndView profileEditForm(@RequestParam("userId") String userId) {

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("mypage/MemberEditForm");
		modelAndView.addObject("member", service.myUserPick(userId));
		modelAndView.addObject("userId", userId);

		return modelAndView;
	}

	@RequestMapping(value = "/mypageEdit", method = RequestMethod.POST)
	public String profileEditPost(UserVO member, HttpServletRequest request, HttpSession session)
			throws IllegalStateException, IOException {

		UserVO user = (UserVO) session.getAttribute("loginUser");
		System.out.println(member.getUserPw());
		if (member.getUserPw() == null) {
			member.setUserPw(user.getUserPw());
		}
		service.myUserUpdate(member, request);
		return "redirect:/mypage";
	}
	
	@RequestMapping("/userDelete")
	   public String userDele(@RequestParam("userId") String userId, HttpServletRequest request, RedirectAttributes rttr) {
	      
	      service.userDelete(userId);
	      HttpSession session = request.getSession(false);
	      session.invalidate();
	      
	      return "redirect:/";
	   }
}
