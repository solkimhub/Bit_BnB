package com.bit.bnb.rooms.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.bit.bnb.rooms.model.AmenitiesVO;
import com.bit.bnb.rooms.model.RoomsImgVO;
import com.bit.bnb.rooms.model.RoomsReviewSummaryVO;
import com.bit.bnb.rooms.model.RoomsReviewVO;
import com.bit.bnb.rooms.model.RoomsVO;
import com.bit.bnb.user.model.UserVO;

@Repository
public class RoomsDAO {

	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	private String mapperPath = "mappers.RoomsMapper.";

	public int insertRooms(RoomsVO rv) {
		return sqlSessionTemplate.update(mapperPath + "insertRooms", rv);
	}

//	public List<RoomsVO> selectRooms(RoomsVO rv) {
//		return sqlSessionTemplate.selectList(mapperPath + "selectRooms", rv);
//	}

	public int updateRooms(RoomsVO rv) {
		return sqlSessionTemplate.update(mapperPath + "updateRooms", rv);
	}

	public int deleteRooms(RoomsVO rv) {
		return sqlSessionTemplate.delete(mapperPath + "deleteRooms", rv);
	}

	public List<AmenitiesVO> selectAmenities(AmenitiesVO av) {
		return sqlSessionTemplate.selectList(mapperPath + "selectAmenities", av);
	}

	// 페이징 테스트
	public List<RoomsVO> selectRoomsList(HashMap<String, Object> map) {
		return sqlSessionTemplate.selectList(mapperPath + "selectRoomsList", map);
	}

	public int selectRoomsListCount(HashMap<String, Object> map) {
		return sqlSessionTemplate.selectOne(mapperPath + "selectRoomsListCount", map);
	}

	public int totalCount(String tableName) {
		return sqlSessionTemplate.selectOne(mapperPath + "totalCount", tableName);
	}

	public int selectMinPrice() {
		return sqlSessionTemplate.selectOne(mapperPath + "selectMinPrice");
	}

	public int selectMaxPrice() {
		return sqlSessionTemplate.selectOne(mapperPath + "selectMaxPrice");
	}

	public List<RoomsReviewVO> selectRoomsReview(HashMap<String, Object> map) {
		return sqlSessionTemplate.selectList(mapperPath + "selectRoomsReview", map);
	}

	public List<RoomsReviewSummaryVO> selectRoomsReviewSummary() {
		return sqlSessionTemplate.selectList(mapperPath + "selectRoomsReviewSummary");
	}

	public int selectRoomsReviewCount(int roomsId) {
		return sqlSessionTemplate.selectOne(mapperPath + "selectRoomsReviewCount", roomsId);
	}

	public List<UserVO> selectRoomsHost(UserVO uv) {
		return sqlSessionTemplate.selectList(mapperPath + "selectRoomsHost", uv);
	}

	public int insertRoomsPhoto(RoomsImgVO rimgv) {
		return sqlSessionTemplate.update(mapperPath + "insertRoomsPhoto", rimgv);
	}

	public int updateRoomsPhoto(RoomsImgVO rimgv) {
		return sqlSessionTemplate.update(mapperPath + "updateRoomsPhoto", rimgv);
	}

	public List<RoomsImgVO> selectRoomsPhoto(RoomsImgVO rimgv) {
		return sqlSessionTemplate.selectList(mapperPath + "selectRoomsPhoto", rimgv);
	}

	public int deleteRoomsPhoto(RoomsImgVO rimgv) {
		return sqlSessionTemplate.delete(mapperPath + "deleteRoomsPhoto", rimgv);
	}

	// 랜덤
	public RoomsVO selectRandomRoom() {
		return sqlSessionTemplate.selectOne(mapperPath + "selectRandomRoom");
	}

}
