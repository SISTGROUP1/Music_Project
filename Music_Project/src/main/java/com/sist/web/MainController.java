package com.sist.web;

import java.util.List;

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
	
	@GetMapping("main/main.do")
	public String main_main(Model model)
	{
		// 음악뉴스 홈
		List<MusicNewsVO> musicNewsList=mnService.musicNews3();
		model.addAttribute("musicNewsList", musicNewsList);
		
		return "main";
	}
}
