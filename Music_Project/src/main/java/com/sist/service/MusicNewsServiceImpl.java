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
	public List<MusicNewsVO> musicNewsData(int start, int end, int cateno) {
		// TODO Auto-generated method stub
		return dao.musicNewsData(start, end, cateno);
	}

	@Override
	public int musicNewsTotalPage(int cateno) {
		// TODO Auto-generated method stub
		return dao.musicNewsTotalPage(cateno);
	}

	@Override
	public MusicNewsVO musicNewsDetailData(int no) {
		// TODO Auto-generated method stub
		return dao.musicNewsDetailData(no);
	}
	
	@Override
	public List<MusicNewsVO> musicNews3() {
		// TODO Auto-generated method stub
		return dao.musicNews3();
	}


	
	
	
}
