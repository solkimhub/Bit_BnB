package com.bit.bnb.rooms.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bit.bnb.rooms.dao.RoomsDAO;
import com.bit.bnb.rooms.model.RoomsImgVO;
import com.bit.bnb.rooms.model.RoomsReviewSummaryVO;
import com.bit.bnb.rooms.model.RoomsVO;
import com.bit.bnb.rooms.util.Paging;

@Service
public class RoomsListService {

	@Autowired
	RoomsDAO roomsDAO;

	public List<RoomsVO> getRoomsList(RoomsVO rv, Paging paging) {

		HashMap<String, Object> map = new HashMap<String, Object>();

		map.put("paging", paging);
		map.put("rv", rv);

		return roomsDAO.selectRoomsList(map);
	}

	public List<RoomsVO> getRoomsList(RoomsVO rv, Paging paging, String checkIn, String checkOut) {

		HashMap<String, Object> map = new HashMap<String, Object>();

		map.put("paging", paging);
		map.put("rv", rv);
		map.put("checkIn", checkIn);
		map.put("checkOut", checkOut);

		return roomsDAO.selectRoomsList(map);
	}

	public Paging getPaging(String tableName, int currentPageNo, int dataPerPage) {
		Paging paging = new Paging(roomsDAO.totalCount(tableName), currentPageNo, dataPerPage);
		paging.makePageing();
		return paging;
	}

	public Paging getRoomSearchPaging(RoomsVO rv, int currentPageNo, int dataPerPage) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("rv", rv);
		Paging paging = new Paging(roomsDAO.selectRoomsListCount(map), currentPageNo, dataPerPage);
		paging.makePageing();
		return paging;
	}

	public Paging getRoomSearchPaging(RoomsVO rv, int currentPageNo, int dataPerPage, String checkIn, String checkOut) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("rv", rv);
		map.put("checkIn", checkIn);
		map.put("checkOut", checkOut);

		Paging paging = new Paging(roomsDAO.selectRoomsListCount(map), currentPageNo, dataPerPage);
		paging.makePageing();
		return paging;
	}

	public List<RoomsReviewSummaryVO> getReviewSummary() {
		return roomsDAO.selectRoomsReviewSummary();
	}

	public int getMinPrice() {
		return roomsDAO.selectMinPrice();
	}

	public int getMaxPrice() {
		return roomsDAO.selectMaxPrice();
	}

	public List<RoomsImgVO> getRoomsThumbnail() {
		RoomsImgVO rimgv = new RoomsImgVO();
		rimgv.setPriority(1);
		return roomsDAO.selectRoomsPhoto(rimgv);
	}

	public RoomsVO getRandomRoom() {
		return roomsDAO.selectRandomRoom();
	}
}
