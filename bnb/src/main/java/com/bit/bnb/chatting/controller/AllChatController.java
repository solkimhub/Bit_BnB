package com.bit.bnb.chatting.controller;

import com.bit.bnb.chatting.dao.ChatDAO;
import com.bit.bnb.chatting.model.AllMessageVO;
import com.bit.bnb.chatting.model.ChatRoomVO;
import com.bit.bnb.user.model.UserVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class AllChatController {
    @Autowired
    private ChatDAO dao;

    @RequestMapping(value = "/devchat", method = RequestMethod.GET)
    public String list(Model model){

        model.addAttribute("lists", dao.devMessageList());

        return "chat/devchat";
    }



}
