package com.bit.bnb.hostpage.controller;

import com.bit.bnb.hostpage.service.EvaluationListService;
import com.bit.bnb.user.model.UserVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

@Controller
public class EvaluationListController {

    @Autowired
    private EvaluationListService listService;

    @RequestMapping(value = "/hostpage/eval", method = RequestMethod.GET)
    @ResponseBody
    public List<List> getList(HttpSession session) {


        UserVO user = (UserVO) session.getAttribute("loginUser");

        List<List> list = new ArrayList<List>();

        list.add(listService.notEvaluationList(user.getUserId()));
        list.add(listService.EvaluationList(user.getUserId()));
        return list;
    }

}
