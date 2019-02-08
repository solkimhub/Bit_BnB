package com.bit.bnb.hostboard.model;

public class ModifyCommentVO {

	private int commentNo;
	private String commentContent;
	
	public ModifyCommentVO(int commentNo, String commentContent) {
		this.commentNo = commentNo;
		this.commentContent = commentContent;
	}

	public int getCommentNo() {
		return commentNo;
	}

	public void setCommentNo(int commentNo) {
		this.commentNo = commentNo;
	}

	public String getCommentContent() {
		return commentContent;
	}

	public void setCommentContent(String commentContent) {
		this.commentContent = commentContent;
	}

	@Override
	public String toString() {
		return "ModifyCommentVO [commentNo=" + commentNo + ", commentContent=" + commentContent + "]";
	}

}
