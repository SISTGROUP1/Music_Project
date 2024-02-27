package com.sist.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sist.dao.LikeDAO;
import com.sist.vo.LikeVO;
@Service
public class LikeServiceImpl implements LikeService {
	@Autowired
	private LikeDAO lDao;

	@Override
	public List<LikeVO> likeListData(int typeno, int fno) {
		return lDao.likeListData(typeno, fno);
	}

	@Override
	public void likeDelete(LikeVO vo) {
		lDao.likeDelete(vo);
	}

	@Override
	public void likeInsert(LikeVO vo) {
		lDao.likeInsert(vo);
	}

}
