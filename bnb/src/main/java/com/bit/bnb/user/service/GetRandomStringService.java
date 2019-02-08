package com.bit.bnb.user.service;

import java.util.Random;

import org.springframework.stereotype.Service;

@Service
public class GetRandomStringService {

	public String getRandomString() {

		Random random = new Random(System.currentTimeMillis());
		StringBuffer keyBuffer = new StringBuffer();

		// 20자리의 난수를 발생한다
		for (int i = 0; i < 20; i++) {
			if (random.nextBoolean()) {
				keyBuffer.append((char) ((int) (random.nextInt(26)) + 97));
			} else {
				keyBuffer.append((random.nextInt(10)));
			}
		}

		String randomString = keyBuffer.toString();
		
		return randomString;
	}

}
