package com.bit.bnb.mypage.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.bit.bnb.mypage.model.WishVO;
import com.bit.bnb.mypage.service.WishService;
import com.bit.bnb.user.model.UserVO;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
public class WishController {

	@Autowired
	private WishService service;

	@RequestMapping(value="/wishIn", method=RequestMethod.GET)
	@ResponseBody
	public int wishInsert(HttpSession session, @RequestParam("roomsId") int roomsId) { // 좋아요클릭시 ajax처리를 위한 컨트롤러매핑

		/*System.out.println("즐겨찾기 컨트롤러진입");*/
		UserVO user = (UserVO) session.getAttribute("loginUser");
		if (service.wishSelect(user.getUserId(), roomsId) == 0) { // 아이디랑 룸넘버가 즐겨찾기에 들어가있는게 없으면
			service.wishInput(user.getUserId(), roomsId); // 넣ㅇㅓ주고
			return 1;			
		} else {
			service.wishDelete(user.getUserId(), roomsId); // 있으면 삭제해주고 ! (즐겨찾기 해제)
			return 2;
		}
	}

	@RequestMapping("/mypage/wish")
	public ModelAndView wishMainList(HttpSession session) { // div나타내줄 쿼리문 뽑아옴ㅎ~~
		
		UserVO user = (UserVO) session.getAttribute("loginUser");

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("mypage/wishMain");
		modelAndView.addObject("wishDiv", service.wishDivList(user.getUserId()));
		modelAndView.addObject("wishDivImg", service.wishDivImg(user.getUserId()));

		return modelAndView;
	}
	
	@RequestMapping(value="/wishCnt", produces = "application/text; charset=utf8")
	@ResponseBody
	public String wishCnt(HttpSession session, @RequestBody List<String> list, Model model) throws JsonProcessingException {
		
		Map<String, Integer> addressMap = new HashMap<String, Integer>();
		ObjectMapper mapper = new ObjectMapper();
		
		String address = "";
		int idx = 0;
		UserVO user = (UserVO) session.getAttribute("loginUser");
		
		for(int i = 0; i< list.size(); i++) {
			address = list.get(i);
			idx = service.wishDivCnt(user.getUserId(), address);
			addressMap.put(address, idx);
			/*System.out.println(addressMap);*/
		}
	
		String jsonWish = mapper.writerWithDefaultPrettyPrinter().writeValueAsString(addressMap);
		/*System.out.println(jsonWish);*/
		return jsonWish;
	}

	@RequestMapping("/mypage/wishList")
	public ModelAndView wishList(@RequestParam("userId") String userId, @RequestParam("address") String address) {

		ModelAndView modelAndView = new ModelAndView();

		modelAndView.setViewName("mypage/wishList");
		modelAndView.addObject("address", address);
		modelAndView.addObject("wishList", service.wishList(userId, address));
		modelAndView.addObject("wishImg", service.wishRoomImg(userId, address));

		return modelAndView;
	}
	
	@RequestMapping(value="/wishOut", method=RequestMethod.GET)
	@ResponseBody
	public List<List> wishOut(HttpSession session, @RequestParam("roomsId") int roomsId, @RequestParam("address") String address) {
		
		ModelAndView modelAndView = new ModelAndView();
		List<List> list = new ArrayList<List>();
		
		UserVO user = (UserVO) session.getAttribute("loginUser");
		service.wishDelete(user.getUserId(), roomsId);
		
		list.add(service.wishList(user.getUserId(), address));
		list.add(service.wishRoomImg(user.getUserId(), address));
		
		return list;
		
	}

}
