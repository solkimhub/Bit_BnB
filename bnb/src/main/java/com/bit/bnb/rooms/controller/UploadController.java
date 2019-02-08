package com.bit.bnb.rooms.controller;

import java.io.File;
import java.util.Iterator;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

@Controller
public class UploadController {

	@RequestMapping(value = "/ajaxUpload")
	public String ajaxUpload() {
		return "ajaxUpload";
	}

	@RequestMapping(value = "/fileUpload", method = RequestMethod.POST)
	@ResponseBody
	public String fileUpload(MultipartHttpServletRequest multi, @RequestParam("imgidx") int imgidx) {

		// 저장 경로
		System.out.println(multi.getSession().getServletContext().getRealPath("/"));
		String root = multi.getSession().getServletContext().getRealPath("/");
		String path = root + "resources/upload/";
		String newFileName = "";

		File dir = new File(path);
		if (!dir.isDirectory()) {
			dir.mkdir();
		}
		// System.out.println(path);
		// System.out.println(imgidx);

		Iterator<String> files = multi.getFileNames();
		while (files.hasNext()) {
			String uploadFile = files.next();
			MultipartFile mFile = multi.getFile(uploadFile);

			String fileName = mFile.getOriginalFilename();
			newFileName = imgidx + "_" + System.currentTimeMillis() + "."
					+ fileName.substring(fileName.lastIndexOf(".") + 1);
			try {
				mFile.transferTo(new File(path + newFileName));
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return newFileName;
	}

	@RequestMapping(value = "/fileDelete", method = RequestMethod.GET)
	@ResponseBody
	public Boolean fileDelete(HttpServletRequest Request, String deleteFileName) {

		// 저장 경로
		String root = Request.getSession().getServletContext().getRealPath("/");
		String path = root + "resources/upload/";

		boolean result = false;
		try {
			new File(path + deleteFileName).delete();
			result = true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
}