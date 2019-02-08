package com.bit.bnb.hostboard.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.bit.bnb.hostboard.dao.HostBoardDao;
import com.bit.bnb.hostboard.model.ModifyVO;
import com.bit.bnb.hostboard.model.PostVO;

@Service
public class PostingService {

	@Autowired
	private HostBoardDao hostBoardDao;
	
	// 포스트 작성
	@Transactional
	public int write(PostVO postVO) {
		int resultCnt = hostBoardDao.insertPost(postVO);
		
		if(resultCnt == 1) {
			hostBoardDao.upPostTotalCount();
		}
		return resultCnt;
	}
	
	// 게시물 삭제
	@Transactional
	public int deletePost(int postNo) {
		int resultCnt = hostBoardDao.deletePost(postNo);
		
		if(resultCnt == 1) {
			hostBoardDao.downPostTotalCount();
		}
		return resultCnt;
	}
	
	// 게시물 수정
	@Transactional
	public int modifyPost(ModifyVO modifyVO) {
		return hostBoardDao.modifyPost(modifyVO);
	}
}
