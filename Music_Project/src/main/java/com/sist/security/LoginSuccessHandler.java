package com.sist.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.security.web.savedrequest.RequestCache;
import org.springframework.security.web.savedrequest.SavedRequest;

import java.util.*;
import com.sist.vo.*;

import lombok.Setter;

import com.sist.service.*;
public class LoginSuccessHandler implements AuthenticationSuccessHandler{
	
	private RequestCache requestCache=new HttpSessionRequestCache();
	private RedirectStrategy redirectStrategy=new DefaultRedirectStrategy();
	
	@Setter
	private String defaultUrl;
	
	@Autowired
	private MemberService mService;

	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {
		// TODO Auto-generated method stub
		MemberVO vo=mService.memberSessionData(authentication.getName());
		HttpSession session=request.getSession();
		session.setAttribute("userId", vo.getUserId());
		session.setAttribute("userName", vo.getUserName());
		session.setAttribute("gender", vo.getGender());
		session.setAttribute("address", vo.getAddr1()+" "+vo.getAddr2());
		session.setAttribute("post", vo.getPost());
		session.setAttribute("phone", vo.getPhone());
		session.setAttribute("email", vo.getEmail());
		response.sendRedirect("../main/main.do");
	}
	
	protected void resultRedirectStrategy(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException
	{
		SavedRequest savedRequest=requestCache.getRequest(request, response);
		if(savedRequest!=null)
		{
			String targetUrl=savedRequest.getRedirectUrl();
			redirectStrategy.sendRedirect(request, response, targetUrl);
		}
	}

}
