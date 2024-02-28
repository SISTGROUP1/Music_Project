package com.sist.mapper;

import java.util.*;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Result;
import org.apache.ibatis.annotations.Results;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.sist.vo.*;

public interface ReserveMapper {

	// 예약페이지
	@Select("SELECT * FROM showInfo "
			+"WHERE sno=#{sno}")
	public ShowVO reserveDetailData(int sno);
		
	// 예약하기
	@Insert("INSERT INTO showReserve VALUES("
			  +"sr_srno_seq.nextval,#{sno},#{userId},#{rDate},#{rTime},#{rSeat},SYSDATE,0)")
	public void showReserveInsert(ReserveVO vo);
	
	// 마이페이지에 예약 내역
	@Results({
		   @Result(column = "stitle",property = "svo.stitle"),
		   @Result(column = "sposter",property = "svo.sposter")
	   })
	@Select("SELECT srno,sr.sno,userId,stitle,sposter,rDate,rTime,"
		  +"rSeat,reserve_ok,TO_CHAR(regdate,'YYYY-MM-DD HH24:MI:SS') as dbday "
		  +"FROM showreserve sr,showInfo s "
		  +"WHERE sr.sno=s.sno "
		  +"AND userId=#{userId} "
		  +"ORDER BY srno DESC")
	public List<ReserveVO> reserveMypageData(String userId);
	
	// 예약 취소
	@Delete("DELETE FROM showreserve "
			+"WHERE srno=#{srno}")
	public void reserveCancel(int srno);
	
	// 어드민
	@Results({
		   @Result(column = "stitle",property = "svo.stitle"),
		   @Result(column = "sposter",property = "svo.sposter")
	   })
	   @Select("SELECT srno,sr.sno,userId,stitle,sposter,rDate,rTime,"
			  +"rSeat,reserve_ok,TO_CHAR(regdate,'YYYY-MM-DD HH24:MI:SS') as dbday "
			  +"FROM showreserve sr,showInfo s "
			  +"WHERE sr.sno=s.sno "
			  +"ORDER BY srno DESC")
	   public List<ReserveVO> reserveAdminpageData();
	   
	   @Update("UPDATE showreserve SET "
			  +"reserve_ok=1 "
			  +"WHERE srno=#{srno}")
	   public void reserveOk(int srno);
	   
	   @Results({
		   @Result(column = "stitle",property = "svo.stitle"),
		   @Result(column = "sposter",property = "svo.sposter")
	   })
	   @Select("SELECT srno,sr.sno,stitle,sposter,rDate,rTime,"
				  +"rSeat,reserve_ok,TO_CHAR(regdate,'YYYY-MM-DD HH24:MI:SS') as dbday "
				  +"FROM showreserve sr,showInfo s "
				  +"WHERE sr.sno=s.sno "
				  +"AND srno=#{srno}")
	   public ReserveVO reserveInfoData(int srno);
}
