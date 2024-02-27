package com.sist.service;

import java.util.List;
import java.util.Map;

import com.sist.vo.CartVO;

public interface CartService {
	public List<CartVO> cartListData(String userId);
	public void cartInsert(CartVO vo);
	public CartVO isExist(CartVO vo);
	public void cartAmountUpdate(CartVO vo);
	public void cartDelete(int no);
//	public CartVO cartData_payment(String userId, int no);
	public CartVO cartData_payment(Map map);
	public void orderInsert(Map map);
}
