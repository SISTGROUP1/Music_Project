package com.sist.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.security.Principal;
import java.util.*;
import com.sist.service.*;
import com.sist.vo.*;
@Controller
public class ChatController {
	
	@Autowired
	private MemberService service;
	
	// tiles가 아닌 vue에서 처리
	@GetMapping("chat/chat.do")
	public String chat_chat(Model model)
	{
		return "site/chat/chat";
	}
}
