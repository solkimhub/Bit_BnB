package com.bit.bnb.hostboard.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.bit.bnb.hostboard.model.ModifyVO;
import com.bit.bnb.hostboard.model.PostVO;
import com.bit.bnb.hostboard.service.HostBoardService;
import com.bit.bnb.hostboard.service.PostingService;

@Controller
public class HostBoardPostingController {

	@Autowired
	private PostingService postingService;
	
	@Autowired
	private HostBoardService hostBoardService;
	
	// 게시판 포스팅 폼 띄우기
	@RequestMapping(value="/hostBoard/write", method=RequestMethod.GET)
	public ModelAndView getPostingForm() {
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("hostBoard/writeForm");
		return modelAndView;
	}
	
	// 포스팅
	@RequestMapping(value="/hostBoard/write", method=RequestMethod.POST)
	public ModelAndView writePost(PostVO postVO) {
		int resultCnt = postingService.write(postVO);
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("redirect:/hostBoard/postView?postNo="+postVO.getPostNo());
		if(resultCnt != 1) {
			modelAndView.setViewName("hostBoard/error");
		}
		return modelAndView;
	}
	
	// 게시물 삭제
	@RequestMapping("/hostBoard/deletePost")
	public String deletePost(@RequestParam("postNo") int postNo) {
		
		int resultCnt = postingService.deletePost(postNo);
		String result = "redirect:/hostBoard";
		
		if(resultCnt != 1) {
			result = "hostBoard/error";
		}
		
		return result;
	}

	
	// 게시물 수정 폼
	@RequestMapping(value="/hostBoard/modifyPost", method=RequestMethod.GET)
	public ModelAndView getModifyForm(@RequestParam("postNo") int postNo,
									  @RequestParam(value="page", defaultValue="1") int page) {
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("hostBoard/modifyForm");
		
		PostVO post = new PostVO();
		post = hostBoardService.getPost(postNo);
		
		modelAndView.addObject("post", post);
		modelAndView.addObject("page", page);
		
		return modelAndView;
	}
	
	
	@RequestMapping(value="/hostBoard/modifyPost", method=RequestMethod.POST)
	public String modifyPost(@RequestParam("title") String title,
								   @RequestParam("content") String content,
								   @RequestParam("postNo") int postNo,
								   @RequestParam(value="page", defaultValue="1") int page) {
	
	String result = "redirect:/hostBoard/postView?postNo="+postNo+"&page="+page;
		
	ModifyVO modifyVO = new ModifyVO();
	modifyVO.setTitle(title);
	modifyVO.setContent(content);
	modifyVO.setPostNo(postNo);
	
	int resultCnt = postingService.modifyPost(modifyVO);
	
	if(resultCnt != 1) {
		result = "hostBoard/error";
	}
		
		return result;
	}
}
