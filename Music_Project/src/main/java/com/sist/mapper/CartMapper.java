package com.sist.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Result;
import org.apache.ibatis.annotations.ResultMap;
import org.apache.ibatis.annotations.Results;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.sist.vo.CartVO;
import com.sist.vo.OrderVO;

public interface CartMapper {
	/*
	 	SELECT poster,subject,price,saleprice,discount,amount
		FROM cdlp JOIN cart
		ON cdlp.NO=cart.clno
		WHERE cart.userId='kang'
	 */
	@Select("SELECT cart.no,clno,poster,subject,price,saleprice,discount,amount "
			+ "FROM cdlp JOIN cart "
			+ "ON cdlp.no=cart.clno "
			+ "WHERE cart.userId=#{userId} "
			+ "ORDER BY cart.no DESC")
	@ResultMap("cartMap")
	public List<CartVO> cartListData(String userId);
	
	@Insert("INSERT INTO cart "
			+ "VALUES(cart_no_seq.nextval,#{clno},#{userId},#{amount})")
	public void cartInsert(CartVO vo);
	// 카트에 동일한 상품이 이미 담겨있을 경우
	@Select("SELECT no,clno,amount "
			+ "FROM cart "
			+ "WHERE clno=#{clno} AND userId=#{userId}")
	public CartVO isExist(CartVO vo);
	@Update("UPDATE cart SET "
			+ "amount=#{amount} "
			+ "WHERE clno=#{clno} AND userId=#{userId}")
	public void cartAmountUpdate(CartVO vo);
	
	@Delete("DELETE FROM cart "
			+ "WHERE no=#{no}")
	public void cartDelete(int no);
	// 결제페이지
//	@Select("SELECT cart.no,clno,poster,subject,price,saleprice,discount,amount "
//			+ "FROM cdlp JOIN cart "
//			+ "ON cdlp.no=cart.clno "
//			+ "WHERE cart.userId=#{userId} "
//			+ "AND cart.no=#{no}")
//	@ResultMap("cartMap")
//	public CartVO cartData_payment(@Param("userId") String userId,@Param("no") int no);
	public CartVO cartData_payment(Map map);
	// Order insert
	@Insert("INSERT INTO music_order(no,clno,userId,amount,price,regdate) "
			+ "VALUES(mo_no_seq.nextval,#{clno},#{userId},#{amount},#{price},SYSDATE)")
	public void orderInsert(Map map);
	@Results({
			@Result(column = "subject",property = "cvo.subject"),
			@Result(column = "poster",property = "cvo.poster")
	})
	@Select("SELECT cdlp.no,subject,poster,amount,music_order.price,TO_CHAR(music_order.regdate,'YYYY-MM-DD') as dbday "
			+ "FROM music_order JOIN cdlp "
			+ "ON music_order.clno=cdlp.no "
			+ "WHERE userId=#{userId} "
			+ "ORDER BY music_order.regdate DESC")
	public List<OrderVO> orderListData(String userId);
	@Select("SELECT CEIL(COUNT(*)/10) "
			+ "FROM music_order "
			+ "WHERE userId=#{userId}")
	public int orderTotalCnt(String userId);
}
