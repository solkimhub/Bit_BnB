package com.bit.bnb.chatting.controller;

import com.bit.bnb.chatting.model.ChatRoomVO;
import com.bit.bnb.chatting.model.MessageVO;
import com.bit.bnb.chatting.service.MessageListService;
import com.bit.bnb.chatting.service.NewMessageCkServie;
import com.bit.bnb.user.model.UserVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

@Controller
public class ChatListController {


    @Autowired
    MessageListService service;
    @Autowired
    NewMessageCkServie newMessageCkServie;

    @RequestMapping(value = "/chat/list", method = RequestMethod.GET)
    @ResponseBody
    public List<ChatRoomVO> list(HttpSession session,ChatRoomVO roomVO){
        UserVO user = (UserVO) session.getAttribute("loginUser");

        if(user.getUserId().equals(roomVO.getUserId())){
            roomVO.setReceive("U");
        }else{
            roomVO.setReceive("H");
        }
        newMessageCkServie.getList(user.getUserId(),session);

        List<ChatRoomVO> list = service.chatAllList(user.getUserId());

        return list;
    }

    @RequestMapping(value = "/chat/list/message", method = RequestMethod.GET)
    @ResponseBody
    public List<MessageVO> list2(HttpSession session, ChatRoomVO roomVO){
        UserVO user = (UserVO) session.getAttribute("loginUser");

        if(user.getUserId().equals(roomVO.getUserId())){
            roomVO.setReceive("U");
        }else{
            roomVO.setReceive("H");
        }
        List<MessageVO> lists= new ArrayList<MessageVO>();
        try {
            lists= service.listviewService(roomVO);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lists;
    }


    @RequestMapping(value="/chat/list/ck", method = RequestMethod.GET)
    @ResponseBody
    public void update(HttpSession session,ChatRoomVO roomVO){

        UserVO user = (UserVO) session.getAttribute("loginUser");
        if(user.getUserId().equals(roomVO.getUserId())){
            roomVO.setReceive("U");
        }else{
            roomVO.setReceive("H");
        }
        service.readOk(roomVO);
    }

}
