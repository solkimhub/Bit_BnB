package com.bit.bnb.hostboard.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.bit.bnb.hostboard.dao.CommentDao;
import com.bit.bnb.hostboard.dao.HostBoardDao;
import com.bit.bnb.hostboard.model.PageView;
import com.bit.bnb.hostboard.model.PostVO;

@Service
public class HostBoardService {

	@Autowired
	private HostBoardDao hostBoardDao;
	
	@Autowired
	private CommentDao commentDao;
	
	// 게시물 목록 가져오기
	@Transactional
	public PageView getPostList(int pageNumber){
		
		int postCountPerPage = 10; // 페이지당 보여줄 게시물 개수
		int currentPageNumber = pageNumber; // 현재 페이지 넘버
		int postTotalCount = hostBoardDao.getPostTotalCount(); // DB에 저장된 게시물 개수
		
		
		List<PostVO> postList = null;
		// 시작할 행과 페이지당 게시물개수를 map으로 묶는다
		HashMap<String, Integer> map = new HashMap<String, Integer>();
		int firstRow = 0;

		if(postTotalCount > 0) {
			firstRow = (pageNumber - 1) * postCountPerPage;
			map.put("firstRow", firstRow);
			map.put("postCountPerPage", postCountPerPage);
			postList = hostBoardDao.getPostList(map);
		}
		
		// pageView 객체에 정보를 담아서 반환
		PageView pageView = new PageView(postList, postTotalCount, currentPageNumber, postCountPerPage, firstRow);
		return pageView;
	
	}
	
	// 전체 게시물 개수
	@Transactional
	public int getPostTotalCount() {
		int totalCount = hostBoardDao.getPostTotalCount();
		return totalCount;
	}
	
	// 게시물 가져오기
	@Transactional
	public PostVO getPost(int postNo) {
		PostVO post = new PostVO();
		post = hostBoardDao.selectPost(postNo);
		
		return post;
	}
	
	// 게시물 조회수 올리기
	public void upViewCnt(int postNo) {
		hostBoardDao.upViewCnt(postNo);
	}
	
	// 게시물 댓글수 증가
	public int upCommentCnt(int postNo) {
		return commentDao.upCommentCnt(postNo);
	}
	
	// 게시물 댓글수 감소
		public int downCommentCnt(int postNo) {
			return commentDao.downCommentCnt(postNo);
		}
}
