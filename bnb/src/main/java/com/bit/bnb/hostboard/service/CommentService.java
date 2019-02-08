package com.bit.bnb.hostboard.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.bit.bnb.hostboard.dao.CommentDao;
import com.bit.bnb.hostboard.dao.HostBoardDao;
import com.bit.bnb.hostboard.model.CommentVO;
import com.bit.bnb.hostboard.model.ModifyCommentVO;

@Service
public class CommentService {

	@Autowired
	private CommentDao commentDao;
	
	@Autowired
	private HostBoardDao hostBoardDao;
	
	//댓글작성
	@Transactional
	public int writeComment(CommentVO comment, int postNo) {
		int resultCnt = 0;
		int resultTmp = commentDao.upCommentCnt(postNo);
		
		if(resultTmp == 1) {
			resultCnt = commentDao.insertComment(comment);
		}
		return resultCnt;
	}
	
	// 해당 포스트의 댓글 리스트 불러오기
	@Transactional
	public List<CommentVO> getCommentList(int postNo){
		return commentDao.getCommentList(postNo);
	}
	
	// 코멘트 삭제
	@Transactional
	public int deleteComment(int commentNo, int postNo) {
		int resultCnt = 0; 
		int resultTmp = commentDao.downCommentCnt(postNo);

		if(resultTmp == 1) {
			resultCnt = commentDao.deleteComment(commentNo);
		}
		return resultCnt;
	}
	
	// 댓글 한개 가져오기
	@Transactional
	public CommentVO getCommentOne(int commentNo) {
		return commentDao.getCommentOne(commentNo);
	}
	
	// 댓글 수정
	@Transactional
	public int modifyComment(ModifyCommentVO modifyComment) {
		return commentDao.modifyComment(modifyComment); 
	}
	
}
