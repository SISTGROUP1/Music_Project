package com.sist.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sist.dao.MusicNewsDAO;
import com.sist.vo.MusicNewsVO;

@Service
public class MusicNewsServiceImpl implements MusicNewsService{
	@Autowired
	private MusicNewsDAO dao;

	@Override
	public List<MusicNewsVO> musicNewsData(int start, int end) {
		// TODO Auto-generated method stub
		return dao.musicNewsData(start, end);
	}

	@Override
	public int musicNewsTotalPage() {
		// TODO Auto-generated method stub
		return dao.musicNewsTotalPage();
	}
	
	
}
