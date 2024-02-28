package com.sist.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sist.dao.MusicFindDAO;
import com.sist.vo.LikeVO;
import com.sist.vo.MusicFindVO;
import com.sist.vo.MusicVideoVO;
import com.sist.vo.MyMusicVO;
import com.sist.vo.ReplyVO;
import com.sist.vo.SubreplyVO;

@Service
public class MusicFindServiceImpl implements MusicFindService{
	@Autowired
	private MusicFindDAO gmDao;

	@Override
	public List<MusicFindVO> gmusicTop10(int gtype) {
		// TODO Auto-generated method stub
		return gmDao.gmusicTop10(gtype);
	}

	@Override
	public List<MusicFindVO> gmusicList1(Map map) {
		// TODO Auto-generated method stub
		return gmDao.gmusicList1(map);
	}

	@Override
	public int gmusicTotalPage(Map map) {
		// TODO Auto-generated method stub
		return gmDao.gmusicTotalPage(map);
	}

	@Override
	public List<MusicFindVO> gmusicListOther(Map map) {
		// TODO Auto-generated method stub
		return gmDao.gmusicListOther(map);
	}

	@Override
	public MusicVideoVO gmusicVideoDetail(int gnum) {
		// TODO Auto-generated method stub
		return gmDao.gmusicVideoDetail(gnum);
	}

	@Override
	public MusicFindVO gmusicArtistDetail(int gnum) {
		// TODO Auto-generated method stub
		return gmDao.gmusicArtistDetail(gnum);
	}

	@Override
	public List<MusicFindVO> gmusicTypeFind(int gtype) {
		// TODO Auto-generated method stub
		return gmDao.gmusicTypeFind(gtype);
	}

	@Override
	public List<MusicFindVO> gmusictagFind(Map map) {
		// TODO Auto-generated method stub
		return gmDao.gmusictagFind(map);
	}

	@Override
	public int gmusictagTotalPage(String tag) {
		// TODO Auto-generated method stub
		return gmDao.gmusictagTotalPage(tag);
	}

	@Override
	public int gmusicLikeCount(LikeVO vo) {
		// TODO Auto-generated method stub
		return gmDao.gmusicLikeCount(vo);
	}

	@Override
	public int gmusicAllLikeCount(LikeVO vo) {
		// TODO Auto-generated method stub
		return gmDao.gmusicAllLikeCount(vo);
	}

	@Override
	public void gmusicLikeInsert(LikeVO vo) {
		// TODO Auto-generated method stub
		gmDao.gmusicLikeInsert(vo);
	}

	@Override
	public void gmusicLikeDelete(LikeVO vo) {
		// TODO Auto-generated method stub
		gmDao.gmusicLikeDelete(vo);
	}

	@Override
	public List<ReplyVO> gmusicDetailReply(Map map) {
		// TODO Auto-generated method stub
		return gmDao.gmusicDetailReply(map);
	}

	@Override
	public int gmusicDetailReplyAllCount(Map map) {
		// TODO Auto-generated method stub
		return gmDao.gmusicDetailReplyAllCount(map);
	}

	@Override
	public void gmusicDetailReplyInsert(Map map) {
		// TODO Auto-generated method stub
		gmDao.gmusicDetailReplyInsert(map);
	}

	@Override
	public void gmusicDetailReplyUpdate(Map map) {
		// TODO Auto-generated method stub
		gmDao.gmusicDetailReplyUpdate(map);
	}

	@Override
	public void gmusicDetailReplyDelete(int no) {
		// TODO Auto-generated method stub
		gmDao.gmusicDetailReplyDelete(no);
	}

	@Override
	public String gmusicReplyMsg(int no) {
		// TODO Auto-generated method stub
		return gmDao.gmusicReplyMsg(no);
	}

	@Override
	public void gmusicDetailsubReplyInsert(SubreplyVO vo) {
		// TODO Auto-generated method stub
		gmDao.gmusicDetailsubReplyInsert(vo);
	}

	@Override
	public List<SubreplyVO> gmusicDetailsubReplySelect(SubreplyVO vo) {
		// TODO Auto-generated method stub
		return gmDao.gmusicDetailsubReplySelect(vo);
	}

	@Override
	public void gmusicSubreplyDelete(int sno) {
		// TODO Auto-generated method stub
		gmDao.gmusicSubreplyDelete(sno);
	}

	@Override
	public void MyMusicInsert(MyMusicVO vo) {
		// TODO Auto-generated method stub
		gmDao.MyMusicInsert(vo);
	}

	@Override
	public List<MusicFindVO> MyMusicList(String userId) {
		// TODO Auto-generated method stub
		return gmDao.MyMusicList(userId);
	}

	@Override
	public void MyMusicDelete(int num) {
		// TODO Auto-generated method stub
		gmDao.MyMusicDelete(num);
	}

	@Override
	public List<MusicFindVO> footerMV() {
		// TODO Auto-generated method stub
		return gmDao.footerMV();
	}

	@Override
	public List<MusicFindVO> searchArtist(Map map) {
		// TODO Auto-generated method stub
		return gmDao.searchArtist(map);
	}

	@Override
	public int searchTotalPage(String search) {
		// TODO Auto-generated method stub
		return gmDao.searchTotalPage(search);
	}
	
}
