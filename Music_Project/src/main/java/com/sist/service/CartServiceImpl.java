package com.sist.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sist.dao.CartDAO;
import com.sist.vo.CartVO;
import com.sist.vo.OrderVO;

@Service
public class CartServiceImpl implements CartService {
	@Autowired
	private CartDAO cDao;

	@Override
	public List<CartVO> cartListData(String userId) {
		return cDao.cartListData(userId);
	}

	@Override
	public void cartInsert(CartVO vo) {
		cDao.cartInsert(vo);
	}

	@Override
	public CartVO isExist(CartVO vo) {
		return cDao.isExist(vo);
	}

	@Override
	public void cartAmountUpdate(CartVO vo) {
		cDao.cartAmountUpdate(vo);
	}

	@Override
	public void cartDelete(int no) {
		cDao.cartDelete(no);
	}

//	@Override
//	public CartVO cartData_payment(String userId, int no) {
//		return cDao.cartData_payment(userId, no);
//	}

	@Override
	public CartVO cartData_payment(Map map) {
		return cDao.cartData_payment(map);
	}
	
	@Override
	public void orderInsert(Map map) {
		cDao.orderInsert(map);
	}

	@Override
	public List<OrderVO> orderListData(String userId) {
		return cDao.orderListData(userId);
	}

	@Override
	public int orderTotalCnt(String userId) {
		return cDao.orderTotalCnt(userId);
	}

}
