package com.sist.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MusicBoardCotroller {
	@GetMapping("musicboard/notice.do")
	public String musicboard_notice()
	{
		return "musicboard/notice";
	}
	
	@GetMapping("musicboard/question.do")
	public String musicboard_question()
	{
		return "musicboard/question";
	}
	
	@GetMapping("musicboard/schand.do")
	public String musicboard_schand()
	{
		return "musicboard/schand";
	}
}
