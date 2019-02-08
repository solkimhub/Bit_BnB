package com.bit.bnb.hostboard.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.bit.bnb.hostboard.model.CommentVO;
import com.bit.bnb.hostboard.model.PageView;
import com.bit.bnb.hostboard.model.PostVO;
import com.bit.bnb.hostboard.service.CommentService;
import com.bit.bnb.hostboard.service.HostBoardService;

@Controller
public class HostBoardController {

	@Autowired
	private HostBoardService hostBoardService;
	
	@Autowired
	private CommentService commentService;

	// 호스트보드 페이지 보여주기
	@RequestMapping("/hostBoard")
	public ModelAndView getHostBoardList(@RequestParam(value="page", defaultValue="1") int page) {
		
		ModelAndView modelAndView = new ModelAndView();
		
		int pageNumber = 1;
		
		if(page != 0) {
			pageNumber = page;
		}
		
		// 페이지 정보를 담아 보낸다
		PageView postListData = hostBoardService.getPostList(pageNumber);
		
		modelAndView.addObject("postListData", postListData);
		// 목록으로 되돌아갈 때를 위한 페이지 번호
		modelAndView.addObject("page", page);
		modelAndView.setViewName("hostBoard/hostBoard");
		
		return modelAndView;
	}
	
	
	// 게시물 내용 보여주기
	@RequestMapping("/hostBoard/postView")
	public ModelAndView getPostView(@RequestParam("postNo") int postNo,
									@RequestParam(value="page", defaultValue="1") int page) {
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("hostBoard/postView");
		
		PostVO post = new PostVO();
		List<CommentVO> commentList = new ArrayList<CommentVO>();
		
		post = hostBoardService.getPost(postNo);
		commentList = commentService.getCommentList(postNo);
		
		modelAndView.addObject("post", post);
		modelAndView.addObject("page", page);
		modelAndView.addObject("commentList", commentList);
		
		//조회수 올리기
		hostBoardService.upViewCnt(postNo);
		
		return modelAndView;
		
	}
	
	
	
}
