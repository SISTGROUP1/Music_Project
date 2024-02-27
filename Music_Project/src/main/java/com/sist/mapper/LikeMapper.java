package com.sist.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.sist.vo.LikeVO;

public interface LikeMapper {
	/*
	@Select("SELECT COUNT(*) "
			+ "FROM All_like "
			+ "WHERE typeno=#{typeno} AND fno=#{fno} AND pno=#{pno}")
	public int likeCount(LikeVO vo);
	*/
	@Insert("INSERT INTO All_like "
			+ "VALUES(al_no_seq.nextval,#{userId},#{typeno},#{fno},#{pno})")
	public void likeInsert(LikeVO vo);
	@Delete("DELETE FROM All_like "
			+ "WHERE typeno=#{typeno} AND fno=#{fno} AND pno=#{pno} AND userId=#{userId}")
	public void likeDelete(LikeVO vo);
	@Select("SELECT pno,userId "
			+ "FROM All_like "
			+ "WHERE typeno=#{typeno} AND fno=#{fno}")
	public List<LikeVO> likeListData(@Param("typeno") int typeno,@Param("fno") int fno);
}
