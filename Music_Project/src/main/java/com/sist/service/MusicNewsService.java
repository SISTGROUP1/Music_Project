package com.sist.service;

import java.util.List;

import com.sist.vo.MusicNewsVO;

public interface MusicNewsService {
	public List<MusicNewsVO> musicNewsData(int start, int end);
	public int musicNewsTotalPage();
}
