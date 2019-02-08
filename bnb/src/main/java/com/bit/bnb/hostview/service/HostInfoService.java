package com.bit.bnb.hostview.service;

import com.bit.bnb.hostview.dao.HostInfoDao;
import com.bit.bnb.user.model.UserVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class HostInfoService {

    @Autowired
    private HostInfoDao dao;

    public UserVO getInfo(String userId){
        return dao.selectOneHostInfo(userId);
    }

    public float getScope(String userId){
        return dao.selectReviewAVG(userId);
    }
    public int getReservationCnt(String userId){
        return dao.selectReservation(userId);
    }

}
