package com.sist.web;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MyPageController {
	@GetMapping("mypage/main.do")
	public String mypage_main()
	{
		return "mypage/main";
	}
	
	@GetMapping("mypage/update.do")
	public String mypage_update(HttpSession session, Model model)
	{
		String userId=(String)session.getAttribute("userId");
		model.addAttribute("userId", userId);
		return "mypage/update";
	}
	
	@GetMapping("adminpage/userlist.do")
	public String adminpage_userlist()
	{
		return "adminpage/userlist";
	}
}
