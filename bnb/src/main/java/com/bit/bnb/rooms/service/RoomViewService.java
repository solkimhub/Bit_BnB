package com.bit.bnb.rooms.service;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import com.bit.bnb.mypage.dao.WishDao;
import com.bit.bnb.rooms.dao.RoomsDAO;
import com.bit.bnb.rooms.model.AmenitiesVO;
import com.bit.bnb.rooms.model.RoomsImgVO;
import com.bit.bnb.rooms.model.RoomsReviewSummaryVO;
import com.bit.bnb.rooms.model.RoomsReviewVO;
import com.bit.bnb.rooms.model.RoomsVO;
import com.bit.bnb.rooms.util.Paging;
import com.bit.bnb.user.model.UserVO;

@Service
@Repository
public class RoomViewService {

	@Autowired
	RoomsDAO roomsDAO;

	public RoomsVO getViewRooms(RoomsVO rv) {
		// return roomsDAO.selectRooms(rv).get(0);
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("rv", rv);
		return roomsDAO.selectRoomsList(map).get(0);
	}

	public List<AmenitiesVO> getAmenities(AmenitiesVO av) {
		return roomsDAO.selectAmenities(av);
	}

	public List<RoomsReviewVO> getReviewList(Paging paging, int roomsId) {

		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("paging", paging);
		map.put("roomsId", roomsId);

		return roomsDAO.selectRoomsReview(map);
	}

	public Paging getPaging(String tableName, int currentPageNo, int dataPerPage) {
		Paging paging = new Paging(roomsDAO.totalCount(tableName), currentPageNo, dataPerPage);
		paging.makePageing();
		return paging;
	}

	public Paging getReviewaging(int roomsId, int currentPageNo, int dataPerPage) {
		Paging paging = new Paging(roomsDAO.selectRoomsReviewCount(roomsId), currentPageNo, dataPerPage);
		paging.makePageing();
		return paging;
	}

	public UserVO getHostInfo(UserVO uv) {
		return roomsDAO.selectRoomsHost(uv).get(0);
	}

	public List<RoomsReviewSummaryVO> getReviewSummary() {
		return roomsDAO.selectRoomsReviewSummary();
	}
	
	public List<RoomsImgVO> getRoomImages(RoomsImgVO rimgv) {
		return roomsDAO.selectRoomsPhoto(rimgv);
	}

}
