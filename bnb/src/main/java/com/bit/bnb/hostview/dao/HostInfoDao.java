package com.bit.bnb.hostview.dao;

import com.bit.bnb.user.model.UserVO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class HostInfoDao {
    @Autowired
    private SqlSessionTemplate sqlSessionTemplate;

    private static String namespace="mappers.hostInfo.";
    public UserVO selectOneHostInfo(String userId) {
        return sqlSessionTemplate.selectOne(namespace + "selectOneHostInfo", userId);
    }
    public float selectReviewAVG(String userId){


        return sqlSessionTemplate.selectOne(namespace+"selectReviewAVG",userId);
    }

    public int selectReservation(String userId){
        return sqlSessionTemplate.selectOne(namespace+"selectReservation",userId);
    }

}
