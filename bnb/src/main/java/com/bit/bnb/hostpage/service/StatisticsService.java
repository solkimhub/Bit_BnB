package com.bit.bnb.hostpage.service;

import com.bit.bnb.hostpage.dao.HostPageDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class StatisticsService {

    @Autowired
    private HostPageDAO dao;

    public int getallprice(String hostId) {

        return dao.allprice(hostId);
    }

    public List<Integer> getList(String hostId) {

        return dao.myroomview(hostId);
    }


}
