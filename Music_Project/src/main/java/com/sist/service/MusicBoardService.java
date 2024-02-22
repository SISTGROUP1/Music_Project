package com.sist.service;

import java.util.List;
import java.util.Map;

import com.sist.vo.MusicBoardVO;

public interface MusicBoardService {
	public List<MusicBoardVO> boardListData(int start, int end, int typeno);
	public int boardTotalPage(int typeno);
	
	public MusicBoardVO boardDetailData(int no);
	
	public void noticeInsert(MusicBoardVO vo);
	public void questionInsert(MusicBoardVO vo);
	public void schandInsert(MusicBoardVO vo);
	
	public MusicBoardVO databoardFileInfoData(int no);
	public String databoardDelete(int no, String pwd);
	
	public MusicBoardVO databoardUpdateData(int no);
	public String databoardUpdate(MusicBoardVO vo);
}
