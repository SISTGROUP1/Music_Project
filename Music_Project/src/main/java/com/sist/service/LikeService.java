package com.sist.service;

import java.util.List;

import com.sist.vo.LikeVO;

public interface LikeService {
	public List<LikeVO> likeListData(int typeno, int fno);
	public void likeDelete(LikeVO vo);
	public void likeInsert(LikeVO vo);
}
