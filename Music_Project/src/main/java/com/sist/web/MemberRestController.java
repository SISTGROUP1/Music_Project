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
	
	// 마이페이지
	@GetMapping(value="mypage/main_vue.do",produces = "text/plain;charset=UTF-8")
	public String mypage_main(HttpSession session) throws Exception
	{
		String userId=(String)session.getAttribute("userId");
		
		MemberVO vo=mService.memberSessionData(userId);
		ObjectMapper mapper=new ObjectMapper();
	    String json=mapper.writeValueAsString(vo);
	    return json;
	}
	
	// 마이페이지 정보 수정
	@GetMapping(value="mypage/update_vue.do",produces = "text/plain;charset=UTF-8")
	public String mypage_update(String userId) throws Exception
	{
		MemberVO vo=mService.memberSessionData(userId);
		ObjectMapper mapper=new ObjectMapper();
	    String json=mapper.writeValueAsString(vo);
	    return json;
	}
	@PostMapping(value="mypage/update_ok_vue.do",produces = "text/plain;charset=UTF-8")
	public String mypage_update_ok(MemberVO vo)
	{
		String result=mService.userInfoUpdate(vo);
		return result;
	}
	
	@GetMapping(value="adminpage/userlist_vue.do",produces = "text/plain;charset=UTF-8")
	public String adminpage_userlist() throws Exception
	{
		List<MemberVO> list=mService.userListData();
		
		//JSON변경
		ObjectMapper mapper=new ObjectMapper();
		String json=mapper.writeValueAsString(list);
		return json;
	}
	
	// 회원 탈퇴
	/*@GetMapping(value="mypage/delete_vue.do",produces = "text/plain;charset=UTF-8")
	public String mypage_delete(HttpSession session)
	{
		String userId=(String)session.getAttribute("userId");
		MemberVO vo=mService.userInfoDelete(userId);
		ObjectMapper mapper=new ObjectMapper();
	    String json=mapper.writeValueAsString(vo);
	    return json;
	}*/
	
}
