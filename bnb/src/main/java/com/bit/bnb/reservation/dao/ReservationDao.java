package com.bit.bnb.reservation.dao;


import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.bit.bnb.reservation.model.ReservationInfo;
import com.bit.bnb.user.model.UserVO;

public interface ReservationDao {
	public List<ReservationInfo> getReservation(int roomsId) throws Exception;

	public int getDuration(@Param("checkInStr") String checkInStr, @Param("nowStr") String nowStr, @Param("roomsId") int roomsId) throws Exception;

	public int ReservationDo(ReservationInfo info) throws Exception;

	public int getPrice(@Param("checkInStr") String checkInStr, @Param("checkOutStr") String checkOutStr, @Param("cnt") int cnt, @Param("roomsId") int roomsId) throws Exception;

	public void deposit(ReservationInfo reservationInfo) throws Exception;

	public UserVO withdraw(UserVO userInfo) throws Exception;

	public int withdrawDo(@Param("price") int price, @Param("userId") String userId) throws Exception;
	
}
