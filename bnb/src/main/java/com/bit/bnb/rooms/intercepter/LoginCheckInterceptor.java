package com.bit.bnb.rooms.intercepter;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.bit.bnb.user.model.UserVO;

public class LoginCheckInterceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws IOException {

		HttpSession session = request.getSession(false);

		if (session != null) {
			Object obj = session.getAttribute("loginUser");
			if (obj != null) {
				return true;
			}
		}
		// response.sendRedirect(request.getContextPath() + "/login");
		/*session.setAttribute("loginModal", "loginModal");*/
		response.sendRedirect(request.getContextPath() + "/");

		return false;
	}
}
