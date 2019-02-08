package com.bit.bnb.hostpage.service;

import com.bit.bnb.hostpage.dao.HostPageDAO;
import com.bit.bnb.hostpage.model.EvaluationVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class EvaluationWriteService {

    @Autowired
    private HostPageDAO dao;

    public void insert(EvaluationVO vo){
        dao.insertEvaluation(vo);
    }

    public EvaluationVO select(int num){
        return dao.selectOneEvaluation(num);
    }
    public void update(EvaluationVO vo){
        dao.updateEvaluation(vo);
    }
}
