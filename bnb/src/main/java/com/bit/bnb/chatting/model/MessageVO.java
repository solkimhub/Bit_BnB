package com.bit.bnb.chatting.model;

import com.google.gson.Gson;

import java.sql.Timestamp;


public class MessageVO {
    private int idx;
    private String hostId;
    private String userId;
    private String roomsId;
    private Timestamp messageDate;
    private String messagecontent;
    private String receive;
    private String sender;
    private String readCk;
    private int unreadCount;

    public int getUnreadCount() {
        return unreadCount;
    }

    public void setUnreadCount(int unreadCount) {
        this.unreadCount = unreadCount;
    }

    public String getSender() {
        return sender;
    }

    public void setSender(String sender) {
        this.sender = sender;
    }

    public int getIdx() {
        return idx;
    }

    public void setIdx(int idx) {
        this.idx = idx;
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

    public Timestamp getMessageDate() {
        return messageDate;
    }

    public void setMessageDate(Timestamp messageDate) {
        this.messageDate = messageDate;
    }

    public String getMessagecontent() {
        return messagecontent;
    }

    public void setMessagecontent(String messagecontent) {
        this.messagecontent = messagecontent;
    }

    public String getReceive() {
        return receive;
    }

    public void setReceive(String receive) {
        this.receive = receive;
    }

    public String getReadCk() {
        return readCk;
    }

    public void setReadCk(String readCk) {
        this.readCk = readCk;
    }

    public static MessageVO convertMessage(String source) {
        MessageVO message = new MessageVO();
        Gson gson = new Gson();
        message = gson.fromJson(source,  MessageVO.class);
        return message;
    }

    @Override
    public String toString() {
        return "MessageVO{" +
                "idx=" + idx +
                ", hostId='" + hostId + '\'' +
                ", userId='" + userId + '\'' +
                ", roomsId='" + roomsId + '\'' +
                ", messageDate=" + messageDate +
                ", messagecontent='" + messagecontent + '\'' +
                ", receive='" + receive + '\'' +
                ", sender='" + sender + '\'' +
                ", readCk='" + readCk + '\'' +
                '}';
    }
}
