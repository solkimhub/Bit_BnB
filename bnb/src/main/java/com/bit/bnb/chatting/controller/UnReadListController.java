package com.bit.bnb.chatting.controller;

import com.bit.bnb.chatting.model.MessageVO;
import com.bit.bnb.chatting.service.UnReadListService;
import com.bit.bnb.user.model.UserVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class UnReadListController {

    @Autowired
    private UnReadListService service;

    @RequestMapping(value = "/chat/unreadlist", method = RequestMethod.GET)
    @ResponseBody
    public List<MessageVO> getUnreadList(HttpSession session) {
        UserVO user = (UserVO) session.getAttribute("loginUser");

        return service.getList(user.getUserId());
    }
}
