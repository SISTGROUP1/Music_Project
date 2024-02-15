package com.sist.service;

import java.util.List;

import com.sist.vo.MusicNewsVO;

public interface MusicNewsService {
	public List<MusicNewsVO> musicNewsData(int start, int end, int cateno);
	public int musicNewsTotalPage(int cateno);
	public MusicNewsVO musicNewsDetailData(int no);
	
	public List<MusicNewsVO> musicNews3();
}
