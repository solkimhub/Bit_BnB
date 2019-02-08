package com.bit.bnb.chatting.controller;

import com.bit.bnb.chatting.model.ChatRoomVO;
import com.bit.bnb.chatting.model.MessageVO;
import com.bit.bnb.chatting.service.MakeChatRoomService;
import com.bit.bnb.rooms.model.RoomsVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ChatMakeContoller {

    @Autowired
    MakeChatRoomService service;

    @RequestMapping(value = "/chat/sendmessage", method = RequestMethod.GET)
    public String getForm(ChatRoomVO roomsVO, Model model){
        System.out.println(roomsVO);
        model.addAttribute("ChatRoomInfo",roomsVO);

        return "chat/makeChatMake";
    }

}
