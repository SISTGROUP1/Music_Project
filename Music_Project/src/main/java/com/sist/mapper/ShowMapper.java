package com.sist.mapper;

import java.util.*;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.sist.vo.ShowVO;

import lombok.experimental.PackagePrivate;

public interface ShowMapper {

	// 공연 메인 페이지
	@Select("SELECT sno,sposter,stitle,num,scate,sdate "
			+"FROM (SELECT sno,sposter,stitle,scate,sdate,rownum as num "
			+"FROM (SELECT sno,sposter,stitle,scate,sdate "
			+"FROM showInfo WHERE scate=1)) "
			+"WHERE num BETWEEN 1 AND 4")
	public List<ShowVO> showconListData();
	@Select("SELECT sno,sposter,stitle,num,scate,sdate "
			+"FROM (SELECT sno,sposter,stitle,scate,sdate,rownum as num "
			+"FROM (SELECT sno,sposter,stitle,scate,sdate "
			+"FROM showInfo WHERE scate=2)) "
			+"WHERE num BETWEEN 1 AND 4")
	public List<ShowVO> showmuListData();
	@Select("SELECT sno,sposter,stitle,num,scate,sdate "
			+"FROM (SELECT sno,sposter,stitle,scate,sdate,rownum as num "
			+"FROM (SELECT sno,sposter,stitle,scate,sdate "
			+"FROM showInfo WHERE scate=3)) "
			+"WHERE num BETWEEN 1 AND 4")
	public List<ShowVO> showclListData();
	
	
	

	// 공연 리스트 페이지
	@Select("SELECT sno,scate,sposter,stitle,sloc,sdate,num "
			+"FROM (SELECT sno,scate,sposter,stitle,sloc,sdate,rownum as num "
			+"FROM (SELECT sno,scate,sposter,stitle,sloc,sdate "
			+"FROM showInfo WHERE scate=#{scate} "
			+"ORDER BY sno ASC)) "
			+"WHERE num BETWEEN #{start} AND #{end}")
	public List<ShowVO> conListData(@Param("start") int start , @Param("end") int end , @Param("scate") int scate);
	
	@Select("SELECT CEIL(COUNT(*)/12.0) FROM showInfo "
			+"WHERE scate=#{scate}")
	public int conTotalPage(int scate);

	
	// 상세 페이지
	@Select("SELECT * FROM showInfo "
			+"WHERE sno=#{sno}")
	public ShowVO showDetailData(int sno);
	
	@Update("UPDATE showInfo SET "
			+"hit=hit+1 "
			+"WHERE sno=#{sno}")
	public void showHitIncrement(int sno);
	
	// 예매 페이지
	@Select("SELECT * FROM showInfo "
			+"WHERE sno=#{sno}")
	public ShowVO showReserveData(int sno);
	
	// 메인에 top1
	@Select("SELECT sno,stitle,sloc,sposter,sdate,sperformer,rownum "
			+"FROM (SELECT sno,stitle,sloc,sposter,sdate,sperformer "
			+"FROM showInfo ORDER BY hit DESC) "
			+"WHERE rownum<=1")
	public List<ShowVO> Topshow();
}
