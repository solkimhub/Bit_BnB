package com.bit.bnb.hostpage.controller;

import com.bit.bnb.hostpage.model.EvaluationVO;
import com.bit.bnb.hostpage.service.EvaluationWriteService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class EvaluationWriteController {

    @Autowired
    private EvaluationWriteService service;

    @RequestMapping(value = "/hostpage/eval/write", method = RequestMethod.POST)
    @ResponseBody
    public String getwrite(EvaluationVO vo) {
        service.insert(vo);
    return "Hi";
    }

    @RequestMapping(value="/hostpage/eval/select", method = RequestMethod.POST)
    @ResponseBody
    public EvaluationVO getselect(@RequestParam("reservationNum") int num){
        EvaluationVO vo = service.select(num);

        return vo;
    }
    @RequestMapping(value="/hostpage/eval/modi", method = RequestMethod.POST)
    @ResponseBody
    public void getmodi(EvaluationVO vo){
        service.update(vo);
    }

}
