package com.sist.web;
import java.util.*;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.sist.dao.MemberDAO;
import com.sist.service.*;
import com.sist.vo.*;

@RestController
public class MemberRestController {
	@Autowired
	private MemberService mService;
	
	@Autowired
	private MemberDAO mDao;
	
	@GetMapping(value="member/idcheck_vue.do",produces = "text/plain;charset=UTF-8")
	  public String member_idcheck(String userId)
	  {
		  int count=mService.memberIdCount(userId);
		  return String.valueOf(count);
	  }
	 
	// 아이디 찾기
	@GetMapping(value="member/idfind_vue.do",produces = "text/plain;charset=UTF-8")
	public String member_idfind(String userName, String email)
	{
		String msg=mService.idFindOpen(userName, email);
		return msg;
	}
	
	// 비밀번호 변경
	@GetMapping(value="member/pwdchange_vue.do",produces = "text/plain;charset=UTF-8")
	public String member_pwdchange(String userId, String email, String userPwd) throws Exception
	{
		MemberVO vo=mService.pwdChange(userId, email, userPwd);
		ObjectMapper mapper=new ObjectMapper();
	    String json=mapper.writeValueAsString(vo);
	    return json;
	}
	
}
