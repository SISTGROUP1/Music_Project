package com.sist.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.StringTokenizer;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.sist.service.CartService;
import com.sist.vo.CartVO;

@RestController
public class CartRestController {
	@Autowired
	private CartService cService;
	
	@GetMapping("cart/insert.do")
	public void cart_insert(CartVO vo,String checked) {
		System.out.println(checked);
		System.out.println(vo.getClno());
		System.out.println(vo.getUserId());
		if(vo.getClno()!=0) {
			CartVO dbVO=cService.isExist(vo);
			if(dbVO==null) {
				cService.cartInsert(vo);
			}else {
				cService.cartAmountUpdate(vo);
			}
		}else {
			StringTokenizer st=new StringTokenizer(checked, ",");
			while(st.hasMoreTokens()) {
				String clno=st.nextToken();
				vo.setClno(Integer.parseInt(clno));
				CartVO dbVO=cService.isExist(vo);
				if(dbVO==null) {
					System.out.println("insert");
					cService.cartInsert(vo);
				}else {
					cService.cartAmountUpdate(vo);
				}
			}
		}
		
	}
	@GetMapping(value = "cart/list.do",produces = "text/plain;charset=UTF-8")
	public String cart_list(HttpSession session) throws Exception {
		String userId=(String) session.getAttribute("userId");
		List<CartVO> list=cService.cartListData(userId);
		ObjectMapper mapper=new ObjectMapper();
		String json=mapper.writeValueAsString(list);
		return json;
	}
	@GetMapping("cart/update.do")
	public void cart_update(CartVO vo) {
		cService.cartAmountUpdate(vo);
	}
	@GetMapping("cart/del.do")
	public void cart_delete(String no,String nos) {
		if(nos!=null) {
			StringTokenizer st=new StringTokenizer(nos, ",");
			while(st.hasMoreTokens()) {
				String n=st.nextToken();
				cService.cartDelete(Integer.parseInt(n));
			}
		}else {
			cService.cartDelete(Integer.parseInt(no));
		}
	}
	@GetMapping(value = "cart/payment_list.do",produces = "text/plain;charset=UTF-8")
	public String cart_payment_list(String checked,String type,HttpSession session) throws Exception {
		System.out.println("카트에서 구매할 상품 : "+checked);
		String userId=(String) session.getAttribute("userId");
		List<CartVO> list=new ArrayList<CartVO>();
		if(checked.contains(",")) {
			StringTokenizer st=new StringTokenizer(checked, ",");
			while(st.hasMoreTokens()) {
				int no=Integer.parseInt(st.nextToken());
				Map map=new HashMap();
				map.put("userId", userId);
				map.put("no", no);
				if(type.equals("0")) {
					map.put("type", 0);
				}else {
					map.put("type", 1);
				}
//				CartVO vo=cService.cartData_payment(userId, no);
				CartVO vo=cService.cartData_payment(map);
				list.add(vo);
			}
		}else {
			Map map=new HashMap();
			map.put("userId", userId);
			map.put("no", Integer.parseInt(checked));
			if(type.equals("0")) {
				map.put("type", 0);
			}else {
				map.put("type", 1);
			}
//			list.add(cService.cartData_payment(userId,Integer.parseInt(checked)));
			list.add(cService.cartData_payment(map));
		}
		ObjectMapper mapper=new ObjectMapper();
		String json=mapper.writeValueAsString(list);
		return json;
	}
	@PostMapping("cart/buy.do")
	public void cart_buy(String nos,String type,HttpSession session) {
		String userId=(String) session.getAttribute("userId");
		StringTokenizer st=new StringTokenizer(nos, ",");
		while(st.hasMoreTokens()) {
			String no=st.nextToken();
			// cartdata 가져오기
			Map map=new HashMap();
			map.put("userId", userId);
			map.put("no", Integer.parseInt(no));
			map.put("type", Integer.parseInt(type));
//			CartVO vo=cService.cartData_payment(userId, Integer.parseInt(no));
			CartVO vo=cService.cartData_payment(map);
			// Order에 insert
			int price=vo.getCvo().getSaleprice();
			int amount=vo.getAmount();
			int orderno=0;
			if(type.equals("0")) {
				orderno=vo.getClno();
			}else {
				orderno=Integer.parseInt(no);
			}
			
			Map map2=new HashMap();
			map2.put("clno", orderno);
			map2.put("userId", userId);
			map2.put("amount", amount);
			map2.put("price", price*amount);
			System.out.println(orderno);
			System.out.println(userId);
			System.out.println(amount);
			System.out.println(price*amount);
			
			cService.orderInsert(map2);
			cService.cartDelete(Integer.parseInt(no));
		}
	}
}
