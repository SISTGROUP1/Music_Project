package com.sist.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sist.mapper.LikeMapper;
import com.sist.vo.LikeVO;

@Repository
public class LikeDAO {
	@Autowired
	private LikeMapper mapper;
	
	public List<LikeVO> likeListData(int typeno, int fno) {
		return mapper.likeListData(typeno, fno);
	}
	public void likeDelete(LikeVO vo) {
		mapper.likeDelete(vo);
	}
	public void likeInsert(LikeVO vo) {
		mapper.likeInsert(vo);
	}
}
