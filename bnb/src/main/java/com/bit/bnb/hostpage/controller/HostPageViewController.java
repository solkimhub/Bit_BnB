package com.bit.bnb.hostpage.controller;

import com.bit.bnb.hostpage.model.ReservationRoomUserVO;
import com.bit.bnb.hostpage.service.GetReservationListService;
import com.bit.bnb.hostpage.service.StatisticsService;
import com.bit.bnb.user.model.UserVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class HostPageViewController {

    @Autowired
    GetReservationListService service;
    @Autowired
    private StatisticsService statisticsService;

    @RequestMapping(value = "/hostpage/main", method = RequestMethod.GET)
    public ModelAndView gethostPage(HttpSession session){

        ModelAndView modelAndView = new ModelAndView();

        modelAndView.setViewName("hostpage/main");

        UserVO vo = (UserVO) session.getAttribute("loginUser");

        modelAndView.addObject("myroomlist",service.getMyroom(vo.getUserId()));


        return modelAndView;
    }

    @RequestMapping(value = "/hostpage/getreser", method = RequestMethod.GET)
    @ResponseBody
    public List<ReservationRoomUserVO> getReservationRoomUser(@RequestParam("roomsId") int roomsid){

        return service.getResevationUserList(roomsid);
    }


    @RequestMapping(value="/hostpage/delreser", method = RequestMethod.GET)
 @ResponseBody
    public int delReservation(@RequestParam("Idx") int idx){
return service.delReservation(idx);
    }
    @RequestMapping(value = "/hostpage/getlist",method = RequestMethod.GET)
    @ResponseBody
    public List<Integer> getmyroomlist(HttpSession session){
        UserVO vo = (UserVO) session.getAttribute("loginUser");

        List<Integer> list =statisticsService.getList(vo.getUserId());
        return list;
    }

    @RequestMapping(value = "/hostpage/getprice",method = RequestMethod.GET)
    @ResponseBody
    public int allPrice(HttpSession session){
        UserVO vo = (UserVO) session.getAttribute("loginUser");

        return statisticsService.getallprice(vo.getUserId());
    }



}
