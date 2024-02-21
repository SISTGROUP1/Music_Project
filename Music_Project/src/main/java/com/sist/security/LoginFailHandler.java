package com.sist.security;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.authentication.InternalAuthenticationServiceException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;

public class LoginFailHandler implements AuthenticationFailureHandler{

	private String defaultFailureUrl;
	
	public void setDefaultFailureUrl(String defaultFailureUrl) {
		this.defaultFailureUrl = defaultFailureUrl;
	}

	@Override
	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
			AuthenticationException exception) throws IOException, ServletException {
		// TODO Auto-generated method stub
		System.out.println("로그인 실패");
		String errorMsg="아이디 또는 비밀번호가 일치하지 않습니다.";
		try
		{
			if(exception instanceof BadCredentialsException)
			{
				// BadCredentialsException : 비밀번호가 틀렸을 때
				errorMsg="아이디 또는 비밀번호가 일치하지 않습니다.";
			}
			else if(exception instanceof InternalAuthenticationServiceException)
			{
				// InternalAuthenticationServiceException : ID가 없을 때
				errorMsg="아이디 또는 비밀번호가 일치하지 않습니다.";
			}
			else if(exception instanceof DisabledException)
			{
				// DisabledException : 계정이 비활성화 되었을 때 (enabled=>0이면 비활성화(휴면계정))
				errorMsg="휴면계정 입니다.";
			}
		}catch(Exception e) {}
		
		request.setAttribute("message", errorMsg);
		request.getRequestDispatcher(defaultFailureUrl).forward(request, response);
		
	}

}
