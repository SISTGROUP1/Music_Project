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
	
	public List<MusicNewsVO> musicNewsData(int start, int end)
	{
		return mapper.musicNewsData(start, end);
	}
	
	public int musicNewsTotalPage()
	{
		return mapper.musicNewsTotalPage();
	}
}
