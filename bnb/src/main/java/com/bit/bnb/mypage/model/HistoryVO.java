package com.bit.bnb.mypage.model;

import java.sql.Timestamp;

public class HistoryVO {

	private int roomsId; // 룸아이디
	private String hostId; // 호스트아이디
	private String details; // 숙소 소개
	private String address; // 숙소 주소
	private int reservationNum; // 예약번호
	private String userId; // 유저아이디
	private Timestamp checkIn; // 체크인시간
	private Timestamp checkOut; // 체크아웃시간
	private int price; // 가격
	private int people; // 사람 수
	private String filename; // 파일이름

	public int getRoomsId() {
		return roomsId;
	}

	public String getHostId() {
		return hostId;
	}

	public String getDetails() {
		return details;
	}

	public String getAddress() {
		return address;
	}

	public int getReservationNum() {
		return reservationNum;
	}

	public String getUserId() {
		return userId;
	}

	public Timestamp getCheckIn() {
		return checkIn;
	}

	public Timestamp getCheckOut() {
		return checkOut;
	}

	public int getPrice() {
		return price;
	}

	public int getPeople() {
		return people;
	}

	public void setRoomsId(int roomsId) {
		this.roomsId = roomsId;
	}

	public void setHostId(String hostId) {
		this.hostId = hostId;
	}

	public void setDetails(String details) {
		this.details = details;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public void setReservationNum(int reservationNum) {
		this.reservationNum = reservationNum;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public void setCheckIn(Timestamp checkIn) {
		this.checkIn = checkIn;
	}

	public void setCheckOut(Timestamp checkOut) {
		this.checkOut = checkOut;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public void setPeople(int people) {
		this.people = people;
	}

	public String getFilename() {
		return filename;
	}

	public void setFilename(String filename) {
		this.filename = filename;
	}

	@Override
	public String toString() {
		return "HistoryVO [roomsId=" + roomsId + ", hostId=" + hostId + ", details=" + details + ", address=" + address
				+ ", reservationNum=" + reservationNum + ", userId=" + userId + ", checkIn=" + checkIn + ", checkOut="
				+ checkOut + ", price=" + price + ", people=" + people + ", filename=" + filename + "]";
	}

}
