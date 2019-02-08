package com.bit.bnb.hostpage.service;

import com.bit.bnb.hostpage.dao.HostPageDAO;
import com.bit.bnb.hostpage.model.MyRoomVO;
import com.bit.bnb.hostpage.model.ReservationRoomUserVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class GetReservationListService {

@Autowired
    private HostPageDAO dao;


public List<MyRoomVO> getMyroom(String userId){
    return dao.ckMyRooms(userId);

    }

    public List<ReservationRoomUserVO> getResevationUserList(int RoomsId){
        return dao.getRoomMember(RoomsId);
    }


    public int delReservation(int idx){
        return dao.delReservation(idx);
    }
}
