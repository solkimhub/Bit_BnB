package com.bit.bnb.hostpage.model;

public class MyRoomVO {
    private int roomsId;
    private int reservationCount;

    public int getRoomsId() {
        return roomsId;
    }

    public void setRoomsId(int roomsId) {
        this.roomsId = roomsId;
    }

    public int getReservationCount() {
        return reservationCount;
    }

    public void setReservationCount(int reservationCount) {
        this.reservationCount = reservationCount;
    }

    @Override
    public String toString() {
        return "MyRoomVO{" +
                "roomsId=" + roomsId +
                ", reservationCount=" + reservationCount +
                '}';
    }
}
