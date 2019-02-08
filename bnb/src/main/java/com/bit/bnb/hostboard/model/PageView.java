package com.bit.bnb.hostboard.model;

import java.util.List;

public class PageView {

	private int postTotalCount;
	private int currentPageNumber;
	private List<PostVO> postList;
	private int pageTotalCount;
	private int postCountPerPage;
	private int firstRow; // 시작 게시물 번호

	private int startPage; // 보여줄 시작 페이지 번호
	private int endPage; // 보여줄 마지막 페이지 번호
	private int displayPageNumber = 10;

	public PageView(List<PostVO> postList, int postTotalCount, int currentPageNumber, int postCountPerPage,
			int firstRow) {
		this.postList = postList;
		this.postTotalCount = postTotalCount;
		this.currentPageNumber = currentPageNumber;
		this.postCountPerPage = postCountPerPage;
		this.firstRow = firstRow;
		clacPageTotalCount();
		calcDisplayPageNumber();
	}

	private void clacPageTotalCount() {
		if (postTotalCount == 0) {
			pageTotalCount = 1;
		} else {
			pageTotalCount = postTotalCount / postCountPerPage;
			if (postTotalCount % postCountPerPage > 0) {
				pageTotalCount++;
			}
		}
	}
	
	public void calcDisplayPageNumber() {
		endPage = (int)(Math.ceil(this.getCurrentPageNumber() / (double) displayPageNumber) * displayPageNumber);
		startPage = (endPage - displayPageNumber) + 1;
		
		if(endPage>pageTotalCount) {
			endPage = pageTotalCount;
		} else if(endPage == 0) {
			endPage = 1;
			startPage = 1;
		}
	}

	public int getPostTotalCount() {
		return postTotalCount;
	}

	public int getCurrentPageNumber() {
		return currentPageNumber;
	}

	public List<PostVO> getPostList() {
		return postList;
	}

	public int getPageTotalCount() {
		return pageTotalCount;
	}

	public int getPostCountPerPage() {
		return postCountPerPage;
	}

	public int getFirstRow() {
		return firstRow;
	}

	public boolean isEmpty() {
		return postTotalCount == 0;
	}

	public int getDisplayPageNumber() {
		return displayPageNumber;
	}

	public int getStartPage() {
		return startPage;
	}

	public int getEndPage() {
		return endPage;
	}

	@Override
	public String toString() {
		return "PageView [postTotalCount=" + postTotalCount + ", currentPageNumber=" + currentPageNumber + ", postList="
				+ postList + ", pageTotalCount=" + pageTotalCount + ", postCountPerPage=" + postCountPerPage
				+ ", firstRow=" + firstRow + ", startPage=" + startPage + ", endPage=" + endPage
				+ ", displayPageNumber=" + displayPageNumber + "]";
	}

}
