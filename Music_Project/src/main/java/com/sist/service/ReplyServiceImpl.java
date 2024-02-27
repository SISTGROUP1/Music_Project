package com.sist.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sist.dao.ReplyDAO;
import com.sist.vo.ReplyVO;

@Service
public class ReplyServiceImpl implements ReplyService {
	@Autowired
	private ReplyDAO rDao;

	@Override
	public List<ReplyVO> replyListData(Map map) {
		return rDao.replyListData(map);
	}
	
	@Override
	public int replyTotalCnt(int typeno,int fno) {
		return rDao.replyTotalCnt(typeno,fno);
	}

	@Override
	public void replyInsert(ReplyVO vo) {
		rDao.replyInsert(vo);
	}

	@Override
	public void replyUpdate(ReplyVO vo) {
		rDao.replyUpdate(vo);
	}

	@Override
	public void replyDelete(ReplyVO vo) {
		rDao.replyDelete(vo);
	}

}
