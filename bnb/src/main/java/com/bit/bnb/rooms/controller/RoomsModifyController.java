package com.bit.bnb.rooms.controller;

import java.util.Arrays;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.bit.bnb.rooms.model.AmenitiesVO;
import com.bit.bnb.rooms.model.RoomsImgVO;
import com.bit.bnb.rooms.model.RoomsVO;
import com.bit.bnb.rooms.service.RoomViewService;
import com.bit.bnb.rooms.service.RoomsModifyService;

@Controller
public class RoomsModifyController {

	@Autowired
	RoomViewService roomViewService;

	@Autowired
	RoomsModifyService roomsModifyService;

	// 숙소수정폼페이지
	@RequestMapping(value = "/rooms/modifyRooms", method = RequestMethod.GET)
	public ModelAndView getModifyRoomsForm(RoomsVO rv, AmenitiesVO av, RoomsImgVO rimgv) {
		ModelAndView modelAndView = new ModelAndView();
		// 줄바꿈 처리
		rv = roomViewService.getViewRooms(rv);
		rv.setDetails(rv.getDetails().replaceAll("<br>", "\r\n"));
		// 줄바꿈 처리 끝
		modelAndView.addObject("amenities", roomsModifyService.getAmenities(av));
		modelAndView.addObject("selectedRoom", rv);
		modelAndView.setViewName("rooms/modifyRoomsForm");
		// modelAndView.addObject("roomImages", roomViewService.getRoomImages(rimgv));
		int fileCnt = roomViewService.getRoomImages(rimgv).size();
		String roomImagesNames = "";
		for (int i = 0; i < fileCnt; i++) {
			roomImagesNames += roomViewService.getRoomImages(rimgv).get(i).getFilename();
			if (i != fileCnt - 1) {
				roomImagesNames += "|";
			}
		}
		modelAndView.addObject("roomImagesNames", roomImagesNames);
		return modelAndView;
	}

	// 숙소수정페이지
	@RequestMapping(value = "/rooms/modifyRooms", method = RequestMethod.POST)
	public @ResponseBody ModelAndView modifyRooms(RoomsVO rv, String filenames[], String filenamesOrg[]) {
		ModelAndView modelAndView = new ModelAndView();
		// 줄 바꿈 처리
		rv.setDetails(rv.getDetails().replaceAll("\r\n", "<br>"));

		// 이미지 수정 관련
		RoomsImgVO rimgv = new RoomsImgVO();
		rimgv.setRoomsId(rv.getRoomsId());
		roomsModifyService.deleteRoomImage(rimgv);
		System.out.println(rimgv);

		for (int i = 0; i < filenames.length; i++) {
			// 왜인지 모르겠으나 [, ", ]이 포함되어서 replace 처리
			filenames[i] = filenames[i].replace("\"", "").replace("[", "").replace("]", "");
			// System.out.println("filenames : " + filenames[i]);
		}

		for (int i = 0; i < filenamesOrg.length; i++) {
			// 왜인지 모르겠으나 [, ", ]이 포함되어서 replace 처리
			// System.out.println("filenamesOrg : " + filenamesOrg[i]);
			filenamesOrg[i] = filenamesOrg[i].replace("\"", "").replace("[", "").replace("]", "");
			// System.out.println("filenamesOrg : " + filenamesOrg[i]);
		}

		// 연산을 위해 변환
		List<String> filenamesList = Arrays.asList(filenames);
		List<String> filenamesOrgList = Arrays.asList(filenamesOrg);

		int priority = 1; // 우선순위 초기화
		for (int i = 0; i < filenamesOrgList.size(); i++) {
			// 기존재 파일이 현재 파일 리스트에 추가 되어 있을 경우
//			roomsModifyService.insertRoomsPhoto(rimgv);
//			if (filenamesList.contains(filenamesOrgList.get(i))) {
//				System.out.println(filenamesOrgList.get(i));
//				// 업데이트 처리
//				rimgv.setFilename(filenamesOrgList.get(i));
//				rimgv.setPriority(priority);
//				priority++;
//				// 업데이트 처리 하였으므로 현재 파일 리스트에서 제거
//				// filenamesList.remove(filenamesList.indexOf(filenamesOrgList.get(i)));
//			} else { // 기존재 파일이 현재 파일 리스트에 존재하지 않을 경우
//				// 삭제 처리
//				System.out.println(filenamesOrgList.get(i) + " : 삭제");
//				System.out.println(rimgv);
//				System.out.println("----------------");
//				rimgv.setFilename(filenamesOrgList.get(i));
//				rimgv.setPriority(0); // 삭제를 위해 0 처리, mybatis에서 =0일 경우 검색 조건 불충족으로 검색 제외
//				roomsModifyService.deleteRoomImage(rimgv);
//			}
		}

		for (int i = priority; i < filenamesList.size() + 1; i++) {
			rimgv.setFilename(filenamesList.get(i - 1));
			rimgv.setPriority(priority);
			// System.out.println(rimgv);
			roomsModifyService.insertRoomsPhoto(rimgv);
			priority++;
		}

		// 숙소수정에 성공하면
		if (roomsModifyService.modifyRooms(rv) > 0) {
			modelAndView.setViewName("redirect:/rooms");
		} else {
			modelAndView.setViewName("redirect:/rooms/modifyRooms");
		}
		return modelAndView;
	}

}
