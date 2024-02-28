package com.sist.dao;

import java.util.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sist.vo.*;
import com.sist.mapper.*;

@Repository
public class ShowDAO {

	@Autowired
	private ShowMapper mapper;
	
	@Autowired
	private ReplyMapper rMapper;

	// 메인 top1
	public List<ShowVO> Topshow()
	{
		return mapper.Topshow();
	}
	
	//서치
	public List<ShowVO> showsearch(Map map)
	{
		return mapper.showsearch(map);
	}
	
	public int showsearchcount(String search)
	{
		return mapper.showsearchcount(search);
	}
	
	// 공연 메인 페이지
	// 콘서트 리스트
	public List<ShowVO> showconListData()
	{
		return mapper.showconListData();
	}
	public List<ShowVO> showmuListData()
	{
		return mapper.showmuListData();
	}
	public List<ShowVO> showclListData()
	{
		return mapper.showclListData();
	}
	
	// 콘서트 페이지
	public List<ShowVO> conListData(int start,int end,int scate)
	{
		return mapper.conListData(start,end,scate);
	}
	
	public int conTotalPage(int scate)
	{
		return mapper.conTotalPage(scate);
	}
	
	// 상세페이지
	public ShowVO showDetailData(int sno)
	{
		mapper.showHitIncrement(sno);
		return mapper.showDetailData(sno);
	}
	
	// 후기
	
}
