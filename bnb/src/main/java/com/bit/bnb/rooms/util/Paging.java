package com.bit.bnb.rooms.util;

// http://diaryofgreen.tistory.com/83
public class Paging {

	private int dataPerPage; // 페이지당 데이터 수
	private int firstPageNo; // 첫번째 페이지 번호
	private int lastPageNo; // 마지막 페이지 번호

	private int prevPageNo; // 이전 페이지 번호
	private int nextPageNo; // 다음 페이지 번호

	private int startPageNo; // 시작 페이지 (페이징 너비 기준)
	private int currentPageNo; // 현재 페이지 번호
	private int endPageNo; // 끝 페이지 (페이징 너비 기준)

	private int totalDataCount; // 전체 레코드 수
	private int sizeOfpage; // 보여지는 페이지 갯수

	private int offset;

	// 페이지당 데이터 수 default 15
	// 아 진짜 구데기 같네
	public Paging(int totalDataCount, int currentPageNo, int dataPerPage) {
		this.totalDataCount = totalDataCount;
		this.currentPageNo = currentPageNo;
		this.dataPerPage = (dataPerPage != 0) ? dataPerPage : 15;
		this.sizeOfpage = 5;
	}

	public void makePageing() {
		// 데이터가 없을 경우
		if (totalDataCount == 0) {
			return;
		}

		// 마지막 페이지
		int lastPageNo = (totalDataCount + (dataPerPage - 1)) / dataPerPage;

		// 현재 페이지 유효성 체크
		if (currentPageNo <= 0) {
			setCurrentPageNo(firstPageNo); // 시작 페이지로
		}
		if (currentPageNo > lastPageNo) {
			setCurrentPageNo(lastPageNo); // 기본값 설정
		}

		offset = (currentPageNo - 1) * dataPerPage;

		boolean isNowFirst = currentPageNo == 1 ? true : false;
		boolean isNowLast = currentPageNo == lastPageNo ? true : false;

		int startPage = ((currentPageNo - 1) / sizeOfpage * sizeOfpage + 1);
		int endPage = startPage + sizeOfpage - 1;

		if (endPage > lastPageNo) {
			endPage = lastPageNo;
		}

		setFirstPageNo(1); // 첫번째 페이지 번호

		if (isNowFirst) {
			setPrevPageNo(1);
		} else {
			setPrevPageNo((currentPageNo - 1) < 1 ? 1 : (currentPageNo - 1));
		}

		setStartPageNo(startPage);
		setEndPageNo(endPage);

		if (isNowLast) {
			setNextPageNo(lastPageNo);
		} else {
			setNextPageNo((currentPageNo + 1) > lastPageNo ? lastPageNo : (currentPageNo + 1));
		}
		setLastPageNo(lastPageNo);

	}

	public final int getDataPerPage() {
		return dataPerPage;
	}

	public final void setDataPerPage(int dataPerPage) {
		this.dataPerPage = dataPerPage;
	}

	public final int getFirstPageNo() {
		return firstPageNo;
	}

	public final void setFirstPageNo(int firstPageNo) {
		this.firstPageNo = firstPageNo;
	}

	public final int getPrevPageNo() {
		return prevPageNo;
	}

	public final void setPrevPageNo(int prevPageNo) {
		this.prevPageNo = prevPageNo;
	}

	public final int getStartPageNo() {
		return startPageNo;
	}

	public final void setStartPageNo(int startPageNo) {
		this.startPageNo = startPageNo;
	}

	public final int getCurrentPageNo() {
		return currentPageNo;
	}

	public final void setCurrentPageNo(int currentPageNo) {
		this.currentPageNo = currentPageNo;
	}

	public final int getEndPageNo() {
		return endPageNo;
	}

	public final void setEndPageNo(int endPageNo) {
		this.endPageNo = endPageNo;
	}

	public final int getNextPageNo() {
		return nextPageNo;
	}

	public final void setNextPageNo(int nextPageNo) {
		this.nextPageNo = nextPageNo;
	}

	public final int getLastPageNo() {
		return lastPageNo;
	}

	public final void setLastPageNo(int lastPageNo) {
		this.lastPageNo = lastPageNo;
	}

	public final int getSizeOfpage() {
		return sizeOfpage;
	}

	public final void setSizeOfpage(int sizeOfpage) {
		this.sizeOfpage = sizeOfpage;
	}

	public final int getTotalDataCount() {
		return totalDataCount;
	}

	public final void setTotalDataCount(int totalDataCount) {
		this.totalDataCount = totalDataCount;
	}

	public final int getOffset() {
		return offset;
	}

	public final void setOffset(int offset) {
		this.offset = offset;
	}

	@Override
	public String toString() {
		return "Paging [dataPerPage=" + dataPerPage + ", firstPageNo=" + firstPageNo + ", lastPageNo=" + lastPageNo
				+ ", prevPageNo=" + prevPageNo + ", nextPageNo=" + nextPageNo + ", startPageNo=" + startPageNo
				+ ", currentPageNo=" + currentPageNo + ", endPageNo=" + endPageNo + ", totalDataCount=" + totalDataCount
				+ ", sizeOfpage=" + sizeOfpage + ", offset=" + offset + "]";
	}

}
