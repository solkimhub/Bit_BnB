package com.bit.bnb.chatting.service;

import com.bit.bnb.chatting.dao.ChatDAO;
import com.bit.bnb.chatting.model.MessageVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpSession;
import java.util.List;

@Service
public class NewMessageCkServie {

    @Autowired
    ChatDAO dao;

    public void getList(String userId, HttpSession session){
        List<MessageVO> list= dao.newChatCK(userId);
        int result = 0;
        for(int i=0; i<list.size();i++){
            MessageVO vo = list.get(i);
            if(vo.getUserId().equals(userId)&&"U".equals(vo.getReceive())){
                result++;
            }
            if(vo.getHostId().equals(userId)&&"H".equals(vo.getReceive())){
                result++;
            }
        }

        session.setAttribute("NewmessageCk",result);

    }
}
