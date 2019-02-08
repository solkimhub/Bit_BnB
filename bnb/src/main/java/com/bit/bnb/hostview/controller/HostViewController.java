package com.bit.bnb.hostview.controller;

import com.bit.bnb.hostview.dao.HostInfoDao;
import com.bit.bnb.hostview.service.HostInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class HostViewController {
    @Autowired
    private HostInfoService service;

    @RequestMapping(value = "hostview", method = RequestMethod.GET)
    public ModelAndView aaa (@RequestParam(value = "hostId") String userId){
        ModelAndView view = new ModelAndView();
        view.setViewName("hostview/hostview");
        view.addObject("avgScope",service.getScope(userId));
        view.addObject("hostInfo",service.getInfo(userId));
        view.addObject("reservaionCnt",service.getReservationCnt(userId));
        return view;
    }

}
