package com.bit.bnb.hostboard.model;

import java.util.Date;

public class PostVO {

	private int postNo;
	private String userId;
	private String nickName;
	private String title;
	private String content;
	private Date date;
	private int viewCnt;

	private int commentCnt;

	public int getPostNo() {
		return postNo;
	}

	public void setPostNo(int postNo) {
		this.postNo = postNo;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getNickName() {
		return nickName;
	}

	public void setNickName(String nickName) {
		this.nickName = nickName;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public int getViewCnt() {
		return viewCnt;
	}

	public void setViewCnt(int viewCnt) {
		this.viewCnt = viewCnt;
	}

	public int getCommentCnt() {
		return commentCnt;
	}

	public void setCommentCnt(int commentCnt) {
		this.commentCnt = commentCnt;
	}

	@Override
	public String toString() {
		return "PostVO [postNo=" + postNo + ", userId=" + userId + ", nickName=" + nickName + ", title=" + title
				+ ", content=" + content + ", date=" + date + ", viewCnt=" + viewCnt + ", commentCnt=" + commentCnt
				+ "]";
	}

}
