package com.bit.bnb.hostboard.controller;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bit.bnb.hostboard.model.CommentVO;
import com.bit.bnb.hostboard.model.ModifyCommentVO;
import com.bit.bnb.hostboard.service.CommentService;

@Controller
public class CommentController {

	@Autowired
	private CommentService commentService;
	
	// 댓글달기
	@RequestMapping("/hostBoard/writeComment")
	public String writeComment(@RequestParam("postNo") int postNo,
							   @RequestParam("userId") String userId,
							   @RequestParam("commentContent") String commentContent) {
		
		CommentVO comment = new CommentVO();
		comment.setPostNo(postNo);
		comment.setUserId(userId);
		comment.setCommentContent(commentContent);

		int resultCnt = commentService.writeComment(comment, postNo);
		String result = "hostBoard/error";
		if(resultCnt == 1) {
			// 댓글 인서트후 댓글 띄우기 위해 넘기기
			result = "redirect:/hostBoard/viewComment?postNo="+postNo;
		}
		
		return result;
	}

	
	// 댓글리스트 가져오기
	@RequestMapping("/hostBoard/viewComment")
	@ResponseBody
	public List<CommentVO> getCommentList(int postNo){
		List<CommentVO> commentList = new ArrayList<CommentVO>();
		commentList = commentService.getCommentList(postNo);
		
		return commentList;
	}
	
	
	// 댓글 삭제 후 댓글리스트 컨트롤러로 넘기기
	@RequestMapping("/hostBoard/deleteComment")
	public String deleteComment(@RequestParam("commentNo") int commentNo,
								@RequestParam("postNo") int postNo){
		String result = "hostBoard/error";
		
		int resultCnt = commentService.deleteComment(commentNo, postNo);
		if(resultCnt == 1) {
			result = "redirect:/hostBoard/viewComment?postNo=" + postNo;
		}
		
		return result;
	}
	
	
	// 댓글 하나 불러오기
	@RequestMapping(value="/hostBoard/selectComment",  produces = "application/text; charset=utf8")
	@ResponseBody
	public String selectComment(@RequestParam("commentNo") int commentNo) throws UnsupportedEncodingException {
		CommentVO comment = new CommentVO();
		comment = commentService.getCommentOne(commentNo);
		String commentCon = comment.getCommentContent();

		return commentCon;
	}
	
	// 댓글 수정하기
	@RequestMapping(value="/hostBoard/modifyComment",  produces = "application/text; charset=utf8")
	@ResponseBody
	public String modifyComment(@RequestParam("commentNo") int commentNo,
									  @RequestParam("commentContent") String commentContent) {
	
		// 넘어온 commentContent는 수정된 글이므로 다시 넘겨주기 위해 변수에 저장
		String result = commentContent;

		ModifyCommentVO modifyComment = new ModifyCommentVO(commentNo, commentContent);
		int resultCnt = commentService.modifyComment(modifyComment);
		
		// 업데이트에 실패하면 result를 에러페이지로 변경
		if(resultCnt != 1) {
			result = "redirect:/hostBoard/error";
		}
		
		return result;
	}
	
	
}