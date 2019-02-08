package com.bit.bnb.rooms.model;

import org.springframework.web.multipart.MultipartFile;

public class RoomsReviewVO {
	private int reservationNum;
	private String reviewContent;
	private int scope;
	private String reviewDate;
//	private Timestamp reviewDate;
	private String hostId;
	private String userId;
	private String checkIn;
	private String checkOut;
//	private Timestamp checkIn;
//	private Timestamp checkOut;
	private int roomsId;
	private int price;
	private int people;
	private int payCheck;
	private int day;
	private String userName;
	private String userPhoto;
	private MultipartFile userPhotoFile;
	private Byte host; // tinyint
	private Byte admin; // tinyint
	private String userKey;
	private Byte userCheck; // tinyint
	private int point;
	private Byte disabled; // tinyint
	private String birth;
//	private Timestamp birth;
	private String userInfo;

	public final int getReservationNum() {
		return reservationNum;
	}

	public final void setReservationNum(int reservationNum) {
		this.reservationNum = reservationNum;
	}

	public final String getReviewContent() {
		return reviewContent;
	}

	public final void setReviewContent(String reviewContent) {
		this.reviewContent = reviewContent;
	}

	public final int getScope() {
		return scope;
	}

	public final void setScope(int scope) {
		this.scope = scope;
	}

	public final String getHostId() {
		return hostId;
	}

	public final void setHostId(String hostId) {
		this.hostId = hostId;
	}

	public final String getUserId() {
		return userId;
	}

	public final void setUserId(String userId) {
		this.userId = userId;
	}

	public final int getRoomsId() {
		return roomsId;
	}

	public final void setRoomsId(int roomsId) {
		this.roomsId = roomsId;
	}

	public final int getPrice() {
		return price;
	}

	public final void setPrice(int price) {
		this.price = price;
	}

	public final int getPeople() {
		return people;
	}

	public final void setPeople(int people) {
		this.people = people;
	}

	public final int getPayCheck() {
		return payCheck;
	}

	public final void setPayCheck(int payCheck) {
		this.payCheck = payCheck;
	}

	public final int getDay() {
		return day;
	}

	public final void setDay(int day) {
		this.day = day;
	}

	public final String getUserName() {
		return userName;
	}

	public final void setUserName(String userName) {
		this.userName = userName;
	}

	public final String getUserPhoto() {
		return userPhoto;
	}

	public final void setUserPhoto(String userPhoto) {
		this.userPhoto = userPhoto;
	}

	public final MultipartFile getUserPhotoFile() {
		return userPhotoFile;
	}

	public final void setUserPhotoFile(MultipartFile userPhotoFile) {
		this.userPhotoFile = userPhotoFile;
	}

	public final Byte getHost() {
		return host;
	}

	public final void setHost(Byte host) {
		this.host = host;
	}

	public final Byte getAdmin() {
		return admin;
	}

	public final void setAdmin(Byte admin) {
		this.admin = admin;
	}

	public final String getUserKey() {
		return userKey;
	}

	public final void setUserKey(String userKey) {
		this.userKey = userKey;
	}

	public final Byte getUserCheck() {
		return userCheck;
	}

	public final void setUserCheck(Byte userCheck) {
		this.userCheck = userCheck;
	}

	public final int getPoint() {
		return point;
	}

	public final void setPoint(int point) {
		this.point = point;
	}

	public final Byte getDisabled() {
		return disabled;
	}

	public final void setDisabled(Byte disabled) {
		this.disabled = disabled;
	}

	public final String getUserInfo() {
		return userInfo;
	}

	public final void setUserInfo(String userInfo) {
		this.userInfo = userInfo;
	}

	@Override
	public String toString() {
		return "RoomsReviewVO [reservationNum=" + reservationNum + ", reviewContent=" + reviewContent + ", scope="
				+ scope + ", reviewDate=" + reviewDate + ", hostId=" + hostId + ", userId=" + userId + ", checkIn="
				+ checkIn + ", checkOut=" + checkOut + ", roomsId=" + roomsId + ", price=" + price + ", people="
				+ people + ", payCheck=" + payCheck + ", day=" + day + ", userName=" + userName + ", userPhoto="
				+ userPhoto + ", userPhotoFile=" + userPhotoFile + ", host=" + host + ", admin=" + admin + ", userKey="
				+ userKey + ", userCheck=" + userCheck + ", point=" + point + ", disabled=" + disabled + ", birth="
				+ birth + ", userInfo=" + userInfo + "]";
	}

//	public final Timestamp getReviewDate() {
//		return reviewDate;
//	}
//
//	public final void setReviewDate(Timestamp reviewDate) {
//		this.reviewDate = reviewDate;
//	}
//
//	public final Timestamp getCheckIn() {
//		return checkIn;
//	}
//
//	public final void setCheckIn(Timestamp checkIn) {
//		this.checkIn = checkIn;
//	}
//
//	public final Timestamp getCheckOut() {
//		return checkOut;
//	}
//
//	public final void setCheckOut(Timestamp checkOut) {
//		this.checkOut = checkOut;
//	}
//
//	public final Timestamp getBirth() {
//		return birth;
//	}
//
//	public final void setBirth(Timestamp birth) {
//		this.birth = birth;
//	}

	public final String getReviewDate() {
		return reviewDate;
	}

	public final void setReviewDate(String reviewDate) {
		this.reviewDate = reviewDate;
	}

	public final String getCheckIn() {
		return checkIn;
	}

	public final void setCheckIn(String checkIn) {
		this.checkIn = checkIn;
	}

	public final String getCheckOut() {
		return checkOut;
	}

	public final void setCheckOut(String checkOut) {
		this.checkOut = checkOut;
	}

	public final String getBirth() {
		return birth;
	}

	public final void setBirth(String birth) {
		this.birth = birth;
	}

}
