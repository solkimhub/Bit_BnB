package com.bit.bnb.rooms.model;

public class RoomsReviewSummaryVO {
	private int roomsId;
	private int reviewCount;
	private double avgScope;

	public final int getRoomsId() {
		return roomsId;
	}

	public final void setRoomsId(int roomsId) {
		this.roomsId = roomsId;
	}

	public final int getReviewCount() {
		return reviewCount;
	}

	public final void setReviewCount(int reviewCount) {
		this.reviewCount = reviewCount;
	}

	public final double getAvgScope() {
		return avgScope;
	}

	public final void setAvgScope(double avgScope) {
		this.avgScope = avgScope;
	}

	@Override
	public String toString() {
		return "RoomsReviewSummaryVO [roomsId=" + roomsId + ", reviewCount=" + reviewCount + ", avgScope=" + avgScope
				+ "]";
	}

}
