package com.sist.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.*;

import javax.servlet.http.HttpSession;

import com.sist.service.*;
import com.sist.vo.*;
@Controller
public class MemberController {
	@Autowired
	private BCryptPasswordEncoder encoder;
	
	@Autowired
	private MemberService mService;
	
	@GetMapping("member/join.do")
    public String member_join()
    {
    	return "member/join";
    }
    
    @PostMapping("member/join_ok.do")
    public String member_join_ok(MemberVO vo)
    {
    	vo.setPhone(vo.getPhone1()+"-"+vo.getPhone2()+"-"+vo.getPhone3());
    	String enPwd=encoder.encode(vo.getUserPwd());
    	vo.setUserPwd(enPwd);
    	mService.memberInsert(vo);
    	mService.memberAuthorityInsert(vo.getUserId());
    	return "main";
    }
    
    @GetMapping("member/sclogin.do")
	public String member_sclogin()
	{
		return "member/sclogin";
	}
    
    @RequestMapping("member/login.do")
    public String member_login()
    {
    	return "member/login";
    }
    
    ///////////////////////////////////////////////////////
    @GetMapping("member/idfind.do")
    public String member_idfind()
    {
    	return "member/idfind";
    }
    
    @GetMapping("member/pwdchange.do")
    public String member_pwdchange()
    {
    	return "member/pwdchange";
    }
    
}
