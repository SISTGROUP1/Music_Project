package com.sist.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.sist.dao.*;
import com.sist.vo.MusicBoardVO;
@Service
public class MusicBoardServiceImpl implements MusicBoardService{
	@Autowired
	private MusicBoardDAO dao;

	@Override
	public List<MusicBoardVO> boardListData(int start, int end, int typeno) {
		// TODO Auto-generated method stub
		return dao.boardListData(start, end, typeno);
	}

	@Override
	public int boardTotalPage(int typeno) {
		// TODO Auto-generated method stub
		return dao.boardTotalPage(typeno);
	}

	@Override
	public MusicBoardVO boardDetailData(int no) {
		// TODO Auto-generated method stub
		return dao.boardDetailData(no);
	}

	@Override
	public void noticeInsert(MusicBoardVO vo) {
		// TODO Auto-generated method stub
		dao.noticeInsert(vo);
		
	}

	@Override
	public void questionInsert(MusicBoardVO vo) {
		// TODO Auto-generated method stub
		dao.questionInsert(vo);
	}

	@Override
	public void schandInsert(MusicBoardVO vo) {
		// TODO Auto-generated method stub
		dao.schandInsert(vo);
	}

	@Override
	public MusicBoardVO databoardFileInfoData(int no) {
		// TODO Auto-generated method stub
		return dao.databoardFileInfoData(no);
	}

	@Override
	public String databoardDelete(int no, String pwd) {
		// TODO Auto-generated method stub
		return dao.databoardDelete(no, pwd);
	}

	@Override
	public String databoardUpdate(MusicBoardVO vo) {
		// TODO Auto-generated method stub
		return dao.databoardUpdate(vo);
	}

	@Override
	public MusicBoardVO databoardUpdateData(int no) {
		// TODO Auto-generated method stub
		return dao.databoardUpdateData(no);
	}
	
}
