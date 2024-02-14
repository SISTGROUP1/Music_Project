package com.sist.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.sist.service.MusicNewsService;
import com.sist.vo.MusicNewsVO;

import java.util.*;

@RestController
@RequestMapping("musicnews/")
public class MusicNewsRestController {
	@Autowired
	private MusicNewsService service;
	
	@GetMapping(value = "list_vue.do", produces = "text/plain;charset=UTF-8")
	public String musicnews_list(int page, int cateno) throws Exception
	{
		int rowSize=12;
		int start=(rowSize*page)-(rowSize-1);
		int end=rowSize*page;
		
		Map map=new HashMap();
		map.put("start", start);
		map.put("end", end);
		map.put("cateno", cateno);
	
		List<MusicNewsVO> list=service.musicNewsData(start, end, cateno);
		
		//JSON변경
		ObjectMapper mapper=new ObjectMapper();
		String json=mapper.writeValueAsString(list);
		return json;
	}
	
	@GetMapping(value = "page_vue.do", produces = "text/plain;charset=UTF-8")
	public String musicnews_page(int page, int cateno) throws Exception
	{
		final int BLOCK=5;
		int startPage=((page-1)/BLOCK*BLOCK)+1;
		int endPage=((page-1)/BLOCK*BLOCK)+BLOCK;
		
		Map map=new HashMap();
		int totalpage=service.musicNewsTotalPage(cateno);
		if(endPage>totalpage)
			endPage=totalpage;
		
		//if(cateno==1)
		//	cateno=1;

		map.put("startPage", startPage);
		map.put("endPage", endPage);
		map.put("curpage", page);
		map.put("totalpage", totalpage);
		map.put("cateno", cateno);
		
		//JSON변경
		ObjectMapper mapper=new ObjectMapper();
		String json=mapper.writeValueAsString(map);
		return json;
	}
	
	@GetMapping(value = "detail_vue.do", produces = "text/plain;charset=UTF-8")
	public String musicnews_detail(int no) throws Exception
	{
		MusicNewsVO vo=service.musicNewsDetailData(no);
		//JSON변경
		ObjectMapper mapper=new ObjectMapper();
		String json=mapper.writeValueAsString(vo);
		return json;
	}
}
