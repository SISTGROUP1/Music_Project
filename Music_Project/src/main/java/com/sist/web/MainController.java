package com.sist.web;

import java.security.Principal;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.sist.service.*;
import com.sist.vo.*;
@Controller
public class MainController {
	
	@Autowired
	private MusicNewsService mnService;
	
	@Autowired
	private MemberService mService;
	
	@GetMapping("main/main.do")
	public String main_main(Model model, Principal p, HttpSession session)
	{
		if(p!=null)
		{
			MemberVO vo=mService.memberSessionData(p.getName());
			session.setAttribute("userId", vo.getUserId());
			session.setAttribute("userName", vo.getUserName());
			session.setAttribute("gender", vo.getGender());
			session.setAttribute("address", vo.getAddr1()+" "+vo.getAddr2());
			session.setAttribute("post", vo.getPost());
			session.setAttribute("phone", vo.getPhone());
			session.setAttribute("email", vo.getEmail());
		}
		
		// 음악뉴스 홈
		List<MusicNewsVO> musicNewsList=mnService.musicNews3();
		model.addAttribute("musicNewsList", musicNewsList);
		
		return "main";
	}
}
