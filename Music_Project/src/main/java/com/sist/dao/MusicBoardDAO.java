package com.sist.dao;
import java.util.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sist.mapper.*;
import com.sist.vo.*;

@Repository
public class MusicBoardDAO {
	@Autowired
	private MusicBoardMapper mapper;
	
	public List<MusicBoardVO> boardListData(int start, int end, int typeno)
	{
		return mapper.boardListData(start, end, typeno);
	}
	public int boardTotalPage(int typeno)
	{
		return mapper.boardTotalPage(typeno);
	}
	
	public MusicBoardVO boardDetailData(int no)
	{
		mapper.hitIncrement(no);
		return mapper.boardDetailData(no);
	}
	
	public void noticeInsert(MusicBoardVO vo)
	{
		mapper.noticeInsert(vo);
	}
	public void questionInsert(MusicBoardVO vo)
	{
		mapper.questionInsert(vo);
	}
	public void schandInsert(MusicBoardVO vo)
	{
		mapper.schandInsert(vo);
	}
	
	// 삭제부분
	public MusicBoardVO databoardFileInfoData(int no)
	{
		return mapper.databoardFileInfoData(no);
	}
	
	public String databoardDelete(int no, String pwd)
	{
		String result="no";
	    String db_pwd=mapper.databoardGetPassword(no);
	    if(db_pwd.equals(pwd))
	    {
	    	result="yes";
	    	mapper.databoardDelete(no);
	    }
	    return result;
	}
	
	public MusicBoardVO databoardUpdateData(int no)
	{
		   return mapper.boardDetailData(no);
	}
	public String databoardUpdate(MusicBoardVO vo)
	{
		String result="no";
		String db_pwd=mapper.databoardGetPassword(vo.getNo());
		if(db_pwd.equals(vo.getPwd()))
		{
			result="yes";
			mapper.databoardUpdate(vo);
		}
		return result;
	}
}
















