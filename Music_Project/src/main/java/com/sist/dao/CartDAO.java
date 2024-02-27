package com.sist.dao;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sist.mapper.CartMapper;
import com.sist.vo.CartVO;

@Repository
public class CartDAO {
	@Autowired
	private CartMapper mapper;
	
	public List<CartVO> cartListData(String userId) {
		return mapper.cartListData(userId);
	}
	public void cartInsert(CartVO vo) {
		mapper.cartInsert(vo);
	}
	public CartVO isExist(CartVO vo) {
		return mapper.isExist(vo);
	}
	public void cartAmountUpdate(CartVO vo) {
		mapper.cartAmountUpdate(vo);
	}
	public void cartDelete(int no) {
		mapper.cartDelete(no);
	}
//	public CartVO cartData_payment(String userId, int no) {
//		return mapper.cartData_payment(userId, no);
//	}
	public CartVO cartData_payment(Map map) {
		return mapper.cartData_payment(map);
	}
	public void orderInsert(Map map) {
		mapper.orderInsert(map);
	}
}
