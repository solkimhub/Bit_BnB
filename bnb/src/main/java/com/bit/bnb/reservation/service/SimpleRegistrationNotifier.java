package com.bit.bnb.reservation.service;

import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailException;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;

import com.bit.bnb.reservation.model.ReservationInfo;

public class SimpleRegistrationNotifier {
	@Autowired
	private JavaMailSender mailSender;

	public void sendMail(String memberemail) {
		SimpleMailMessage message = new SimpleMailMessage();
		message.setSubject("[Simple] 회원 가입 안내");
		message.setFrom("isisncorp@gmail.com");
		message.setText("회원 가입을 환영합니다.");
		message.setTo(memberemail);
		try {
			mailSender.send(message);
		} catch (MailException ex) {
			ex.printStackTrace();
		}

	}

	public void mailSendHtml(String email, ReservationInfo info) {
		MimeMessage message = mailSender.createMimeMessage();
		try {
			message.setSubject("[AirBnb] 예약신청이 완료 되었습니다.", "utf-8");
			String htmlStr = "<b>안녕하세요</b> 회원님.<br> "+info.getCheckIn()+" ~ "+info.getCheckOut()+"<br> "+info.getPrice()+"원이 정상적으로 입금 되었습니다.<br> <a href=\"http://www.naver.com\">사이트가기</a>";
			message.setText(htmlStr, "utf-8", "html");
			message.addRecipient(RecipientType.TO, new InternetAddress(email));
			
			mailSender.send(message);
		} catch (MessagingException e) {
			e.printStackTrace();
		}
	}
}