package com.sist.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.sist.service.CdlpService;
import com.sist.vo.CdlpVO;

@RestController
public class CdlpRestController {
	@Autowired
	private CdlpService cService;
	
	@GetMapping(value = "cdlp/cate_vue.do",produces = "text/plain;charset=UTF-8")
	public String cdlp_main_cate_vue() throws Exception {
		List<CdlpVO> list=cService.cdlpCateList();
		ObjectMapper mapper=new ObjectMapper();
		String json=mapper.writeValueAsString(list);
		return json;
	}
//	@GetMapping(value = "cdlp/list_recentM_vue.do",produces = "text/plain;charset=UTF-8")
//	public String cdlp_list_recentM_vue(int page) throws Exception {
//		int rowSize=4;
//		int start=(page*rowSize)-(rowSize-1);
//		int end=page*rowSize;
//		
//		List<CdlpVO> list=cService.cdlpListData_RecentM(start,end);
//		ObjectMapper mapper=new ObjectMapper();
//		String json=mapper.writeValueAsString(list);
//		return json;
//	}
	@GetMapping(value = "cdlp/list_sort_vue.do",produces = "text/plain;charset=UTF-8")
	public String cdlp_list_sort_vue(int page,CdlpVO vo,HttpSession session) throws Exception {
		int rowSize=20;
		int start=(page*rowSize)-(rowSize-1);
		int end=page*rowSize;
		
		String sessionId="";
		String userId=(String) session.getAttribute("userId");
		if(userId!=null) {
			sessionId=userId;
		}
		
		Map map=new HashMap();
		map.put("genre", vo.getGenre());
		map.put("sub_genre", vo.getSub_genre());
		map.put("listType", vo.getListType());
		map.put("start", start);
		map.put("end", end);
		
		List<CdlpVO> list=cService.cdlpListData_Sort(map);
		
		Map map2=new HashMap();
		map2.put("list", list);
		map2.put("sessionId", sessionId);
		
		ObjectMapper mapper=new ObjectMapper();
		String json=mapper.writeValueAsString(map2);
		return json;
	}
	@GetMapping("cdlp/list_page_vue.do")
	public String cdlp_list_page_vue(int page,CdlpVO vo) throws Exception {
		int totalpage=cService.cdlpListTotalPage(vo);
		final int BLOCK=10;
		int startPage=((page-1)/BLOCK*BLOCK)+1;
		int endPage=((page-1)/BLOCK*BLOCK)+BLOCK;
		if(endPage>totalpage) endPage=totalpage;
		
		Map map=new HashMap();
		map.put("curpage", page);
		map.put("totalpage", totalpage);
		map.put("startPage", startPage);
		map.put("endPage", endPage);
		
		ObjectMapper mapper=new ObjectMapper();
		String json=mapper.writeValueAsString(map);
		return json;
	}
	@GetMapping(value = "cdlp/detail_vue.do",produces = "text/plain;charset=UTF-8")
	public String cdlp_detail_vue(int no,HttpSession session) throws Exception {
		CdlpVO vo=cService.cdlpDetailData(no);
		String userId=(String) session.getAttribute("userId");
		
		Map map=new HashMap();
		map.put("cdlp_detail", vo);
		map.put("sessionId", userId);
		
		ObjectMapper mapper=new ObjectMapper();
		String json=mapper.writeValueAsString(map);
		return json;
	}
}
