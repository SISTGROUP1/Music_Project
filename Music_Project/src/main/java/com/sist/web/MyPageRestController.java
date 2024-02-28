package com.sist.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.sist.service.CartService;
import com.sist.vo.OrderVO;

@RestController
public class MyPageRestController {
	@Autowired
	private CartService cService;
	
	@GetMapping(value = "mypage/payment_list.do",produces = "text/plain;charset=UTF-8")
	public String mypage_payment(int page,HttpSession session) throws Exception {
		String userId=(String) session.getAttribute("userId");
		List<OrderVO> list=cService.orderListData(userId);
		ObjectMapper mapper=new ObjectMapper();
		String json=mapper.writeValueAsString(list);
		return json;
	}
	@GetMapping("mypage/payment_list_page.do")
	public String mypage_payment_page(int page,HttpSession session) throws Exception {
		String userId=(String) session.getAttribute("userId");
		int totalpage=cService.orderTotalCnt(userId);
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
}
