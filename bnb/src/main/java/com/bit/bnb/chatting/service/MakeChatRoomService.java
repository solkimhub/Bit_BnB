package com.bit.bnb.chatting.service;

import com.bit.bnb.chatting.dao.ChatDAO;
import com.bit.bnb.chatting.model.MessageVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MakeChatRoomService {

    @Autowired
    ChatDAO chatDAO;

    public void makeChatRoom (MessageVO messageVO){
        try {
            chatDAO.createRoom(messageVO);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
