package com.bit.bnb.report.service;

import com.bit.bnb.report.dao.ReportDao;
import com.bit.bnb.report.model.ReportVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AdminReportService {

    @Autowired
    private ReportDao dao;


    public List<ReportVO> getList(int firstRow){

        return dao.notckreportList(firstRow);
    }

    public int getTotalCount(){
        return dao.totalCount();
    }

    public void update(ReportVO vo){
        dao.ckupdate(vo);
    }
}
