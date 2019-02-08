package com.bit.bnb.report.contoller;

import com.bit.bnb.report.service.AdminReportService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class AdminReportController {

    @Autowired
    AdminReportService service;

    @RequestMapping(value = "/adminpage/report", method = RequestMethod.GET)
    public String getPage(@RequestParam(value = "page", defaultValue = "1") int page, Model model) {

        int totalCount = service.getTotalCount();
        int totalPage = 0;
        if (totalCount <= 10) {
            totalPage = 1;
        } else {
            totalPage = totalCount / 10;
            if (totalCount % 10 != 0) {
                totalPage = totalPage + 1;
            }
        }
        int firstRow = (page -1)*10;
        model.addAttribute("totalPage",totalPage);
        model.addAttribute("reportList",service.getList(firstRow));

        return "admin/reportCk";
    }


}


