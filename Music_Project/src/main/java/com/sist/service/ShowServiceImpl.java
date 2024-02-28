package com.sist.service;

import java.util.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.sist.vo.*;
import com.sist.dao.*;

@Service
public class ShowServiceImpl implements ShowService {

	@Autowired
	private ShowDAO dao;
	
	@Override
	public List<ShowVO> Topshow() {
		// TODO Auto-generated method stub
		return dao.Topshow();
	}
	
	@Override
	public List<ShowVO> showconListData() {
		// TODO Auto-generated method stub
		return dao.showconListData();
	}
	@Override
	public List<ShowVO> showmuListData() {
		// TODO Auto-generated method stub
		return dao.showmuListData();
	}
	@Override
	public List<ShowVO> showclListData() {
		// TODO Auto-generated method stub
		return dao.showclListData();
	}
	
	
	
	@Override
	public List<ShowVO> conListData(int start, int end, int scate) {
		// TODO Auto-generated method stub
		return dao.conListData(start, end, scate);
	}

	@Override
	public int conTotalPage(int scate) {
		// TODO Auto-generated method stub
		return dao.conTotalPage(scate);
	}

	@Override
	public ShowVO showDetailData(int sno) {
		// TODO Auto-generated method stub
		return dao.showDetailData(sno);
	}

	// 후기
}
