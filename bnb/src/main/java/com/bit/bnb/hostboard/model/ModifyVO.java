package com.bit.bnb.hostboard.model;

public class ModifyVO {

	private int postNo;
	private String title;
	private String content;

	public int getPostNo() {
		return postNo;
	}

	public void setPostNo(int postNo) {
		this.postNo = postNo;
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

	@Override
	public String toString() {
		return "ModifyVO [postNo=" + postNo + ", title=" + title + ", content=" + content + "]";
	}

}
