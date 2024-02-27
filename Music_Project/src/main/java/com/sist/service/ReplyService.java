package com.sist.service;

import java.util.List;
import java.util.Map;

import com.sist.vo.ReplyVO;

public interface ReplyService {
	public List<ReplyVO> replyListData(Map map);
	public int replyTotalCnt(int typeno,int fno);
	public void replyInsert(ReplyVO vo);
	public void replyUpdate(ReplyVO vo);
	public void replyDelete(ReplyVO vo);
}
