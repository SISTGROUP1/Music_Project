package com.sist.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.sist.service.LikeService;
import com.sist.service.ReplyService;
import com.sist.vo.LikeVO;
import com.sist.vo.ReplyVO;

@RestController
public class ReplyRestController {
	@Autowired
	private ReplyService rService;
	@Autowired
	private LikeService lService;
	
	@GetMapping(value = "reply/reply_list.do",produces = "text/plain;charset=UTF-8")
	public String replyListData(ReplyVO vo) throws Exception {
		int rowSize=10;
		int start=(vo.getPage()*rowSize)-(rowSize-1);
		int end=vo.getPage()*rowSize;
		
		Map map=new HashMap();
		map.put("typeno", vo.getTypeno());
		map.put("fno", vo.getFno());
		map.put("start", start);
		map.put("end", end);
		
		List<ReplyVO> list=rService.replyListData(map);
		int replyTotalCnt=rService.replyTotalCnt(vo.getTypeno(), vo.getFno());
		
		List<LikeVO> like_list=lService.likeListData(vo.getTypeno(), vo.getFno());
		
		Map map2=new HashMap();
		map2.put("reply_list", list);
		map2.put("reply_cnt", replyTotalCnt);
		map2.put("like_list", like_list);
		
		ObjectMapper mapper=new ObjectMapper();
		String json=mapper.writeValueAsString(map2);
		return json;
	}
	@GetMapping(value = "reply/reply_insert.do",produces = "text/plain;charset=UTF-8")
	public String reply_insert(ReplyVO vo,HttpSession session) throws Exception {
		String userId=(String) session.getAttribute("userId");
		String userName=(String) session.getAttribute("userName");
		vo.setUserId(userId);
		vo.setUserName(userName);
		rService.replyInsert(vo);
		return replyListData(vo);
	}
	@GetMapping(value = "reply/reply_delete.do",produces = "text/plain;charset=UTF-8")
	public String reply_delete(ReplyVO vo) throws Exception {
		rService.replyDelete(vo);
		return replyListData(vo);
	}
	@PostMapping(value = "reply/reply_update.do",produces = "text/plain;charset=UTF-8")
	public String reply_update(ReplyVO vo) throws Exception {
		rService.replyUpdate(vo);
		return replyListData(vo);
	}
	@GetMapping("reply/reply_page.do")
	public String reply_page(ReplyVO vo) throws Exception {
		int replyTotalCnt=rService.replyTotalCnt(vo.getTypeno(), vo.getFno());
		int totalpage=(int)(Math.ceil(replyTotalCnt/10.0));
		final int BLOCK=10;
		int startPage=((vo.getPage()-1)/BLOCK*BLOCK)+1;
		int endPage=((vo.getPage()-1)/BLOCK*BLOCK)+BLOCK;
		if(endPage>totalpage) endPage=totalpage;
		
		Map map=new HashMap();
		map.put("curpage", vo.getPage());
		map.put("totalpage", totalpage);
		map.put("startPage", startPage);
		map.put("endPage", endPage);
		
		ObjectMapper mapper=new ObjectMapper();
		String json=mapper.writeValueAsString(map);
		return json;
	}
	@GetMapping(value = "reply/reply_like.do",produces = "text/plain;charset=UTF-8")
	public String reply_like(LikeVO vo,String type,HttpSession session) {
		String userId=(String) session.getAttribute("userId");
		vo.setUserId(userId);
		if(type.equals("delete")) {
			lService.likeDelete(vo);
		}else {
			lService.likeInsert(vo);
		}
		return "";
	}
}
