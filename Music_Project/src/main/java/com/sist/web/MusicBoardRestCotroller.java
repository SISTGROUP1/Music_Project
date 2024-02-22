package com.sist.web;

import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.sist.dao.MusicBoardDAO;
import com.sist.service.*;
import com.sist.vo.MusicBoardVO;
import com.sist.vo.MusicNewsVO;

@RestController
public class MusicBoardRestCotroller {
	@Autowired
	private MusicBoardService service;
	
	// 카테고리별 리스트 출력
	@GetMapping(value = "musicboard/notice_vue.do", produces = "text/plain;charset=UTF-8")
	public String musicboard_list(int page, int typeno) throws Exception
	{
		int rowSize=12;
		int start=(rowSize*page)-(rowSize-1);
		int end=rowSize*page;
		
		Map map=new HashMap();
		map.put("start", start);
		map.put("end", end);
		map.put("typeno", typeno);
	
		List<MusicBoardVO> list=service.boardListData(start, end, typeno);
		
		//JSON변경
		ObjectMapper mapper=new ObjectMapper();
		String json=mapper.writeValueAsString(list);
		return json;
	}
	
	// 리스트 총페이지
	@GetMapping(value = "musicboard/page_vue.do", produces = "text/plain;charset=UTF-8")
	public String musicboard_page(int page, int typeno) throws Exception
	{
		final int BLOCK=5;
		int startPage=((page-1)/BLOCK*BLOCK)+1;
		int endPage=((page-1)/BLOCK*BLOCK)+BLOCK;
		
		Map map=new HashMap();
		int totalpage=service.boardTotalPage(typeno);
		if(endPage>totalpage)
			endPage=totalpage;

		map.put("startPage", startPage);
		map.put("endPage", endPage);
		map.put("curpage", page);
		map.put("totalpage", totalpage);
		map.put("typeno", typeno);
		
		//JSON변경
		ObjectMapper mapper=new ObjectMapper();
		String json=mapper.writeValueAsString(map);
		return json;
	}
	
	// 디테일 출력
	@GetMapping(value = "musicboard/detail_vue.do", produces = "text/plain;charset=UTF-8")
	public String musicboard_detail(int no) throws Exception
	{
		MusicBoardVO vo=service.boardDetailData(no);
		
		//JSON변경
		ObjectMapper mapper=new ObjectMapper();
		String json=mapper.writeValueAsString(vo);
		return json;
	}
	
   // notice insert
   @PostMapping(value="musicboard/noticeInsert_vue.do",produces = "text/plain;charset=UTF-8")
   public String musicboard_noticeInsert(MusicBoardVO vo)
   {
	   String result="";
	   try
	   {
		   service.noticeInsert(vo);
		   result="yes";
	   }catch(Exception ex)
	   {
		   result=ex.getMessage();
	   }
	   return result;
   }
   
   // question insert
   @PostMapping(value="musicboard/queInsert_vue.do",produces = "text/plain;charset=UTF-8")
   public String musicboard_queInsert(MusicBoardVO vo)
   {
	   String result="";
	   try
	   {
		   service.questionInsert(vo);
		   result="yes";
	   }catch(Exception ex)
	   {
		   result=ex.getMessage();
	   }
	   return result;
   }
   
   // schand insert
   @PostMapping(value="musicboard/schInsert_vue.do",produces = "text/plain;charset=UTF-8")
   public String musicboard_schInsert(MusicBoardVO vo)
   {
	   String result="";
	   try
	   {
		   service.schandInsert(vo);
		   result="yes";
	   }catch(Exception ex)
	   {
		   result=ex.getMessage();
	   }
	   return result;
   }
   
   // 삭제
   @GetMapping(value="musicboard/delete_vue.do",produces = "text/plain;charset=UTF-8")
   public String freeboard_delete(int no,String pwd)
   {
	   String result=service.databoardDelete(no, pwd);
	   return result;
   }
   
   // 수정
   @GetMapping(value="musicboard/update_vue.do",produces = "text/plain;charset=UTF-8")
   public String musicboard_update(int no) throws Exception
   {
	   MusicBoardVO vo=service.databoardUpdateData(no);
	   ObjectMapper mapper=new ObjectMapper();
	   String json=mapper.writeValueAsString(vo);
	   return json;
   }
   @PostMapping(value="musicboard/update_ok_vue.do",produces = "text/plain;charset=UTF-8")
   public String musicboard_update_ok(MusicBoardVO vo)
   {
	   String result=service.databoardUpdate(vo);
	   return result;
   }
	
}
