package com.bit.bnb.hostboard.model;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

public class CommentVO {

	private int commentNo;
	private int postNo;
	private String userId;
	private String nickName;
	private String commentContent;

	@JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd HH:mm")
	private Date commentDate;

	public int getCommentNo() {
		return commentNo;
	}

	public void setCommentNo(int commentNo) {
		this.commentNo = commentNo;
	}

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

	public String getCommentContent() {
		return commentContent;
	}

	public void setCommentContent(String commentContent) {
		this.commentContent = commentContent;
	}

	public Date getCommentDate() {
		return commentDate;
	}

	public void setCommentDate(Date commentDate) {
		this.commentDate = commentDate;
	}

	@Override
	public String toString() {
		return "CommentVO [commentNo=" + commentNo + ", postNo=" + postNo + ", userId=" + userId + ", nickName="
				+ nickName + ", commentContent=" + commentContent + ", commentDate=" + commentDate + "]";
	}

}
