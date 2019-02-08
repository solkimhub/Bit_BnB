package com.bit.bnb.mypage.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.bit.bnb.mypage.model.ReviewSearchVO;
import com.bit.bnb.mypage.model.ReviewVO;
import com.bit.bnb.mypage.service.ReviewService;
import com.bit.bnb.user.model.UserVO;

@Controller
public class ReviewController {
	
	@Autowired
	private ReviewService service;
	
	@RequestMapping(value="/reviewWrite", method = RequestMethod.GET)
	public String reviewForm(@RequestParam("reservationNum") int reservationNum, Model model) { // 리뷰써주는폼
		model.addAttribute("reviewChk", service.reviewChk2(reservationNum));
		return "mypage/reviewWriteForm";
	}
	
	@RequestMapping(value="/reviewWrite", method = RequestMethod.POST)
	public String reviewInsert(ReviewVO review) { // 리뷰 넣어주긔 ㅎ
		int result = service.reviewWrite(review);
		if(result == 0) {
			return "mypage/reviewWriteFail";
		}
		return "redirect:mypage/review";		
	}
	
	@RequestMapping("/mypage/review")
	public ModelAndView reviewToList(HttpSession session) { // 리뷰메인페이지 나타내기

		UserVO user = (UserVO) session.getAttribute("loginUser");
		ModelAndView modelAndView = new ModelAndView();

		modelAndView.setViewName("mypage/review");
		modelAndView.addObject("reviewTo", service.reviewToListView(user.getUserId()));
		modelAndView.addObject("reviewWrite", service.reviewWriteList(user.getUserId()));
		modelAndView.addObject("hostReview", service.hostReview(user.getUserId()));		

		return modelAndView;
	}
	
	@RequestMapping(value="/reviewSearchList", method=RequestMethod.GET)
	@ResponseBody
	public ModelAndView reviewSearch(@ModelAttribute("rvs") ReviewSearchVO rvs, HttpSession session) { // 리뷰찾기
		
		UserVO user = (UserVO) session.getAttribute("loginUser");
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("reviewSearch", service.reviewSearchList(user.getUserId(), rvs));
		modelAndView.addObject("hostReviewSearch", service.HostReviewSearchList(user.getUserId(), rvs));
		modelAndView.setViewName("mypage/reviewSearchList");
		
		return modelAndView;
	}
	
	@RequestMapping(value="/reviewEdit", method = RequestMethod.GET)
	public String reviewEditForm(@RequestParam("reservationNum") int reservationNum, Model model) { // 리뷰수정폼
		/*model.addAttribute("reservationNum", reservationNum);*/
		model.addAttribute("reviewPick", service.reviewPick(reservationNum));
		model.addAttribute("reviewChk", service.reviewChk(reservationNum));
		return "mypage/reviewEditForm";
	}
	
	@RequestMapping(value="/reviewEdit", method = RequestMethod.POST)
	public String reviewEdit(Model model, ReviewVO review) { // 리뷰수정하기
		/*model.addAttribute("reviewPick", service.reviewPick(reservationNum));*/
		service.reviewEdit(review);
		return "redirect:mypage/review";
	}
	
	@RequestMapping("mypage/review_delete")
	public String reviewDele(@RequestParam("reservationNum") int reservationNum) {
		service.reviewDelete(reservationNum);
		return "redirect:review";
	}

}
