package com.bit.bnb.hostpage.service;

import com.bit.bnb.hostpage.dao.HostPageDAO;
import com.bit.bnb.hostpage.model.EvaluationVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EvaluationListService {

    @Autowired
    private HostPageDAO dao;

    public List<EvaluationVO> notEvaluationList(String hostId){
        List<EvaluationVO> list =dao.getNotEvaluation(hostId);
        return list;

    }


    public List<EvaluationVO> EvaluationList(String hostId){

        return dao.getEvaluation(hostId);

    }

}
