package com.bit.bnb.chatting.service;


import com.bit.bnb.chatting.dao.ChatDAO;
import com.bit.bnb.chatting.model.ChatRoomVO;
import com.bit.bnb.chatting.model.MessageVO;
import com.bit.bnb.rooms.model.RoomsVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class MessageListService {

    @Autowired
    ChatDAO dao;

    public List<MessageVO> listviewService(ChatRoomVO roomsVO) throws Exception {


        List<MessageVO> list = dao.getMessageList(roomsVO);
        readOk(roomsVO);
        return list;

    }
    public void readOk(ChatRoomVO roomVO){
        dao.readOkUpdate(roomVO);
    }

    public List<ChatRoomVO> chatAllList(String userId) {
        List<ChatRoomVO> list = new ArrayList<ChatRoomVO>();
        try {
           list= dao.getAllRoomList(userId);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

}
