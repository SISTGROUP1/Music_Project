package com.sist.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MusicNewsController {
	@GetMapping("musicnews/list.do")
	public String musicnews_list()
	{
		return "musicnews/list";
	}
	
	@GetMapping("musicnews/detail.do")
	public String musicnews_detail()
	{
		return "musicnews/detail";
	}
}
