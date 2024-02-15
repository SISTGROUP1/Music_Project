package com.sist.dao;
import java.util.*;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sist.vo.*;
import com.sist.mapper.*;
@Repository
public class MusicNewsDAO {
	@Autowired
	private MusicNewsMapper mapper;
	
	public List<MusicNewsVO> musicNewsData(int start, int end, int cateno)
	{
		return mapper.musicNewsData(start, end, cateno);
	}
	
	public int musicNewsTotalPage(int cateno)
	{
		return mapper.musicNewsTotalPage(cateno);
	}
	
	public MusicNewsVO musicNewsDetailData(int no)
	{
		return mapper.musicNewsDetailData(no);
	}
	
	public List<MusicNewsVO> musicNews3()
	{
		return mapper.musicNews3();
	}
}
