package com.bit.bnb.chatting.service;

import com.bit.bnb.chatting.dao.ChatDAO;
import com.bit.bnb.chatting.model.MessageVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UnReadListService {


    @Autowired
    private ChatDAO dao;

    public List<MessageVO> getList(String userId){

        List<MessageVO> list = dao.UnreadMessageList(userId);
        return list;
    }

}
