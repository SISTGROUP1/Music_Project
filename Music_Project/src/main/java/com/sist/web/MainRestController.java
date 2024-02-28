package com.sist.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.sist.service.*;
import com.sist.vo.CdlpVO;
import com.sist.vo.ShowVO;

@RestController
public class MainRestController {
	@Autowired
	private CdlpService cService;
	
	@Autowired
	private ShowService sService;
	
	@GetMapping(value = "search/searchDataFind_vue.do",produces = "text/plain;charset=UTF-8")
	public String searchDataFind_vue(int page,String type,String search) throws Exception {
		int rowSize=8;
		int start=(page*rowSize)-(rowSize-1);
		int end=page*rowSize;
		
		Map map=new HashMap();
		map.put("start", start);
		map.put("end", end);
		map.put("search", search);
		
		if(type.equals("0")) {
			
		}else if(type.equals("1")) {
			List<CdlpVO> list=cService.searchCdlpData(map);
			int totalpage=cService.searchCdlpDataCnt(search);
			
			final int BLOCK=10;
			int startPage=((page-1)/BLOCK*BLOCK)+1;
			int endPage=((page-1)/BLOCK*BLOCK)+BLOCK;
			if(endPage>totalpage) endPage=totalpage;
			
			map.put("list", list);
			map.put("curpage", page);
			map.put("startPage", startPage);
			map.put("endPage", endPage);
			map.put("totalpage", totalpage);
			
		}else {
			List<ShowVO> list=sService.showsearch(map);
			
			int totalpage=sService.showsearchcount(search);
			
			final int BLOCK=10;
			int startPage=((page-1)/BLOCK*BLOCK)+1;
			int endPage=((page-1)/BLOCK*BLOCK)+BLOCK;
			if(endPage>totalpage) endPage=totalpage;
			
			map.put("list", list);
			map.put("curpage", page);
			map.put("startPage", startPage);
			map.put("endPage", endPage);
			map.put("totalpage", totalpage);
		}
		
		ObjectMapper mapper=new ObjectMapper();
		String json=mapper.writeValueAsString(map);
		return json;
	}
}
