package com.bit.bnb.rooms.model;

public class RoomsImgVO {

	private int roomsId;
	private String filename;
	private int priority;

	public final int getRoomsId() {
		return roomsId;
	}

	public final void setRoomsId(int roomsId) {
		this.roomsId = roomsId;
	}

	public final String getFilename() {
		return filename;
	}

	public final void setFilename(String filename) {
		this.filename = filename;
	}

	public final int getPriority() {
		return priority;
	}

	public final void setPriority(int priority) {
		this.priority = priority;
	}

	@Override
	public String toString() {
		return "RoomsImgVO [roomsId=" + roomsId + ", filename=" + filename + ", priority=" + priority + "]";
	}

}
