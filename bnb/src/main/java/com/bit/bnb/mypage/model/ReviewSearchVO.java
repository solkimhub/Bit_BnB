package com.bit.bnb.mypage.model;

public class ReviewSearchVO {

	private String searchType;
	private String keyword;

	public String getSearchType() {
		return searchType;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	@Override
	public String toString() {
		return "ReviewSearchVO [searchType=" + searchType + ", keyword=" + keyword + "]";
	}

}
