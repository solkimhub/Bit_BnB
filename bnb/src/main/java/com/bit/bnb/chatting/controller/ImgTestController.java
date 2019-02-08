package com.bit.bnb.chatting.controller;

import com.bit.bnb.user.model.UserVO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;
import java.io.File;

@Controller
public class ImgTestController {

@RequestMapping(value = "/img", method = RequestMethod.GET)
public String getform(Model model, HttpServletRequest request){

    return "imgTest";

}
    @RequestMapping(value = "/img", method = RequestMethod.POST)
public String getImg(UserVO vo){
    System.out.println(vo.toString());
    return "imgTest";
}

}

