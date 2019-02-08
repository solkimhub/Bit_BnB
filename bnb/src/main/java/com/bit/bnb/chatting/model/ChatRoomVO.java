package com.bit.bnb.chatting.model;

public class ChatRoomVO{

    private String hostId;
    private String userId;
    private String roomsId;
   private  String unreadcount;
   private String receive;
   private String userName;
    private String hostName;
    private String readCk;
    private String userPhoto;
    private String hostPhoto;
    private String messagecontent;

    public String getMessagecontent() {
        return messagecontent;
    }

    public void setMessagecontent(String messagecontent) {
        this.messagecontent = messagecontent;
    }

    public ChatRoomVO() {
    }

    public ChatRoomVO(String hostId, String userId, String roomsId) {
        this.hostId = hostId;
        this.userId = userId;
        this.roomsId = roomsId;
    }

    public ChatRoomVO(String hostId, String userId, String roomsId, String receive) {
        this.hostId = hostId;
        this.userId = userId;
        this.roomsId = roomsId;
        this.receive = receive;
    }


    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getHostName() {
        return hostName;
    }

    public void setHostName(String hostName) {
        this.hostName = hostName;
    }

    public String getReadCk() {
        return readCk;
    }

    public void setReadCk(String readCk) {
        this.readCk = readCk;
    }

    public String getUserPhoto() {
        return userPhoto;
    }

    public void setUserPhoto(String userPhoto) {
        this.userPhoto = userPhoto;
    }

    public String getHostPhoto() {
        return hostPhoto;
    }

    public void setHostPhoto(String hostPhoto) {
        this.hostPhoto = hostPhoto;
    }

    public String getReceive() {
        return receive;
    }

    public void setReceive(String receive) {
        this.receive = receive;
    }

    public String getUnreadcount() {
        return unreadcount;
    }

    public void setUnreadcount(String unreadcount) {
        this.unreadcount = unreadcount;
    }

    public String getHostId() {
        return hostId;
    }

    public void setHostId(String hostId) {
        this.hostId = hostId;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getRoomsId() {
        return roomsId;
    }

    public void setRoomsId(String roomsId) {
        this.roomsId = roomsId;
    }


    @Override
    public String toString() {
        return "ChatRoomVO{" +
                "hostId='" + hostId + '\'' +
                ", userId='" + userId + '\'' +
                ", roomsId='" + roomsId + '\'' +
                ", unreadcount='" + unreadcount + '\'' +
                ", receive='" + receive + '\'' +
                ", userName='" + userName + '\'' +
                ", hostName='" + hostName + '\'' +
                ", readCk='" + readCk + '\'' +
                ", userPhoto='" + userPhoto + '\'' +
                ", hostPhoto='" + hostPhoto + '\'' +
                ", messagecontent='" + messagecontent + '\'' +
                '}';
    }
}
