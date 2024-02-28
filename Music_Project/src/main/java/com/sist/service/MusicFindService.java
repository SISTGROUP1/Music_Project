package com.sist.service;

import java.util.List;
import java.util.Map;

import com.sist.vo.LikeVO;
import com.sist.vo.MusicFindVO;
import com.sist.vo.MusicVideoVO;
import com.sist.vo.MyMusicVO;
import com.sist.vo.ReplyVO;
import com.sist.vo.SubreplyVO;

public interface MusicFindService {
	public List<MusicFindVO> gmusicTop10(int gtype);
	public List<MusicFindVO> gmusicList1(Map map);
	public List<MusicFindVO> gmusicListOther(Map map);
	public int gmusicTotalPage(Map map);
	public MusicVideoVO gmusicVideoDetail(int gnum);
	public MusicFindVO gmusicArtistDetail(int gnum);
	public List<MusicFindVO> gmusicTypeFind(int gtype);
	public List<MusicFindVO> gmusictagFind(Map map);
	public int gmusictagTotalPage(String tag);
	public int gmusicLikeCount(LikeVO vo);
	public int gmusicAllLikeCount(LikeVO vo);
	public void gmusicLikeInsert(LikeVO vo);
	public void gmusicLikeDelete(LikeVO vo);
	public List<ReplyVO> gmusicDetailReply(Map map);
	public int gmusicDetailReplyAllCount(Map map);
	public void gmusicDetailReplyInsert(Map map);
	public void gmusicDetailReplyUpdate(Map map);
	public void gmusicDetailReplyDelete(int no);
	public String gmusicReplyMsg(int no);
	public void gmusicDetailsubReplyInsert(SubreplyVO vo);
	public List<SubreplyVO> gmusicDetailsubReplySelect(SubreplyVO vo);
	public void gmusicSubreplyDelete(int sno);
	public void MyMusicInsert(MyMusicVO vo);
	public List<MusicFindVO> MyMusicList(String userId);
	public void MyMusicDelete(int num);
	public List<MusicFindVO> footerMV();
	public List<MusicFindVO> searchArtist(Map map);
	public int searchTotalPage(String search);
}
