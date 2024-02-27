package com.sist.dao;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sist.mapper.ReplyMapper;
import com.sist.vo.ReplyVO;
@Repository
public class ReplyDAO {
	@Autowired
	private ReplyMapper mapper;
	
	public List<ReplyVO> replyListData(Map map) {
		return mapper.replyListData(map);
	}
	public int replyTotalCnt(int typeno,int fno) {
		return mapper.replyTotalCnt(typeno,fno);
	}
	public void replyInsert(ReplyVO vo) {
		mapper.replyInsert(vo);
	}
	public void replyUpdate(ReplyVO vo) {
		mapper.replyUpdate(vo);
	}
	public void replyDelete(ReplyVO vo) {
		mapper.replyDelete(vo);
	}
}
