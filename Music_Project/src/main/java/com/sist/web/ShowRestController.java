package com.sist.web;

import java.util.*;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.sist.service.*;
import com.sist.vo.*;

@RestController
public class ShowRestController {
	
	@Autowired
	private ShowService service;
	
	@GetMapping(value = "show/main_concert_vue.do" , produces = "text/plain;charset=UTF-8")
	public String main_concert_vue() throws Exception
	{
		List<ShowVO> list=service.showconListData();
	    //JSON변경
	    ObjectMapper mapper=new ObjectMapper();
	    String json=mapper.writeValueAsString(list);
	    return json;
	}
	@GetMapping(value = "show/main_musical_vue.do" , produces = "text/plain;charset=UTF-8")
	public String main_musical_vue() throws Exception
	{
		List<ShowVO> list=service.showmuListData();
	    //JSON변경
	    ObjectMapper mapper=new ObjectMapper();
	    String json=mapper.writeValueAsString(list);
	    return json;
	}
	@GetMapping(value = "show/main_classic_vue.do" , produces = "text/plain;charset=UTF-8")
	public String main_classic_vue() throws Exception
	{
		List<ShowVO> list=service.showclListData();
	    //JSON변경
	    ObjectMapper mapper=new ObjectMapper();
	    String json=mapper.writeValueAsString(list);
	    return json;
	}
	
	
	
	// 총 목록
	@GetMapping(value = "show/show_list_vue.do" , produces = "text/plain;charset=UTF-8")
	public String concert_list_vue(int page,int scate) throws Exception
	{
		int rowSize=12;
	    int start=(rowSize*page)-(rowSize-1);
	    int end=(rowSize*page);
		
	    Map map=new HashMap();
		map.put("start", start);
		map.put("end", end);
		map.put("scate", scate);
		
	    List<ShowVO> list=service.conListData(start, end, scate);
//	    for(ShowVO vo: list) {
//	    	System.out.println(vo.getSno());
//	    }
	    //JSON변경
	    ObjectMapper mapper=new ObjectMapper();
	    String json=mapper.writeValueAsString(list);
	    return json;
	}
	
	@GetMapping(value = "show/show_page_vue.do" , produces = "text/plain;charset=UTF-8")
	public String con_page_vue(int page,int scate) throws Exception
	{
		final int BLOCK=3;
		int startPage=((page-1)/BLOCK*BLOCK)+1;
		int endPage=((page-1)/BLOCK*BLOCK)+BLOCK;
		
		Map map=new HashMap();
		int totalpage=service.conTotalPage(scate);
		if(endPage>totalpage)
			endPage=totalpage;
		
		map.put("startPage", startPage);
		map.put("endPage", endPage);
		map.put("curpage", page);
		map.put("totalpage", totalpage);
		map.put("scate", scate);
		
		//JSON변경
		ObjectMapper mapper=new ObjectMapper();
		String json=mapper.writeValueAsString(map);
		return json;
	}
	
	// 상세보기
	@GetMapping(value="show/detail_vue.do",produces = "text/plain;charset=UTF-8")
    public String food_detail(int sno) throws Exception
    {
		ShowVO vo=service.showDetailData(sno);
    	
    	Map map=new HashMap();
    	map.put("show_detail", vo);
    	
    	ObjectMapper mapper=new ObjectMapper();
    	String json=mapper.writeValueAsString(map);
    	
    	return json;
    }
}
