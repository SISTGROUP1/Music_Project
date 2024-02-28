package com.sist.web;

import java.util.*;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ShowController {
	
	@GetMapping("show/main.do")
	public String show_main()
	{
		return "show/main";
	}
	@GetMapping("show/list.do")
	public String show_list()
	{
		return "show/list";
	}
	@GetMapping("show/musical.do")
	public String show_musical()
	{
		return "show/musical";
	}
	@GetMapping("show/classic.do")
	public String show_classic()
	{
		return "show/classic";
	}
	
	@GetMapping("show/detail.do")
	public String show_detail(int sno,Model model,HttpSession session)
	{
		String userId=(String)session.getAttribute("userId");
	    String sessionId="";
	    
	    if(userId==null)
		    sessionId="";
	    else
		   sessionId=userId;
	    
	    model.addAttribute("sessionId", sessionId);
	    model.addAttribute("sno", sno);
		return "show/detail";
	}
}
