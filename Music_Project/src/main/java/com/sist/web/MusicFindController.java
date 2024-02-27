package com.sist.web;

import java.security.Principal;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sist.vo.MemberVO;

@Controller
@RequestMapping("musicfind/")
public class MusicFindController {
	private static String[] category = {"","차트 <span class=\"text-primary\">200</span> 위","<span class=\"text-primary\">최신</span>음악","<span class=\"text-primary\">장르</span>음악"};
	
	@GetMapping("list.do")
	public String musicFind_main(String cate,Model model) {
		String name = category[Integer.parseInt(cate)];
		
		model.addAttribute("cateNum",cate);
		model.addAttribute("name",name);
		
		return "musicfind/list";
	}
	
	@GetMapping("mvdetail.do")
	public String musicVideo_main(int gnum,Model model){
		model.addAttribute("gnum",gnum);
		return "musicfind/mvdetail";
	}
	
	@GetMapping(value = "tagfind.do",produces = "text/plain;charset=UTF-8")
	public String musictagFind(String tag,Model model) {
		model.addAttribute("tag",tag);
		
		return "musicfind/tagfind";
	}
	
	@GetMapping(value = "mymusic.do")
	public String myMusic(int gnum,Principal p,Model model) {
		model.addAttribute("gnum",gnum);
		return "musicfind/mymusic";
	}
}
