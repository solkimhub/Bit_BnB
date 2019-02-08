package com.bit.bnb.chatting.model;

import com.google.gson.Gson;

public class AllMessageVO {
    private int idx;
    private String userName;
    private String message;

    @Override
    public String toString() {
        return "AllMessageVO{" +
                "idx=" + idx +
                ", userName='" + userName + '\'' +
                ", message='" + message + '\'' +
                '}';
    }

    public int getIdx() {
        return idx;
    }

    public void setIdx(int idx) {
        this.idx = idx;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public static AllMessageVO convertMessage(String source) {
        AllMessageVO message = new AllMessageVO();
        Gson gson = new Gson();
        message = gson.fromJson(source,  AllMessageVO.class);
        return message;
    }

}
