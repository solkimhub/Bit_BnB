package com.bit.bnb.hostpage.model;

import java.sql.Timestamp;

public class EvaluationVO {

	private String userId;
	private String hostId;
	private String userName;
	private String userPhoto;
	private int roomsId;
	private String checkIn;
	private String checkOut;
	private String evaluationContent;
	private String evaluationDate;
	private int reservationNum;
	private Timestamp reviewDate;

	public int getReservationNum() {
		return reservationNum;
	}

	public void setReservationNum(int reservationNum) {
		this.reservationNum = reservationNum;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getUserPhoto() {
		return userPhoto;
	}

	public void setUserPhoto(String userPhoto) {
		this.userPhoto = userPhoto;
	}

	public int getRoomsId() {
		return roomsId;
	}

	public void setRoomsId(int roomsId) {
		this.roomsId = roomsId;
	}

	public String getCheckIn() {
		return checkIn;
	}

	public void setCheckIn(String checkIn) {
		this.checkIn = checkIn;
	}

	public String getCheckOut() {
		return checkOut;
	}

	public void setCheckOut(String checkOut) {
		this.checkOut = checkOut;
	}

	public String getEvaluationContent() {
		return evaluationContent;
	}

	public void setEvaluationContent(String evaluationContent) {
		this.evaluationContent = evaluationContent.replace("\n", "<br>");
	}

	public String getEvaluationDate() {
		return evaluationDate;
	}

	public void setEvaluationDate(String evaluationDate) {
		this.evaluationDate = evaluationDate;
	}

	public String getHostId() {
		return hostId;
	}

	public void setHostId(String hostId) {
		this.hostId = hostId;
	}

	public Timestamp getReviewDate() {
		return reviewDate;
	}

	public void setReviewDate(Timestamp reviewDate) {
		this.reviewDate = reviewDate;
	}

	@Override
	public String toString() {
		return "EvaluationVO [userId=" + userId + ", hostId=" + hostId + ", userName=" + userName + ", userPhoto="
				+ userPhoto + ", roomsId=" + roomsId + ", checkIn=" + checkIn + ", checkOut=" + checkOut
				+ ", evaluationContent=" + evaluationContent + ", evaluationDate=" + evaluationDate
				+ ", reservationNum=" + reservationNum + ", reviewDate=" + reviewDate + "]";
	}

}
