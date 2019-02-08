package com.bit.bnb.user.service;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Locale;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class DateCheckService {

	// 유효한 날짜인지 검사
	@Transactional
	public static boolean dateCheck(String date) {
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd", Locale.KOREA);
		dateFormat.setLenient(false);
		try {
			dateFormat.parse(date);
			return true;
		} catch(Exception ex) {
			return false;
		}
	}

	
	@Transactional
	public int getAge(int birthYear, int birthMonth, int birthDay) {
		Calendar current = Calendar.getInstance();
		int currentYear = current.get(Calendar.YEAR); 
		int currentMonth = current.get(Calendar.MONTH) + 1;
		int currentDay = current.get(Calendar.DAY_OF_MONTH);
		
		// 나이계산
		int age = currentYear - birthYear;
		
		// 생일이 지나지 않았다면 -1 해준다(만나이)
		if((birthMonth * 100 + birthDay) > currentMonth * 100 + currentDay) {
			age--;
		}

		return age;
	}
	
}
