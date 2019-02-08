package com.bit.bnb.user.service;

import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class MailSendService {

	@Autowired
	private JavaMailSender mailSender;
	
	// 이메일 계정 인증메일 보내기
	@Transactional
	public void mailSendWithUserKey(String email, String name, String userKey, HttpServletRequest request) {

		MimeMessage mail = mailSender.createMimeMessage();

		String htmlStr = "<h2>안녕하세요, " + name + "님!</h2>"
						  + "이메일 계정을 인증받으시려면 아래의 버튼을 클릭해주세요!<br>"
						  + "메일 인증과 동시에 BITBNB 홈페이지로 이동합니다.<br>"
						  + "(혹시 잘못 전달된 메일이라면 이 이메일을 무시하셔도 됩니다) <br><br>"
						  + "<form action=\"http://ec2-13-209-99-134.ap-northeast-2.compute.amazonaws.com:8080/bnb/userKeyConfirm\" method=\"post\">"
						  + "<input type=\"hidden\" name=\"userId\" value=\"" + email + "\">"
						  + "<input type=\"hidden\" name=\"userKey\" value=\"" + userKey + "\">"
						  + "<input type=\"submit\" style=\"display: inline-block; "
						  + "font-weight: 400; text-align: center; white-space: nowrap; "
						  + "vertical-align: middle; user-select: none; border: 1px solid transparent; " 
						  + "padding: 0.375rem 0.75rem; font-size: 1rem; line-height: 1.5; "
						  + "border-radius: 0.25rem; transition: color 0.15s ease-in-out, "
						  + "background-color 0.15s ease-in-out, border-color 0.15s ease-in-out, "
						  + "box-shadow 0.15s ease-in-out; cursor:pointer; background-color:#f59f00; "
						  + "color:#ffffff;\" value=\"메일인증하기\">"
						  + "</form>"; 
						
		try {
			mail.setSubject("[본인인증] BITBNB 회원가입 인증메일입니다", "utf-8");
			mail.setText(htmlStr, "utf-8", "html");
			mail.addRecipient(RecipientType.TO, new InternetAddress(email));
			mailSender.send(mail);
		} catch (MessagingException e) {
			e.printStackTrace();
		}
	}
		
		
	// 비밀번호 찾기 이메일 전송
	public void mailSendSearchPw(String email, String name, String userKey) {
		MimeMessage mail = mailSender.createMimeMessage();
		
		String htmlStr = "<h2>안녕하세요, " + name + "님!</h2>"
						  + "비밀번호 재설정을 요청하셨습니다.<br>"
						  + "(혹시 잘못 전달된 메일이라면 이 이메일을 무시하셔도 됩니다) <br>"
						  + "아래의 링크를 이용해 비밀번호를 재설정하세요.<br>"
						  + "<form action=\"http://ec2-13-209-99-134.ap-northeast-2.compute.amazonaws.com:8080/bnb/user/updatePwForm\" method=\"post\">"
						  + "<input type=\"hidden\" name=\"userId\" value=\"" + email + "\">"
						  + "<input type=\"hidden\" name=\"userKey\" value=\"" + userKey + "\">"
						  + "<input type=\"submit\" style=\"display: inline-block; "
						  + "font-weight: 400; text-align: center; white-space: nowrap; "
						  + "vertical-align: middle; user-select: none; border: 1px solid transparent; " 
						  + "padding: 0.375rem 0.75rem; font-size: 1rem; line-height: 1.5; "
						  + "border-radius: 0.25rem; transition: color 0.15s ease-in-out, "
						  + "background-color 0.15s ease-in-out, border-color 0.15s ease-in-out, "
						  + "box-shadow 0.15s ease-in-out; cursor:pointer; background-color:#f59f00; "
						  + "color:#ffffff;\" value=\"비밀번호 재설정하러 가기\">"
						  + "</form>";
			
		try {
			mail.setSubject("[BITBNB]비밀번호를 재설정하세요", "utf-8");
			mail.setText(htmlStr, "utf-8", "html");
			mail.addRecipient(RecipientType.TO, new InternetAddress(email));
			mailSender.send(mail);
		} catch (MessagingException e) {
			e.printStackTrace();
		}
	}
	
}
